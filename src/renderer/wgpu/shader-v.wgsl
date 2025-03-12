override render_to_texture: bool;

struct ViewSize {
    x: f32,
    y: f32,
    pad: vec2<f32>,
}

@group(0)
@binding(0)
var<uniform> viewSize: ViewSize;

struct Vertex {
    vertex: vec2<f32>,
    tcoord: vec2<f32>,
}

struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) ftcoord: vec2<f32>,
    @location(1) fpos: vec2<f32>,
};

@vertex
fn vs_main(
    @location(0) vertex: vec2<f32>,
    @location(1) tcoord: vec2<f32>,
) -> VertexOutput {
    var result: VertexOutput;
    result.ftcoord = tcoord;
    result.fpos = vertex;

    if (render_to_texture) {
        result.position = vec4<f32>(2.0 * vertex.x / viewSize.x - 1.0, 2.0 * vertex.y / viewSize.y - 1.0, 0, 1);
    } else {
        result.position = vec4<f32>(2.0 * vertex.x / viewSize.x - 1.0, 1.0 - 2.0 * vertex.y / viewSize.y, 0, 1);
    }
    return result;
}
