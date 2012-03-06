From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 4/6] ARM: OMAP3+: PRM: Enable IO wake up
Date: Tue, 6 Mar 2012 17:11:40 +0200
Message-ID: <1331046702-2472-5-git-send-email-t-kristo@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48512 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030854Ab2CFPMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 10:12:03 -0500
In-Reply-To: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Enable IO Wake up for OMAP3/4 as part of PRM Init. Currently this has been
managed in cpuidle path which is not the right place. Subsequent patch
will remove IO Daisy chain handling in cpuidle path once daisy chain is
handled as part of hwmod mux. This patch also moves the OMAP4 IO wakeup
enable code from the trigger function to init time setup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   11 ++++++++++-
 arch/arm/mach-omap2/prm44xx.c      |   18 ++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 2f45b96..f0179f6 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -338,10 +338,19 @@ void omap3_disable_io_chain(void)
 					     WKUP_MOD, PM_WKEN);
 }
 
+static void __init omap3_enable_io_wakeup(void)
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
+		omap3_enable_io_wakeup();
 		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+	}
 	return 0;
 }
 subsys_initcall(omap3xxx_prcm_init);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index caa5e0f..4ce6f08 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -242,13 +242,6 @@ void omap4_trigger_io_chain(void)
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
@@ -272,10 +265,19 @@ void omap4_trigger_io_chain(void)
 	return;
 }
 
+static void __init omap4_enable_io_wakeup(void)
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
+		omap4_enable_io_wakeup();
 		return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
+	}
 	return 0;
 }
 subsys_initcall(omap4xxx_prcm_init);
-- 
1.7.4.1

