From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 8/7] ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx
Date: Fri,  6 Jan 2012 10:53:43 -0800
Message-ID: <1325876023-7040-1-git-send-email-khilman@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33375 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751985Ab2AFSxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 13:53:43 -0500
Received: by mail-yw0-f45.google.com with SMTP id g71so835734yhg.32
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 10:53:42 -0800 (PST)
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Currently cpu_is_omap3517() actually detects any device in the AM35x
family (3517 and no-SGX version 3505.)  To make it more clear what is
being detected, convert the names from 3517 to AM35xx.

For the same reason, replace the CK_3517 flag used in the clock data
to CK_AM35XX.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c          |    8 ++++----
 arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
 arch/arm/mach-omap2/id.c                      |    7 +++----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +--
 arch/arm/plat-omap/include/plat/cpu.h         |   15 +++++++--------
 9 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 26fb4d9..745df5f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3286,8 +3286,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
-	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2PLUS | CK_3517 | CK_36XX),
-	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2PLUS | CK_3517 | CK_36XX),
+	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
 	CLK(NULL,	"modem_fck",	&modem_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_34XX | CK_36XX),
@@ -3505,9 +3505,9 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = 0;
 
-	if (cpu_is_omap3517()) {
+	if (cpu_is_am35xx()) {
 		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3517;
+		cpu_clkflg = CK_AM35XX;
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index c49a91d..70dbe6a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -353,7 +353,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	 *
 	 * temporary HACK: ocr_mask instead of fixed supply
 	 */
-	if (cpu_is_omap3517())
+	if (cpu_is_am35xx())
 		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
 					 MMC_VDD_26_27 |
 					 MMC_VDD_27_28 |
@@ -363,7 +363,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
-	if (!cpu_is_omap3517())
+	if (!cpu_is_am35xx())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
 	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
@@ -386,7 +386,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
-		if (cpu_is_omap3517())
+		if (cpu_is_am35xx())
 			mmc->slots[0].set_power = nop_mmc_set_power;
 
 		/* OMAP3630 HSMMC1 supports only 4-bit */
@@ -398,7 +398,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		}
 		break;
 	case 2:
-		if (cpu_is_omap3517())
+		if (cpu_is_am35xx())
 			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
 
 		if (c->ext_clock)
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 92e4d55..325e12e 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -183,8 +183,7 @@ static void __init omap3_cpuinfo(void)
 	 */
 	if (cpu_is_omap3630()) {
 		cpu_name = "OMAP3630";
-	} else if (cpu_is_omap3517()) {
-		/* AM35xx devices */
+	} else if (cpu_is_am35xx()) {
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
 		cpu_name = "TI816X";
@@ -350,13 +349,13 @@ void __init omap3xxx_check_revision(void)
 		 */
 		switch (rev) {
 		case 0:
-			omap_revision = OMAP3517_REV_ES1_0;
+			omap_revision = AM35XX_REV_ES1_0;
 			cpu_rev = "1.0";
 			break;
 		case 1:
 		/* FALLTHROUGH */
 		default:
-			omap_revision = OMAP3517_REV_ES1_1;
+			omap_revision = AM35XX_REV_ES1_1;
 			cpu_rev = "1.1";
 		}
 		break;
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5324e8d..06627dd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3664,7 +3664,7 @@ int __init omap3xxx_hwmod_init(void)
 	    rev == OMAP3430_REV_ES2_1 || rev == OMAP3430_REV_ES3_0 ||
 	    rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2) {
 		h = omap34xx_hwmods;
-	} else if (rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1) {
+	} else if (rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1) {
 		h = am35xx_hwmods;
 	} else if (rev == OMAP3630_REV_ES1_0 || rev == OMAP3630_REV_ES1_1 ||
 		   rev == OMAP3630_REV_ES1_2) {
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 8ef26da..6360736 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -310,7 +310,7 @@ void __init omap3xxx_powerdomains_init(void)
 		 rev == OMAP3430_REV_ES3_0 || rev == OMAP3630_REV_ES1_0)
 		pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
 	else if (rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2 ||
-		 rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1 ||
+		 rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1 ||
 		 rev == OMAP3630_REV_ES1_1 || rev == OMAP3630_REV_ES1_2)
 		pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
 	else
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index bf33b4d..ae07060 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -90,7 +90,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap3517()) {
+	if (cpu_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
 	} else if (cpu_is_ti81xx()) {
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index bdb82f1..ea98939 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -116,7 +116,7 @@ void __init omap3xxx_voltagedomains_init(void)
 		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
 	}
 
-	if (cpu_is_omap3517())
+	if (cpu_is_am35xx())
 		voltdms = voltagedomains_am35xx;
 	else
 		voltdms = voltagedomains_omap3;
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 45afa4d..d0ed8c4 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -34,7 +34,7 @@ struct omap_clk {
 #define CK_243X		(1 << 5)	/* 243x, 253x */
 #define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
 #define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only */
-#define CK_3517		(1 << 9)
+#define CK_AM35XX	(1 << 9)	/* Sitara AM35xx */
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
@@ -43,7 +43,6 @@ struct omap_clk {
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
-#define CK_AM35XX	CK_3517		/* all Sitara AM35xx */
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
 
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2c8e5ab..43b3283 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -121,6 +121,7 @@ IS_OMAP_CLASS(16xx, 0x16)
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
+IS_AM_CLASS(35xx, 0x35)
 IS_AM_CLASS(33xx, 0x33)
 
 IS_TI_CLASS(81xx, 0x81)
@@ -148,6 +149,7 @@ IS_AM_SUBCLASS(335x, 0x335)
 #define cpu_is_ti81xx()			0
 #define cpu_is_ti816x()			0
 #define cpu_is_ti814x()			0
+#define cpu_is_am35xx()			0
 #define cpu_is_am33xx()			0
 #define cpu_is_am335x()			0
 #define cpu_is_omap44xx()		0
@@ -251,7 +253,6 @@ IS_AM_SUBCLASS(335x, 0x335)
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
  * cpu_is_omap4430():	True for OMAP4430
- * cpu_is_omap3517():	True for AM35x: OMAP3517, OMAP3505
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -275,7 +276,6 @@ IS_OMAP_TYPE(2422, 0x2422)
 IS_OMAP_TYPE(2423, 0x2423)
 IS_OMAP_TYPE(2430, 0x2430)
 IS_OMAP_TYPE(3430, 0x3430)
-IS_OMAP_TYPE(3517, 0x3517)
 
 #define cpu_is_omap310()		0
 #define cpu_is_omap730()		0
@@ -290,7 +290,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap2422()		0
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
-#define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
 #define cpu_is_omap4430()		0
 #define cpu_is_omap3630()		0
@@ -343,19 +342,19 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #if defined(CONFIG_ARCH_OMAP3)
 # undef cpu_is_omap3430
-# undef cpu_is_omap3517
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
+# undef cpu_is_am35xx
 # undef cpu_is_am33xx
 # undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
-# define cpu_is_omap3517()		is_omap3517()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
+# define cpu_is_am35xx()		is_am35xx()
 # define cpu_is_am33xx()		is_am33xx()
 # define cpu_is_am335x()		is_am335x()
 #endif
@@ -398,9 +397,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3630_REV_ES1_1	(OMAP363X_CLASS | (0x1 << 8))
 #define OMAP3630_REV_ES1_2	(OMAP363X_CLASS | (0x2 << 8))
 
-#define OMAP3517_CLASS		0x35170034
-#define OMAP3517_REV_ES1_0	OMAP3517_CLASS
-#define OMAP3517_REV_ES1_1	(OMAP3517_CLASS | (0x1 << 8))
+#define AM35XX_CLASS		0x35170034
+#define AM35XX_REV_ES1_0	AM35XX_CLASS
+#define AM35XX_REV_ES1_1	(AM35XX_CLASS | (0x1 << 8))
 
 #define TI816X_CLASS		0x81600034
 #define TI8168_REV_ES1_0	TI816X_CLASS
-- 
1.7.8.2

