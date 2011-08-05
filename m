From: Tero Kristo <t-kristo@ti.com>
Subject: [RFCv2 2/2] TEMP: OMAP3: beagle: added dummy clock setup times
Date: Fri, 5 Aug 2011 16:27:21 +0300
Message-ID: <1312550842-32466-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41441 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab1HEN1Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 09:27:25 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p75DRPUR028607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:25 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p75DROOT029312
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:24 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p75DROvv022480
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 08:27:24 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch provided just as an example, actual time should be checked from
the datasheet.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 34f8411..6b3b67a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -47,6 +47,7 @@
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -83,6 +84,11 @@ static struct gpio omap3_beagle_rev_gpios[] __initdata = {
 	{ 173, GPIOF_IN, "rev_id_2"    },
 };
 
+struct omap_osc_data beagle_osc_data = {
+	.clk_setup_ret = 50,
+	.clk_setup_off = 5000,
+};
+
 static void __init omap3_beagle_init_rev(void)
 {
 	int ret;
@@ -532,6 +538,8 @@ static void __init omap3_beagle_init(void)
 
 	beagle_display_init();
 	beagle_opp_init();
+
+	omap_osc_register(&beagle_osc_data);
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

