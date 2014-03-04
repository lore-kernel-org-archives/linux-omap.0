From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/18] ARM: OMAP3: CM: remove a few OMAP34XX_CM_REGADDR defines
Date: Tue, 4 Mar 2014 18:19:01 +0200
Message-ID: <1393949958-816-2-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48403 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaCDQUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 11:20:06 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Remove a few OMAP34XX_CM_REGADDR defines and replace these with offset
based register accesses instead.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm3xxx.c |   12 ++++++++----
 arch/arm/mach-omap2/cm3xxx.h |    6 ++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index f6f0288..60c2c9f 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -388,7 +388,8 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	cm_context.iva2_cm_clksel2 =
 		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
-	cm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
+	cm_context.cm_sysconfig =
+		omap2_cm_read_mod_reg(OCP_MOD, OMAP3430_CM_SYSCONFIG);
 	cm_context.sgx_cm_clksel =
 		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
 	cm_context.dss_cm_clksel =
@@ -418,7 +419,8 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
 	cm_context.pll_cm_clken2 =
 		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
-	cm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
+	cm_context.cm_polctrl =
+		omap2_cm_read_mod_reg(OCP_MOD, OMAP3430_CM_POLCTRL);
 	cm_context.iva2_cm_fclken =
 		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
 	cm_context.iva2_cm_clken_pll =
@@ -519,7 +521,8 @@ void omap3_cm_restore_context(void)
 			       CM_CLKSEL1);
 	omap2_cm_write_mod_reg(cm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
 			       CM_CLKSEL2);
-	__raw_writel(cm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
+	omap2_cm_write_mod_reg(cm_context.cm_sysconfig, OCP_MOD,
+			       OMAP3430_CM_SYSCONFIG);
 	omap2_cm_write_mod_reg(cm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
 			       CM_CLKSEL);
 	omap2_cm_write_mod_reg(cm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
@@ -547,7 +550,8 @@ void omap3_cm_restore_context(void)
 			       OMAP3430ES2_CM_CLKSEL5);
 	omap2_cm_write_mod_reg(cm_context.pll_cm_clken2, PLL_MOD,
 			       OMAP3430ES2_CM_CLKEN2);
-	__raw_writel(cm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
+	omap2_cm_write_mod_reg(cm_context.cm_polctrl, OCP_MOD,
+			       OMAP3430_CM_POLCTRL);
 	omap2_cm_write_mod_reg(cm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
 			       CM_FCLKEN);
 	omap2_cm_write_mod_reg(cm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 8224c91..0301557 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -29,12 +29,10 @@
  * These registers appear once per CM module.
  */
 
-#define OMAP3430_CM_REVISION		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP3430_CM_SYSCONFIG		OMAP34XX_CM_REGADDR(OCP_MOD, 0x0010)
-#define OMAP3430_CM_POLCTRL		OMAP34XX_CM_REGADDR(OCP_MOD, 0x009c)
+#define OMAP3430_CM_SYSCONFIG		0x0010
+#define OMAP3430_CM_POLCTRL		0x009c
 
 #define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
-#define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
 /*
  * Module specific CM register offsets from CM_BASE + domain offset
-- 
1.7.9.5

