From: Tero Kristo <t-kristo@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Mon, 23 Apr 2012 12:24:04 +0300
Message-ID: <1335173044.2149.64.camel@sokoban>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tfrQ0os1oItwZHZ9eW9s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36190 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645Ab2DWJYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 05:24:08 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--=-tfrQ0os1oItwZHZ9eW9s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-04-06 at 07:52 +0000, Mohammed, Afzal wrote:
> Hi Paul,
> 
> On Fri, Apr 06, 2012 at 12:43:06, Paul Walmsley wrote:
> > Perhaps you might be willing to add some debugging to omap_mux_late_init() 
> > to find out what part of that function is causing it to hang?
> 
> It is getting hung as interrupt handler "omap_hwmod_mux_handle_irq"
> is being repeatedly called.
> 

Hi Afzal,

can you try the attached patch with this branch and omap3evm board? I
don't have the board myself so I can't test it myself (I tested this
with omap3beagle and it works with that one.)

-Tero


--=-tfrQ0os1oItwZHZ9eW9s
Content-Disposition: attachment;
	filename*0="0001-ARM-OMAP3-PM-move-wakeup-event-ack-to-hwmod_io-handl.pat";
	filename*1="ch"
Content-Type: text/x-patch;
	name="0001-ARM-OMAP3-PM-move-wakeup-event-ack-to-hwmod_io-handl.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 26733dd988ccc9e72355a39e01b2d6e9215a892d Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Mon, 23 Apr 2012 12:14:46 +0300
Subject: [PATCH] ARM: OMAP3: PM: move wakeup event ack to hwmod_io handler

PRCM IO interrupts are handled with a shared interrupt handler logic.
Currently hwmod_io is processing the actual event, but the acking
of the IO wakeups is done from the PM code with a separate handler.
If a wakeup event is detected during init before the PM code is in
place, the interrupt handler can hang in an infinite loop. Fix this
by removing the pm_io handler, and calling its functionality from
within the hwmod_io handler. This fix applies only to OMAP3, as
OMAP4 does not have similar wakeup handling logic.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c    |   18 +++++++++++++++++-
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm34xx.c |   18 ++----------------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 65c3391..17349e3 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -41,6 +41,7 @@
 #include "control.h"
 #include "mux.h"
 #include "prm.h"
+#include "pm.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
@@ -427,6 +428,13 @@ static irqreturn_t omap_hwmod_mux_handle_irq(int irq, void *unused)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t omap34xx_hwmod_mux_handle_irq(int irq, void *unused)
+{
+	omap_hwmod_for_each(_omap_hwmod_mux_handle_irq, NULL);
+	prcm_int_ack_io();
+	return IRQ_HANDLED;
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
@@ -792,6 +800,7 @@ static int __init omap_mux_late_init(void)
 {
 	struct omap_mux_partition *partition;
 	int ret;
+	irq_handler_t irq_handler;
 
 	list_for_each_entry(partition, &mux_partitions, node) {
 		struct omap_mux_entry *e, *tmp;
@@ -812,12 +821,19 @@ static int __init omap_mux_late_init(void)
 		}
 	}
 
+#ifdef CONFIG_PM
+	if (cpu_is_omap34xx())
+		irq_handler = omap34xx_hwmod_mux_handle_irq;
+	else
+		irq_handler = omap_hwmod_mux_handle_irq;
+
 	ret = request_irq(omap_prcm_event_to_irq("io"),
-		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
+		irq_handler, IRQF_SHARED | IRQF_NO_SUSPEND,
 			"hwmod_io", omap_mux_late_init);
 
 	if (ret)
 		pr_warning("mux: Failed to setup hwmod io irq %d\n", ret);
+#endif
 
 	omap_mux_dbg_init();
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 36fa90b..09ba9e7 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -20,6 +20,7 @@ extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+extern void prcm_int_ack_io(void);
 extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index afe3dda..cea4408 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -182,14 +182,10 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 	return c;
 }
 
-static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
+void prcm_int_ack_io(void)
 {
-	int c;
-
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
+	prcm_clear_mod_irqs(WKUP_MOD, 1,
 		~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
-
-	return c ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
@@ -683,16 +679,6 @@ static int __init omap3_pm_init(void)
 		goto err1;
 	}
 
-	/* IO interrupt is shared with mux code */
-	ret = request_irq(omap_prcm_event_to_irq("io"),
-		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
-		omap3_pm_init);
-
-	if (ret) {
-		pr_err("pm: Failed to request pm_io irq\n");
-		goto err1;
-	}
-
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
-- 
1.7.4.1


--=-tfrQ0os1oItwZHZ9eW9s--
