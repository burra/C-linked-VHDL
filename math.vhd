package math is
  -- a standard C library function
  function sin (v : real) return real;
  attribute foreign of sin : function is "VHPIDIRECT sin";

  -- my own c function
  function divide (num, denom : real) return real;
  attribute foreign of divide : function is "VHPIDIRECT divide";
end math;

package body math is
  function sin (v : real) return real is
  begin
    assert false severity failure;
  end sin;

  function divide (num, denom : real) return real is
  begin
    assert false severity failure;
  end divide;

end math;
