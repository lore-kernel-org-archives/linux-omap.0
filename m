From: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Subject: [PATCH] OMAP3EVM: ehci: Fix EHCI support
Date: Tue, 23 Aug 2011 17:16:35 +0200
Message-ID: <1314112595-14849-1-git-send-email-bdefaria@adeneo-embedded.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41285 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab1HWPRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 11:17:08 -0400
Received: by fxh19 with SMTP id 19so310170fxh.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 08:17:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Bryan DE FARIA <bdefaria@adeneo-embedded.com>, linux-omap@vger.kernel.org

Set the VAUX2 regulator supply to 1.8V for the HSUSB host interface.
Gpio 2 of the TPS65950 has to be set to zero in order to enable the HSUBS2 clock.

Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c452b3f..ce09e9e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	if (r)
 		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
 
+	/* gpio + 2 == HSUSB2 Clock Enable */
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW, "EN_HSUSB2_CLK");
+
 	/* gpio + 7 == DVI Enable */
 	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
 
@@ -450,6 +454,25 @@ static struct regulator_init_data omap3evm_vio = {
 	.consumer_supplies	= omap3evm_vio_supply,
 };
 
+/* VAUX2 for EHCI */
+static struct regulator_consumer_supply omap3evm_vaux2_supplies[] = {
+	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
+};
+
+static struct regulator_init_data omap3evm_vaux2 = {
+	.constraints = {
+		.min_uV      		= 1800000,
+		.max_uV      		= 1800000,
+		.apply_uV    		= true,
+		.valid_modes_mask  	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask  	= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(omap3evm_vaux2_supplies),
+	.consumer_supplies   	= omap3evm_vaux2_supplies,
+};
+
 #ifdef CONFIG_WL12XX_PLATFORM_DATA
 
 #define OMAP3EVM_WLAN_PMENA_GPIO	(150)
@@ -645,6 +668,7 @@ static void __init omap3_evm_init(void)
 	usb_nop_xceiv_register();
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
+		omap3evm_twldata.vaux2 = &omap3evm_vaux2;
 		/* enable EHCI VBUS using GPIO22 */
 		omap_mux_init_gpio(OMAP3_EVM_EHCI_VBUS, OMAP_PIN_INPUT_PULLUP);
 		/* Select EHCI port on main board */
-- 
1.7.4.1

