// NOTE: This has only been tested on ruby 1.8.7.

#include <ruby.h>
#include <node.h>
#include <env.h>

#define AUTOPLUCK_MODULE_NAME "Autopluck"
#define AUTOPLUCK_FUNCTION_NAME "__extract_symbol"

// This is just the first couple fields from Ruby 1.8.7's BLOCK structure. In this case, we
// don't care about the first field, but we need it to be present so we know where the
// body begins. See eval.c in ruby-1.8.7.
struct BLOCK {
  NODE *__padding, *body;
};

// The only BLOCK body with nd_state of YIELD_FUNC_LAMBDA is a symbol that has been converted
// into a proc. See eval.c in ruby-1.8.7.
#define YIELD_FUNC_LAMBDA 5

static VALUE rb_extract_symbol(VALUE self, VALUE proc) {
  struct BLOCK *data;
  NODE *body;

  // Populate the BLOCK structure...
  Data_Get_Struct(proc, struct BLOCK, data);

  body = data->body;

  // If the state is correct, then we know that body->u2.value is an ID referring to the
  // symbol that was converted to a proc. Yank it out. Return nil otherwise.
  return body->nd_state == YIELD_FUNC_LAMBDA ? ID2SYM(body->u2.value) : Qnil;
}

void Init_autopluck(void) {
  VALUE module;

  module = rb_define_module(AUTOPLUCK_MODULE_NAME);

  rb_define_module_function(module, AUTOPLUCK_FUNCTION_NAME, rb_extract_symbol, 1);

  // Yep, it's this verbose to call private.
  rb_funcall(module, rb_intern("private"), 1, ID2SYM(rb_intern(AUTOPLUCK_FUNCTION_NAME))); 
}
