#![feature(plugin)]
#![plugin(rocket_codegen)]

extern crate rocket;
extern crate rocket_contrib;
extern crate tera;

mod static_files;

use rocket_contrib::Template;
use tera::Context;

#[get("/")]
fn index() -> Template {
    let context = Context::new();
    Template::render("index", &context)
}

fn main() {
    rocket::ignite()
        .mount("/", routes![index, static_files::all])
        .attach(Template::fairing())
        .launch();
}