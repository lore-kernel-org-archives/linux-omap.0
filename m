From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/11] ARM: OMAP2+: Add device tree compatible revision checks for n8x0
Date: Thu, 14 Nov 2013 16:09:51 -0800
Message-ID: <1384474198-20756-5-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42206 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab3KOAKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:05 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

This allows us to initialize the legacy devices when booted
with device tree.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c | 51 +++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 827d1500..d61a00d 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -42,6 +42,38 @@
 #define TUSB6010_GPIO_ENABLE	0
 #define TUSB6010_DMACHAN	0x3f
 
+#define NOKIA_N810_WIMAX	(1 << 2)
+#define NOKIA_N810		(1 << 1)
+#define NOKIA_N800		(1 << 0)
+
+static u32 board_caps;
+
+#define board_is_n800()		(board_caps & NOKIA_N800)
+#define board_is_n810()		(board_caps & NOKIA_N810)
+#define board_is_n810_wimax()	(board_caps & NOKIA_N810_WIMAX)
+
+static void board_check_revision(void)
+{
+	if (of_have_populated_dt()) {
+		if (of_machine_is_compatible("nokia,n800"))
+			board_caps = NOKIA_N800;
+		else if (of_machine_is_compatible("nokia,n810"))
+			board_caps = NOKIA_N810;
+		else if (of_machine_is_compatible("nokia,n810-wimax"))
+			board_caps = NOKIA_N810_WIMAX;
+	} else {
+		if (machine_is_nokia_n800())
+			board_caps = NOKIA_N800;
+		else if (machine_is_nokia_n810())
+			board_caps = NOKIA_N810;
+		else if (machine_is_nokia_n810_wimax())
+			board_caps = NOKIA_N810_WIMAX;
+	}
+
+	if (!board_caps)
+		pr_err("Unknown board\n");
+}
+
 #if defined(CONFIG_I2C_CBUS_GPIO) || defined(CONFIG_I2C_CBUS_GPIO_MODULE)
 static struct i2c_cbus_platform_data n8x0_cbus_data = {
 	.clk_gpio = 66,
@@ -342,7 +374,7 @@ static void n810_set_power_emmc(struct device *dev,
 static int n8x0_mmc_set_power(struct device *dev, int slot, int power_on,
 			      int vdd)
 {
-	if (machine_is_nokia_n800() || slot == 0)
+	if (board_is_n800() || slot == 0)
 		return n8x0_mmc_set_power_menelaus(dev, slot, power_on, vdd);
 
 	n810_set_power_emmc(dev, power_on);
@@ -388,7 +420,7 @@ static void n8x0_mmc_callback(void *data, u8 card_mask)
 {
 	int bit, *openp, index;
 
-	if (machine_is_nokia_n800()) {
+	if (board_is_n800()) {
 		bit = 1 << 1;
 		openp = &slot2_cover_open;
 		index = 1;
@@ -421,7 +453,7 @@ static int n8x0_mmc_late_init(struct device *dev)
 	if (r < 0)
 		return r;
 
-	if (machine_is_nokia_n800())
+	if (board_is_n800())
 		vs2sel = 0;
 	else
 		vs2sel = 2;
@@ -444,7 +476,7 @@ static int n8x0_mmc_late_init(struct device *dev)
 	if (r < 0)
 		return r;
 
-	if (machine_is_nokia_n800()) {
+	if (board_is_n800()) {
 		bit = 1 << 1;
 		openp = &slot2_cover_open;
 	} else {
@@ -471,7 +503,7 @@ static void n8x0_mmc_shutdown(struct device *dev)
 {
 	int vs2sel;
 
-	if (machine_is_nokia_n800())
+	if (board_is_n800())
 		vs2sel = 0;
 	else
 		vs2sel = 2;
@@ -486,7 +518,7 @@ static void n8x0_mmc_cleanup(struct device *dev)
 
 	gpio_free(N8X0_SLOT_SWITCH_GPIO);
 
-	if (machine_is_nokia_n810()) {
+	if (board_is_n810()) {
 		gpio_free(N810_EMMC_VSD_GPIO);
 		gpio_free(N810_EMMC_VIO_GPIO);
 	}
@@ -537,7 +569,7 @@ static void __init n8x0_mmc_init(void)
 {
 	int err;
 
-	if (machine_is_nokia_n810()) {
+	if (board_is_n810()) {
 		mmc1_data.slots[0].name = "external";
 
 		/*
@@ -555,7 +587,7 @@ static void __init n8x0_mmc_init(void)
 	if (err)
 		return;
 
-	if (machine_is_nokia_n810()) {
+	if (board_is_n810()) {
 		err = gpio_request_array(n810_emmc_gpios,
 					 ARRAY_SIZE(n810_emmc_gpios));
 		if (err) {
@@ -700,6 +732,7 @@ static inline void board_serial_init(void)
 
 static void __init n8x0_init_machine(void)
 {
+	board_check_revision();
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
 	/* FIXME: add n810 spi devices */
 	spi_register_board_info(n800_spi_board_info,
@@ -707,7 +740,7 @@ static void __init n8x0_init_machine(void)
 	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_1,
 			      ARRAY_SIZE(n8x0_i2c_board_info_1));
 	omap_register_i2c_bus(2, 400, NULL, 0);
-	if (machine_is_nokia_n810())
+	if (board_is_n810())
 		i2c_register_board_info(2, n810_i2c_board_info_2,
 					ARRAY_SIZE(n810_i2c_board_info_2));
 	board_serial_init();
-- 
1.8.1.1

