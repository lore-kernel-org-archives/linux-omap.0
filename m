From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: Calling irq_set_irq_wake() from .set_irq_wake()?
Date: Mon, 18 May 2015 17:52:48 +0300
Message-ID: <5559FCC0.2050302@linaro.org>
References: <CAMuHMdXYPcQNCHhGa5kC8omtBw_O=Ua+rRJ+gh3tc6dY0oC5JA@mail.gmail.com> <alpine.DEB.2.11.1505181626060.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:32980 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbEROww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2015 10:52:52 -0400
Received: by lagr1 with SMTP id r1so142395834lag.0
        for <linux-omap@vger.kernel.org>; Mon, 18 May 2015 07:52:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1505181626060.4225@nanos>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ingo Molnar <mingo@redhat.com>, Roger Quadros <rogerq@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/18/2015 05:31 PM, Thomas Gleixner wrote:
> On Sun, 17 May 2015, Geert Uytterhoeven wrote:
>>>>> At least the recursive locking message no longer appears after the revert.
>>>>>
>>>>> [   30.591905] PM: Syncing filesystems ... done.
>>>>> [   30.623060] Freezing user space processes ... (elapsed 0.003 seconds) done.
>>>>> [   30.634470] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>>>>> [   30.658288] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>>> [   30.663678]
>>>>> [   30.663681] =============================================
>>>>> [   30.663683] [ INFO: possible recursive locking detected ]
>>>>> [   30.663688] 4.1.0-rc3 #1115 Not tainted
>>>>> [   30.663693] ---------------------------------------------
>>>>> [   30.663697] suspend.sh/2319 is trying to acquire lock:
>>>>> [   30.663719]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>>>> [   30.663722]
>>>>> [   30.663722] but task is already holding lock:
>>>>> [   30.663734]  (class){......}, at: [<c0096ebc>] __irq_get_desc_lock+0x48/0x88
>>>>
>>>> Does this mean .set_irq_wake() cannot call irq_set_irq_wake()?
> 
> It can call it, if it's guaranteed that this wont deadlock.
> 
> To tell lockdep that you sure about that, you need to set a different
> lock class for the child interrupts. irq_set_lockdep_class() is what
> you want to use here.

Hm. Seems we already have corresponding call in gpiochip_irq_map:

 static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
			    irq_hw_number_t hwirq)
{
	struct gpio_chip *chip = d->host_data;

	irq_set_chip_data(irq, chip);
	irq_set_lockdep_class(irq, &gpiochip_irq_lock_class);
^^^^

commit e45d1c80c0eee88e82751461e9cac49d9ed287bc
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Tue Apr 22 14:01:46 2014 +0200

    gpio: put GPIO IRQs into their own lock clas

added in Kernel v3.16

Roger, can you confirm that you've observed this issue with latest kernel, pls?

> 
>>>> Many GPIO drivers do that, as they need to propagate wake-up state to the
>>>> parent interrupt controller?
>>>
>>> As I remember, there was similar problem, so I found corresponding patch (just FYI)
>>>
>>> ab2b926 mfd: Fix twl6030 lockdep recursion warning on setting wake IRQs
>>>
>>> Not sure such kind of solution is the best choice (
>>
>> That looks like a convoluted solution...
> 
> Indeed. See above.


-- 
regards,
-grygorii
