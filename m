From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH] audio : AM3517 : Adding i2c info for AIC23 codec
Date: Tue,  8 Mar 2011 20:43:24 +0530
Message-ID: <1299597204-25160-1-git-send-email-abhilash.kv@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48023 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332Ab1CHPNk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 10:13:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, Abhilash Vadakkepat Koyamangalath <x0151633@psplinux051.india.ti.com>, Abhilash K V <abhilash.kv@ti.com>

From: Abhilash Vadakkepat Koyamangalath <x0151633@psplinux051.india.ti.com>

The i2c_board_info entry supporting AIC23 codec was added into
the i2c2 bus.

Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index ad71cbf..8da8d20 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -358,6 +358,9 @@ static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
 };
 static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
 	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1A),
+	},
+	{
 		I2C_BOARD_INFO("tca6416", 0x21),
 		.platform_data = &am3517evm_gpio_expander_info_0,
 	},
-- 
1.6.2.4

