// Code generated by protoc-gen-go-grpc. DO NOT EDIT.

package pb

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

// AirlineCompanyServicesClient is the client API for AirlineCompanyServices service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type AirlineCompanyServicesClient interface {
	CreateAirlineCompany(ctx context.Context, in *CreateAirlineCompanyParams, opts ...grpc.CallOption) (*AirlineCompany, error)
}

type airlineCompanyServicesClient struct {
	cc grpc.ClientConnInterface
}

func NewAirlineCompanyServicesClient(cc grpc.ClientConnInterface) AirlineCompanyServicesClient {
	return &airlineCompanyServicesClient{cc}
}

func (c *airlineCompanyServicesClient) CreateAirlineCompany(ctx context.Context, in *CreateAirlineCompanyParams, opts ...grpc.CallOption) (*AirlineCompany, error) {
	out := new(AirlineCompany)
	err := c.cc.Invoke(ctx, "/cawo.v1alpha1.AirlineCompanyServices/CreateAirlineCompany", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// AirlineCompanyServicesServer is the server API for AirlineCompanyServices service.
// All implementations must embed UnimplementedAirlineCompanyServicesServer
// for forward compatibility
type AirlineCompanyServicesServer interface {
	CreateAirlineCompany(context.Context, *CreateAirlineCompanyParams) (*AirlineCompany, error)
	mustEmbedUnimplementedAirlineCompanyServicesServer()
}

// UnimplementedAirlineCompanyServicesServer must be embedded to have forward compatible implementations.
type UnimplementedAirlineCompanyServicesServer struct {
}

func (UnimplementedAirlineCompanyServicesServer) CreateAirlineCompany(context.Context, *CreateAirlineCompanyParams) (*AirlineCompany, error) {
	return nil, status.Errorf(codes.Unimplemented, "method CreateAirlineCompany not implemented")
}
func (UnimplementedAirlineCompanyServicesServer) mustEmbedUnimplementedAirlineCompanyServicesServer() {
}

// UnsafeAirlineCompanyServicesServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to AirlineCompanyServicesServer will
// result in compilation errors.
type UnsafeAirlineCompanyServicesServer interface {
	mustEmbedUnimplementedAirlineCompanyServicesServer()
}

func RegisterAirlineCompanyServicesServer(s grpc.ServiceRegistrar, srv AirlineCompanyServicesServer) {
	s.RegisterService(&AirlineCompanyServices_ServiceDesc, srv)
}

func _AirlineCompanyServices_CreateAirlineCompany_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(CreateAirlineCompanyParams)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(AirlineCompanyServicesServer).CreateAirlineCompany(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/cawo.v1alpha1.AirlineCompanyServices/CreateAirlineCompany",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(AirlineCompanyServicesServer).CreateAirlineCompany(ctx, req.(*CreateAirlineCompanyParams))
	}
	return interceptor(ctx, in, info, handler)
}

// AirlineCompanyServices_ServiceDesc is the grpc.ServiceDesc for AirlineCompanyServices service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var AirlineCompanyServices_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "cawo.v1alpha1.AirlineCompanyServices",
	HandlerType: (*AirlineCompanyServicesServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "CreateAirlineCompany",
			Handler:    _AirlineCompanyServices_CreateAirlineCompany_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "company_service.proto",
}