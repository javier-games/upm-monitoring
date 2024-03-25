namespace games.javier.upm.monitoring
{
    public interface ITracker
    {
        void Start();
        string Stop();
        void Flush();
    }
}