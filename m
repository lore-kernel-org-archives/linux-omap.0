From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 4/8] ARM: OMAP: AM35x: remove redunant cpu_is checks for AM3505
Date: Thu, 26 Apr 2012 16:29:49 -0700
Message-ID: <1335482993-14035-5-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56057 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753398Ab2DZX3Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 19:29:16 -0400
Received: by dadz8 with SMTP id z8so244405dad.24
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 16:29:15 -0700 (PDT)
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

There are several checks for AM35x devices done using

      if (cpu_is_omap3517() || cpu_is_omap3505())

However, since the 3505 is just a 3517 without an SGX, the 3505 check
is redundant because cpu_is_omap3517() will always be true whenever
cpu_is_omap3505() is true.  From <plat/cpu.h>:

 #define cpu_is_omap3505() (cpu_is_omap3517() && !omap3_has_sgx())

Therefore, remove the redunant 3505 checks.  This helps move towards
removal of SoC detection that depends on specific IP detection.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
 arch/arm/mach-omap2/usb-musb.c                |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b0268ea..a8ca655 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -355,7 +355,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	 *
 	 * temporary HACK: ocr_mask instead of fixed supply
 	 */
-	if (cpu_is_omap3505() || cpu_is_omap3517())
+	if (cpu_is_omap3517())
 		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
 					 MMC_VDD_26_27 |
 					 MMC_VDD_27_28 |
@@ -365,7 +365,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
-	if (!cpu_is_omap3517() && !cpu_is_omap3505())
+	if (!cpu_is_omap3517())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
 	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
@@ -388,7 +388,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
-		if (cpu_is_omap3517() || cpu_is_omap3505())
+		if (cpu_is_omap3517())
 			mmc->slots[0].set_power = nop_mmc_set_power;
 
 		/* OMAP3630 HSMMC1 supports only 4-bit */
@@ -400,7 +400,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		}
 		break;
 	case 2:
-		if (cpu_is_omap3517() || cpu_is_omap3505())
+		if (cpu_is_omap3517())
 			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
 
 		if (c->ext_clock)
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 8d5ed77..bf33b4d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -90,7 +90,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap3517() || cpu_is_omap3505()) {
+	if (cpu_is_omap3517()) {
 		oh_name = "am35x_otg_hs";
 		name = "musb-am35x";
 	} else if (cpu_is_ti81xx()) {
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 57db203..98ed4d7 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -118,7 +118,7 @@ void __init omap3xxx_voltagedomains_init(void)
 	}
 #endif
 
-	if (cpu_is_omap3517() || cpu_is_omap3505())
+	if (cpu_is_omap3517())
 		voltdms = voltagedomains_am35xx;
 	else
 		voltdms = voltagedomains_omap3;
-- 
1.7.9.2

