From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
Date: Tue,  8 May 2012 10:19:01 -0700
Message-ID: <1336497542-13629-2-git-send-email-khilman@ti.com>
References: <1336497542-13629-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:39013 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756476Ab2EHRTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 13:19:09 -0400
Received: by pbbro2 with SMTP id ro2so10452602pbb.27
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 10:19:08 -0700 (PDT)
In-Reply-To: <1336497542-13629-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-arm-kernel@lists.infradead.org

The TWL driver has been converted to use SPARSE_IRQ and no longer
needs to be passed IRQ base/end.  Since driver no longer uses these
fields, so remove them from the reamaining users.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
 arch/arm/mach-omap2/board-omap3logic.c |    3 ---
 arch/arm/mach-omap2/twl-common.c       |   10 ----------
 3 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e658f83..3a59a25 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -218,9 +218,6 @@ static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
 };
 
 static struct twl4030_platform_data sdp2430_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
-
 	/* platform_data for children goes here */
 	.gpio		= &sdp2430_gpio_data,
 	.vmmc1		= &sdp2430_vmmc1,
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 9b3c141..0dea793 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -86,9 +86,6 @@ static struct twl4030_gpio_platform_data omap3logic_gpio_data = {
 };
 
 static struct twl4030_platform_data omap3logic_twldata = {
-	.irq_base	= TWL4030_IRQ_BASE,
-	.irq_end	= TWL4030_IRQ_END,
-
 	/* platform_data for children goes here */
 	.gpio		= &omap3logic_gpio_data,
 	.vmmc1		= &omap3logic_vmmc1,
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 7a7b893..f0e0fee 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -156,11 +156,6 @@ static struct regulator_init_data omap3_vpll2_idata = {
 void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL4030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL4030_IRQ_END;
-
 	/* Common platform data configurations */
 	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
 		pmic_data->usb = &omap3_usb_pdata;
@@ -313,11 +308,6 @@ static struct regulator_init_data omap4_clk32kg_idata = {
 void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
 				  u32 pdata_flags, u32 regulators_flags)
 {
-	if (!pmic_data->irq_base)
-		pmic_data->irq_base = TWL6030_IRQ_BASE;
-	if (!pmic_data->irq_end)
-		pmic_data->irq_end = TWL6030_IRQ_END;
-
 	/* Common platform data configurations */
 	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
 		pmic_data->usb = &omap4_usb_pdata;
-- 
1.7.9.2

