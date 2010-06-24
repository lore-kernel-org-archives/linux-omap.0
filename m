From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Thu, 24 Jun 2010 10:23:05 -0700
Message-ID: <87r5jwgxae.fsf@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
	<1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com>
	<87mxvebrry.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com>
	<87hbkw1idx.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006211130120.1550@utopia.booyaka.com>
	<87fx0gos2j.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006231832570.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33935 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0FXRXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:23:09 -0400
Received: by pwj8 with SMTP id 8so1946291pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:23:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006231832570.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 23 Jun 2010 21:27:48 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> On Mon, 21 Jun 2010, Kevin Hilman wrote:
>
>> Paul Walmsley <paul@pwsan.com> writes:
>> 
>> > I guess the intent of your patch is to avoid having to patch in 
>> > omap_device_{idle,enable}() into a bunch of driver DPM suspend/resume 
>> > callbacks?  
>> 
>> Partially.  Actually, I think many (most?) drivers can get rid of
>> static suspend/resume paths all together and just use runtime PM.
>> 
>> There are some cases though (MMC comes to mind, more on that below)
>> where static suspend has some extra steps necessary and behaves
>> differently than runtime PM.
>
> It's not just MMC, any driver that can be in the middle of doing something 
> during DPM ->suspend() will need to have DPM suspend code to stop what 
> it's doing and quiesce the device before returning from the suspend 
> callback.  

I don't think we do a very good job of that today in most drivers, but
your point is valid.

Probably best to "trick" the runtime PM core by doing a runtime PM
put/get in the bus code as you suggest below to avoid this kind of
potential conflict.

> Either that, or ->suspend() needs to return an error and block 
> the system suspend process...
>

[...]

>> >   Right now the OMAP2+ codebase doesn't use any
>> >   shared interrupts for on-chip devices, as far as I can see.  It
>> >   looks like you use ->suspend_noirq() to ensure your code runs after
>> >   the existing driver suspend functions.  
>> 
>> No. The primary reason for using _noirq() is that if any driver ever
>> did use the _noirq() hooks (for any atomic activity, or late wakeup
>> detection, etc.)  the device will still be accessible.
>>
>> >   Using ->suspend_noirq() for this purpose seems like a hack.  
>> >   A better place for that code would be in a bus->pm->suspend()
>> >   callback, which will run after the device's dev_pm_ops->suspend()
>> >   callback.
>> 
>> I originally put it in bus->pm->suspend, but moved it to
>> bus->pm->suspend_noirq() since I didn't do a full audit so see
>> if anything was using the _noirq hooks.
>> 
>> If we want to have a requirement that no on-chip devices can use the
>> _noirq hooks (or at least they can't touch hardware in those hooks)
>> then I can move it back to bus->pm->suspend().
>
> That sounds like the best argument for keeping these hooks in 
> _noirq() -- some driver writer may be likely to use suspend_noirq() 
> without understanding that they shouldn't... maybe we should add some code 
> that looks for this and warns.
>
> But thinking about it further, it also seems possible that a handful of 
> OMAP drivers might use shared IRQs at some point in the future.  DSS comes 
> to mind -- that really is a shared IRQ.  So, _noirq() is fine, then.

OK.

[...]

>> > - It is not safe to call omap_device_{idle,enable}() from DPM
>> >   callbacks as the patch does, because they will race with runtime PM
>> >   calls to omap_device_{idle,enable}().  
>> 
>> No, they cannot race.  
>> 
>> Runtime PM transitions are prevented by the system PM core during a
>> system PM transition.  The system suspend path does a pm_runtime_get()
>> for each device being suspended, and then does a _put() upon resume.
>> (see drivers/base/power/main.c, grep for pm_runtime_)
>
> Yes, you are correct in terms of my original statement.  But the problem 
> -- and the race -- that I did a poor job of describing is still present.
>
> What if this pm_bus ->suspend_noirq() calls omap_device_idle() while other 
> code in the driver is still in the middle of interacting with the device?  
> Although that would certainly be a driver bug, I certainly wouldn't trust 
> all of our existing driver DPM suspend* functions to adequately wait for 
> in-progress operations to complete and block new operations from starting 
> before returning.

Yes, I see the point now, and I agree that this is a problem.

> We shouldn't idle (and potentially power off) a device unless we know its 
> driver is done with it.  In an ideal world, this would always be taken 
> care of by driver ->suspend()/->suspend_noirq() functions.  But we know 
> this isn't always the case -- perhaps it's not even the case for most of 
> the OMAP drivers.

Yeah, I don't think we handle this very well currently in most drivers.

> We can use the device's runtime PM state to figure out whether the driver 
> thinks it's done with the device.  Unfortunately, the existing Linux DPM 
> suspend code makes it difficult to deal with this by calling 
> pm_runtime_get_noresume() before entering suspend and never calling 
> pm_runtime_put() until after resume -- no idea why.  

I gathered it was intended to minimize potential conflicts between
system PM and runtime PM, but not sure.  I may ask on linux-pm.

> That strikes me as a bug.  From a semantic perspective it is certainly
> confusing: the PM runtime implementation will think the device is
> still active after it's been suspended.  I wouldn't want the full
> Linux system suspend code to enter some low power state while some
> driver still thought its device should stay powered.

Completely agree here, and this is the root cause of all this funny
business in the first place.

If I we could just put pm_runtime_put_sync() in the driver's suspend
routine (and _get_sync() in the resume routine) this patch would be
totally unncessary.

> Anyway, given this strange behavior, I think there is probably a simple 
> workaround.  Rather than calling omap_device_idle() in 
> platform_pm_suspend_noirq(), how about calling pm_runtime_put_sync()?  It 
> probably needs a comment to indicate that it's intended to balance the 
> pm_runtime_get_noresume() that's in dpm_prepare().  Similarly it should be 
> possible to replace the omap_device_enable() in platform_pm_resume_noirq() 
> with pm_runtime_get_sync().  That way the pm_bus code will not call 
> omap_device_idle() on a device that the driver has not yet indicated is 
> safe to enter idle.

Hehe.  This was actually the original implementation.    

I decided I didn't like having to put those comments to admit defeat
against the DPM core. ;) So, I decided to change it to directly use
omap_device*.  But now, in light of the potential conflicts you raised,
I will go back to this implementation.

Thanks for the thorough feedback,

Kevin
