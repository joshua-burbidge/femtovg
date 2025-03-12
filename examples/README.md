All the demos can be run using `cargo run --example $name`


# Running the main demo in the Web Browser

To run the demo as a WASM example, a few steps are needed:

```sh
cargo install wasm-bindgen-cli
cargo build --target=wasm32-unknown-unknown --example demo
wasm-bindgen ./target/wasm32-unknown-unknown/debug/examples/demo.wasm --out-dir examples/generated --target web

cd examples/
python3 -m http.server
```

Then browse to http://localhost:8000/ with a WebGL enabled browser.

------------------

- override not found error fixed by adding references to the override in the vs_main entrypoint. The constants were likely being optimized out because they were never used.
- Then, "uninitialized pipeline overridable constants" error. It goes away if I set default values in the wgsl file, but it does not render correctly.
  - All the consts that are used in the fragment stage are saying they are uninitialized.**
  - const mapping: 
    - bools: 0.0 and NaN are false, else true
    - i32: truncates, error if infinite or out of bounds of i32
    - u32: same
    - f32, f64: same
  - webgpu is wrapper around vulkan?
  - naga src/renderer/wgpu/shader.wgsl my_shader.vert --override enable_glyph_texture=1.0,shader_type=1.0,render_to_texture=1.0 --profile es310 --entry-point vs_main
  
Split up shaders into two files?
  
