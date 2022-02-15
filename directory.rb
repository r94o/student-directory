@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  while true do
    puts "Enter Name"
    name = STDIN.gets.chomp

    if name.empty?
      break
    end

    puts "Enter Cohort"
    cohort = STDIN.gets.chomp
    if cohort.empty?
      cohort = "N/A"
    end

    puts "Enter Height in cm"
    height = STDIN.gets.chomp

    puts "Enter Country of Birth"
    birth_country = STDIN.gets.chomp

    # add the student hash to the array
    add_student_details(name, cohort, height, birth_country)
    
    puts "Now we have #{@students.count} students"
    # return the array of students
  end
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_students_list
  if @students.length >= 1
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort) Height: #{student[:height]}, born in #{student[:birth_country]}.".center(50)
    end
  end
end

def print_footer
  if @students.length == 1
    student_text = "student"
  else
    student_text = "students"
  puts "Overall, we have #{@students.count} great #{student_text}".center(50)
  end
end

def filter_students
  puts "Do you want to filter by cohort (y/n)"
  filter = STDIN.gets.chomp
  if filter == "y"
    puts "Choose a cohort"
    cohort = STDIN.gets.chomp
    @students.filter! {|student| student[:cohort] == cohort}
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def show_students
  print_header
  filter_students
  print_students_list
  print_footer
end

def print_menu
  #1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
  when "1"
    #input the students
    input_students
  when "2"
    #show the students
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "Please enter a valid number"
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:height], student[:birth_country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, height, birth_country = line.chomp.split(",")
    add_student_details(name, cohort, height, birth_country)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist"
  end
end

def add_student_details(name, cohort, height, birth_country)
  @students << {name: name, cohort: cohort, height: height, birth_country: birth_country}
end


try_load_students
interactive_menu