using Microsoft.AspNetCore.Mvc;

namespace CodeFire.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GreetingController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetGreeting()
        {
            return Ok("Hello there!");
        }

        [HttpGet("formal")]
        public IActionResult GetFormalGreeting()
        {
            return Ok(new { message = "Greetings, esteemed user!", timestamp = DateTime.UtcNow });
        }
    }
}
