From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Wed, 02 May 2012 07:27:34 -0700
Message-ID: <87aa1qhd49.fsf@ti.com>
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
	<1335790016.2149.185.camel@sokoban> <87vckht0lf.fsf@ti.com>
	<alpine.DEB.2.00.1205020242420.19695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46262 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754150Ab2EBO1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 10:27:35 -0400
Received: by pbbrp2 with SMTP id rp2so1087365pbb.28
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 07:27:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205020242420.19695@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 2 May 2012 02:45:34 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
>> Afzal, care to give this one a test as well?  It should have the same
>> result but is a more targetted fix.  With and ack from Tero and a
>> Tested-by from you, I'll post this to the list and and queue it up for
>> v3.5.
>
> just checking on this one to discuss how we should handle the 
> io_chain_devel_3.5 branch on my git tree, which would depend on this 
> patch... this is a tricky series since it touches PM, PRM, and hwmod 
> code...

Right, you should probably take this patch along with the
io_chain_devel_3.5 branch.  Below is a version that applies on top of
io_chain_devel_3.5 with an ack from Tero and Tested-by from Mohammed.

Kevin

>From 22726db6fc514cc5110db43fdf05d5afda8e4a59 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 1 May 2012 07:06:42 -0700
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

Tested-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3e6b564..745a151 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -685,6 +685,7 @@ static int __init omap3_pm_init(void)
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
 		omap3_pm_init);
+	enable_irq(omap_prcm_event_to_irq("io"));
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_io irq\n");
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 1471a33..a0309de 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 
 #include "common.h"
 #include <plat/cpu.h>
@@ -350,10 +351,16 @@ static void __init omap3xxx_prm_enable_io_wakeup(void)
 
 static int __init omap3xxx_prcm_init(void)
 {
+	int ret = 0;
+
 	if (cpu_is_omap34xx()) {
 		omap3xxx_prm_enable_io_wakeup();
-		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		if (!ret)
+			irq_set_status_flags(omap_prcm_event_to_irq("io"),
+					     IRQ_NOAUTOEN);
 	}
-	return 0;
+
+	return ret;
 }
 subsys_initcall(omap3xxx_prcm_init);
-- 
1.7.9.2





