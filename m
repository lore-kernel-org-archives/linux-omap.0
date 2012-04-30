From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Mon, 30 Apr 2012 15:46:56 +0300
Message-ID: <1335790016.2149.185.camel@sokoban>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	 <1335173044.2149.64.camel@sokoban> <87obqhawig.fsf@ti.com>
	 <1335532591.2149.163.camel@sokoban>  <87fwbowyuu.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57816 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab2D3MrA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 08:47:00 -0400
In-Reply-To: <87fwbowyuu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2012-04-27 at 16:15 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > On Tue, 2012-04-24 at 10:07 -0700, Kevin Hilman wrote:
> 
> [...]
> 
> >> > From 26733dd988ccc9e72355a39e01b2d6e9215a892d Mon Sep 17 00:00:00 2001
> >> > From: Tero Kristo <t-kristo@ti.com>
> >> > Date: Mon, 23 Apr 2012 12:14:46 +0300
> >> > Subject: [PATCH] ARM: OMAP3: PM: move wakeup event ack to hwmod_io handler
> >> >
> >> > PRCM IO interrupts are handled with a shared interrupt handler logic.
> >> > Currently hwmod_io is processing the actual event, but the acking
> >> > of the IO wakeups is done from the PM code with a separate handler.
> >> > If a wakeup event is detected during init before the PM code is in
> >> > place, the interrupt handler can hang in an infinite loop. Fix this
> >> > by removing the pm_io handler, and calling its functionality from
> >> > within the hwmod_io handler. This fix applies only to OMAP3, as
> >> > OMAP4 does not have similar wakeup handling logic.
> >> >
> >> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> 
> >> 
> >> Doesn't this mean that even on a !PM kernel that IO events might still
> >> be firing for nothing?
> >
> > I actually disabled the IO handler in !PM kernel, as I thought this
> > would be a problem there.
> 
> OK
> 
> >> Seems like it would be better to ensure that these interrupts are just
> >> disabled until the PM core initializes and can enable them.
> >
> > I thought about this but I couldn't figure out a clean way to do this.
> > If I do irq_request, it automatically enables the interrupt, and if
> > there is an interrupt pending it will fire immediately and get stuck. 
> 
> hmm, I thought there was a flag for disabling the auto-enable feature...
> /me looks
> 
> Yup, from <linux/irq.h>
> 
>  * IRQ_NOAUTOEN			- Interrupt is not automatically enabled in
>  *				  request/setup_irq()
> 
> With that, we can just set all the PRCM IRQs to be disabled until
> explicitly enabled using enable_irq().  The following patch (only boot
> tested on OMAP3530/Overo and OMAP4430/Panda) should take care of it.
> 
> Do you think that should solve this problem?

Yea that works. However your patch implements the disable for all PRCM
interrupts, and this is only needed for the IO event on OMAP3. How about
something like this:

--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -691,6 +691,8 @@ static int __init omap3_pm_init(void)
                goto err2;
        }
 
+       enable_irq(omap_prcm_event_to_irq("io"));
+
        ret = pwrdm_for_each(pwrdms_setup, NULL);
        if (ret) {
                pr_err("Failed to setup powerdomains\n");
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c
b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index b8962fe..2b12bb9 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 
 #include "common.h"
 #include <plat/cpu.h>
@@ -339,9 +340,13 @@ static void __init omap3_enable_io_wakeup(void)
 
 static int __init omap3xxx_prcm_init(void)
 {
+       int ret = 0;
+
        if (cpu_is_omap34xx()) {
                omap3_enable_io_wakeup();
-               return
omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+               ret =
omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+               irq_set_status_flags(omap_prcm_event_to_irq("io"),
+                       IRQ_NOAUTOEN);
        }
-       return 0;
+       return ret;
 }



