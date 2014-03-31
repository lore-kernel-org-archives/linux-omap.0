From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/55] ARM: OMAP3/OMAP4: PRM: add prm_features flags and add IO wakeup under it
Date: Mon, 31 Mar 2014 18:15:44 +0300
Message-ID: <1396278994-12624-6-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49796 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbaCaPRe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:34 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

prm_features flag will contain SoC specific feature enabler flags. Initially
IO wakeup is added under this. Helps to get rid of runtime cpu_is_X checks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h        |    8 ++++++++
 arch/arm/mach-omap2/prm3xxx.c    |    8 +++++++-
 arch/arm/mach-omap2/prm44xx.c    |    6 ++++++
 arch/arm/mach-omap2/prm_common.c |    2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 623db40..04426c4 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -17,10 +17,18 @@
 
 # ifndef __ASSEMBLER__
 extern void __iomem *prm_base;
+extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
 int of_prcm_init(void);
 # endif
 
+/*
+ * prm_features flag values
+ *
+ * PRM_HAS_IO_WAKEUP: has IO wakeup capability
+ * PRM_HAS_VOLTAGE: has voltage domains
+ */
+#define PRM_HAS_IO_WAKEUP	(1 << 0)
 
 /*
  * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index dab93f4..fcbe854 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -410,7 +410,7 @@ void omap3xxx_prm_reconfigure_io_chain(void)
  */
 static void __init omap3xxx_prm_enable_io_wakeup(void)
 {
-	if (omap3_has_io_wakeup())
+	if (prm_features & PRM_HAS_IO_WAKEUP)
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
 					   PM_WKEN);
 }
@@ -640,6 +640,9 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 
 int __init omap3xxx_prm_init(void)
 {
+	if (omap3_has_io_wakeup())
+		prm_features |= PRM_HAS_IO_WAKEUP;
+
 	return prm_register(&omap3xxx_prm_ll_data);
 }
 
@@ -650,6 +653,9 @@ static int __init omap3xxx_prm_late_init(void)
 	if (!cpu_is_omap34xx())
 		return 0;
 
+	if (!(prm_features & PRM_HAS_IO_WAKEUP))
+		return 0;
+
 	omap3xxx_prm_enable_io_wakeup();
 	ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	if (!ret)
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 10834cb..dc357df 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -661,6 +661,9 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
+	if (cpu_is_omap44xx())
+		prm_features |= PRM_HAS_IO_WAKEUP;
+
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
@@ -669,6 +672,9 @@ static int __init omap44xx_prm_late_init(void)
 	if (!cpu_is_omap44xx())
 		return 0;
 
+	if (!(prm_features & PRM_HAS_IO_WAKEUP))
+		return 0;
+
 	omap44xx_prm_enable_io_wakeup();
 
 	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b3c593b..f98c01a 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -62,6 +62,8 @@ static struct omap_prcm_irq_setup *prcm_irq_setup;
 /* prm_base: base virtual address of the PRM IP block */
 void __iomem *prm_base;
 
+u16 prm_features;
+
 /*
  * prm_ll_data: function pointers to SoC-specific implementations of
  * common PRM functions
-- 
1.7.9.5

