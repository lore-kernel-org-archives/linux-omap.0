From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv7 5/7] OMAP: Powerdomains: Add support for checking if pwrdm/clkdm can idle
Date: Fri, 12 Mar 2010 17:39:15 +0200
Message-ID: <1268408357-15621-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53995 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758131Ab0CLNyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:54:53 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDrj2h007397
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 07:54:52 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV8m003701
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:36 +0200
In-Reply-To: <1268408357-15621-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

pwrdm_can_idle(pwrdm) will check if the specified powerdomain can enter
idle. This is done by checking all clockdomains under the powerdomain
if they can idle also.

omap2_clkdm_can_idle(clkdm) will check if the specified clockdomain can
enter idle. This checks the functional clocks and idle status bits of the
domain according to following rules:
1) functional clock check
  * get FCLK register content
  * ignore all clocks defined in idle_def.fclk_ignore
  * if any active functional clocks remain, domain can't idle
2) idle status check
  * get IDLEST register content
  * inverse it (any non-idle blocks are now as 1)
  * mask against idle_def.idlest_mask
  * if any bits remain high, domain can't idle

These calls can be used e.g. inside cpuidle to decide which power states
core and mpu should enter during idle, as there are certain dependencies
between wakeup capabilities and reset logic.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   32 ++++++++
 arch/arm/mach-omap2/clockdomains.h            |  106 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.c             |   20 +++++
 arch/arm/plat-omap/include/plat/clockdomain.h |   17 ++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 5 files changed, 176 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index a38a615..9ebff51 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -867,6 +867,38 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
