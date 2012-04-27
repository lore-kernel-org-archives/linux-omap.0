From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Fri, 27 Apr 2012 16:15:21 -0700
Message-ID: <87fwbowyuu.fsf@ti.com>
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
	<1335532591.2149.163.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47461 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab2D0XPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 19:15:21 -0400
Received: by dacx6 with SMTP id x6so1866580dac.4
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 16:15:19 -0700 (PDT)
In-Reply-To: <1335532591.2149.163.camel@sokoban> (Tero Kristo's message of
	"Fri, 27 Apr 2012 16:16:31 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: "Mohammed, Afzal" <afzal@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tero Kristo <t-kristo@ti.com> writes:

> On Tue, 2012-04-24 at 10:07 -0700, Kevin Hilman wrote:

[...]

>> > From 26733dd988ccc9e72355a39e01b2d6e9215a892d Mon Sep 17 00:00:00 2001
>> > From: Tero Kristo <t-kristo@ti.com>
>> > Date: Mon, 23 Apr 2012 12:14:46 +0300
>> > Subject: [PATCH] ARM: OMAP3: PM: move wakeup event ack to hwmod_io handler
>> >
>> > PRCM IO interrupts are handled with a shared interrupt handler logic.
>> > Currently hwmod_io is processing the actual event, but the acking
>> > of the IO wakeups is done from the PM code with a separate handler.
>> > If a wakeup event is detected during init before the PM code is in
>> > place, the interrupt handler can hang in an infinite loop. Fix this
>> > by removing the pm_io handler, and calling its functionality from
>> > within the hwmod_io handler. This fix applies only to OMAP3, as
>> > OMAP4 does not have similar wakeup handling logic.
>> >
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> 
>> 
>> Doesn't this mean that even on a !PM kernel that IO events might still
>> be firing for nothing?
>
> I actually disabled the IO handler in !PM kernel, as I thought this
> would be a problem there.

OK

>> Seems like it would be better to ensure that these interrupts are just
>> disabled until the PM core initializes and can enable them.
>
> I thought about this but I couldn't figure out a clean way to do this.
> If I do irq_request, it automatically enables the interrupt, and if
> there is an interrupt pending it will fire immediately and get stuck. 

hmm, I thought there was a flag for disabling the auto-enable feature...
/me looks

Yup, from <linux/irq.h>

 * IRQ_NOAUTOEN			- Interrupt is not automatically enabled in
 *				  request/setup_irq()

With that, we can just set all the PRCM IRQs to be disabled until
explicitly enabled using enable_irq().  The following patch (only boot
tested on OMAP3530/Overo and OMAP4430/Panda) should take care of it.

Do you think that should solve this problem?

Afzal, care to test the patch below to see if it fixes your boot problem
on OMAP3EVM with the IO chain series?

Thanks,

Kevin



From: Kevin Hilman <khilman@ti.com>
Date: Fri, 27 Apr 2012 16:05:51 -0700
Subject: [PATCH] ARM: OMAP2+: PM: leave PRCM interrupts disabled until
 explicitly enabled.

By default, request_irq() will auto-enable the requested IRQ.

For PRCM interrupts, we want to avoid that until the PM core code is
fully ready to handle the interrupts.  This is particularily true for
IO pad interrupts, which are shared between the hwmod core and the PRM
core.  This is also important for !PM kernels where we don't need
any PRCM interrupts firing at all.

In order to avoid PRCM interrupts until ready, set the IRQ_NOAUTOEN
flag for the PRCM chained handler which means PRCM interrupts will
remain disabled after request_irq().

Then, explicitly enable the PRCM interrupts after the request_irq() in
the PM core (but not in the hwmod core.)

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c     |    2 ++
 arch/arm/mach-omap2/prm_common.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 66ff828..ba17813 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -722,6 +722,7 @@ static int __init omap3_pm_init(void)
 
 	ret = request_irq(omap_prcm_event_to_irq("wkup"),
 		_prcm_int_handle_wakeup, IRQF_NO_SUSPEND, "pm_wkup", NULL);
+	enable_irq(omap_prcm_event_to_irq("wkup"));
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_wkup irq\n");
@@ -732,6 +733,7 @@ static int __init omap3_pm_init(void)
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
 		omap3_pm_init);
+	enable_irq(omap_prcm_event_to_irq("io"));
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_io irq\n");
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index d28f848..c805775 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -307,7 +307,8 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 		ct->regs.ack = irq_setup->ack + i * 4;
 		ct->regs.mask = irq_setup->mask + i * 4;
 
-		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
+		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST,
+				       IRQ_NOAUTOEN);
 		prcm_irq_chips[i] = gc;
 	}
 
-- 
1.7.9.2

