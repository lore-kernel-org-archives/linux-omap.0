From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 1/4] omap3: GPIO's for W-LAN + Bluetooth combo depends on IGEP v2 hardware revision.
Date: Tue,  3 Aug 2010 13:56:11 +0200
Message-ID: <1280836574-32467-2-git-send-email-eballetbo@gmail.com>
References: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45985 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab0HCL4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 07:56:23 -0400
Received: by wwj40 with SMTP id 40so5028712wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Aug 2010 04:56:22 -0700 (PDT)
In-Reply-To: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Enric Balletbo i Serra <eballetbo@gmail.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

This patch adds support to detect IGEP v2 hardware revision and configure
GPIO's for W-LAN + Bluetooth combo which depends on hardware revision.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   99 +++++++++++++++++++++++++++-------
 1 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d55c57b..6b5f9c8 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -42,8 +42,19 @@
 #define IGEP2_GPIO_LED0_RED 	27
 #define IGEP2_GPIO_LED1_RED   	28
 #define IGEP2_GPIO_DVI_PUP	170
-#define IGEP2_GPIO_WIFI_NPD 	94
-#define IGEP2_GPIO_WIFI_NRESET 	95
+
+/*  HIGH : It is a rev. B or C (B-compatible) board
+    LOW  : It is a rev. C (B-NON compatible) board */
+#define IGEP2_GPIO_HW_REV		28
+
+/* Platform: IGEP v2 Hw Rev. B / C (B-compatible) */
+#define IGEP2_RB_GPIO_WIFI_NPD		94
+#define IGEP2_RB_GPIO_WIFI_NRESET	95
+#define IGEP2_RB_GPIO_BT_NRESET		137
+/* Platform: IGEP v2 Hw Rev. C (B-non compatible) */
+#define IGEP2_RC_GPIO_WIFI_NPD		138
+#define IGEP2_RC_GPIO_WIFI_NRESET	139
+#define IGEP2_RC_GPIO_BT_NRESET		137
 
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
@@ -476,8 +487,66 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+static int igep2_get_hw_rev(void)
+{
+	int ret = -1;
+
+	if ((gpio_request(IGEP2_GPIO_HW_REV, "GPIO_HW_REV") == 0) &&
+	    (gpio_direction_input(IGEP2_GPIO_HW_REV) == 0))
+		ret = gpio_get_value(IGEP2_GPIO_HW_REV);
+	else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_HW_REV\n");
+
+	gpio_free(IGEP2_GPIO_HW_REV);
+
+	return ret;
+}
+
+static void __init igep2_init_wifi_bt(void)
+{
+	int hwrev;
+	unsigned npd, wreset, btreset;
+
+	hwrev = igep2_get_hw_rev();
+
+	/* GPIO's for W-LAN + Bluetooth combo depends on hardware revision */
+	if (hwrev) {
+		npd = IGEP2_RB_GPIO_WIFI_NPD;
+		wreset = IGEP2_RB_GPIO_WIFI_NRESET;
+		btreset = IGEP2_RB_GPIO_BT_NRESET;
+	} else {
+		npd = IGEP2_RC_GPIO_WIFI_NPD;
+		wreset = IGEP2_RC_GPIO_WIFI_NRESET;
+		btreset = IGEP2_RC_GPIO_BT_NRESET;
+	}
+
+	/* Set GPIO's for  W-LAN + Bluetooth combo module */
+	if ((gpio_request(npd, "GPIO_WIFI_NPD") == 0) &&
+	    (gpio_direction_output(npd, 1) == 0)) {
+		gpio_export(npd, 0);
+	} else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NPD\n");
+
+	if ((gpio_request(wreset, "GPIO_WIFI_NRESET") == 0) &&
+	    (gpio_direction_output(wreset, 1) == 0)) {
+		gpio_export(wreset, 0);
+		gpio_set_value(wreset, 0);
+		udelay(10);
+		gpio_set_value(wreset, 1);
+	} else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NRESET\n");
+
+	if ((gpio_request(btreset, "GPIO_BT_NRESET") == 0) &&
+	    (gpio_direction_output(btreset, 1) == 0)) {
+		gpio_export(btreset, 0);
+	} else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_BT_NRESET\n");
+}
+
 static void __init igep2_init(void)
 {
+	int hwrev;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
@@ -485,10 +554,19 @@ static void __init igep2_init(void)
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 
+	hwrev = igep2_get_hw_rev();
+	if (hwrev == 0)
+		pr_info("IGEP platform: IGEP v2 Hw Rev. C (B-NON compatible)\n");
+	else if (hwrev ==  1)
+		pr_info("IGEP platform: IGEP v2 Hw Rev. B/C (B compatible)\n");
+	else
+		pr_err("IGEP platform: Unknow\n");
+
 	igep2_flash_init();
 	igep2_init_led();
 	igep2_display_init();
 	igep2_init_smsc911x();
+	igep2_init_wifi_bt();
 
 	/* GPIO userspace leds */
 #if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
@@ -513,23 +591,6 @@ static void __init igep2_init(void)
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_RED\n");
 #endif
-
-	/* GPIO W-LAN + Bluetooth combo module */
-	if ((gpio_request(IGEP2_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_WIFI_NPD, 1) == 0)) {
-		gpio_export(IGEP2_GPIO_WIFI_NPD, 0);
-/* 		gpio_set_value(IGEP2_GPIO_WIFI_NPD, 0); */
-	} else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NPD\n");
-
-	if ((gpio_request(IGEP2_GPIO_WIFI_NRESET, "GPIO_WIFI_NRESET") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_WIFI_NRESET, 1) == 0)) {
-		gpio_export(IGEP2_GPIO_WIFI_NRESET, 0);
-		gpio_set_value(IGEP2_GPIO_WIFI_NRESET, 0);
-		udelay(10);
-		gpio_set_value(IGEP2_GPIO_WIFI_NRESET, 1);
-	} else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NRESET\n");
 }
 
 static void __init igep2_map_io(void)
-- 
1.7.0.4

