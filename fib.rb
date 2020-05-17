def fib(n)
    return 0 if n == 0
    return 1 if n == 1 
    fib(n-1) + fib(n-2)
end

def fibseq(n)
    ary = []
    n.times { |i| ary << fib(i) }
    ary
end

puts fib 10

p fibseq 10
