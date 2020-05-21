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

def flatten(a, flat=[])
  a.each do |el|
    if el.is_a?(Array)
      flatten(el, flat)
    else
      flat << el
    end
  end
  flat
end


nested_ary = [6,8,9,[4,2,100,[2,[5,4,1,2],5,8],[2,4,7]],4,[5,7]]
simplenest_ary = [1,[2,[3],2],1]
s_n_ary = [2, 3, [1, 2]]


p flatten s_n_ary
p flatten simplenest_ary
p flatten nested_ary