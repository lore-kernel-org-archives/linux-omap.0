From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv3 3/6] omap3: Introduce function to detect the IGEP v2 hardware revision.
Date: Fri,  1 Oct 2010 23:09:06 +0200
Message-ID: <1285967349-32767-4-git-send-email-eballetbo@gmail.com>
References: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59129 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0JAVJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:09:22 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so3369724wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:09:21 -0700 (PDT)
In-Reply-To: <1285967349-32767-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

There are currently two versions of IGEP v2 board, this patch introduces a
function to detect the hardware revision of IGEP board.

  --------------------------
 | Id. | Hw Rev. | GPIO 28  |
  --------------------------
 |  0  |   B/C   |   high   |
 |  1  |   C     |   low    |
  --------------------------

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   47 ++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 83a30ce..ddb46a3 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -45,6 +45,49 @@
 #define IGEP2_GPIO_WIFI_NPD 	94
 #define IGEP2_GPIO_WIFI_NRESET 	95
 
+/*
+ * IGEP2 Hardware Revision Table
+ *
+ *  --------------------------
+ * | Id. | Hw Rev. | HW0 (28) |
+ *  --------------------------
+ * |  0  |   B/C   |   high   |
+ * |  1  |   C     |   low    |
+ *  --------------------------
+ */
+
+#define IGEP2_BOARD_HWREV_B	0
+#define IGEP2_BOARD_HWREV_C	1
+
+static u8 hwrev;
+
+static void __init igep2_get_revision(void)
+{
+	u8 ret;
+
+	omap_mux_init_gpio(IGEP2_GPIO_LED1_RED, OMAP_PIN_INPUT);
+
+	if ((gpio_request(IGEP2_GPIO_LED1_RED, "GPIO_HW0_REV") == 0) &&
+	    (gpio_direction_input(IGEP2_GPIO_LED1_RED) == 0)) {
+		ret = gpio_get_value(IGEP2_GPIO_LED1_RED);
+		if (hwrev == 0) {
+			pr_info("IGEP2: Hardware Revision C (B-NON compatible)\n");
+			hwrev = IGEP2_BOARD_HWREV_C;
+		} else if (hwrev ==  1) {
+			pr_info("IGEP2: Hardware Revision B/C (B compatible)\n");
+			hwrev = IGEP2_BOARD_HWREV_B;
+		} else {
+			pr_err("IGEP2: Unknow Hardware Revision\n");
+			hwrev = -1;
+		}
+	} else {
+		pr_warning("IGEP2: Could not obtain gpio GPIO_HW0_REV\n");
+		pr_err("IGEP2: Unknow Hardware Revision\n");
+	}
+
+	gpio_free(IGEP2_GPIO_LED1_RED);
+}
+
 #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
 	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
 
@@ -537,6 +580,10 @@ static struct omap_board_mux board_mux[] __initdata = {
 static void __init igep2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+
+	/* Get IGEP2 hardware revision */
+	igep2_get_revision();
+
 	igep2_i2c_init();
 	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
-- 
1.7.0.4

