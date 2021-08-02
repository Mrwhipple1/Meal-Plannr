﻿using Capstone.DAO.Interfaces;
using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class IngredientsSqlDAO : IIngredientsDAO
    {
        private readonly string connectionString;

        private string sqlAddIngredient = "INSERT INTO ingredients (ingredient_name, measurement_unit, ) " +
            "VALUES ( @ingredient_name, @measurment_unit );";


        public IngredientsSqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public bool AddIngredient(Ingredients ingredients)
        {
            bool result = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmdAddIngredient = new SqlCommand(sqlAddIngredient, conn);

                    cmdAddIngredient.Parameters.AddWithValue("@ingredient_name", ingredients.IngredientName);
                    cmdAddIngredient.Parameters.AddWithValue("@measurment_unit", ingredients.MeasurementUnit);

                    int count = cmdAddIngredient.ExecuteNonQuery();

                    if (count > 0)
                    {
                        result = true;
                    }
                }
            }
            catch (Exception ex)
            {
                result = false;
            }
            return result;
        }
    }
}
