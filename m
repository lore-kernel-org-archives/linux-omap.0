From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 4/6] omap3: Fix handling some GPIO's for WLAN-BT combo on IGEP v2.
Date: Fri,  1 Oct 2010 21:45:51 +0200
Message-ID: <1285962353-9586-5-git-send-email-eballetbo@gmail.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42595 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0JATqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 15:46:13 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1814916wwj.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 12:46:12 -0700 (PDT)
In-Reply-To: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Some GPIO's used by WLAN-BT combo on IGEP v2 depends on hardware
revision. This patch handles these GPIO's.

  ----------------------------------------------------------
 |       Hw Rev.       | WIFI_NPD | WIFI_NRESET | BT_NRESET |
  ----------------------------------------------------------
 |  B                  | gpio94  |   gpio95    |     -      |
 |  B/C (B-compatible) | gpio94  |   gpio95    |  gpio137   |
 |  C                  | gpio138 |   gpio139   |  gpio137   |
  ----------------------------------------------------------

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   94 ++++++++++++++++++++++++----------
 1 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index a386425..ec7da7f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -38,22 +38,28 @@
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
 #define IGEP2_GPIO_USBH_NRESET  24
-#define IGEP2_GPIO_LED0_GREEN 	26
-#define IGEP2_GPIO_LED0_RED 	27
-#define IGEP2_GPIO_LED1_RED   	28
-#define IGEP2_GPIO_DVI_PUP	170
-#define IGEP2_GPIO_WIFI_NPD 	94
-#define IGEP2_GPIO_WIFI_NRESET 	95
+#define IGEP2_GPIO_LED0_GREEN   26
+#define IGEP2_GPIO_LED0_RED     27
+#define IGEP2_GPIO_LED1_RED     28
+#define IGEP2_GPIO_DVI_PUP      170
+
+#define IGEP2_RB_GPIO_WIFI_NPD     94
+#define IGEP2_RB_GPIO_WIFI_NRESET  95
+#define IGEP2_RB_GPIO_BT_NRESET    137
+#define IGEP2_RC_GPIO_WIFI_NPD     138
+#define IGEP2_RC_GPIO_WIFI_NRESET  139
+#define IGEP2_RC_GPIO_BT_NRESET    137
 
 /*
  * IGEP2 Hardware Revision Table
  *
- *  --------------------------
- * | Id. | Hw Rev. | HW0 (28) |
- *  --------------------------
- * |  0  |   B/C   |   high   |
- * |  1  |   C     |   low    |
- *  --------------------------
+ *  --------------------------------------------------------------------------
+ * | Id. | Hw Rev.            | HW0 (28) | WIFI_NPD | WIFI_NRESET | BT_NRESET |
+ *  --------------------------------------------------------------------------
+ * |  0  | B                  |   high   |  gpio94  |   gpio95    |     -     |
+ * |  0  | B/C (B-compatible) |   high   |  gpio94  |   gpio95    |  gpio137  |
+ * |  1  | C                  |   low    |  gpio138 |   gpio139   |  gpio137  |
+ *  --------------------------------------------------------------------------
  */
 
 #define IGEP2_BOARD_HWREV_B	0
@@ -295,12 +301,14 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
+#if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
 	{
 		.mmc		= 2,
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
+#endif
 	{}      /* Terminator */
 };
 
@@ -575,6 +583,48 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+#if defined(CONFIG_LIBERTAS_SDIO) || defined(CONFIG_LIBERTAS_SDIO_MODULE)
+
+static void __init igep2_wlan_bt_init(void)
+{
+	unsigned npd, wreset, btreset;
+
+	/* GPIO's for WLAN-BT combo depends on hardware revision */
+	if (hwrev == IGEP2_BOARD_HWREV_B) {
+		npd = IGEP2_RB_GPIO_WIFI_NPD;
+		wreset = IGEP2_RB_GPIO_WIFI_NRESET;
+		btreset = IGEP2_RB_GPIO_BT_NRESET;
+	} else if (hwrev == IGEP2_BOARD_HWREV_B) {
+		npd = IGEP2_RC_GPIO_WIFI_NPD;
+		wreset = IGEP2_RC_GPIO_WIFI_NRESET;
+		btreset = IGEP2_RC_GPIO_BT_NRESET;
+	} else
+		return;
+
+	/* Set GPIO's for  WLAN-BT combo module */
+	if ((gpio_request(npd, "GPIO_WIFI_NPD") == 0) &&
+	    (gpio_direction_output(npd, 1) == 0)) {
+		gpio_export(npd, 0);
+	} else
+		pr_warning("IGEP2: Could not obtain gpio GPIO_WIFI_NPD\n");
+
+	if ((gpio_request(wreset, "GPIO_WIFI_NRESET") == 0) &&
+	    (gpio_direction_output(wreset, 1) == 0)) {
+		gpio_export(wreset, 0);
+		gpio_set_value(wreset, 0);
+		udelay(10);
+		gpio_set_value(wreset, 1);
+	} else
+		pr_warning("IGEP2: Could not obtain gpio GPIO_WIFI_NRESET\n");
+
+	if ((gpio_request(btreset, "GPIO_BT_NRESET") == 0) &&
+	    (gpio_direction_output(btreset, 1) == 0)) {
+		gpio_export(btreset, 0);
+	} else
+		pr_warning("IGEP2: Could not obtain gpio GPIO_BT_NRESET\n");
+}
+#endif
+
 static void __init igep2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -593,22 +643,12 @@ static void __init igep2_init(void)
 	igep2_display_init();
 	igep2_init_smsc911x();
 
-	/* GPIO W-LAN + Bluetooth combo module */
-	if ((gpio_request(IGEP2_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_WIFI_NPD, 1) == 0)) {
-		gpio_export(IGEP2_GPIO_WIFI_NPD, 0);
-/* 		gpio_set_value(IGEP2_GPIO_WIFI_NPD, 0); */
-	} else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NPD\n");
+	/*
+	 * WLAN-BT combo module from MuRata wich has a Marvell WLAN
+	 * (88W8686) + CSR Bluetooth chipset. Uses SDIO interface.
+	 */
+	igep2_wlan_bt_init();
 
-	if ((gpio_request(IGEP2_GPIO_WIFI_NRESET, "GPIO_WIFI_NRESET") == 0) &&
-	    (gpio_direction_output(IGEP2_GPIO_WIFI_NRESET, 1) == 0)) {
-		gpio_export(IGEP2_GPIO_WIFI_NRESET, 0);
-		gpio_set_value(IGEP2_GPIO_WIFI_NRESET, 0);
-		udelay(10);
-		gpio_set_value(IGEP2_GPIO_WIFI_NRESET, 1);
-	} else
-		pr_warning("IGEP v2: Could not obtain gpio GPIO_WIFI_NRESET\n");
 }
 
 MACHINE_START(IGEP0020, "IGEP v2 board")
-- 
1.7.0.4

