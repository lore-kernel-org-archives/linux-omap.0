From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 01/13] ARM: OMAP2+: hwmod: AM335x: prepare for AM43x reuse
Date: Thu, 11 Jul 2013 12:04:03 +0530
Message-ID: <1c4a872117bd814d7fad856b6ef89fc6dbcf37da.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33965 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab3GKGe3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 02:34:29 -0400
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>

AM335x & AM43x have most of the interconnects, IPs similar. Instead of
adding new hwmod data for AM43x, reuse AM335x hwmod data as much as
possible.

In the hwmod entries that could be reused on AM43x, major changes are
in register offsets and different ocpif clock for most of peripherals
that comes under l4_wkup interconnect.

To achieve reuse, as a first step, bring out ocpif's relevant for both
SoC's to a new array and handle appropriately.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 7a9b492..b0a38f0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -29,6 +29,7 @@
 #include "i2c.h"
 #include "mmc.h"
 #include "wd_timer.h"
+#include "soc.h"
 
 /*
  * IP blocks
@@ -2458,6 +2459,13 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
 
 static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__emif,
+	&am33xx_l4_hs__pruss,
+	&am33xx_l3_main__lcdc,
+	&am33xx_l3_s__usbss,
+	NULL,
+};
+
+static struct omap_hwmod_ocp_if *amx3xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_mpu__l3_main,
 	&am33xx_mpu__prcm,
 	&am33xx_l3_s__l4_ls,
@@ -2481,7 +2489,6 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__gpio0,
 	&am33xx_l4_wkup__adc_tsc,
 	&am33xx_l4_wkup__wd_timer1,
-	&am33xx_l4_hs__pruss,
 	&am33xx_l4_per__dcan0,
 	&am33xx_l4_per__dcan1,
 	&am33xx_l4_per__gpio1,
@@ -2522,14 +2529,12 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_epwmss2__eqep2,
 	&am33xx_epwmss2__ehrpwm2,
 	&am33xx_l3_s__gpmc,
-	&am33xx_l3_main__lcdc,
 	&am33xx_l4_ls__mcspi0,
 	&am33xx_l4_ls__mcspi1,
 	&am33xx_l3_main__tptc0,
 	&am33xx_l3_main__tptc1,
 	&am33xx_l3_main__tptc2,
 	&am33xx_l3_main__ocmc,
-	&am33xx_l3_s__usbss,
 	&am33xx_l4_hs__cpgmac0,
 	&am33xx_cpgmac0__mdio,
 	&am33xx_l3_main__sha0,
@@ -2539,6 +2544,15 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 
 int __init am33xx_hwmod_init(void)
 {
+	int ret;
+
 	omap_hwmod_init();
-	return omap_hwmod_register_links(am33xx_hwmod_ocp_ifs);
+	ret = omap_hwmod_register_links(amx3xx_hwmod_ocp_ifs);
+	if (ret < 0)
+		return ret;
+
+	if (soc_is_am33xx())
+		return omap_hwmod_register_links(am33xx_hwmod_ocp_ifs);
+
+	return 0;
 }
-- 
1.8.3.1

