From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/18] ARM: OMAP3: control: add API for setting up the modem pads
Date: Tue, 4 Mar 2014 18:19:16 +0200
Message-ID: <1393949958-816-17-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48501 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbaCDQUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:41 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

This patch moves the functionality from PM core to control driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   26 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h |    1 +
 arch/arm/mach-omap2/pm34xx.c  |   15 +--------------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 5eb991a..2def1ff 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -569,4 +569,30 @@ void omap3_ctrl_set_iva_bootmode_idle(void)
 	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
 			 OMAP343X_CONTROL_IVA2_BOOTMOD);
 }
+
+/**
+ * omap3_ctrl_setup_d2d_padconf - setup stacked modem pads for idle
+ *
+ * Sets up the pads controlling the stacked modem in such way that the
+ * device can enter idle.
+ */
+void omap3_ctrl_setup_d2d_padconf(void)
+{
+	u16 mask, padconf;
+
+	/*
+	 * In a stand alone OMAP3430 where there is not a stacked
+	 * modem for the D2D Idle Ack and D2D MStandby must be pulled
+	 * high. S CONTROL_PADCONF_SAD2D_IDLEACK and
+	 * CONTROL_PADCONF_SAD2D_MSTDBY to have a pull up.
+	 */
+	mask = (1 << 4) | (1 << 3); /* pull-up, enabled */
+	padconf = omap_ctrl_readw(OMAP3_PADCONF_SAD2D_MSTANDBY);
+	padconf |= mask;
+	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_MSTANDBY);
+
+	padconf = omap_ctrl_readw(OMAP3_PADCONF_SAD2D_IDLEACK);
+	padconf |= mask;
+	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
+}
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index da05480..fc00158 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -428,6 +428,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 extern void omap3_ctrl_set_iva_bootmode_idle(void);
+void omap3_ctrl_setup_d2d_padconf(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0b9a298..8df2d65 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -348,20 +348,7 @@ restore:
 
 static void __init omap3_d2d_idle(void)
 {
-	u16 mask, padconf;
-
-	/* In a stand alone OMAP3430 where there is not a stacked
-	 * modem for the D2D Idle Ack and D2D MStandby must be pulled
-	 * high. S CONTROL_PADCONF_SAD2D_IDLEACK and
-	 * CONTROL_PADCONF_SAD2D_MSTDBY to have a pull up. */
-	mask = (1 << 4) | (1 << 3); /* pull-up, enabled */
-	padconf = omap_ctrl_readw(OMAP3_PADCONF_SAD2D_MSTANDBY);
-	padconf |= mask;
-	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_MSTANDBY);
-
-	padconf = omap_ctrl_readw(OMAP3_PADCONF_SAD2D_IDLEACK);
-	padconf |= mask;
-	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
+	omap3_ctrl_setup_d2d_padconf();
 
 	/* reset modem */
 	omap3_prm_reset_modem();
-- 
1.7.9.5

