namespace games.javier.upm.monitoring
{
    public class DefaultTracker : ITracker
    {
        public void Start() { }

        public string Stop() => string.Empty;

        public void Flush() { }
    }
}