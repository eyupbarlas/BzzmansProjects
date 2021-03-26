using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _8_Rooks_Problem
{
    class Program
    {
        private static int N = 8; // Chess board dimensions
        private static int k = 1; // Step Counter

        // Printing out the chess board with steps
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

        // Is next rook placement true? Is our new rook safe?
        public static Boolean IsSafe(string[,] board, int row, int column)
        {
            int i, j;

            if (board[row, column] == "R") // seçilen konumda kale bulunması kontrolü
            {
                return false;
            }
            else // diğer konumlar kalenin yeni gelecek kaleyi alabileceği konumda mı kontrolü
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
                // Random coordinates
                var randomRow = rand.Next(0, 8);
                var randomColumn = rand.Next(0, 8);

                if (IsSafe(board, randomRow, randomColumn)) // After confirmation, rook is being added.
                {
                    board[randomRow, randomColumn] = "R";
                }
                else
                {
                    goto Randomize;
                }

                PrintBoard(board);
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