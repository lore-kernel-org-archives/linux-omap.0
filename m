From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/10] ARM: OMAP3: PRM: move modem reset and iva2 idle to PRM driver
Date: Fri, 4 Jul 2014 17:10:34 +0300
Message-ID: <1404483035-21666-10-git-send-email-t-kristo@ti.com>
References: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55142 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085AbaGDOKs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jul 2014 10:10:48 -0400
In-Reply-To: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to move PRM into its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   15 ---------------
 arch/arm/mach-omap2/prm3xxx.c |    7 +++++++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 126f3ec..9410b4a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -353,27 +353,12 @@ restore:
 #define omap3_pm_suspend NULL
 #endif /* CONFIG_SUSPEND */
 
-static void __init omap3_d2d_idle(void)
-{
-	omap3_ctrl_setup_d2d_padconf();
-
-	/* reset modem */
-	omap3_prm_reset_modem();
-}
-
 static void __init prcm_setup_regs(void)
 {
 	/* XXX This should be handled by hwmod code or SCM init code */
 	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
 
 	omap3_prm_init_pm(cpu_is_omap3630(), omap3_has_iva());
-
-	/*
-	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
-	 */
-	omap3xxx_prm_iva_idle();
-
-	omap3_d2d_idle();
 }
 
 void omap3_pm_off_mode_enable(int enable)
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 48218a4..75dfe8e 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -362,6 +362,13 @@ void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
 
 	/* Clear any pending PRCM interrupts */
 	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+
+	/* We need to idle iva2_pwrdm even on am3703 with no iva2. */
+	omap3xxx_prm_iva_idle();
+
+	omap3_ctrl_setup_d2d_padconf();
+
+	omap3_prm_reset_modem();
 }
 
 /**
-- 
1.7.9.5

