From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 2/5] ARM: OMAP3EVM: Adding USB internal LDOs board file
Date: Mon, 11 Jun 2012 22:00:13 +0800
Message-ID: <1339423216-1323-3-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:44335 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab2FKOAm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:00:42 -0400
In-Reply-To: <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, zumeng.chen@gmail.com

EHCI PHY requires these regulators:
        EVM Rev >=E  --> VAUX2
        EVM Rev < E  --> VUSB1V5, VUSB1V8

Adding USB internal LDOs (vusb1v5 & vusb1v8) and VAUX2 to omap3evm
board file. Also removing vaux2_{1/2/3} supplies as they are not
used on omap3 evm.

But we need not to add vaux2 in twl4030_platform_data since it will
be added conditionally.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index fef911d..7e5e18f 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -466,6 +466,30 @@ struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
 };
 #endif
 
+/* VAUX2 for USB */
+static struct regulator_consumer_supply omap3evm_vaux2_supplies[] = {
+	REGULATOR_SUPPLY("VDD_CSIPHY1", "omap3isp"),	/* OMAP ISP */
+	REGULATOR_SUPPLY("VDD_CSIPHY2", "omap3isp"),	/* OMAP ISP */
+	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
+	{
+		.supply		= "vaux2",
+	}
+};
+
+static struct regulator_init_data omap3evm_vaux2 = {
+	.constraints = {
+		.min_uV		= 2800000,
+		.max_uV		= 2800000,
+		.apply_uV	= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(omap3evm_vaux2_supplies),
+	.consumer_supplies		= omap3evm_vaux2_supplies,
+};
+
 static struct twl4030_platform_data omap3evm_twldata = {
 	/* platform_data for children goes here */
 	.keypad		= &omap3evm_kp_data,
@@ -659,6 +683,9 @@ static void __init omap3_evm_init(void)
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	omap_hsmmc_init(mmc);
 
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
+		omap3evm_twldata.vaux2 = &omap3evm_vaux2;
+
 	omap3_evm_i2c_init();
 
 	omap_display_init(&omap3_evm_dss_data);
-- 
1.7.5.4

