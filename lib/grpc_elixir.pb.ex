defmodule GrpcElixir.UserReply do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  field :id, 1, type: :int32
  field :first_name, 2, type: :string, json_name: "firstName"
  field :last_name, 3, type: :string, json_name: "lastName"
  field :age, 4, type: :int32
end

defmodule GrpcElixir.CreateRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  field :first_name, 1, type: :string, json_name: "firstName"
  field :last_name, 2, type: :string, json_name: "lastName"
  field :age, 3, type: :int32
end

defmodule GrpcElixir.GetRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.12.0", syntax: :proto3

  field :id, 1, type: :int32
end

defmodule GrpcElixir.User.Service do
  @moduledoc false

  use GRPC.Service, name: "grpc_elixir.User", protoc_gen_elixir_version: "0.12.0"

  rpc :Create, GrpcElixir.CreateRequest, GrpcElixir.UserReply

  rpc :Get, GrpcElixir.GetRequest, GrpcElixir.UserReply
end

defmodule GrpcElixir.User.Stub do
  @moduledoc false

  use GRPC.Stub, service: GrpcElixir.User.Service
end