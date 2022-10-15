# 导入第三方库
import random
import os

# 首先是进行发牌
def deal_card():
	'''随机返回一张卡片'''
	cards = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]  # 11视情况被认为是1
	# 随机抽出一张牌
	card = random.choice(cards)
	# 返回抽出来的这张牌
	return card


# 接着我们进行点数计算
def calculate_score(cards):
	'''传入一个列表，并且返回计算的结果'''
	
	# 如果出现了第一次发牌（两张牌）就11和10的情况
	if sum(cards) == 21 and len(cards)==2:
		return 0

	# 但是ACE可能会导致超过21的情况，而ACE同时还可以是1
	if 11 in cards and sum(cards) > 21:
		cards.remove(11)  # 去掉11
		cards.append(1)  # 修改为1
	return sum(cards)


# 开始进行比较
def compare(user_score, computer_score):
	'''传入用户分数和电脑分数，返回比较的结果'''

	# 如果双方都超过了21
	if user_score > 21 and computer_score > 21:
		return "You went over. You Lost"

	# 其他几种常见的情况
	if user_score == computer_score:
		return "Draw"  # 算作是平局
	elif computer_score == 0:
		return "Lost, opponent has Blackjack!"  # 对方10,11直接获胜
	elif user_score == 0:
		return "Win, have BlackJack"  # 你直接10,11获胜
	elif user_score > 21:
		return "You went over. You Lost"
	elif computer_score > 21:
		return "Opponent went over. You Win"
	elif user_score > computer_score:
		return "You Win"
	else:
		return "You Lost"


# 游戏函数
def play_game():

	# 打印欢迎标语
	print('''
		===================================
		    Welcome to Black Jack Game
		===================================''')

	# 需要使用到的三个变量
	user_cards = []  # 用户的牌
	computer_cards = []  # 电脑的牌
	is_game_over = False  # 游戏是否结束的变量

	# 一次发两张牌
	for _ in range(2):
		user_cards.append(deal_card())
		computer_cards.append(deal_card())

	# 创建一个循环
	while not is_game_over:  # not false 则为 true，不断的进行循环
		
		# 对双方的情况进行计算
		user_score = calculate_score(user_cards)  # 传入用户卡组
		computer_score = calculate_score(computer_cards)  # 传入电脑卡组

		# 进行打印
		print(f"Yourr cards: {user_cards}, current score:{user_score}")
		print(f"Computer's first card: {computer_cards[0]}")  # 对方只会亮出来第一张来给你看

		# 然后就可以判断是否结束或者是否要求发牌
		# 三种情况，一方直接21，或者用户超过了21
		if user_score == 0 or computer_score == 0 or user_score > 21:
			is_game_over = True  # 将游戏结束设定为True，如此not true就是false了
		else:
			# 让用户决定是否要获得一张新的牌
			user_should_deal = input("Type 'y' to get another card, type 'n' to pass: ")
			if user_should_deal == 'y':
				user_cards.append(deal_card())  # 调用抽卡函数，抽一张卡加入到牌组
			else:
				is_game_over = True

	# 电脑小于17的时候，电脑必须抽一次卡
	while computer_score !=0 and computer_score < 17:
		computer_cards.append(deal_card())
		computer_score = calculate_score(computer_cards)


	# 打印结果
	print(f"Your final hand: {user_cards}, final score: {user_score}")
	print(f"Computer's final hand: {computer_cards}, final score: {computer_score}")

	# 打印比较的结果
	print(compare(user_score, computer_score))

# 主函数
if __name__ == '__main__':
	# 要求用户来决定是否玩游戏
	while input("Do you want to play a game of Blackjack? Type 'y' or 'n': ") == "y":
		os.system('clear')
		play_game()