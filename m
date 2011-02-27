From: Eyal Reizer <eyalreizer@googlemail.com>
Subject: Re: Re: Ping-> Subject:    [PATCH] omap: omap3evm: add support for the WL12xx WLAN module to the omap3evm
Date: Sun, 27 Feb 2011 12:45:18 +0200
Message-ID: <1298803518-12095-1-git-send-email-eyalr@ti.com>
References: <y>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60418 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab1B0Kpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Feb 2011 05:45:33 -0500
Received: by gyh20 with SMTP id 20so1207430gyh.19
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 02:45:32 -0800 (PST)
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: Eyal Reizer <eyalr@ti.com>

This patch is again current omap-for-linus branch

Adds platform initialization for working with the WLAN module
attached to the omap3evm.
The patch includes MMC2 initialization, SDIO and control pins
muxing and platform device registration.

Signed-off-by: Eyal Reizer <eyalr@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5364147..7341f96 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -411,7 +411,7 @@ static struct omap2_hsmmc_info mmc[] = {
 #ifdef CONFIG_WL12XX_PLATFORM_DATA
 	{
 		.name		= "wl1271",
-		.mmc            = 2,
+		.mmc		= 2,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
 		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
@@ -603,10 +603,8 @@ static struct regulator_init_data omap3evm_vio = {
 #define OMAP3EVM_WLAN_PMENA_GPIO	(150)
 #define OMAP3EVM_WLAN_IRQ_GPIO		(149)
 
-static struct regulator_consumer_supply omap3evm_vmmc2_supply = {
-	.supply			= "vmmc",
-	.dev_name		= "mmci-omap-hs.1",
-};
+static struct regulator_consumer_supply omap3evm_vmmc2_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
 
 /* VMMC2 for driving the WL12xx module */
 static struct regulator_init_data omap3evm_vmmc2 = {
@@ -627,7 +625,7 @@ static struct fixed_voltage_config omap3evm_vwlan = {
 	.init_data		= &omap3evm_vmmc2,
 };
 
-static struct platform_device omap3evm_vwlan_device = {
+static struct platform_device omap3evm_wlan_regulator = {
 	.name		= "reg-fixed-voltage",
 	.id		= 1,
 	.dev = {
@@ -637,8 +635,7 @@ static struct platform_device omap3evm_vwlan_device = {
 
 struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
 	.irq = OMAP_GPIO_IRQ(OMAP3EVM_WLAN_IRQ_GPIO),
-	/* ref clock is 38.4 MHz */
-	.board_ref_clock = 2,
+	.board_ref_clock = WL12XX_REFCLOCK_38, /* 38.4 MHz */
 };
 #endif
 
@@ -765,7 +762,7 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
 				OMAP_PIN_OFF_NONE),
 #ifdef CONFIG_WL12XX_PLATFORM_DATA
 	/* WLAN IRQ - GPIO 149 */
-	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 
 	/* WLAN POWER ENABLE - GPIO 150 */
 	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
@@ -801,6 +798,21 @@ static struct omap_board_mux omap36x_board_mux[] __initdata = {
 	OMAP3_MUX(SYS_BOOT4, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(SYS_BOOT6, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
+#ifdef CONFIG_WL12XX_PLATFORM_DATA
+	/* WLAN IRQ - GPIO 149 */
+	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+
+	/* WLAN POWER ENABLE - GPIO 150 */
+	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+
+	/* MMC2 SDIO pin muxes for WL12xx */
+	OMAP3_MUX(SDMMC2_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(SDMMC2_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+#endif
 
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
@@ -871,7 +883,7 @@ static void __init omap3_evm_init(void)
 	/* WL12xx WLAN Init */
 	if (wl12xx_set_platform_data(&omap3evm_wlan_data))
 		pr_err("error setting wl12xx data\n");
-	platform_device_register(&omap3evm_vwlan_device);
+	platform_device_register(&omap3evm_wlan_regulator);
 #endif
 }
 
-- 
1.7.0.4

