From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 3/4] Audio: Modifying board-evm file for audio codec
Date: Fri, 30 Oct 2009 00:22:51 +0530
Message-ID: <1256842371-30447-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36049 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805AbZJ2Swz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 14:52:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

Adding I2C bus registration code in board-evm file for OMAP3517 /
AM3517 EVM for AIC23 audio codec.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 23cf949..5f5f3ee 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -30,6 +30,25 @@
 #include <plat/common.h>
 
 /*
+ * I2C
+ */
+static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
+	{
+	I2C_BOARD_INFO("tlv320aic23", 0x1A),
+	},
+};
+
+static int __init am3517_evm_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, am3517evm_i2c_boardinfo,
+			ARRAY_SIZE(am3517evm_i2c_boardinfo));
+	omap_register_i2c_bus(3, 400, NULL, 0);
+
+	return 0;
+}
+
+/*
  * Board initialization
  */
 static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
@@ -50,6 +69,8 @@ static void __init am3517_evm_init_irq(void)
 
 static void __init am3517_evm_init(void)
 {
+	am3517_evm_i2c_init();
+
 	platform_add_devices(am3517_evm_devices,
 				ARRAY_SIZE(am3517_evm_devices));
 
-- 
1.6.2.4

