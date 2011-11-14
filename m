From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 3/3] ARM: omap4: Add pinmux map in SDP and PANDA board files
Date: Mon, 14 Nov 2011 18:10:09 +0530
Message-ID: <1321274409-24643-4-git-send-email-rnayak@ti.com>
References: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab1KNMk0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Nov 2011 07:40:26 -0500
In-Reply-To: <1321274409-24643-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linus.walleij@stericsson.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Register pinmux mappings for SDP and PANDA from board files.
Retain the existing mux configurations as they do pull up/down
configuration as well which are not handled currently.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   10 ++++++++++
 arch/arm/mach-omap2/board-omap4panda.c |   11 +++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5156468..136597e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
+#include <linux/pinctrl/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -942,6 +943,12 @@ static void omap4_sdp4430_wifi_init(void)
 	platform_device_register(&omap_vwlan_device);
 }
 
+/* Pinmux settings */
+static struct pinmux_map omap_pinmux_map[] = {
+	PINMUX_MAP_PRIMARY_SYS_HOG("HDMI", "hdmi"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("SDMMC5", "sdmmc5"),
+};
+
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -950,6 +957,9 @@ static void __init omap_4430sdp_init(void)
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);
+	/* Initialize pinmuxing */
+	pinmux_register_mappings(omap_pinmux_map,
+				ARRAY_SIZE(omap_pinmux_map));
 
 	omap4_i2c_init();
 	omap_sfh7741prox_init();
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a8c2c42..05c7927 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/wl12xx.h>
+#include <linux/pinctrl/machine.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -548,6 +549,13 @@ void omap4_panda_display_init(void)
 	omap_display_init(&omap4_panda_dss_data);
 }
 
+/* Pinmux settings */
+static struct pinmux_map omap_pinmux_map[] = {
+	PINMUX_MAP_PRIMARY_SYS_HOG("HDMI", "hdmi"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("SDMMC5", "sdmmc5"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("DISPC2", "dispc2"),
+};
+
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
@@ -555,6 +563,9 @@ static void __init omap4_panda_init(void)
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		package = OMAP_PACKAGE_CBL;
 	omap4_mux_init(board_mux, NULL, package);
+	/* Initialize pinmuxing */
+	pinmux_register_mappings(omap_pinmux_map,
+				ARRAY_SIZE(omap_pinmux_map));
 
 	if (wl12xx_set_platform_data(&omap_panda_wlan_data))
 		pr_err("error setting wl12xx data\n");
-- 
1.7.1

