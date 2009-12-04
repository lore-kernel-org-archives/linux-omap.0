From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv2 1/6] OMAP: Powerdomains: Add support for INACTIVE state on pwrdm level
Date: Fri,  4 Dec 2009 10:52:56 +0200
Message-ID: <1259916781-2741-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27369 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbZLDI4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 03:56:15 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nB48u8wU001544
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 10:56:20 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nB48tm68013537
	for <linux-omap@vger.kernel.org>; Fri, 4 Dec 2009 10:55:50 +0200
In-Reply-To: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Currently only ON, RET and OFF are supported, and ON is arguably broken as it
allows the powerdomain to enter INACTIVE state unless idle is prevented.
Now, pwrdm code prevents idle if ON is selected, and also adds support for
INACTIVE. This simplifies the control needed inside sleep code.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   32 +++++++++++++++++++++----
 arch/arm/mach-omap2/powerdomains34xx.h        |   26 ++++++++++----------
 arch/arm/plat-omap/include/plat/powerdomain.h |    6 ++++-
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index b6990e3..1237717 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -112,8 +112,8 @@ static struct powerdomain *_pwrdm_deps_lookup(struct powerdomain *pwrdm,
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 {
 
-	int prev;
-	int state;
+	u8 prev;
+	u8 state;
 
 	if (pwrdm == NULL)
 		return -EINVAL;
@@ -220,7 +220,7 @@ int pwrdm_register(struct powerdomain *pwrdm)
 
 	pr_debug("powerdomain: registered %s\n", pwrdm->name);
 	ret = 0;
-
+	pwrdm->next_state = -1;
 pr_unlock:
 	write_unlock_irqrestore(&pwrdm_rwlock, flags);
 
@@ -701,19 +701,38 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
  */
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
+	u8 prg_pwrst;
+
 	if (!pwrdm)
 		return -EINVAL;
 
+	if (pwrdm->next_state == pwrst)
+		return 0;
+
 	if (!(pwrdm->pwrsts & (1 << pwrst)))
 		return -EINVAL;
 
 	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
+	/* INACTIVE is reserved, so we program pwrdm as ON */
+	if (pwrst == PWRDM_POWER_INACTIVE)
+		prg_pwrst = PWRDM_POWER_ON;
+	else
+		prg_pwrst = pwrst;
+
 	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
-			     (pwrst << OMAP_POWERSTATE_SHIFT),
+			     (prg_pwrst << OMAP_POWERSTATE_SHIFT),
 			     pwrdm->prcm_offs, PM_PWSTCTRL);
 
+	/* If next state is ON, prevent idle */
+	if (pwrst == PWRDM_POWER_ON)
+		omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[0]);
+	else
+		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+
+	pwrdm->next_state = pwrst;
+
 	return 0;
 }
 
@@ -730,8 +749,11 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
+	if (pwrdm->next_state > -1)
+		return pwrdm->next_state;
+
 	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
-					OMAP_POWERSTATE_MASK);
+				       OMAP_POWERSTATE_MASK);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index fd09b08..9eb2dc5 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -165,7 +165,7 @@ static struct powerdomain iva2_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
 	.wkdep_srcs	  = iva2_wkdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 4,
 	.pwrsts_mem_ret	  = {
@@ -188,7 +188,7 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.dep_bit	  = OMAP3430_EN_MPU_SHIFT,
 	.wkdep_srcs	  = mpu_34xx_wkdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
@@ -206,7 +206,7 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
@@ -214,8 +214,8 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 		[1] = PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
 	},
 	.pwrsts_mem_on	  = {
-		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
-		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
+		[0] = PWRSTS_OFF_RET_INA_ON, /* MEM1ONSTATE */
+		[1] = PWRSTS_OFF_RET_INA_ON, /* MEM2ONSTATE */
 	},
 };
 
@@ -224,7 +224,7 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
@@ -233,8 +233,8 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
 		[1] = PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
 	},
 	.pwrsts_mem_on	  = {
-		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
-		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
+		[0] = PWRSTS_OFF_RET_INA_ON, /* MEM1ONSTATE */
+		[1] = PWRSTS_OFF_RET_INA_ON, /* MEM2ONSTATE */
 	},
 };
 
@@ -246,7 +246,7 @@ static struct powerdomain dss_pwrdm = {
 	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
 	.wkdep_srcs	  = cam_dss_wkdeps,
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
@@ -286,7 +286,7 @@ static struct powerdomain cam_pwrdm = {
 	.prcm_offs	  = OMAP3430_CAM_MOD,
 	.wkdep_srcs	  = cam_dss_wkdeps,
 	.sleepdep_srcs	  = cam_gfx_sleepdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
@@ -304,7 +304,7 @@ static struct powerdomain per_pwrdm = {
 	.dep_bit	  = OMAP3430_EN_PER_SHIFT,
 	.wkdep_srcs	  = per_usbhost_wkdeps,
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
@@ -326,7 +326,7 @@ static struct powerdomain neon_pwrdm = {
 	.prcm_offs	  = OMAP3430_NEON_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.wkdep_srcs	  = neon_wkdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 };
 
@@ -336,7 +336,7 @@ static struct powerdomain usbhost_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.wkdep_srcs	  = per_usbhost_wkdeps,
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
 	.pwrsts_logic_ret = PWRDM_POWER_RET,
 	/*
 	 * REVISIT: Enabling usb host save and restore mechanism seems to
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 3d45ee1..55350d0 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -37,6 +37,9 @@
 
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
 
+#define PWRSTS_OFF_RET_INA_ON	(PWRSTS_OFF_RET_ON | \
+				 (1 << PWRDM_POWER_INACTIVE))
+
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
@@ -117,7 +120,8 @@ struct powerdomain {
 
 	struct list_head node;
 
-	int state;
+	u8 state;
+	s8 next_state;
 	unsigned state_counter[4];
 
 #ifdef CONFIG_PM_DEBUG
-- 
1.5.4.3

