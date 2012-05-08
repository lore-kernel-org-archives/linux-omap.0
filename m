From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: AM35xx: convert 3517 detection/flags to
 AM35xx
Date: Tue, 8 May 2012 15:15:05 -0700
Message-ID: <20120508221505.GM5088@atomide.com>
References: <1335829030-19431-1-git-send-email-khilman@ti.com>
 <1335829030-19431-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16144 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab2EHWPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 18:15:08 -0400
Content-Disposition: inline
In-Reply-To: <1335829030-19431-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120430 16:40]:
> Currently cpu_is_omap3517() actually detects any device in the AM35x
> family (3517 and no-SGX version 3505.)  To make it more clear what is
> being detected, convert the names from 3517 to AM35xx.
> 
> This adds a new cpu_is_am35xx() which duplicates the cpu_is_omap3517().
> In order to avoid cross-tree dependencies with clock-tree changes,
> cpu_is_omap3517() is left until the clock changes are merged,
> at which point cpu_is_omap3517() will be completely removed.

We should start using soc_is_omap instead of cpu_is_omap for the
new ones. The old ones we can rename as part of other clean-up.

I've updated your patch below accordingly.

Regards,

Tony

From: Kevin Hilman <khilman@ti.com>
Date: Mon, 30 Apr 2012 16:37:10 -0700
Subject: [PATCH] ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx

Currently cpu_is_omap3517() actually detects any device in the AM35x
family (3517 and no-SGX version 3505.)  To make it more clear what is
being detected, convert the names from 3517 to AM35xx.

This adds a new soc_is_am35xx() which duplicates the cpu_is_omap3517().
In order to avoid cross-tree dependencies with clock-tree changes,
cpu_is_omap3517() is left until the clock changes are merged,
at which point cpu_is_omap3517() will be completely removed.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Mark A. Greer <mgreer@animalcreek.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
[tony@atomide.com: change to use soc_is_omap instead]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index a8ca655..be697d4 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -355,7 +355,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	 *
 	 * temporary HACK: ocr_mask instead of fixed supply
 	 */
-	if (cpu_is_omap3517())
+	if (soc_is_am35xx())
 		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
 					 MMC_VDD_26_27 |
 					 MMC_VDD_27_28 |
@@ -365,7 +365,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
-	if (!cpu_is_omap3517())
+	if (!soc_is_am35xx())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
 	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
@@ -388,7 +388,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
-		if (cpu_is_omap3517())
+		if (soc_is_am35xx())
 			mmc->slots[0].set_power = nop_mmc_set_power;
 
 		/* OMAP3630 HSMMC1 supports only 4-bit */
@@ -400,7 +400,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		}
 		break;
 	case 2:
-		if (cpu_is_omap3517())
+		if (soc_is_am35xx())
 			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
 
 		if (c->ext_clock)
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 0e79b7b..f611e30 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -185,8 +185,7 @@ static void __init omap3_cpuinfo(void)
 	 */
 	if (cpu_is_omap3630()) {
 		cpu_name = "OMAP3630";
-	} else if (cpu_is_omap3517()) {
-		/* AM35xx devices */
+	} else if (soc_is_am35xx()) {
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
 		cpu_name = "TI816X";
@@ -352,13 +351,13 @@ void __init omap3xxx_check_revision(void)
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
index 0c65079..43d2880 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3224,7 +3224,7 @@ int __init omap3xxx_hwmod_init(void)
 	    rev == OMAP3430_REV_ES2_1 || rev == OMAP3430_REV_ES3_0 ||
 	    rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2) {
 		h = omap34xx_hwmod_ocp_ifs;
-	} else if (rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1) {
+	} else if (rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1) {
 		h = am35xx_hwmod_ocp_ifs;
 	} else if (rev == OMAP3630_REV_ES1_0 || rev == OMAP3630_REV_ES1_1 ||
 		   rev == OMAP3630_REV_ES1_2) {
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index b7ea468..fb0a0a6 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -311,7 +311,7 @@ void __init omap3xxx_powerdomains_init(void)
 		 rev == OMAP3430_REV_ES3_0 || rev == OMAP3630_REV_ES1_0)
 		pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
 	else if (rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2 ||
-		 rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1 ||
+		 rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1 ||
 		 rev == OMAP3630_REV_ES1_1 || rev == OMAP3630_REV_ES1_2)
 		pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
 	else
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index bf33b4d..b19d1b4 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -90,7 +90,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap3517()) {
+	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
 	} else if (cpu_is_ti81xx()) {
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 98ed4d7..d0103c8 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -118,7 +118,7 @@ void __init omap3xxx_voltagedomains_init(void)
 	}
 #endif
 
-	if (cpu_is_omap3517())
+	if (soc_is_am35xx())
 		voltdms = voltagedomains_am35xx;
 	else
 		voltdms = voltagedomains_omap3;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..bf90212 100644
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
+#define soc_is_am35xx()			0
 #define cpu_is_am33xx()			0
 #define cpu_is_am335x()			0
 #define cpu_is_omap44xx()		0
@@ -357,6 +359,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
+# undef soc_is_am35xx
 # undef cpu_is_am33xx
 # undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
@@ -378,6 +381,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
+# define soc_is_am35xx()		is_am35xx()
 # define cpu_is_am33xx()		is_am33xx()
 # define cpu_is_am335x()		is_am335x()
 #endif
@@ -433,6 +437,10 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8148_REV_ES2_0	(TI814X_CLASS | (0x1 << 8))
 #define TI8148_REV_ES2_1	(TI814X_CLASS | (0x2 << 8))
 
+#define AM35XX_CLASS		0x35170034
+#define AM35XX_REV_ES1_0	AM35XX_CLASS
+#define AM35XX_REV_ES1_1	(AM35XX_CLASS | (0x1 << 8))
+
 #define AM335X_CLASS		0x33500034
 #define AM335X_REV_ES1_0	AM335X_CLASS
 
