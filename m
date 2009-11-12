From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 5/6] OMAP: Powerdomains: Add support for checking if pwrdm can idle
Date: Thu, 12 Nov 2009 19:02:38 +0200
Message-ID: <1258045359-7962-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
 <1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
 <1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
 <1258045359-7962-4-git-send-email-tero.kristo@nokia.com>
 <1258045359-7962-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24927 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbZKLRUB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 12:20:01 -0500
In-Reply-To: <1258045359-7962-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

From: Tero Kristo <tero.kristo@nokia.com>

pwrdm_can_idle(pwrdm) will check if the specified powerdomain can enter
idle. This is done by checking the current fclk enable bits.

This call can be used e.g. inside cpuidle to decide which power states
core and mpu should enter during idle, as there are certain dependencies
between wakeup capabilities and reset logic.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |   14 ++++++++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |    9 +++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1237717..bf2b97a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1217,6 +1217,28 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+/**
+ * pwrdm_can_idle - check if the powerdomain can enter idle
+ * @pwrdm: struct powerdomain * the powerdomain to check status of
+ *
+ * Does a functional clock check for the powerdomain and returns 1 if the
+ * powerdomain can enter idle, 0 if not.
+ */
+int pwrdm_can_idle(struct powerdomain *pwrdm)
+{
+	int i;
+	const int fclk_regs[] = { CM_FCLKEN, OMAP3430ES2_CM_FCLKEN3 };
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	for (i = 0; i < pwrdm->fclk_reg_amt; i++)
+		if (cm_read_mod_reg(pwrdm->prcm_offs, fclk_regs[i]) &
+				(0xffffffff ^ pwrdm->fclk_masks[i]))
+			return 0;
+	return 1;
+}
+
 int pwrdm_state_switch(struct powerdomain *pwrdm)
 {
 	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 9eb2dc5..c8cd297 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -180,6 +180,7 @@ static struct powerdomain iva2_pwrdm = {
 		[2] = PWRSTS_OFF_ON,
 		[3] = PWRDM_POWER_ON,
 	},
+	.fclk_reg_amt	  = 1,
 };
 
 static struct powerdomain mpu_34xx_pwrdm = {
@@ -236,6 +237,11 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_INA_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_INA_ON, /* MEM2ONSTATE */
 	},
+	.fclk_reg_amt	  = 2,
+	.fclk_masks	  = {
+		[0] = OMAP3430_EN_UART2 | OMAP3430_EN_UART1,
+		[1] = 0,
+	},
 };
 
 /* Another case of bit name collisions between several registers: EN_DSS */
@@ -255,6 +261,7 @@ static struct powerdomain dss_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.fclk_reg_amt	  = 1,
 };
 
 /*
@@ -278,6 +285,7 @@ static struct powerdomain sgx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.fclk_reg_amt	  = 1,
 };
 
 static struct powerdomain cam_pwrdm = {
@@ -295,6 +303,7 @@ static struct powerdomain cam_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.fclk_reg_amt	  = 1,
 };
 
 static struct powerdomain per_pwrdm = {
@@ -313,6 +322,10 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.fclk_reg_amt	  = 1,
+	.fclk_masks	  = {
+		[0] = OMAP3430_EN_UART3,
+	},
 };
 
 static struct powerdomain emu_pwrdm = {
@@ -352,6 +365,7 @@ static struct powerdomain usbhost_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
 	},
+	.fclk_reg_amt	  = 1,
 };
 
 static struct powerdomain dpll1_pwrdm = {
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 55350d0..b004d88 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -57,6 +57,12 @@
  */
 #define PWRDM_MAX_CLKDMS	4
 
+/*
+ * Maximum number of FCLK register masks that can be associated with a
+ * powerdomain. CORE powerdomain on OMAP3 is the worst case
+ */
+#define PWRDM_MAX_FCLK		2
+
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
 
@@ -124,6 +130,8 @@ struct powerdomain {
 	s8 next_state;
 	unsigned state_counter[4];
 
+	u8 fclk_reg_amt;
+	u32 fclk_masks[PWRDM_MAX_FCLK];
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[4];
@@ -177,6 +185,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
 bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
+int pwrdm_can_idle(struct powerdomain *pwrdm);
 
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
-- 
1.5.4.3

