From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Mon, 30 Apr 2012 13:40:28 -0700
Message-ID: <87vckht0lf.fsf@ti.com>
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
	<1335532591.2149.163.camel@sokoban> <87fwbowyuu.fsf@ti.com>
	<1335790016.2149.185.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:49372 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756820Ab2D3Ukc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 16:40:32 -0400
Received: by dang27 with SMTP id g27so5500717dan.29
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 13:40:30 -0700 (PDT)
In-Reply-To: <1335790016.2149.185.camel@sokoban> (Tero Kristo's message of
	"Mon, 30 Apr 2012 15:46:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: "Mohammed, Afzal" <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tero Kristo <t-kristo@ti.com> writes:

> On Fri, 2012-04-27 at 16:15 -0700, Kevin Hilman wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>> 
>> > On Tue, 2012-04-24 at 10:07 -0700, Kevin Hilman wrote:
>> 
>> [...]
>> 
>> >> > From 26733dd988ccc9e72355a39e01b2d6e9215a892d Mon Sep 17 00:00:00 2001
>> >> > From: Tero Kristo <t-kristo@ti.com>
>> >> > Date: Mon, 23 Apr 2012 12:14:46 +0300
>> >> > Subject: [PATCH] ARM: OMAP3: PM: move wakeup event ack to hwmod_io handler
>> >> >
>> >> > PRCM IO interrupts are handled with a shared interrupt handler logic.
>> >> > Currently hwmod_io is processing the actual event, but the acking
>> >> > of the IO wakeups is done from the PM code with a separate handler.
>> >> > If a wakeup event is detected during init before the PM code is in
>> >> > place, the interrupt handler can hang in an infinite loop. Fix this
>> >> > by removing the pm_io handler, and calling its functionality from
>> >> > within the hwmod_io handler. This fix applies only to OMAP3, as
>> >> > OMAP4 does not have similar wakeup handling logic.
>> >> >
>> >> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> >> 
>> >> 
>> >> Doesn't this mean that even on a !PM kernel that IO events might still
>> >> be firing for nothing?
>> >
>> > I actually disabled the IO handler in !PM kernel, as I thought this
>> > would be a problem there.
>> 
>> OK
>> 
>> >> Seems like it would be better to ensure that these interrupts are just
>> >> disabled until the PM core initializes and can enable them.
>> >
>> > I thought about this but I couldn't figure out a clean way to do this.
>> > If I do irq_request, it automatically enables the interrupt, and if
>> > there is an interrupt pending it will fire immediately and get stuck. 
>> 
>> hmm, I thought there was a flag for disabling the auto-enable feature...
>> /me looks
>> 
>> Yup, from <linux/irq.h>
>> 
>>  * IRQ_NOAUTOEN			- Interrupt is not automatically enabled in
>>  *				  request/setup_irq()
>> 
>> With that, we can just set all the PRCM IRQs to be disabled until
>> explicitly enabled using enable_irq().  The following patch (only boot
>> tested on OMAP3530/Overo and OMAP4430/Panda) should take care of it.
>> 
>> Do you think that should solve this problem?
>
> Yea that works. However your patch implements the disable for all PRCM
> interrupts, and this is only needed for the IO event on OMAP3. 
> How about something like this:

Your patch seems to have been mangled, but I think I get the idea, and
that looks right.

I've updated my patch to use (what I understood to be) your idea and
updated the changelog to reflect that it's a targetted fix for just the
IO interrupt on OMAP3.

Afzal, care to give this one a test as well?  It should have the same
result but is a more targetted fix.  With and ack from Tero and a
Tested-by from you, I'll post this to the list and and queue it up for
v3.5.

Thanks,

Kevin



>From 274ded7fbe573bbbe45db80bdc1989272077c011 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 27 Apr 2012 16:05:51 -0700
Subject: [PATCH] ARM: OMAP3: PM: leave PRCM interrupts disabled until
 explicitly enabled.

By default, request_irq() will auto-enable the requested IRQ.

For PRCM interrupts, we may want to avoid that until the PM core code
is fully ready to handle the interrupts.  This is particularily true
for IO pad interrupts on OMAP3, which are shared between the hwmod
core and the PRM core.

In order to avoid PRCM IO-chain interrupts until the PM core is ready
to handle them, ready, set the IRQ_NOAUTOEN flag for the PRCM IO-chain
interrupt,  which means it will remain disabled after request_irq().

Then, explicitly enable the PRCM interrupts after the request_irq() in
the PM core (but not in the hwmod core.)

Special thanks to Tero Kristo for suggesting to isolate the fix to
only the IO-chain interrupt on OMAP3 instead of all PRCM interrupts.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 66ff828..b40de27 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -732,6 +732,7 @@ static int __init omap3_pm_init(void)
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
 		omap3_pm_init);
+	enable_irq(omap_prcm_event_to_irq("io"));
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_io irq\n");
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9ce7654..21cb740 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 
 #include "common.h"
 #include <plat/cpu.h>
@@ -303,8 +304,15 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
 
 static int __init omap3xxx_prcm_init(void)
 {
-	if (cpu_is_omap34xx())
-		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
-	return 0;
+	int ret = 0;
+
+	if (cpu_is_omap34xx()) {
+		ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		if (!ret)
+			irq_set_status_flags(omap_prcm_event_to_irq("io"),
+					     IRQ_NOAUTOEN);
+	}
+
+	return ret;
 }
 subsys_initcall(omap3xxx_prcm_init);
-- 
1.7.9.2

