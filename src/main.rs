use leptos::*;

/*
// Use `wee_alloc` as the global allocator.
#[global_allocator]
static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;
*/

fn main() {
    let world = "world";
    mount_to_body(move || view! { <p>"Hello, " {world} "!"</p> })
}