+
+/**
+ * omap2_clkdm_can_idle - check if clockdomain has any active clocks or not
+ * @clkdm: struct clockdomain *
+ *
+ * Checks if the clockdomain has any active clock or not, i.e. whether it
+ * can enter idle. Returns -EINVAL if clkdm is NULL; 0 if unable to idle;
+ * 1 if can idle.
+ */
+int omap2_clkdm_can_idle(struct clockdomain *clkdm)
+{
+	int i;
+
+	if (!clkdm)
+		return -EINVAL;
+
+	for (i = 0; i < clkdm->clk_reg_num; i++) {
+		u32 idlest, fclk;
+
+		fclk = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
+				CM_FCLKEN + 4 * i);
+		if (fclk & ~clkdm->idle_def[i].fclk_ignore)
+			return 0;
+
+		idlest = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
+				CM_IDLEST + 4 * i);
+		if (~idlest & clkdm->idle_def[i].idlest_mask)
+			return 0;
+	}
+	return 1;
+}
+
 /**
  * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
  * @clkdm: struct clockdomain *
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 8fc19ff..5e29de8 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -663,6 +663,12 @@ static struct clockdomain iva2_clkdm = {
 	.wkdep_srcs	= iva2_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.clk_reg_num	= 1,
+	.idle_def	= {
+		[0] = {
+			.idlest_mask = OMAP3430_ST_IVA2,
+		},
+	},
 };
 
 static struct clockdomain gfx_3430es1_clkdm = {
@@ -686,6 +692,12 @@ static struct clockdomain sgx_clkdm = {
 	.sleepdep_srcs	= gfx_sgx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.clk_reg_num	= 1,
+	.idle_def	= {
+		[0] = {
+			.idlest_mask = OMAP3430ES2_ST_SGX_SHIFT,
+		},
+	},
 };
 
 /*
@@ -717,6 +729,57 @@ static struct clockdomain core_l3_3xxx_clkdm = {
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.clk_reg_num	= 3,
+	.idle_def	= {
+		[0] = {
+			/* UARTs are controlled by idle loop so ignore */
+			.fclk_ignore = OMAP3430_EN_UART2 |
+				OMAP3430_EN_UART1,
+			/*
+			 * Reason for IDLEST ignores:
+			 * - SDRC and OMAPCTRL controlled by HW
+			 * - HSOTGUSB_IDLE bit is autoidled by HW
+			 * - MAILBOX is controlled by HW
+			 */
+			.idlest_mask =
+				OMAP3430ES2_ST_MMC3_MASK |
+				OMAP3430_ST_ICR_MASK |
+				OMAP3430_ST_AES2_MASK |
+				OMAP3430_ST_SHA12_MASK |
+				OMAP3430_ST_DES2_MASK |
+				OMAP3430_ST_MMC2_MASK |
+				OMAP3430_ST_MMC1_MASK |
+				OMAP3430_ST_MSPRO_MASK |
+				OMAP3430_ST_HDQ_MASK |
+				OMAP3430_ST_MCSPI4_MASK |
+				OMAP3430_ST_MCSPI3_MASK |
+				OMAP3430_ST_MCSPI2_MASK |
+				OMAP3430_ST_MCSPI1_MASK |
+				OMAP3430_ST_I2C3_MASK |
+				OMAP3430_ST_I2C2_MASK |
+				OMAP3430_ST_I2C1_MASK |
+				OMAP3430_ST_GPT11_MASK |
+				OMAP3430_ST_GPT10_MASK |
+				OMAP3430_ST_MCBSP5_MASK |
+				OMAP3430_ST_MCBSP1_MASK |
+				OMAP3430ES2_ST_SSI_IDLE_MASK |
+				OMAP3430ES2_ST_HSOTGUSB_STDBY_MASK |
+				OMAP3430_ST_D2D_MASK |
+				OMAP3430_ST_SDMA_MASK |
+				OMAP3430_ST_SSI_STDBY_MASK,
+		},
+		[1] = {
+			.idlest_mask = OMAP3430_ST_PKA_MASK |
+				OMAP3430_ST_AES1_MASK |
+				OMAP3430_ST_RNG_MASK |
+				OMAP3430_ST_SHA11_MASK |
+				OMAP3430_ST_DES1_MASK,
+		},
+		[2] = {
+			.idlest_mask = OMAP3430ES2_ST_USBTLL_MASK |
+				OMAP3430ES2_ST_CPEFUSE_MASK,
+		},
+	},
 };
 
 /*
@@ -746,6 +809,13 @@ static struct clockdomain dss_3xxx_clkdm = {
 	.sleepdep_srcs	= dss_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.clk_reg_num	= 1,
+	.idle_def	= {
+		[0] = {
+			.idlest_mask = OMAP3430ES2_ST_DSS_IDLE_MASK |
+				OMAP3430ES2_ST_DSS_STDBY_MASK,
+		},
+	},
 };
 
 static struct clockdomain cam_clkdm = {
@@ -758,6 +828,12 @@ static struct clockdomain cam_clkdm = {
 	.sleepdep_srcs	= cam_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.clk_reg_num	= 1,
+	.idle_def	= {
+		[0] = {
+			.idlest_mask = OMAP3430_ST_CAM,
+		},
+	},
 };
 
 static struct clockdomain usbhost_clkdm = {
@@ -770,6 +846,13 @@ static struct clockdomain usbhost_clkdm = {
 	.sleepdep_srcs	= usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.clk_reg_num	= 1,
+	.idle_def	= {
+		[0] = {
+			.idlest_mask = OMAP3430ES2_ST_USBHOST_IDLE_MASK |
+				OMAP3430ES2_ST_USBHOST_STDBY_MASK,
+		},
+	},
 };
 
 static struct clockdomain per_clkdm = {
@@ -783,6 +866,29 @@ static struct clockdomain per_clkdm = {
 	.sleepdep_srcs	= per_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.clk_reg_num	= 1,
+	.idle_def	= {
+		[0] = {
+			.fclk_ignore = OMAP3430_ST_UART3_MASK,
+			/*
+			 * GPIO2...6 are dropped out from this mask
+			 * as they are always non-idle, UART3 is also
+			 * out as it is handled by idle loop
+			 * */
+			.idlest_mask = OMAP3430_ST_WDT3_MASK |
+				OMAP3430_ST_GPT9_MASK |
+				OMAP3430_ST_GPT8_MASK |
+				OMAP3430_ST_GPT7_MASK |
+				OMAP3430_ST_GPT6_MASK |
+				OMAP3430_ST_GPT5_MASK |
+				OMAP3430_ST_GPT4_MASK |
+				OMAP3430_ST_GPT3_MASK |
+				OMAP3430_ST_GPT2_MASK |
+				OMAP3430_ST_MCBSP4_MASK |
+				OMAP3430_ST_MCBSP3_MASK |
+				OMAP3430_ST_MCBSP2_MASK,
+		},
+	},
 };
 
 /*
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index dc03289..a9ca884 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -919,6 +919,26 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+/**
+ * pwrdm_can_idle - check if the powerdomain can enter idle
+ * @pwrdm: struct powerdomain * the powerdomain to check status of
+ *
+ * Checks all associated clockdomains if they can idle or not.
+ * Returns 1 if the powerdomain can idle, 0 if not.
+ */
+int pwrdm_can_idle(struct powerdomain *pwrdm)
+{
+	int i;
+	int ret = 1;
+
+	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
+		if (pwrdm->pwrdm_clkdms[i] &&
+		    !omap2_clkdm_can_idle(pwrdm->pwrdm_clkdms[i]))
+			ret = 0;
+
+	return ret;
+}
+
 int pwrdm_state_switch(struct powerdomain *pwrdm)
 {
 	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index ba0a6c0..ecf7f88 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -30,6 +30,12 @@
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
 #define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | CLKDM_CAN_HWSUP)
 
+/*
+ * Maximum number of FCLK register masks that can be associated with a
+ * clockdomain. CORE powerdomain on OMAP3 is the worst case
+ */
+#define CLKDM_MAX_CLK_REGS			3
+
 /* OMAP24XX CM_CLKSTCTRL_*.AUTOSTATE_* register bit values */
 #define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
 #define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
@@ -82,6 +88,11 @@ struct clkdm_dep {
 	const struct omap_chip_id omap_chip;
 };
 
+struct clkdm_idle_def {
+	u32 fclk_ignore;
+	u32 idlest_mask;
+};
+
 /**
  * struct clockdomain - OMAP clockdomain
  * @name: clockdomain name
@@ -95,6 +106,8 @@ struct clkdm_dep {
  * @omap_chip: OMAP chip types that this clockdomain is valid on
  * @usecount: Usecount tracking
  * @node: list_head to link all clockdomains together
+ * @clk_reg_num: Number of idle definitions for clockdomain idle status checks
+ * @idle_def: Declarations for idle checks for clockdomain
  */
 struct clockdomain {
 	const char *name;
@@ -111,6 +124,8 @@ struct clockdomain {
 	const struct omap_chip_id omap_chip;
 	atomic_t usecount;
 	struct list_head node;
+	u8 clk_reg_num;
+	struct clkdm_idle_def idle_def[CLKDM_MAX_CLK_REGS];
 };
 
 void clkdm_init(struct clockdomain **clkdms, struct clkdm_autodep *autodeps);
@@ -138,4 +153,6 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 
+int omap2_clkdm_can_idle(struct clockdomain *clkdm);
+
 #endif
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index e15c7e9..a1ecd47 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -145,6 +145,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
 bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
+int pwrdm_can_idle(struct powerdomain *pwrdm);
 
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
-- 
1.5.4.3

