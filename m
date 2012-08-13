From: Kevin Hilman <khilman@ti.com>
Subject: Re: debug needed: twl4030 RTC wakeups: repeated attempts fail on Beagle
Date: Mon, 13 Aug 2012 11:24:43 -0700
Message-ID: <87r4rak5uc.fsf@ti.com>
References: <87d32yd1l4.fsf@ti.com> <20120811082739.6bb66bb0@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33345 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556Ab2HMSYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 14:24:48 -0400
Received: by ghbg24 with SMTP id g24so5743176ghb.1
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 11:24:47 -0700 (PDT)
In-Reply-To: <20120811082739.6bb66bb0@notabene.brown> (NeilBrown's message of
	"Sat, 11 Aug 2012 08:27:39 +1000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, Russ Dill <russ.dill@gmail.com>

NeilBrown <neilb@suse.de> writes:

> On Fri, 10 Aug 2012 11:49:27 -0700 Kevin Hilman <khilman@ti.com> wrote:
>
>> Hello,
>> 
>> In doing some automated testing of suspend/resume I noticed that
>> repeated attempts to suspend and resume via RTC wakeup fail on
>> 3530/Beagle and 3730/Beagle-xM, but work fine on 3430/n900, 3530/Overo,
>> 3730/OveroSTORM and 4430/Panda.
>> 
>> When RTC wakeup fails, a UART wakeup will work, and in the logs, you'll
>> see this:
>> 
>> [  316.036132] twl: i2c_read failed to transfer all messages
>> [  316.036163] twl4030: I2C error -13 reading PIH ISR
>> 
>> My guess about what might be happening is that very late in the suspend
>> process (during the noirq hooks), a PMIC interrupt fires, but by this
>> time the I2C driver is runtime suspended (and clock gated.)  Since
>> runtime PM is disabled at this point, I2C reads fail, so the twl4030 IRQ
>> driver cannot talk over I2C to the PMIC to determine the interrupt
>> source.
>
> This area seems to be rife with opportunity for bugs.  I wrote about some of
> it here:  https://lwn.net/Articles/482345/

Yeah, that was a great article.

> I don't know that I saw quite what you are seeing though.
>
> If a PMIC interrupt fires during the noirq phase, the interrupt handler
> shouldn't be run (it isn't marked NOSUSPEND).  However there is probably room
> for a race between the 'suspend' phase and the 'noirq' phase.
>
> When the suspend processing handles the I2C device, the last thing that
> __device_suspend does is
>
> 		__pm_runtime_disable(dev, false);
>
> which will freeze the current runtime_pm state of the I2C device.  If it is
> off, it stays off.  If on, it stays on.

Correct.

> As the noirq phase hasn't been entered yet an interrupt from the PMIC could
> still be handled.  If it is, you get exactly the error you see.

Right, this is what I suspect is happening.  I just haven't had the time
to confirm and/or fix.

> I'm not convinced that the __pm_runtime_disable call is correct.  It think we
> need to stop async runtime_suspends, but we don't need to stop sync
> runtime_resumes. So just a pm_runtime_get should be enough.  But there  is
> possibly an important point I am missing.

Yes, I went back and forth with Rafael on the interactions between
system PM and runtime PM and he pursuaded me that there were a handful
of reasons that system PM needed to block runtime PM transitions.  I
don't recall what they are at the moment (my brain is already being
pre-flushed in preparation for some time off.)

> However if my analysis is correct, then this can be 'fixed' by changing the
> omap i2c suspend routine to do a pm_runtime_get, and the resume routine to do
> a pm_runtime_put.  The I2C will still be put to sleep during suspend by the
> noirq suspend handler, but we will be sure of it being awake during the
> crucial suspend and resume transition.

Hmm, that's a good idea.  Hopefully someone can give it a try before I
get back from vacation. :)

Thanks for the suggestion.

> See also https://lwn.net/Articles/505683/.  Particularly (towards the end)
>
>     If the device might be needed to power down other devices, such as an I2C
>     controller that might be needed to tell some regulator to turn off, then the
>     device should be activated for runtime PM purposes so that it will still be
>     active when runtime PM is disabled. 
>
> (Rafael reviewed this article so it shouldn't be very far from the mark).
>
>
>> 
>> The real mystery is why this happens on Beagle and Beagle-xM, but none
>> of the other OMAP3 boards (at least the ones I have.)
>
> Maybe didn't components of the PMIC are active and have the potential to
> generate an interrupt at an awkward time.  USB and battery chargers seem good
> at that.
>
> Or maybe due to the particular components active and the particular timing,
> the pm_runtime_disable ends up freezing the runtime_pm state in 'on' rather
> than 'off'.
>
>> 
>> Reproducing is easy.  Simply run rtcwake in a loop:
>> 
>>   # while true; do rtcwake -m mem -s 1; done
>> 
>> In my tests, this happens using omap2plus_defconfig (+ initramfs) on
>> v3.6-rc1, v3.5, v3.4, v3.3 but seems to work fine on v3.2.
>> 
>> I'm going on vacation for a few weeks, so any help debugging this would
>> be greatly appreciated. 
>
> Enjoy your vacation!   I don't suppose it ends up in San Diego in late August
> for one of the multitude of conferences there?

No, I'll miss the summer conferences this year, this vacation will be
unplugged.

Kevin

