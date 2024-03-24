-- title:   rando strategem
-- author:  Undead Dood
-- desc:    SWEET LIBERTY!!!
-- site:    On teh webs
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

function init()
	prompt={}
	input={}
	score=0
	best_score=0
	time_current=0
	time_max=900
end

init()

function rnd(num) --0 to num
	local r_num=math.floor(math.random(num+1))-1
	return r_num
end

function load_strategem(num)
	prompt={}
	input={}
	local length=4+rnd(num-4)	--min is 4
	while #prompt<length do
		table.insert(prompt,rnd(3))
	end
end

load_strategem(10)	--do this one time before start

function check_input(num)
	if num==prompt[#input+1]
		then
		table.insert(input,num)
		score=score+1
		else
		score=score-#input
		input={}		--clear current progress
		if score<0 then score=0 end
	end
end

function draw_arrows()
	for i=1,#prompt do
		spr(prompt[i]+1,i*16,0,-1,2)
	end
	for i=1,#input do		--draw the input over the prompts
		spr(input[i]+5,i*16,0,-1,2)
	end
end

function timer_bar()
	time_current=time_current+1
	local x_bar=(time_current/time_max)*100		--size taken from time bar
	local clr=2
	if x_bar<67 then clr=4 end		--2/3
	if x_bar<33 then clr=6 end		--1/3 
	rect(8*2,16,100-x_bar,8,clr)
	if x_bar>100 --if time is greater than 100...
		then
		time_current=0		--reset time to zero
		load_strategem(10)	--pick a new sequence
		if score>best_score
			then
			best_score=score		--save the best score
		end 
	end
end

function TIC()
	cls()
	draw_arrows()
	if #prompt==#input then load_strategem(10) end	--checks if both tables are the same size

	if btnp(0) then check_input(0) end
	if btnp(1) then check_input(1) end
	if btnp(2) then check_input(2) end
	if btnp(3) then check_input(3) end
	
	print("SCORE:",16,8*4,6)
	print(score,8*7,8*4,6)
	print("BEST SCORE:",16,8*6,6)
	print(best_score,8*11,8*6,6)
	timer_bar()
end
