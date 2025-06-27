using Microsoft.Extensions.Configuration;

namespace TaskManager.Configuration
{
    public static class DatabaseConfig
    {
        public static string BuildConnectionString(IConfiguration configuration)
        {
            return $"Host={configuration["POSTGRES_HOST"]};" +
                   $"Port={configuration["POSTGRES_PORT"]};" +
                   $"Database={configuration["POSTGRES_DATABASE"]};" +
                   $"Username={configuration["POSTGRES_USERNAME"]};" +
                   $"Password={configuration["POSTGRES_PASSWORD"]}";
        }
    }
}
