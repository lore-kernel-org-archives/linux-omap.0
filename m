From: Paul Walmsley <paul@pwsan.com>
Subject: Re: RFC: hwmod, iclks, auto-idle and autodeps
Date: Mon, 22 Nov 2010 21:01:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011221948220.20215@utopia.booyaka.com>
References: <87ipzv38o2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46172 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab0KWEBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 23:01:10 -0500
In-Reply-To: <87ipzv38o2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Partha Basak <p-basak2@ti.com>, Charulatha Varadarajan <charu@ti.com>, linux-omap@vger.kernel.org

Hi

Kevin and I discussed this privately, this is just to summarize for 
everyone else.

On Wed, 17 Nov 2010, Kevin Hilman wrote:

> There have been a few discussions over the few months about how to
> properly use omap_hwmod to manage certain IPs that have the interface
> clock as the functional clock (e.g. OMAP3 GPIOs.)  The goal of this RFC
> is to come to a conclusion about what should be done, and how to go
> about implementing it.
> 
> In the initial conversion of the GPIO core to omap_hwmod, main_clk was 
> left NULL so that hwmod was not managing the clock on every hwmod 
> enable/disable.

Since GPIO has a register target, main_clk cannot be null.  There's an 
erroneous comment in plat/omap_hwmod.h about this; I'll add it to my list 
of things to fix.

> This behavior matched current mainline GPIO code, which does not 
> dynamically disable/enable GPIO iclks after init time. Instead, it 
> relies on the module-level auto idle feature in HW.
> 
> However, without dynamically managing the clock in hwmod, this meant
> that there were no autodeps tracked for GPIO and thus the PER
> powerdomain could transition independently of MPU/CORE.

The current GPIO driver works only because it exploits some incidental 
properties of the OMAP core code.  It implicitly relies on CM_AUTOIDLE = 1 
on its iclk for power management to work, since the driver never disables 
its iclk.  The driver also relies on the addition of MPU/IVA2 autodeps to 
avoid losing logic context once all devices in PER go idle.  And by never 
explicitly disabling its iclk, the driver avoids dealing with the various 
GPIO wakeup/interrupt modes, causing its context save/restore to be 
implemented as a weird hack in pm34xx.c.

That said, there definitely is one real limitation/bug in the OMAP PM core 
code that the GPIO driver has to work around.  The current core code 
doesn't try to keep a powerdomain powered when an IP block inside the 
powerdomain is still considered to be in use but all its system-sourced 
clocks are cut.  This can result in unexpected context loss and 
malfunction in some GPIO and McBSP cases, possibly some other modules also 
that can be externally clocked and contain FIFOs/buffers, or that can 
generate asynchronous wakeups.  There's a patch in the works here that 
will require a powerdomain to stay on as long as a hwmod in that 
powerdomain is enabled.  Once omap_hwmod_idle() is called for that hwmod, 
the lower-bound on the power state of the powerdomain is removed.

So in the context of the PM runtime conversion of the GPIO driver, the 
thing to do is to only do a pm_runtime_put*() once the GPIO module is 
really ready to be powered down.  After that call, the GPIO block may lose 
its logic context, and it may not be able to generate interrupts or 
wakeups.  We may enforce the latter in the hwmod code for debugging 
purposes by forcing the module into idle and instructing the PRCM to 
ignore wakeups from the module in omap_hwmod_idle().  IO ring/chain 
wakeups may still occur, but these are independent of the GPIO block.

The rest of the time, if the GPIO driver wants to use idle-mode wakeups 
(presumably higher wakeup latency, but lower power consumption), it should 
just clk_disable() its clocks, but not call pm_runtime_put*().  After the 
previously-mentioned improvement to the powerdomain/hwmod code is 
completed and applied, that should result in the powerdomain staying 
powered, but all clocks being disabled.  Otherwise, if the GPIO driver
wants to use active-mode interrupts (presumably lower wakeup latency, but 
higher power consumption), then the driver should just leave its clocks 
enabled and never call pm_runtime_put*().

Both of these latter modes will block some low-power states.  At some 
point, the selection of the interrupt/wakeup mode -- GPIO active, GPIO 
idle, IO ring/chain -- should be made based on the required wakeup latency 
of the GPIO user.  Multiple modes may need to used simultaneously, since 
individual modes are restricted to certain power states (e.g. IO ring is 
only available in CORE off, IO chain is only available in CORE/PER 
retention)

> The initial solution to this was to set the iclk to be the main_clk of 
> the hwmod, such that autodeps were managed dynamically as well.  This 
> led to a change in functionality in current code, since the iclk was now 
> being manually enabled/disabled at runtime instead of being left for HW 
> to manage by module autoidle.  It also led to problems in correctly 
> handling asynchronous GPIO wakeups.

If idle-mode wakeup is used, then the PRCM ISR code that notes the GPIO 
wakeup event either needs to enable the GPIO main clock before calling its 
ISR, or the GPIO ISR needs to enable its main clock first thing.  If 
active-mode interrupts are used, then the GPIO ISR doesn't need to enable 
its main clock since it is already running at that point.

> Alternatively, would it make sense to do something different with
> autodeps, such that modules like this that don't have a separate
> functional clock still have autodeps handled, possibly by using an
> optional clock?
> 
> Does extending autodeps make sense since, IIUC, we won't really need
> them after all devices are using hwmod?

The goal is definitely to get rid of the autodeps.  They are an old CDP 
artifact that shouldn't be necessary once the device power control is 
cleaned up.  The autodeps are almost certainly wasting power - they are 
added for every clockdomain for both the MPU and IVA2 processor modules.
Hopefully they should be removable after the hwmod conversion is complete 
and targeted dependencies have been added for chip limitations/bugs (e.g. 
the PER/CORE dependency issues)


- Paul
