From: Paul Walmsley <paul@pwsan.com>
Subject: RE: RFC: hwmod, iclks, auto-idle and autodeps
Date: Fri, 10 Dec 2010 00:45:23 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012100011250.13430@utopia.booyaka.com>
References: <87ipzv38o2.fsf@deeprootsystems.com> <alpine.DEB.2.00.1011221948220.20215@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB59302477EB871@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41865 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0LJHpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 02:45:24 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302477EB871@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Partha

On Tue, 23 Nov 2010, Basak, Partha wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, November 23, 2010 9:31 AM
> > 
> > The rest of the time, if the GPIO driver wants to use idle-mode 
> > wakeups (presumably higher wakeup latency, but lower power 
> > consumption), it should just clk_disable() its clocks, but not call 
> > pm_runtime_put*().  After
> 
> This would require that clk_disable() be called directly by the driver
> outside of pm_runtime_putsync(). 

Yes.

> Isn't this not in line with runtime PM paradigm?

Not really sure what you mean.  If you're asking whether I'd prefer to 
have this hidden behind some other API, the answer is probably yes.  In 
the medium- to long-term, I do think we should try to figure out a 
coherent way to handle this case without calling 
clk_enable()/clk_disable() directly from the driver.  Maybe by adding some 
omap_device API calls to allow the driver to tell the 
omap_device/omap_hwmod code what level of 'idle' to enter.

But to get there, we have to understand the problem first that we're 
trying to solve.  I'm not sure we (at least I) fully understand that now.  
To the extent our current device drivers rely on asynchronous wakeup or 
autonomous operation, those parts of the drivers are definitely not 
documented.  GPIO seems to tacitly rely on it.  Maybe UART.  (Essentially 
any device that has special hacks in the pm34xx.c idle loop for 
enabling/disabling it.)  And McBSP also has some tricky twists here.  I 
suspect that there are lots of hidden dependencies, like assuming 
interface clock autoidle, or certain powerdomain sleep dependencies, etc.

> > If idle-mode wakeup is used, then the PRCM ISR code that notes the 
> > GPIO wakeup event either needs to enable the GPIO main clock before 
> > calling its ISR, or the GPIO ISR needs to enable its main clock first 
> > thing.  If active-mode interrupts are used, then the GPIO ISR doesn't 
> > need to enable its main clock since it is already running at that 
> > point.
> 
> Enabling main clock via pm_runtime_getsync() in interrupt context will 
> be a problem.  Can we use pm_runtime_get() instead? This will lead to
> some delay in the interrupts getting processed.

If the GPIO interface/functional clock is off, and the GPIO debounce clock
is off, then according to the TRM, the GPIO block will never assert an 
interrupt, so we don't need to worry about the ISR in that case.  This 
state is entered after the last pm_runtime_put_sync() on the GPIO block.

If however, the GPIO driver wants to support idle-mode wakeups, then the 
GPIO debounce clock needs to be running.  pm_runtime_put_sync() cannot 
currently be called in this situation - instead, the driver has to call 
clk_disable() on its ifclk -- or rely on interface clock autoidle -- if it 
wants the GPIO IP block to be able to wake the system from idle mode.  In 
this case, the GPIO ISR _can_ successfully call clk_enable() on the GPIO 
IFCLK, and then clk_disable() once it is done accessing the GPIO block 
registers.  The GPIO ISR should not use pm_runtime_get*() right now, if 
for no other reason than because the driver did not previously call 
pm_runtime_put*().

...

So for the time being, I'd suggest calling clk_enable() on the GPIO ifclk 
as the first thing in the GPIO ISR, and ensuring that clk_disable() is 
called on the ifclk before exiting the ISR.  That should be safe for both 
the idle-mode wakeup and active-mode interrupt GPIO use cases, and should 
be safe for both interface clock auto-idle and interface clock manual 
idle.  And since the last pm_runtime_put*() on the device will prevent the 
GPIO from sending any kind of wakeup or interrupt (since all GPIO clocks 
will be off), pm_runtime_put*() should only be called when the GPIO block 
is not in use and not expected to generate wakeups nor interrupts.

Does this sound reasonable?


- Paul
