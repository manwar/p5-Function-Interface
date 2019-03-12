use Test2::V0;
use lib 't/lib';

use Class::Load qw(load_class);
use Function::Interface::Types qw(ImplOf);

subtest 'simple' => sub {
    use Foo;
    my $type = ImplOf['IFoo'];
    ok $type->check('Foo');
};

subtest 'object' => sub {
    use FooObject;
    my $type = ImplOf['IFoo'];
    my $e = FooObject->new;
    ok $type->check($e);
};

subtest 'not loaded' => sub {
    # DO NOT use FooClone;
    my $type = ImplOf['IFoo'];

    ok not $type->check('FooClone');
    is $type->get_message('FooClone'), 'FooClone is not loaded';
};

subtest 'not impl' => sub {
    use FooNotImpl;
    my $type = ImplOf['IFoo'];

    ok not $type->check('FooNotImpl');
    is $type->get_message('FooNotImpl'), 'Value "FooNotImpl" did not pass type constraint "ImplOf[IFoo]"';
};

subtest 'impl IFoo & IBar' => sub {
    use FooBar;
    my $type = ImplOf['IFoo', 'IBar'];

    ok $type->check('FooBar');
    ok not $type->check('Foo');
    ok not $type->check('Bar');
};

done_testing;
