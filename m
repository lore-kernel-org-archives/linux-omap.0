From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 5/6] omap3: beagleboard: add SMPS regulators
Date: Mon, 18 Jul 2011 20:35:21 +0300
Message-ID: <1311010522-5868-6-git-send-email-t-kristo@ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60875 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab1GRRgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jul 2011 13:36:09 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com

This is using the common API defined in twl-common.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 32f5f89..d493b0b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -444,6 +444,8 @@ static struct platform_device keys_gpio = {
 	},
 };
 
+static struct platform_device beagle_smps;
+
 static void __init omap3_beagle_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -459,6 +461,7 @@ static void __init omap3_beagle_init_irq(void)
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
+	&beagle_smps,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
@@ -533,6 +536,7 @@ static void __init omap3_beagle_init(void)
 
 	gpio_buttons[0].gpio = beagle_config.usr_button_gpio;
 
+	omap3_pmic_get_smps_config(&beagle_smps);
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

