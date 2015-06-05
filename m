From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Calling irq_set_irq_wake() from .set_irq_wake()?
Date: Fri, 5 Jun 2015 12:47:15 +0300
Message-ID: <55717023.2090908@ti.com>
References: <CAMuHMdXYPcQNCHhGa5kC8omtBw_O=Ua+rRJ+gh3tc6dY0oC5JA@mail.gmail.com>	<alpine.DEB.2.11.1505181626060.4225@nanos>	<5559FCC0.2050302@linaro.org>	<CAMuHMdX7exSoJdnLD9_5ZB3Xmbxud+gPbcy2XJZv6hu9MEvEFg@mail.gmail.com>	<556F5B0F.7040603@ti.com> <20150605053543.3b10d605@rockdesk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150605053543.3b10d605@rockdesk>
Sender: linux-gpio-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 06/05/2015 05:35 AM, Roger Quadros wrote:
> Hi,
> 
> On Wed, 3 Jun 2015 22:52:47 +0300
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
>> Hi Geert,
>>
>> On 05/19/2015 12:38 PM, Geert Uytterhoeven wrote:
>>> On Mon, May 18, 2015 at 4:52 PM, Grygorii.Strashko@linaro.org
>>> <grygorii.strashko@linaro.org> wrote:
>>>> On 05/18/2015 05:31 PM, Thomas Gleixner wrote:
>>>>> On Sun, 17 May 2015, Geert Uytterhoeven wrote:
>>>>>>>>> At least the recursive locking message no longer appears after the revert.
>>>>>>>>>
>>>>>>>>> [   30.591905] PM: Syncing filesystems ... done.
>>>>>>>>> [   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
>>>>>>>>> [   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>>>>>>>>> [   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>>>>>>> [   30.663678]
>>>>>>>>> [   30.663681] =============================================
>>>>>>>>> [   30.663683] [ INFO: possible recursive locking detected ]
>>>>>>>>> [   30.663688] 4.1.0-rc3 #1115 Not tainted
>>>>>>>>> [   30.663693] ---------------------------------------------
>>>>>>>>> [   30.663697] suspend.sh/2319 is trying to acquire lock:
>>>>>>>>> [   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>>>>>>>> [   30.663722]
>>>>>>>>> [   30.663722] but task is already holding lock:
>>>>>>>>> [   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>>>>>>>
>>>>>>>> Does this mean .set_irq_wake() cannot call irq_set_irq_wake()?
>>>>>
>>>>> It can call it, if it's guaranteed that this wont deadlock.
>>>>>
>>>>> To tell lockdep that you sure about that, you need to set a different
>>>>> lock class for the child interrupts. irq_set_lockdep_class() is what
>>>>> you want to use here.
>>>>
>>>> Hm. Seems we already have corresponding call in gpiochip_irq_map:
>>>>
>>>>    static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
>>>>                               irq_hw_number_t hwirq)
>>>> {
>>>>           struct gpio_chip *chip = d->host_data;
>>>>
>>>>           irq_set_chip_data(irq, chip);
>>>>           irq_set_lockdep_class(irq, &gpiochip_irq_lock_class);
>>>> ^^^^
>>>
>>> That piece of code sets the lockdep class of the gpiochip's interrupts, not
>>> the parent interrupt.
>>>
>>> Found out the hard way by adding some debug code ;-)
>> [..]
>>>
>>> However, I cannot reproduce the problem on sh73a0/kzm9g with
>>> s2ram on a current tree (renesas-drivers-2015-05-19-v4.1-rc4 from
>>> (https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git), using
>>>
>>> CONFIG_LOCKDEP_SUPPORT=y
>>> CONFIG_LOCKDEP=y
>>> CONFIG_DEBUG_LOCKDEP=y
>>> CONFIG_PROVE_LOCKING=y
>>>
>>> Wake-up from gpio-keys works fine, no scary messages.
>>>
>>>> commit e45d1c80c0eee88e82751461e9cac49d9ed287bc
>>>> Author: Linus Walleij <linus.walleij@linaro.org>
>>>> Date:   Tue Apr 22 14:01:46 2014 +0200
>>>>
>>>>       gpio: put GPIO IRQs into their own lock clas
>>>>
>>>> added in Kernel v3.16
>>>>
>>>> Roger, can you confirm that you've observed this issue with latest kernel, pls?
>>>
>>> Yes please. Thanks!
> 
> Issue is reproducible on v4.1-rc6
> 
>>
>> Unfortunately, I was able to reproduce it, but have no clue how to fix it gracefully.
>> lockdep_set_class_and_subclass(..,gpio_chip->base)?
>>
>> HW configuration which generates lockdep warning:
>>
>> [SOC GPIO bankA.gpioX] <- irq - [pcf875x.gpioY] <- irq - DevZ.enable_irq_wake(pcf_gpioY_irq);
>>
>> There stacked GPIO chips, but gpiolib uses only one lockdep class for all GPIOirqchips -
>> - gpiochip_irq_lock_class.
> 
> If this is a gpiolib core issue are we (dra7-evm) the only stacked GPIO users facing
> this problem?
> 
> Linus/Alexandre/Geert,
> 
> Please advise what can be done for v4.1. The warning is annoying for dra7-evm users.
> Should we temporarily revert the patch even though it is correct and add it back when the
> gpiolib core issue is fixed?

No. Pls. don't do that. See https://lkml.org/lkml/2015/6/3/965

Simple revert is not good solution.

Probably we need to allow GPIO drivers to specify own lockdep class somehow. 

-- 
regards,
-grygorii
