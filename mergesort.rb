
ary = [10,5,7,1,22,4,0,-5,10]

a = [5, 10]
b = [1, 7]

x = [2]
y = [1]

c = [8]
d = [1, 9]

def merge(a, b)
  return b[0...1] if a[0].nil?
  return a[0...1] if b[0].nil?
  if a[0] < b[0]
    a[0...1] + merge(a[1..-1], b)
  else
    b[0...1] + merge(a, b[1..-1])
  end
end

p merge a, b

p merge c, d

