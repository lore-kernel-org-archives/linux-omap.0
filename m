From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Calling irq_set_irq_wake() from .set_irq_wake()? (was: Re: [PATCH]
 gpio: pcf875x: Revert "gpio: pcf857x: Propagate wake-up setting to parent irq controller")
Date: Sun, 17 May 2015 10:25:54 +0200
Message-ID: <CAMuHMdXYPcQNCHhGa5kC8omtBw_O=Ua+rRJ+gh3tc6dY0oC5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Roger Quadros <rogerq@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Grygorii, Thomas, Ingo,

On Thu, May 14, 2015 at 2:32 PM, Grygorii.Strashko@linaro.org
<grygorii.strashko@linaro.org> wrote:
> On 05/11/2015 08:36 PM, Geert Uytterhoeven wrote:
>> On Mon, May 11, 2015 at 4:13 PM, Roger Quadros <rogerq@ti.com> wrote:
>>> commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
>>> introduces the following recursive locking warning while suspending dra7-evm.
>>>
>>> The issue addressed by that commit has been already resolved by
>>> commit 10a50f1ab5f0 ('genirq: Set IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip')
>>
>> That's not 100% correct: commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up
>> setting to parent irq controller') fixes _two_ things:
>>    1. warning due to missing irq_set_wake / IRQCHIP_SKIP_SET_WAKE,
>>    2. propagating set_wake, so the parent interrupt controller stays awake, as
>>       it's needed for wake-up,
>>
>> Only the first issue is addressed by commit 10a50f1ab5f0 ('genirq: Set
>> IRQCHIP_SKIP_SET_WAKE flag for dummy_irq_chip').
>>
>>> and so let's revert commit b80eef95beb0 ('gpio: pcf857x: Propagate wake-up setting to parent irq controller')
>>>
>>> At least the recursive locking message no longer appears after the revert.
>>>
>>> [   30.591905] PM: Syncing filesystems ... done.
>>> [   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
>>> [   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>>> [   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>> [   30.663678]
>>> [   30.663681] =============================================
>>> [   30.663683] [ INFO: possible recursive locking detected ]
>>> [   30.663688] 4.1.0-rc3 #1115 Not tainted
>>> [   30.663693] ---------------------------------------------
>>> [   30.663697] suspend.sh/2319 is trying to acquire lock:
>>> [   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>> [   30.663722]
>>> [   30.663722] but task is already holding lock:
>>> [   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>
>> Does this mean .set_irq_wake() cannot call irq_set_irq_wake()?
>> Many GPIO drivers do that, as they need to propagate wake-up state to the
>> parent interrupt controller?
>
> As I remember, there was similar problem, so I found corresponding patch (just FYI)
>
> ab2b926 mfd: Fix twl6030 lockdep recursion warning on setting wake IRQs
>
> Not sure such kind of solution is the best choice (

That looks like a convoluted solution...

Thomas, Ingo, can you please chime in w.r.t. calling irq_set_irq_wake()
from .set_irq_wake()?

The thread starts at http://www.spinics.net/lists/linux-gpio/msg05844.html

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
