load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def envoy_http_archive(name, **kwargs):
    # `existing_rule_keys` contains the names of repositories that have already
    # been defined in the Bazel workspace. By skipping repos with existing keys,
    # users can override dependency versions by using standard Bazel repository
    # rules in their WORKSPACE files.
    existing_rule_keys = native.existing_rules().keys()
    if name in existing_rule_keys:
        # This repository has already been defined, probably because the user
        # wants to override the version. Do nothing.
        return

    # HTTP tarball at a given URL. Add a BUILD file if requested.
    http_archive(
        name = name,
        urls = ["https://github.com/proxy-wasm/proxy-wasm-cpp-sdk/archive/956f0d500c380cc1656a2d861b7ee12c2515a664.tar.gz"],
        sha256 = "b97e3e716b1f38dc601487aa0bde72490bbc82b8f3ad73f1f3e69733984955df",
        strip_prefix = "proxy-wasm-cpp-sdk-956f0d500c380cc1656a2d861b7ee12c2515a664",
        **kwargs
    )

def external_http_archive(name, **kwargs):
    envoy_http_archive(
        name,
        **kwargs
    )

def proxy_wasm_cpp_sdk():
    external_http_archive(name = "proxy_wasm_cpp_sdk")