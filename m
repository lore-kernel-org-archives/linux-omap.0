From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 2/2] TEMP: OMAP3: beagle: added dummy vdd ramp up and clock setup times
Date: Wed, 3 Aug 2011 18:29:15 +0300
Message-ID: <1312385355-17029-3-git-send-email-t-kristo@ti.com>
References: <1312385355-17029-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44933 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab1HCP3u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 11:29:50 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p73FToa5002916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Aug 2011 10:29:50 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p73FTov1025078
	for <linux-omap@vger.kernel.org>; Wed, 3 Aug 2011 10:29:50 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p73FTmSI017147
	for <linux-omap@vger.kernel.org>; Wed, 3 Aug 2011 10:29:49 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1312385355-17029-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch provided just as an example, actual times should be measured
for the board.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   36 +++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 34f8411..fea94cc 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -47,11 +47,13 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "mux.h"
 #include "hsmmc.h"
 #include "pm.h"
 #include "common-board-devices.h"
+#include "voltage.h"
 
 /*
  * OMAP3 Beagle revision
@@ -83,6 +85,29 @@ static struct gpio omap3_beagle_rev_gpios[] __initdata = {
 	{ 173, GPIOF_IN, "rev_id_2"    },
 };
 
+struct omap_volt_board_data beagle_mpu_volt_data = {
+	.vdd_setup_ret = {
+		.ramp_up = 50,
+	},
+	.vdd_setup_off = {
+		.ramp_up = 100,
+	},
+};
+
+struct omap_volt_board_data beagle_core_volt_data = {
+	.vdd_setup_ret = {
+		.ramp_up = 50,
+	},
+	.vdd_setup_off = {
+		.ramp_up = 100,
+	},
+};
+
+struct omap_osc_data beagle_osc_data = {
+	.clk_setup_ret = 50,
+	.clk_setup_off = 5000,
+};
+
 static void __init omap3_beagle_init_rev(void)
 {
 	int ret;
@@ -506,6 +531,8 @@ static void __init beagle_opp_init(void)
 
 static void __init omap3_beagle_init(void)
 {
+	struct voltagedomain *voltdm;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
@@ -532,6 +559,15 @@ static void __init omap3_beagle_init(void)
 
 	beagle_display_init();
 	beagle_opp_init();
+
+	voltdm = voltdm_lookup("mpu_iva");
+	pr_info("beagle: adding volt data\n");
+	omap_voltage_register_board_params(voltdm, &beagle_mpu_volt_data);
+
+	voltdm = voltdm_lookup("core");
+	omap_voltage_register_board_params(voltdm, &beagle_core_volt_data);
+
+	omap_osc_register(&beagle_osc_data);
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

