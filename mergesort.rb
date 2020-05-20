def merge(a, b)
  return b if a[0].nil?
  return a if b[0].nil?
  if a[0] < b[0]
    a[0...1] + merge(a[1..-1], b)
  else
    b[0...1] + merge(a, b[1..-1])
  end
end

def merge_sort(a)
  return a[0...1] if a.length == 1
  half = a.length/2
  ary_a = a[0...half]
  ary_b = a[half..-1]
  left = merge_sort ary_a
  right = merge_sort ary_b
  merge(left, right)
end

def merge_sort_short(a)
  return a[0...1] if a.length == 1
  merge(merge_sort_short(a[0...a.length/2]), merge_sort_short(a[a.length/2..-1]))
end

ary = [10,5,7,1,22,4,0,-5,10]
ary_1 = [65, 61, 85, 90, 23, 84, 63, 75, 36, 13, 1, 94, 91, 74, 41, 49, 42, 51, 29, 10]
ary_2 = [13, 13, 27, 63, 40]
ary_rand = Array.new(5) { rand(1...100) }

p merge_sort ary
p merge_sort_short ary

p ary_rand
p merge_sort_short ary_rand

p ary_1
p merge_sort ary_1

p ary_2
p merge_sort ary_2

