From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 08/11] ARM: OMAP3: control: add API for setting IVA bootmode
Date: Fri, 11 Oct 2013 19:15:38 +0300
Message-ID: <1381508141-15244-9-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44649 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758558Ab3JKQQd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:33 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP3 PM core requires IVA2 bootmode to be set to idle during init. Currently,
a direct register write is used for this. Add a new ctrl API for this purpose
instead.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/control.c |   11 +++++++++++
 arch/arm/mach-omap2/control.h |    1 +
 arch/arm/mach-omap2/pm34xx.c  |    3 +--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a597114..44bb4d5 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -569,4 +569,15 @@ int omap3_ctrl_save_padconf(void)
 	return 0;
 }
 
+/**
+ * omap3_ctrl_set_iva_bootmode_idle - sets the IVA2 bootmode to idle
+ *
+ * Sets the bootmode for IVA2 to idle. This is needed by the PM code to
+ * force disable IVA2 so that it does not prevent any low-power states.
+ */
+void omap3_ctrl_set_iva_bootmode_idle(void)
+{
+	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
+			 OMAP343X_CONTROL_IVA2_BOOTMOD);
+}
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index f7d7c2e..da05480 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -427,6 +427,7 @@ extern void omap_ctrl_write_dsp_boot_addr(u32 bootaddr);
 extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
+extern void omap3_ctrl_set_iva_bootmode_idle(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a73a012..a0c7e83 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -428,8 +428,7 @@ static void __init omap3_iva_idle(void)
 	omap3_cm_force_iva_clk(true);
 
 	/* Set IVA2 boot mode to 'idle' */
-	omap_ctrl_writel(OMAP3_IVA2_BOOTMOD_IDLE,
-			 OMAP343X_CONTROL_IVA2_BOOTMOD);
+	omap3_ctrl_set_iva_bootmode_idle();
 
 	/* Un-reset IVA2 */
 	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
-- 
1.7.9.5

