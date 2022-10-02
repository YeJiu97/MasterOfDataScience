import os
import random
import time

"""  README

Student Information
-   Student Name: Wangjun Shen
-   Student ID: 110248810

The rules of Black Jack Simulator
1. There are 4 decks are used in one game
2. Contestants: Player 1, Player 2, Dealer
3. Players only play against the Dealer
4. At the beginning of the game, the Dealer will deal two cards to Player 1, Player 2 and himself(or herself)
5. Player 1 first decides whether to want a card or to end. Then Player2 and Dealer
6. Once the selection is over or the value of cards in hand exceeds 21, that player's turn is ended.
7. Dealer's hand total value is less than 17 (excluding 17), then choose to have only one more card;
   otherwise, end directly.
8. If all players and the Dealer have more than 21 in their hands, the Dealer wins.
9. If there are two or more hand cards whose value does not exceed 21, the team closest to 21 wins.
10. If two cards and 21, Black Jack happens! That person will win.

"""

LOOP_TIMES = 1000  # constant, how many times that game will run
GAP_TIME = 1  # constant, Gap time between two turns


def print_welcome():
    """print the welcome screen"""
    print("====================================================="
          "             Welcome to Black Jack Game              "
          "=====================================================")


def card_deck():
    """prepare the deck of card"""
    new_cards = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10] * 4 * 4  # 4 decks are used
    random.shuffle(new_cards)  # shuffling card deck
    return new_cards


def draw_card(left_cards):
    """randomly deal a card"""
    random_number = random.randint(0, len(left_cards) - 1)  # generate a int number
    random_card = left_cards[random_number]
    left_cards.pop(random_number)  # pop that card
    return random_card, left_cards


def calculate_score(hand_cards):
    """calculate the score of cards on hand"""
    # The situation of black jack
    if sum(hand_cards) == 21 and len(hand_cards) == 2:
        return 0

    # the value of ACE will transfer to 1 from 11 if the total score is lager than 21
    if 11 in hand_cards and sum(hand_cards) > 21:
        hand_cards.remove(11)
        hand_cards.append(1)

    return sum(hand_cards)


def display_cards(player_1, player_2, dealer):
    """display everyone's hand cards and the total of score"""
    print(f"Player 1's cards is {player_1}, the total score is {calculate_score(player_1)}")
    print(f"Player 2's cards is {player_2}, the total score is {calculate_score(player_2)}")
    print(f"Dealer's cards is {dealer}, the total score is {calculate_score(dealer)}")


def compare_score(player_1_score, player_2_score, dealer_score):
    """compare scores and return a result"""
    # if all over 21
    if player_1_score > 21 and player_2_score > 21 and dealer_score > 21:
        return "Dealer Win!"

    # if dealer is over 21 and one of players under 21
    if dealer_score > 21 and player_1_score <= 21 or dealer_score > 21 and player_2_score <= 21:
        return "Players Win!"

    # draw situation
    if player_1_score == dealer_score or player_2_score == dealer_score:
        return "Draw"

    # Black Jack
    if dealer_score == 0:
        return "Dealer Win! Black Jack!"
    if player_1_score == 0 or player_2_score == 0:
        return "Players Win! Black Jack!"

    # other situations
    if player_1_score > 21 and dealer_score <= 21:
        if player_2_score > 21:
            return "Dealer Win!"
        elif dealer_score > 21:
            return "Players Win!"
        elif player_2_score > dealer_score:
            return "Players Win!"
        else:
            return "Dealer Win!"

    if player_2_score > 21 and dealer_score <= 21:
        if player_1_score > 21:
            return "Dealer Win!"
        elif dealer_score > 21:
            return "Players Win!"
        elif player_1_score > dealer_score:
            return "Players Win!"
        else:
            return "Dealer Win!"

    return "Dealer Win!"


def run_game():
    """run that black jack game"""
    print_welcome()  # say welcome to players
    new_cards = card_deck()  # generate a list for card deck in a game

    # generate lists for player 1, player 2 and dealer
    player_1 = []
    player_2 = []
    dealer = []

    # deal two cards to each at the start of the game
    for _ in range(2):
        card_got, new_cards = draw_card(new_cards)
        player_1.append(card_got)

    for _ in range(2):
        card_got, new_cards = draw_card(new_cards)
        player_2.append(card_got)

    for _ in range(2):
        card_got, new_cards = draw_card(new_cards)
        dealer.append(card_got)

    # calculate everyone's hand cards' total scores
    player_1_score = calculate_score(player_1)
    player_2_score = calculate_score(player_2)
    dealer_score = calculate_score(dealer)

    # displayer everyone's hand cards and their total scores
    print("Current situation: ")
    display_cards(player_1, player_2, dealer)

    # whether game keeps running or end
    if player_1_score == 0 or player_2_score == 0 or dealer_score == 0:
        pass  # Black Jack!
    else:
        # Player 1 will use a more aggressive strategy
        # 20% is the expected value modified under the aggressive strategy
        while (player_1_score + sum(new_cards) / len(new_cards)) < 21 * 1.1:
            card_got, new_cards = draw_card(new_cards)
            player_1.append(card_got)
            player_1_score = calculate_score(player_1)

        # Player 2 take a more conservative approach
        while (player_2_score + sum(new_cards) / len(new_cards)) < 21 * 0.9:
            card_got, new_cards = draw_card(new_cards)
            player_2.append(card_got)
            player_2_score = calculate_score(player_2)

    # if dealer's total score is lower than 17
    while dealer_score != 0 and dealer_score < 17:
        card_got, new_cards = draw_card(new_cards)
        dealer.append(card_got)
        dealer_score = calculate_score(dealer)

    # show everyone's cards again
    print("Final situation:")
    display_cards(player_1, player_2, dealer)

    # starting compare
    result = compare_score(player_1_score, player_2_score, dealer_score)
    print(result)
    return result


if __name__ == '__main__':
    dealer_win = 0
    players_win = 0
    draw_time = 0
    for _ in range(LOOP_TIMES):
        os.system("cls")
        result = run_game()
        if result == "Players Win!" or result == "Dealer Win! Black Jack!":
            players_win += 1
        elif result == "Draw":
            draw_time += 1
        else:
            dealer_win += 1
        print(f"Current Outcome: Players Win:{players_win}, Dealer Win:{dealer_win}, Draw:{draw_time}")
        time.sleep(0.1)
    if players_win > dealer_win:
        print("It is a good strategy for players to win the Black Jack Game!")
    else:
        print("That strategy may be not a good one to win the Black Jack Game!")
