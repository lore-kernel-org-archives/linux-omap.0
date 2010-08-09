From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Issues with calling pm_runtime functions in platform_pm_suspend_noirq/IRQ
 disabled context.
Date: Mon, 9 Aug 2010 01:50:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1008082350130.8958@utopia.booyaka.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0FDF@dbde02.ent.ti.com> <alpine.DEB.2.00.1008061305360.5732@utopia.booyaka.com> <B85A65D85D7EB246BE421B3FB0FBB59301E800BD63@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44105 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0HIHui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 03:50:38 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E800BD63@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Basak, Partha" <p-basak2@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

On Sat, 7 Aug 2010, Basak, Partha wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Saturday, August 07, 2010 1:00 AM
> > 
> > On Tue, 3 Aug 2010, Basak, Partha wrote:
> > 
> > > I believe, it is not correct to call the pm_runtime APIs from interrupt
> > > locked context
> > 
> > Why do you think that the PM runtime APIs are being called from interrupt
> > context?  Could you point out the call chain that you're seeing?
> >
> I meant that they should not not be called in a context which has 
> interrupts disabled. SRAM_Idle as well as suspend_no_irq are the 
> instances I was referring to.

It would be really helpful if you would use the exact names of the 
functions that you are referring to. This message assumes that your use of 
"SRAM_Idle" refers to omap_sram_idle() in pm34xx.c, and that 
"suspend_no_irq" refers to platform_pm_suspend_noirq() in pm_bus.c.

You write that "[the PM runtime functions] should not not be called in a 
context which has interrupts disabled."  All interrupts?  Some interrupts?  
"Context" in the general sense, or in the strict sense used in Linux 
interrupt handling?  It is difficult to comment on this statement since it 
is unclear.  I will guess that your message refers to the fact that some
of the PM runtime functions take a mutex, and therefore it is invalid to 
call those functions when the timer interrupt is disabled.

If that's what you mean, then it's worth observing that it's valid to call 
some PM runtime functions, such as pm_runtime_get_noresume(), 
pm_runtime_suspended(), etc., no matter which interrupts are enabled, 
since they don't take any mutex.  Similarly, it seems quite valid to call 
pretty much any PM runtime function as long as the timer interrupt is 
still running.  This is the case with platform_pm_suspend_noirq(), at 
least, with this call chain:

dpm_suspend_noirq() ->
  device_suspend_noirq() ->
    pm_irq_op() ->
      dev_pm_ops.suspend_noirq ->
         platform_pm_suspend_noirq()

Unfortunately, your message didn't provide a call chain, so, not sure if 
we're even referring to the same code path.  Based on this chain, I don't 
see any interrupt-related problems with calling PM runtime functions from 
platform_pm_suspend_noirq().  If you are actually seeing some problem 
here, then you should post the warning that you're seeing and the call 
chain that's causing the problem.

Finally, we have omap_sram_idle():

> In particular, for USB, while executing SRAM_Idle, is we use pm_runtime 
> functions, we see spurious IO-Pad interrupts.

Your message doesn't specify what PM runtime functions you are executing.  
But if those functions are calling mutex_lock(), then they obviously must 
not be called from omap_sram_idle() in interrupt context.

It's not clear from your message why you need to call PM runtime functions 
from the idle loop.  I'd suggest that you post the problematic code in 
question to the list.


- Paul
