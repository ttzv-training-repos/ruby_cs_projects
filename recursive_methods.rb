def test(n)
  return "finish" if n == 0
  test (n-1)
  p n
end

puts test 1

def factorial(n)
  return 1 if n == 0
  return 1 if n == 1
  factorial(n-1) * n
end

p factorial 5

def reverse_string(string)
  return '' if string.length == 0
  return string[-1] + reverse_string(string[0..-2])
end

p reverse_string "recursion"