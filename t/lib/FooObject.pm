package FooObject;
use Function::Interface::Impl qw(IFoo);

fun foo() :Return() { }

fun new($class) { bless {} => $class };

1;
