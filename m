From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Calling irq_set_irq_wake() from .set_irq_wake()?
Date: Tue, 19 May 2015 11:38:28 +0200
Message-ID: <CAMuHMdX7exSoJdnLD9_5ZB3Xmbxud+gPbcy2XJZv6hu9MEvEFg@mail.gmail.com>
References: <CAMuHMdXYPcQNCHhGa5kC8omtBw_O=Ua+rRJ+gh3tc6dY0oC5JA@mail.gmail.com>
	<alpine.DEB.2.11.1505181626060.4225@nanos>
	<5559FCC0.2050302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5559FCC0.2050302@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Roger Quadros <rogerq@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On Mon, May 18, 2015 at 4:52 PM, Grygorii.Strashko@linaro.org
<grygorii.strashko@linaro.org> wrote:
> On 05/18/2015 05:31 PM, Thomas Gleixner wrote:
>> On Sun, 17 May 2015, Geert Uytterhoeven wrote:
>>>>>> At least the recursive locking message no longer appears after the revert.
>>>>>>
>>>>>> [   30.591905] PM: Syncing filesystems ... done.
>>>>>> [   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
>>>>>> [   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>>>>>> [   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>>>> [   30.663678]
>>>>>> [   30.663681] =============================================
>>>>>> [   30.663683] [ INFO: possible recursive locking detected ]
>>>>>> [   30.663688] 4.1.0-rc3 #1115 Not tainted
>>>>>> [   30.663693] ---------------------------------------------
>>>>>> [   30.663697] suspend.sh/2319 is trying to acquire lock:
>>>>>> [   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>>>>> [   30.663722]
>>>>>> [   30.663722] but task is already holding lock:
>>>>>> [   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>>>>
>>>>> Does this mean .set_irq_wake() cannot call irq_set_irq_wake()?
>>
>> It can call it, if it's guaranteed that this wont deadlock.
>>
>> To tell lockdep that you sure about that, you need to set a different
>> lock class for the child interrupts. irq_set_lockdep_class() is what
>> you want to use here.
>
> Hm. Seems we already have corresponding call in gpiochip_irq_map:
>
>  static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
>                             irq_hw_number_t hwirq)
> {
>         struct gpio_chip *chip = d->host_data;
>
>         irq_set_chip_data(irq, chip);
>         irq_set_lockdep_class(irq, &gpiochip_irq_lock_class);
> ^^^^

That piece of code sets the lockdep class of the gpiochip's interrupts, not
the parent interrupt.

Found out the hard way by adding some debug code ;-)

gpiochip_irq_map: setting lockdep class for irq 111
gpiochip_irq_map: setting lockdep class for irq 112
gpiochip_irq_map: setting lockdep class for irq 113
gpiochip_irq_map: setting lockdep class for irq 114
gpiochip_irq_map: setting lockdep class for irq 115
gpiochip_irq_map: setting lockdep class for irq 116
gpiochip_irq_map: setting lockdep class for irq 117
gpiochip_irq_map: setting lockdep class for irq 118
gpiochip_irq_map: setting lockdep class for irq 119
gpiochip_irq_map: setting lockdep class for irq 120
gpiochip_irq_map: setting lockdep class for irq 121
gpiochip_irq_map: setting lockdep class for irq 122
gpiochip_irq_map: setting lockdep class for irq 123
gpiochip_irq_map: setting lockdep class for irq 124
gpiochip_irq_map: setting lockdep class for irq 125
gpiochip_irq_map: setting lockdep class for irq 126

pcf857x_irq_set_wake: setting wake for irq 96

However, I cannot reproduce the problem on sh73a0/kzm9g with
s2ram on a current tree (renesas-drivers-2015-05-19-v4.1-rc4 from
(https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git), using

CONFIG_LOCKDEP_SUPPORT=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_PROVE_LOCKING=y

Wake-up from gpio-keys works fine, no scary messages.

> commit e45d1c80c0eee88e82751461e9cac49d9ed287bc
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Tue Apr 22 14:01:46 2014 +0200
>
>     gpio: put GPIO IRQs into their own lock clas
>
> added in Kernel v3.16
>
> Roger, can you confirm that you've observed this issue with latest kernel, pls?

Yes please. Thanks!

>>>>> Many GPIO drivers do that, as they need to propagate wake-up state to the
>>>>> parent interrupt controller?
>>>>
>>>> As I remember, there was similar problem, so I found corresponding patch (just FYI)
>>>>
>>>> ab2b926 mfd: Fix twl6030 lockdep recursion warning on setting wake IRQs
>>>>
>>>> Not sure such kind of solution is the best choice (
>>>
>>> That looks like a convoluted solution...
>>
>> Indeed. See above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
