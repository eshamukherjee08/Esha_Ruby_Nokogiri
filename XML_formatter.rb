require 'nokogiri'

# Module comprising of xml file scanner and builder
module Formatting
  
  # Method to return array of text elements of xml file passed.
  def scanner(filename)
     building(Nokogiri::XML(File.open(filename)).text.scan(/[a-zA-Z']+(?=\n)/))
  end
   
  # Method to build xml in new format with text extracted from input file format
  def building(array_XMLtext)
    objects, counter, new_file = [Object.new], 0, File.new("new_format.xml","w")
     builder = Nokogiri::XML::Builder.new do |xml|
       # creation first node people.
       xml.people {
         # creation second node person.
         xml.person {
           objects.each do
             #creation of third node and inner most text nodes.
             while (counter < array_XMLtext.size) do
               xml.name{ xml.first array_XMLtext[counter] ; xml.last array_XMLtext[counter+1] }
               counter+=2
             end
           end
         }
       }
     end
     # Writing to new file.
     new_file.puts builder.to_xml
  end
end

# Formatter class to create Formatter object and include Formatting module.
class Formatter
  include Formatting
end

a = Formatter.new
#a.scanner("xml_test.xml")
#a.scanner("xml_test2.xml")
a.scanner("xml_test3.xml")