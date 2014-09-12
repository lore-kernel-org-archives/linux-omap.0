From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP3: Fix I/O chain clock line assertion timed out error
Date: Fri, 12 Sep 2014 10:50:22 -0700
Message-ID: <1410544222-25913-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17180 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751092AbaILRuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2014 13:50:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

We are getting "PRM: I/O chain clock line assertion timed out" errors
on early omaps for device tree based booting. This is because we are
unconditionally calling reconfigure_io_chain while legacy booting
has omap3_has_io_chain_ctrl() checks in place in omap_hwmod.c.

For device tree based booting, we are calling reconfigure_io_chain
unconditionally from pinctrl framework. So we need to add a check for
omap3_has_io_chain_ctrl() to avoid the errors for trying to access
a register that does not exist.

For es3.0, the documentation in "4.11.2 Device Off-Mode Configuration"
just mentions PM_WKEN_WKUP[8] bit. For es3.1, there's a new chapter in
documentation for "4.11.2.2 I/O Wake-Up Mechanism" that describes the
PM_WKEN_WKUP[16] ST_IO_CHAIN bit. So PM_WKEN_WKUP[16] bit did not get
added until in es3.1 probaly to fix issues with flakey wake-up events.

We are doing proper checks for ST_IO_CHAIN already in id.c and with
omap3_has_io_chain_ctrl(). For more information, see also commit
b02b917211d5 ("ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
control detection").

Let's fix the issue by selecting the right function during init for
reconfigure_io_chain depending on the omap revision. For es3.0 and
earlier we need to just toggle EN_IO. By doing this, we can move the
check for omap3_has_io_chain_ctrl() from omap_hwmod.c to the init code
in prm_3xxx.c. And then we can unconditionally call reconfigure_io_chain.

Thanks to Paul Walmsley and Nishanth Menon for help with debugging the
issue.

Fixes: 30a69ef785e8 ("ARM: OMAP: Move DT wake-up event handling over to use pinctrl-single-omap")
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |  2 +-
 arch/arm/mach-omap2/prm3xxx.c    | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8fd87a3..9e91a4e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2065,7 +2065,7 @@ static void _reconfigure_io_chain(void)
 
 	spin_lock_irqsave(&io_chain_lock, flags);
 
-	if (cpu_is_omap34xx() && omap3_has_io_chain_ctrl())
+	if (cpu_is_omap34xx())
 		omap3xxx_prm_reconfigure_io_chain();
 	else if (cpu_is_omap44xx())
 		omap44xx_prm_reconfigure_io_chain();
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index e0088e0..1c24693 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -46,7 +46,7 @@ static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
 	.ocp_barrier		= &omap3xxx_prm_ocp_barrier,
 	.save_and_clear_irqen	= &omap3xxx_prm_save_and_clear_irqen,
 	.restore_irqen		= &omap3xxx_prm_restore_irqen,
-	.reconfigure_io_chain	= &omap3xxx_prm_reconfigure_io_chain,
+	.reconfigure_io_chain	= NULL,
 };
 
 /*
@@ -370,15 +370,30 @@ void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
 }
 
 /**
- * omap3xxx_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
+ * omap3430_pre_es3_1_reconfigure_io_chain - restart wake-up daisy chain
+ *
+ * The ST_IO_CHAIN bit does not exist in 3430 before es3.1. The only
+ * thing we can do is toggle EN_IO bit for earlier omaps.
+ */
+void omap3430_pre_es3_1_reconfigure_io_chain(void)
+{
+	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
+				     PM_WKEN);
+	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
+				   PM_WKEN);
+	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+}
+
+/**
+ * omap3_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
  *
  * Clear any previously-latched I/O wakeup events and ensure that the
  * I/O wakeup gates are aligned with the current mux settings.  Works
  * by asserting WUCLKIN, waiting for WUCLKOUT to be asserted, and then
  * deasserting WUCLKIN and clearing the ST_IO_CHAIN WKST bit.  No
- * return value.
+ * return value. These registers are only available in 3430 es3.1 and later.
  */
-void omap3xxx_prm_reconfigure_io_chain(void)
+void omap3_prm_reconfigure_io_chain(void)
 {
 	int i = 0;
 
@@ -401,6 +416,15 @@ void omap3xxx_prm_reconfigure_io_chain(void)
 }
 
 /**
+ * omap3xxx_prm_reconfigure_io_chain - reconfigure I/O chain
+ */
+void omap3xxx_prm_reconfigure_io_chain(void)
+{
+	if (omap3_prcm_irq_setup.reconfigure_io_chain)
+		omap3_prcm_irq_setup.reconfigure_io_chain();
+}
+
+/**
  * omap3xxx_prm_enable_io_wakeup - enable wakeup events from I/O wakeup latches
  *
  * Activates the I/O wakeup event latches and allows events logged by
@@ -674,6 +698,13 @@ static int omap3xxx_prm_late_init(void)
 		}
 	}
 
+	if (omap3_has_io_chain_ctrl())
+		omap3_prcm_irq_setup.reconfigure_io_chain =
+			omap3_prm_reconfigure_io_chain;
+	else
+		omap3_prcm_irq_setup.reconfigure_io_chain =
+			omap3430_pre_es3_1_reconfigure_io_chain;
+
 	omap3xxx_prm_enable_io_wakeup();
 	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	if (!ret)
-- 
2.1.0

