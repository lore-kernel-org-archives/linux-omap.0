From: =?ISO-8859-1?Q?Rapha=EBl_Ass=E9nat?= <raph@8d.com>
Subject: [PATCH 2/5] am3505/3517: Set the omap chip id to CHIP_IS_AM35XX
Date: Mon, 04 Jul 2011 15:32:27 -0400
Message-ID: <4E12154B.8030301@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:48831 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab1GDTzr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jul 2011 15:55:47 -0400
Received: from raph.usine.8d.com ([192.168.142.55])
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Qdosd-0001Jx-Du
	for linux-omap@vger.kernel.org; Mon, 04 Jul 2011 15:32:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix id.c to set CHIP_IS_AM35XX instead of CHIP_IS_OMAP3430ES3_1.
Then, in order to enable the same functionalities, we need to
add CHIP_IS_AM35XX where CHIP_IS_OMAP3430, was is used in
clockdomains2xxx_3xxx_data, omap_hwmod_3xxx_data, 
powerdomains2xxx_3xxx_data and powerdomains3xxx_data.

Also in omap_hwmod_3xxx_data.c, changes for AM35xx 
UART4 support:
	AM35xx-specific omap_hwmod

	Renamed omap3xxx_uart4_hwmod to omap36xx_uart4_hwmod 
	for clarity)


Signed-off-by: Raphael Assenat <raph@8d.com>

diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index 13bde95..4f4368d 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -71,17 +71,20 @@ static struct clkdm_dep gfx_sgx_wkdeps[] = {
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "mpu_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
+					    CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					    CHIP_IS_OMAP3430)
+					    CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -208,23 +211,28 @@ static struct clkdm_dep mdm_2430_wkdeps[] = {
 static struct clkdm_dep per_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -233,23 +241,28 @@ static struct clkdm_dep per_wkdeps[] = {
 static struct clkdm_dep usbhost_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					   CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -258,23 +271,28 @@ static struct clkdm_dep usbhost_wkdeps[] = {
 static struct clkdm_dep mpu_3xxx_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "dss_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "per_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -283,27 +301,33 @@ static struct clkdm_dep mpu_3xxx_wkdeps[] = {
 static struct clkdm_dep iva2_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "core_l4_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "dss_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "per_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -313,15 +337,18 @@ static struct clkdm_dep iva2_wkdeps[] = {
 static struct clkdm_dep cam_wkdeps[] = {
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -330,15 +357,18 @@ static struct clkdm_dep cam_wkdeps[] = {
 static struct clkdm_dep dss_wkdeps[] = {
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "wkup_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -347,7 +377,8 @@ static struct clkdm_dep dss_wkdeps[] = {
 static struct clkdm_dep neon_wkdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -359,11 +390,13 @@ static struct clkdm_dep neon_wkdeps[] = {
 static struct clkdm_dep dss_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -372,11 +405,13 @@ static struct clkdm_dep dss_sleepdeps[] = {
 static struct clkdm_dep per_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -385,11 +420,13 @@ static struct clkdm_dep per_sleepdeps[] = {
 static struct clkdm_dep usbhost_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm_name = "iva2_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -398,7 +435,8 @@ static struct clkdm_dep usbhost_sleepdeps[] = {
 static struct clkdm_dep cam_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -412,7 +450,8 @@ static struct clkdm_dep cam_sleepdeps[] = {
 static struct clkdm_dep gfx_sgx_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 |
+					    CHIP_IS_AM35XX)
 	},
 	{ NULL },
 };
@@ -434,19 +473,22 @@ static struct clockdomain wkup_clkdm = {
 	.name		= "wkup_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
 	.dep_bit	= OMAP_EN_WKUP_SHIFT,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430 |
+					 CHIP_IS_AM35XX),
 };
 
 static struct clockdomain prm_clkdm = {
 	.name		= "prm_clkdm",
 	.pwrdm		= { .name = "wkup_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430 |
+					 CHIP_IS_AM35XX)
 };
 
 static struct clockdomain cm_clkdm = {
 	.name		= "cm_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430 |
+					 CHIP_IS_AM35XX)
 };
 
 /*
@@ -619,7 +661,7 @@ static struct clockdomain mpu_3xxx_clkdm = {
 	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
 	.wkdep_srcs	= mpu_3xxx_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain neon_clkdm = {
@@ -628,7 +670,7 @@ static struct clockdomain neon_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.wkdep_srcs	= neon_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain iva2_clkdm = {
@@ -638,7 +680,7 @@ static struct clockdomain iva2_clkdm = {
 	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
 	.wkdep_srcs	= iva2_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain gfx_3430es1_clkdm = {
@@ -673,7 +715,7 @@ static struct clockdomain d2d_clkdm = {
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /*
@@ -687,7 +729,7 @@ static struct clockdomain core_l3_3xxx_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP,
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /*
@@ -701,7 +743,7 @@ static struct clockdomain core_l4_3xxx_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP,
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* Another case of bit name collisions between several registers: EN_DSS */
@@ -713,7 +755,7 @@ static struct clockdomain dss_3xxx_clkdm = {
 	.wkdep_srcs	= dss_wkdeps,
 	.sleepdep_srcs	= dss_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain cam_clkdm = {
@@ -723,7 +765,7 @@ static struct clockdomain cam_clkdm = {
 	.wkdep_srcs	= cam_wkdeps,
 	.sleepdep_srcs	= cam_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain usbhost_clkdm = {
@@ -733,7 +775,7 @@ static struct clockdomain usbhost_clkdm = {
 	.wkdep_srcs	= usbhost_wkdeps,
 	.sleepdep_srcs	= usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain per_clkdm = {
@@ -744,7 +786,7 @@ static struct clockdomain per_clkdm = {
 	.wkdep_srcs	= per_wkdeps,
 	.sleepdep_srcs	= per_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /*
@@ -756,37 +798,37 @@ static struct clockdomain emu_clkdm = {
 	.pwrdm		= { .name = "emu_pwrdm" },
 	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain dpll1_clkdm = {
 	.name		= "dpll1_clkdm",
 	.pwrdm		= { .name = "dpll1_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain dpll2_clkdm = {
 	.name		= "dpll2_clkdm",
 	.pwrdm		= { .name = "dpll2_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain dpll3_clkdm = {
 	.name		= "dpll3_clkdm",
 	.pwrdm		= { .name = "dpll3_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain dpll4_clkdm = {
 	.name		= "dpll4_clkdm",
 	.pwrdm		= { .name = "dpll4_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct clockdomain dpll5_clkdm = {
 	.name		= "dpll5_clkdm",
 	.pwrdm		= { .name = "dpll5_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 | CHIP_IS_AM35XX),
 };
 
 #endif   /* CONFIG_ARCH_OMAP3 */
@@ -798,11 +840,11 @@ static struct clockdomain dpll5_clkdm = {
 static struct clkdm_autodep clkdm_autodeps[] = {
 	{
 		.clkdm	   = { .name = "mpu_clkdm" },
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm	   = { .name = "iva2_clkdm" },
-		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 	},
 	{
 		.clkdm	   = { .name = NULL },
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2537090..53e1996 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -284,10 +284,10 @@ static void __init omap3_check_revision(void)
 		 * Set the device to be OMAP3505 here. Actual device
 		 * is identified later based on the features.
 		 *
-		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
+		 * REVISIT: Should AM3505/AM3517 have independant CHIP_IS?
 		 */
 		omap_revision = OMAP3505_REV(rev);
-		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+		omap_chip.oc = CHIP_IS_AM35XX; 
 		break;
 	case 0xb891:
 		/* Handle 36xx devices */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 909a84d..1b80ed5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -156,7 +156,7 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
 	.slaves		= omap3xxx_l3_main_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_main_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -164,7 +164,8 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
 static struct omap_hwmod omap3xxx_uart1_hwmod;
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
-static struct omap_hwmod omap3xxx_uart4_hwmod;
+static struct omap_hwmod omap36xx_uart4_hwmod;
+static struct omap_hwmod am35xx_uart4_hwmod;
 static struct omap_hwmod omap3xxx_usbhsotg_hwmod;
 
 /* l3_core -> usbhsotg interface */
@@ -300,8 +301,8 @@ static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* L4 PER -> UART4 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart4_addr_space[] = {
+/* L4 PER -> UART4 interface on omap36xx */
+static struct omap_hwmod_addr_space omap36xx_uart4_addr_space[] = {
 	{
 		.pa_start	= OMAP3_UART4_BASE,
 		.pa_end		= OMAP3_UART4_BASE + SZ_1K - 1,
@@ -311,13 +312,32 @@ static struct omap_hwmod_addr_space omap3xxx_uart4_addr_space[] = {
 
 static struct omap_hwmod_ocp_if omap3_l4_per__uart4 = {
 	.master		= &omap3xxx_l4_per_hwmod,
-	.slave		= &omap3xxx_uart4_hwmod,
+	.slave		= &omap36xx_uart4_hwmod,
 	.clk		= "uart4_ick",
-	.addr		= omap3xxx_uart4_addr_space,
-	.addr_cnt	= ARRAY_SIZE(omap3xxx_uart4_addr_space),
+	.addr		= omap36xx_uart4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap36xx_uart4_addr_space),
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* AM35xx L4 CORE -> UART4 interface */
+static struct omap_hwmod_addr_space am35xx_uart4_addr_space[] = {
+	{
+		.pa_start	= AM35XX_UART4_BASE,
+		.pa_end		= AM35XX_UART4_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if am35xx_l4_core__uart4 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &am35xx_uart4_hwmod,
+	.clk		= "uart4_ick",
+	.addr		= am35xx_uart4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(am35xx_uart4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+
 /* I2C IP block address space length (in bytes) */
 #define OMAP2_I2C_AS_LEN		128
 
@@ -498,7 +518,7 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 	.class		= &l4_hwmod_class,
 	.slaves		= omap3xxx_l4_core_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -513,7 +533,7 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.class		= &l4_hwmod_class,
 	.slaves		= omap3xxx_l4_per_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -528,7 +548,7 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.class		= &l4_hwmod_class,
 	.slaves		= omap3xxx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -544,7 +564,7 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.main_clk	= "arm_fck",
 	.masters	= omap3xxx_mpu_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_mpu_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /*
@@ -572,7 +592,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.class		= &iva_hwmod_class,
 	.masters	= omap3xxx_iva_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer class */
@@ -656,7 +676,7 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.slaves		= omap3xxx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer1_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer2 */
@@ -706,7 +726,7 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 	.slaves		= omap3xxx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer2_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer3 */
@@ -756,7 +776,7 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 	.slaves		= omap3xxx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer3_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer4 */
@@ -806,7 +826,7 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 	.slaves		= omap3xxx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer4_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer5 */
@@ -856,7 +876,7 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	.slaves		= omap3xxx_timer5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer5_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer6 */
@@ -906,7 +926,7 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	.slaves		= omap3xxx_timer6_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer6_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer7 */
@@ -956,7 +976,7 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	.slaves		= omap3xxx_timer7_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer7_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer8 */
@@ -1006,7 +1026,7 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	.slaves		= omap3xxx_timer8_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer8_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer9 */
@@ -1056,7 +1076,7 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	.slaves		= omap3xxx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer9_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer10 */
@@ -1106,7 +1126,7 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	.slaves		= omap3xxx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer10_slaves),
 	.class		= &omap3xxx_timer_1ms_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer11 */
@@ -1156,7 +1176,7 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.slaves		= omap3xxx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer11_slaves),
 	.class		= &omap3xxx_timer_hwmod_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX)
 };
 
 /* timer12*/
@@ -1283,7 +1303,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 	},
 	.slaves		= omap3xxx_wd_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	/*
 	 * XXX: Use software supervised mode, HW supervised smartidle seems to
 	 * block CORE power domain idle transitions. Maybe a HW bug in wdt2?
@@ -1343,7 +1363,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.slaves		= omap3xxx_uart1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart1_slaves),
 	.class		= &uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* UART2 */
@@ -1380,7 +1400,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.slaves		= omap3xxx_uart2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart2_slaves),
 	.class		= &uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* UART3 */
@@ -1417,7 +1437,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.slaves		= omap3xxx_uart3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart3_slaves),
 	.class		= &uart_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* UART4 */
@@ -1435,7 +1455,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
 	&omap3_l4_per__uart4,
 };
 
-static struct omap_hwmod omap3xxx_uart4_hwmod = {
+static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.name		= "uart4",
 	.mpu_irqs	= uart4_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(uart4_mpu_irqs),
@@ -1457,6 +1477,42 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
+static struct omap_hwmod_irq_info omap35xx_uart4_mpu_irqs[] = {
+	{ .irq = INT_35XX_UART4, },
+};
+
+static struct omap_hwmod_dma_info omap35xx_uart4_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = AM35XX_DMA_UART4_RX, },
+	{ .name = "tx",	.dma_req = AM35XX_DMA_UART4_TX, },
+};
+
+static struct omap_hwmod_ocp_if *am35xx_uart4_slaves[] = {
+	&am35xx_l4_core__uart4,
+};
+
+static struct omap_hwmod am35xx_uart4_hwmod = {
+	.name		= "uart4",
+	.mpu_irqs	= omap35xx_uart4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap35xx_uart4_mpu_irqs),
+	.sdma_reqs	= omap35xx_uart4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap35xx_uart4_sdma_reqs),
+	.main_clk	= "uart4_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = AM35XX_EN_UART4_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = AM35XX_EN_UART4_SHIFT,
+		},
+	},
+	.slaves		= am35xx_uart4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(am35xx_uart4_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_AM35XX),
+};
+
+
 static struct omap_hwmod_class i2c_class = {
 	.name = "i2c",
 	.sysc = &i2c_sysc,
@@ -1909,7 +1965,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c1_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* I2C2 */
@@ -1951,7 +2007,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c2_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* I2C3 */
@@ -1993,7 +2049,7 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c3_slaves),
 	.class		= &i2c_class,
 	.dev_attr	= &i2c3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* l4_wkup -> gpio1 */
@@ -2160,7 +2216,7 @@ static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio1_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* gpio2 */
@@ -2197,7 +2253,7 @@ static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio2_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* gpio3 */
@@ -2234,7 +2290,7 @@ static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio3_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* gpio4 */
@@ -2271,7 +2327,7 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio4_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* gpio5 */
@@ -2308,7 +2364,7 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio5_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* gpio6 */
@@ -2345,7 +2401,7 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio6_slaves),
 	.class		= &omap3xxx_gpio_hwmod_class,
 	.dev_attr	= &gpio_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* dma_system -> L3 */
@@ -2437,7 +2493,7 @@ static struct omap_hwmod omap3xxx_dma_system_hwmod = {
 	.masters	= omap3xxx_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_dma_system_masters),
 	.dev_attr	= &dma_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -2516,7 +2572,7 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcbsp2 */
@@ -2579,7 +2635,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.slaves		= omap3xxx_mcbsp2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_slaves),
 	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcbsp3 */
@@ -2642,7 +2698,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.slaves		= omap3xxx_mcbsp3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_slaves),
 	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcbsp4 */
@@ -2700,7 +2756,7 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcbsp5 */
@@ -2758,7 +2814,7 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp5_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 /* 'mcbsp sidetone' class */
 
@@ -2819,7 +2875,7 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp2_sidetone_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sidetone_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcbsp3_sidetone */
@@ -2868,7 +2924,7 @@ static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 	},
 	.slaves		= omap3xxx_mcbsp3_sidetone_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sidetone_slaves),
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 
@@ -3208,7 +3264,7 @@ static struct omap_hwmod omap34xx_mcspi1 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi1_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi1_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcspi2 */
@@ -3251,7 +3307,7 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi2_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi2_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* mcspi3 */
@@ -3294,7 +3350,7 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi3_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi3_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* SPI4 */
@@ -3335,7 +3391,7 @@ static struct omap_hwmod omap34xx_mcspi4 = {
 	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi4_slaves),
 	.class		= &omap34xx_mcspi_class,
 	.dev_attr       = &omap_mcspi4_dev_attr,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /*
@@ -3420,7 +3476,7 @@ static struct omap_hwmod am35xx_usbhsotg_hwmod = {
 	.slaves		= am35xx_usbhsotg_slaves,
 	.slaves_cnt	= ARRAY_SIZE(am35xx_usbhsotg_slaves),
 	.class		= &am35xx_usbotg_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1)
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 | CHIP_IS_AM35XX)
 };
 
 /* MMC/SD/SDIO common */
@@ -3486,7 +3542,7 @@ static struct omap_hwmod omap3xxx_mmc1_hwmod = {
 	.slaves		= omap3xxx_mmc1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc1_slaves),
 	.class		= &omap34xx_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* MMC/SD/SDIO2 */
@@ -3529,7 +3585,7 @@ static struct omap_hwmod omap3xxx_mmc2_hwmod = {
 	.slaves		= omap3xxx_mmc2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc2_slaves),
 	.class		= &omap34xx_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 /* MMC/SD/SDIO3 */
@@ -3571,7 +3627,7 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.slaves		= omap3xxx_mmc3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mmc3_slaves),
 	.class		= &omap34xx_mmc_class,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
@@ -3602,7 +3658,9 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_uart1_hwmod,
 	&omap3xxx_uart2_hwmod,
 	&omap3xxx_uart3_hwmod,
-	&omap3xxx_uart4_hwmod,
+	&omap36xx_uart4_hwmod,
+	&am35xx_uart4_hwmod,
+
 	/* dss class */
 	&omap3430es1_dss_core_hwmod,
 	&omap3xxx_dss_core_hwmod,
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 4210c33..2083f2c 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -75,6 +75,6 @@ struct powerdomain gfx_omap2_pwrdm = {
 struct powerdomain wkup_omap2_pwrdm = {
 	.name		= "wkup_pwrdm",
 	.prcm_offs	= WKUP_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.pwrsts		= PWRSTS_ON,
 };
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 469a920..9a94482 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -36,7 +36,7 @@
 static struct powerdomain iva2_pwrdm = {
 	.name		  = "iva2_pwrdm",
 	.prcm_offs	  = OMAP3430_IVA2_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 4,
@@ -57,7 +57,7 @@ static struct powerdomain iva2_pwrdm = {
 static struct powerdomain mpu_3xxx_pwrdm = {
 	.name		  = "mpu_pwrdm",
 	.prcm_offs	  = MPU_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_MPU_QUIRK,
@@ -104,7 +104,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
-					  CHIP_GE_OMAP3630ES1_1),
+					  CHIP_GE_OMAP3630ES1_1 | CHIP_IS_AM35XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	/*
@@ -125,7 +125,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 
 static struct powerdomain dss_pwrdm = {
 	.name		  = "dss_pwrdm",
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.prcm_offs	  = OMAP3430_DSS_MOD,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
@@ -161,7 +161,7 @@ static struct powerdomain sgx_pwrdm = {
 
 static struct powerdomain cam_pwrdm = {
 	.name		  = "cam_pwrdm",
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.prcm_offs	  = OMAP3430_CAM_MOD,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
@@ -177,7 +177,7 @@ static struct powerdomain cam_pwrdm = {
 static struct powerdomain per_pwrdm = {
 	.name		  = "per_pwrdm",
 	.prcm_offs	  = OMAP3430_PER_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -192,13 +192,13 @@ static struct powerdomain per_pwrdm = {
 static struct powerdomain emu_pwrdm = {
 	.name		= "emu_pwrdm",
 	.prcm_offs	= OMAP3430_EMU_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct powerdomain neon_pwrdm = {
 	.name		  = "neon_pwrdm",
 	.prcm_offs	  = OMAP3430_NEON_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 };
@@ -206,7 +206,7 @@ static struct powerdomain neon_pwrdm = {
 static struct powerdomain usbhost_pwrdm = {
 	.name		  = "usbhost_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_USBHOST_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 | CHIP_IS_AM35XX),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
 	/*
@@ -228,31 +228,31 @@ static struct powerdomain usbhost_pwrdm = {
 static struct powerdomain dpll1_pwrdm = {
 	.name		= "dpll1_pwrdm",
 	.prcm_offs	= MPU_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct powerdomain dpll2_pwrdm = {
 	.name		= "dpll2_pwrdm",
 	.prcm_offs	= OMAP3430_IVA2_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct powerdomain dpll3_pwrdm = {
 	.name		= "dpll3_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct powerdomain dpll4_pwrdm = {
 	.name		= "dpll4_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430 | CHIP_IS_AM35XX),
 };
 
 static struct powerdomain dpll5_pwrdm = {
 	.name		= "dpll5_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2 | CHIP_IS_AM35XX),
 };
 
 /* As powerdomains are added or removed above, this list must also be changed */
