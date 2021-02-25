load("@proxy_wasm_cpp_sdk//bazel/wasm:wasm.bzl", "wasm_cc_binary")

def _wasm_binary_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)
    if ctx.attr.precompile:
        ctx.actions.run(
            executable = ctx.executable._compile_tool,
            arguments = [ctx.files.binary[0].path, out.path],
            outputs = [out],
            inputs = ctx.files.binary,
        )
    else:
        ctx.actions.run(
            executable = "cp",
            arguments = [ctx.files.binary[0].path, out.path],
            outputs = [out],
            inputs = ctx.files.binary,
        )

    return [DefaultInfo(files = depset([out]), runfiles = ctx.runfiles([out]))]

def _wasm_attrs(transition):
    return {
        "binary": attr.label(mandatory = True, cfg = transition),
        "precompile": attr.bool(default = False),
        # This is deliberately in target configuration to avoid compiling v8 twice.
        "_compile_tool": attr.label(default = "@envoy//test/tools/wee8_compile:wee8_compile_tool", executable = True, cfg = "target"),
        "_whitelist_function_transition": attr.label(default = "@bazel_tools//tools/whitelists/function_transition_whitelist"),
    }

def envoy_wasm_cc_binary(name, deps = [], tags = [], **kwargs):
    wasm_cc_binary(
        name = name,
        deps = deps + ["@proxy_wasm_cpp_sdk//:proxy_wasm_intrinsics"],
        tags = tags + ["manual"],
        **kwargs
    )
