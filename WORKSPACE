workspace(name = "envoy_wasm_module")

load("//bazel:envoy_http_archive.bzl", "proxy_wasm_cpp_sdk")

proxy_wasm_cpp_sdk()

load("@proxy_wasm_cpp_sdk//bazel/dep:deps.bzl", "wasm_dependencies")

wasm_dependencies()

load("@proxy_wasm_cpp_sdk//bazel/dep:deps_extra.bzl", "wasm_dependencies_extra")

wasm_dependencies_extra()
