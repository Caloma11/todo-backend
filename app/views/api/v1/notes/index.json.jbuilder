json.array! @notes do |note|
  json.extract! note, :id, :title, :description
end
