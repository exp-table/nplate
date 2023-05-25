fn main(x: pub Field, y : pub Field) -> pub Field {
    x + y
}

#[test]
fn test_addition() {
    assert(main(2, 2) == 4);
    assert(main(3, 4) == 7);
}