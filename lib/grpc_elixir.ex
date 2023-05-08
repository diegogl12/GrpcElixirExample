defmodule GrpcElixir.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run GrpcElixir.User.Server
end

defmodule GrpcElixir.User.Server do
  use GRPC.Server, service: GrpcElixir.User.Service
  alias GrpcElixir.UserDB

  def create(request, _stream) do
    new_user =
      UserDB.add_user(%{
        first_name: request.first_name,
        last_name: request.last_name,
        age: request.age
      })

    GrpcElixir.UserReply.new(new_user)
  end

  def get(request, _stream) do
    user = UserDB.get_user(request.id)

    if user == nil do
      raise GRPC.RPCError, status: :not_found
    else
      GrpcElixir.UserReply.new(user)
    end
  end
end
