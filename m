From: Shahar Lev <shahar@wizery.com>
Subject: [PATCH] omap3evm: Add Mistral WL12XX config support
Date: Tue, 14 Jun 2011 15:16:28 +0300
Message-ID: <1308053788-25937-1-git-send-email-shahar@wizery.com>
References: <y>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46255 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab1FNMQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 08:16:40 -0400
Received: by wwa36 with SMTP id 36so5813396wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Jun 2011 05:16:39 -0700 (PDT)
In-Reply-To: <y>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Shahar Lev <shahar@wizery.com>

Add Kconfig entries indicating the existence of omap3evm's
wlan/bt wl12xx daughter card (see
http://mistralsolutions.com/component/jumi/Download_Common_Code.html?docid=298),
and the exact reference clock type that the wl12xx device is hardwired
to (the wl12xx driver must know this).

In addition, start using CONFIG_OMAP3EVM_MISTRAL_WL12XX in
the omap3evm's board file instead of CONFIG_WL12XX_PLATFORM_DATA,
because the latter only indicates that the driver is being built, and
shouldn't be used to assume the existence of extension cards.

Signed-off-by: Shahar Lev <shahar@wizery.com>
---
 arch/arm/mach-omap2/Kconfig          |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c |   12 ++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 19d5891..8ef012d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -342,6 +342,29 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+config OMAP3EVM_MISTRAL_WL12XX
+	bool "Enable Mistral WL12XX daughter board support"
+	depends on MACH_OMAP3EVM
+	help
+	  Support for the Mistral WL12XX daughter board.
+	  This extension board which supports both WLAN and Bluetooth.
+	  Specifically, for WL1271, more info can be found at
+	  http://mistralsolutions.com/component/jumi/Download_Common_Code.html?docid=298
+
+config OMAP3EVM_MISTRAL_WL12XX_REFCLOCK
+	int "Ref clock value"
+	range 0 5
+	depends on OMAP3EVM_MISTRAL_WL12XX
+	default 2
+	help
+	  Set ref clock value for the Mistral WL12XX daughter board.
+	  Select 0 for 19.2 MHz.
+	  Select 1 for 26 MHz.
+	  Select 2 for 38.4 MHz.
+	  Select 3 for 52 MHz.
+	  Select 4 for 38.4 MHz, XTAL.
+	  Select 5 for 26 MHz, XTAL.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b4d4346..23f12ff 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -318,7 +318,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= 63,
 	},
-#ifdef CONFIG_WL12XX_PLATFORM_DATA
+#ifdef CONFIG_OMAP3EVM_MISTRAL_WL12XX
 	{
 		.name		= "wl1271",
 		.mmc		= 2,
@@ -506,7 +506,7 @@ static struct regulator_init_data omap3evm_vio = {
 	.consumer_supplies	= &omap3evm_vio_supply,
 };
 
-#ifdef CONFIG_WL12XX_PLATFORM_DATA
+#ifdef CONFIG_OMAP3EVM_MISTRAL_WL12XX
 
 #define OMAP3EVM_WLAN_PMENA_GPIO	(150)
 #define OMAP3EVM_WLAN_IRQ_GPIO		(149)
@@ -543,7 +543,7 @@ static struct platform_device omap3evm_wlan_regulator = {
 
 struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
 	.irq = OMAP_GPIO_IRQ(OMAP3EVM_WLAN_IRQ_GPIO),
-	.board_ref_clock = WL12XX_REFCLOCK_38, /* 38.4 MHz */
+	.board_ref_clock = CONFIG_OMAP3EVM_MISTRAL_WL12XX_REFCLOCK,
 };
 #endif
 
@@ -606,7 +606,7 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
 				OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_NONE),
-#ifdef CONFIG_WL12XX_PLATFORM_DATA
+#ifdef CONFIG_OMAP3EVM_MISTRAL_WL12XX
 	/* WLAN IRQ - GPIO 149 */
 	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 
@@ -644,7 +644,7 @@ static struct omap_board_mux omap36x_board_mux[] __initdata = {
 	OMAP3_MUX(SYS_BOOT4, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(SYS_BOOT6, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
-#ifdef CONFIG_WL12XX_PLATFORM_DATA
+#ifdef CONFIG_OMAP3EVM_MISTRAL_WL12XX
 	/* WLAN IRQ - GPIO 149 */
 	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 
@@ -726,7 +726,7 @@ static void __init omap3_evm_init(void)
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 
-#ifdef CONFIG_WL12XX_PLATFORM_DATA
+#ifdef CONFIG_OMAP3EVM_MISTRAL_WL12XX
 	/* WL12xx WLAN Init */
 	if (wl12xx_set_platform_data(&omap3evm_wlan_data))
 		pr_err("error setting wl12xx data\n");
-- 
1.7.4.1

