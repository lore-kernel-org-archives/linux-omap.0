From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 17/18] ARM: OMAP3: PRM: move modem reset and iva2 idle to PRM driver
Date: Tue, 4 Mar 2014 18:19:17 +0200
Message-ID: <1393949958-816-18-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35175 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbaCDQUk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:40 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to move PRM into its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   15 ---------------
 arch/arm/mach-omap2/prm3xxx.c |    7 +++++++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8df2d65..faa2c05 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -346,27 +346,12 @@ restore:
 
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
index eb37970..239163f 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -361,6 +361,13 @@ void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
 
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

