use leptos::*;

fn main() {
    let world = "world";
    mount_to_body(move || view! { <p>"Hello, " {world} "!"</p> })
}
