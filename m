From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 4/6] ARM: OMAP3+: PRM: Enable IO wake up
Date: Fri, 9 Mar 2012 21:00:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203092100060.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34099 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab2CJEAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 23:00:36 -0500
In-Reply-To: <1331046702-2472-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 6 Mar 2012, Tero Kristo wrote:

> Enable IO Wake up for OMAP3/4 as part of PRM Init. Currently this has been
> managed in cpuidle path which is not the right place. Subsequent patch
> will remove IO Daisy chain handling in cpuidle path once daisy chain is
> handled as part of hwmod mux. This patch also moves the OMAP4 IO wakeup
> enable code from the trigger function to init time setup.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>

Here's an updated version of this patch.  Please let me know if you have 
any comments.

- Paul

From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 2 Mar 2012 17:17:53 +0200
Subject: [PATCH 4/6] ARM: OMAP3+: PRM: Enable IO wake up

Enable IO Wake up for OMAP3/4 as part of PRM Init. Currently this has been
managed in cpuidle path which is not the right place. Subsequent patch
will remove IO Daisy chain handling in cpuidle path once daisy chain is
handled as part of hwmod mux. This patch also moves the OMAP4 IO wakeup
enable code from the trigger function to init time setup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: harmonize function names with other PRM functions; add
 kerneldoc]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   20 +++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx.c      |   26 ++++++++++++++++++--------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 7d62bd6..1471a33 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -332,10 +332,28 @@ void omap3xxx_prm_reconfigure_io_chain(void)
 	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
 }
 
+/**
+ * omap3xxx_prm_enable_io_wakeup - enable wakeup events from I/O wakeup latches
+ *
+ * Activates the I/O wakeup event latches and allows events logged by
+ * those latches to signal a wakeup event to the PRCM.  For I/O
+ * wakeups to occur, WAKEUPENABLE bits must be set in the pad mux
+ * registers, and omap3xxx_prm_reconfigure_io_chain() must be called.
+ * No return value.
+ */
+static void __init omap3xxx_prm_enable_io_wakeup(void)
+{
+	if (omap3_has_io_wakeup())
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
+					   PM_WKEN);
+}
+
 static int __init omap3xxx_prcm_init(void)
 {
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
+		omap3xxx_prm_enable_io_wakeup();
 		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+	}
 	return 0;
 }
 subsys_initcall(omap3xxx_prcm_init);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 5868a12..af251c7 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -244,13 +244,6 @@ void omap44xx_prm_reconfigure_io_chain(void)
 {
 	int i = 0;
 
-	/* Enable GLOBAL_WUEN */
-	if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
-		OMAP4_PRM_IO_PMCTRL_OFFSET) & OMAP4430_GLOBAL_WUEN_MASK))
-		omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
-			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
-			OMAP4_PRM_IO_PMCTRL_OFFSET);
-
 	/* Trigger WUCLKIN enable */
 	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK,
 			OMAP4430_WUCLK_CTRL_MASK, OMAP4430_PRM_DEVICE_INST,
@@ -279,10 +272,27 @@ void omap44xx_prm_reconfigure_io_chain(void)
 	return;
 }
 
+/**
+ * omap44xx_prm_enable_io_wakeup - enable wakeup events from I/O wakeup latches
+ *
+ * Activates the I/O wakeup event latches and allows events logged by
+ * those latches to signal a wakeup event to the PRCM.  For I/O wakeups
+ * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
+ * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
+ */
+static void __init omap44xx_prm_enable_io_wakeup(void)
+{
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
+			OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,
+			OMAP4_PRM_IO_PMCTRL_OFFSET);
+}
+
 static int __init omap4xxx_prcm_init(void)
 {
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
+		omap44xx_prm_enable_io_wakeup();
 		return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
+	}
 	return 0;
 }
 subsys_initcall(omap4xxx_prcm_init);
-- 
1.7.9.1

