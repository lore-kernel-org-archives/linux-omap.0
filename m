From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
Date: Wed,  5 Jan 2011 14:49:36 -0600
Message-ID: <1294260576-20237-3-git-send-email-nm@ti.com>
References: <1294260576-20237-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51566 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939Ab1AEUtu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 15:49:50 -0500
In-Reply-To: <1294260576-20237-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Nishanth Menon <nm@ti.com>

Beagle XM uses 3730 and the board design allows enabling 800MHz and 1GHz
OPPs. However, We need Smart reflex class 1.5 and ABB to enable 1GHz safely.
For the moment, we tweak the default table to allow for 800Mhz OPP usage.

Reported-by: Koen Kooi <koen@beagleboard.org>
Tested-by: Koen Kooi <koen@beagleboard.org>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   50 +++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6c12760..0b99b80 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/opp.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -44,10 +45,12 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
 
 #include "mux.h"
 #include "hsmmc.h"
 #include "timer-gp.h"
+#include "pm.h"
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
@@ -556,6 +559,52 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static void __init beagle_opp_init(void)
+{
+	int r = 0;
+
+	/* Initialize the omap3 opp table */
+	if (omap3_opp_init()) {
+		pr_err("%s: opp default init failed\n", __func__);
+		return;
+	}
+
+	/* Custom OPP enabled for XM */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
+		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
+		struct device *dev;
+
+		if (!mh || !dh) {
+			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
+				__func__, mh, dh);
+			r = -EINVAL;
+		} else {
+			/* Enable MPU 1GHz and lower opps */
+			dev = &mh->od->pdev.dev;
+			r = opp_enable(dev, 800000000);
+			/* TODO: MPU 1GHz needs SR and ABB */
+
+			/* Enable IVA 800MHz and lower opps */
+			dev = &dh->od->pdev.dev;
+			r |= opp_enable(dev, 660000000);
+			/* TODO: DSP 800MHz needs SR and ABB */
+		}
+		if (r) {
+			pr_err("%s: failed to enable higher opp %d\n",
+				__func__, r);
+			/*
+			 * Cleanup - disable the higher freqs - we dont care
+			 * about the results
+			 */
+			dev = &mh->od->pdev.dev;
+			opp_disable(dev, 800000000);
+			dev = &dh->od->pdev.dev;
+			opp_disable(dev, 660000000);
+		}
+	}
+}
+
 static void __init omap3_beagle_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -579,6 +628,7 @@ static void __init omap3_beagle_init(void)
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	beagle_display_init();
+	beagle_opp_init();
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
-- 
1.6.3.3

