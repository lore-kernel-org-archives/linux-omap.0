From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv2 2/5] driver: serial: omap: prevent runtime PM for "no_console_suspend"
Date: Mon, 22 Apr 2013 11:36:50 -0700
Message-ID: <87fvyi8la5.fsf@linaro.org>
References: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com>
	<1366638237-6880-3-git-send-email-sourav.poddar@ti.com>
	<51754DD7.6040904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <51754DD7.6040904@ti.com> (Grygorii Strashko's message of "Mon,
	22 Apr 2013 17:48:55 +0300")
Sender: linux-serial-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> On 04/22/2013 04:43 PM, Sourav Poddar wrote:
>> The driver manages "no_console_suspend" by preventing runtime PM
>> during the suspend path, which forces the console UART to stay awake.
>>
>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>> ---
>>   drivers/tty/serial/omap-serial.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 08332f3..640b14e 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1582,7 +1582,7 @@ static int serial_omap_runtime_suspend(struct device *dev)
>>   	struct uart_omap_port *up = dev_get_drvdata(dev);
>>   	struct omap_uart_port_info *pdata = dev->platform_data;
>>   -	if (!up)
>> +	if (!up || (!console_suspend_enabled && uart_console(&up->port)))
>>   		return -EINVAL;
> Hi Sourav,
> No ) You will block Runtime PM for console UART forever, but instead
> it need to be blocked only during suspend - autosuspend should
> continue working.

Correct.  

Sourav, as I mentioned when I suggested this approach, it should be done
*only* during suspend.

> But this will be not easy, again, -
> because System suspend isn't synchronized with Runtime PM (I mean,
> serial_omap_suspend/resume() may be called from one thread and
> serial_omap_runtime_suspend/resume() from another at same time).
> And now, serial_omap_suspend() callback is the only one place where you
> can detect that system is going to sleep.

So set an 'is_suspending' flag in ->suspend (it may need to be in
->prepare) and clear it in ->resume (->complete), and check the flag in
the ->runtime_supend() callback.  It's not uncommon for drivers to have
such a flag for various reasons.

> Personally, i don't believe in such approach (my experiences from K3.4
> said me that there will be more problems than benefits).
>
> And, I like combination of "no_console_suspend" in bootargs +
> "ti,no_idle_on_suspend" for console UART in DT, because 1) it's debug
> option and 2) until
> smth. will be decided about OMAP OCP Bus it can be used.
>
> It's just my opinion.

No, we need to get rid of ti,no_idle_on_suspend.  It's an ugly,
OMAP-specific hack (and I'm free to insult it because I introduced it.)

Kevin

