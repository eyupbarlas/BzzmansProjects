using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _8_Rooks_Problem
{
    class Program
    {
		private static int N = 8; // One dimension of the chess board.
        private static int k = 1; // Step counter
		
        // Printing out the chess board step by step
        public static void PrintBoard(string[,] board)
        {
            Console.Write("{0}-\n", k++);
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    Console.Write(String.Format("{0}    ", board[i, j]));
                }

                Console.WriteLine("\n");
            }

            Console.WriteLine();
        }

        // Checking if the new rook placement is true or not.
        public static Boolean IsSafe(string[,] board, int row, int column)
        {
            int i, j;

            if (board[row, column] == "R") // if there are any rooks on that coordinate
            {
                return false;
            }
            else // are the other coordinates are safe from other rooks' move?
            {
                for (i = 0; i < N; i++)
                {
                    for (j = 0; j < N; j++)
                    {
                        if ((board[row, j] == "R") || (board[i, column] == "R"))
                            return false;
                    }
                }
            }

            return true;
        }

        // Creating random coordinates every time and checks if places are true
        public static void RandomCoordinator(string[,] board)
        {
            var rand = new Random(); // Random object

            for (int i = 0; i < N; i++)
            {
                Randomize:
                // creating random coordinates
                var randomRow = rand.Next(0, 8);
                var randomColumn = rand.Next(0, 8);

                if (IsSafe(board, randomRow, randomColumn)) // After confirmation, rook is added successfully.
                {
                    board[randomRow, randomColumn] = "R";
                }
                else
                {
                    goto Randomize;
                }

                PrintBoard(board); // Printing out the board.
            }
        }

        public static void Main(string[] args)
        {
            // Chess board
            string[,] board = new String[N, N];

            // Empty chess board.
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    board[i, j] = "0";
                }
            }

            RandomCoordinator(board);

            Console.WriteLine("\nPress Enter for exit...");
            Console.ReadLine();
        }
    }
}