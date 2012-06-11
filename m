From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Mon, 11 Jun 2012 22:00:14 +0800
Message-ID: <1339423216-1323-4-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37096 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab2FKOAo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:00:44 -0400
In-Reply-To: <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, zumeng.chen@gmail.com

TWL4030.GPIO2-...->(T2_GPIO2_3V3)U131-..>nUSB2_EN-..>U134-..>EXP_nUSB2_1V8
which starts EHCI tranceiver USB3320.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 7e5e18f..3806f0e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -360,6 +360,15 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 
 	platform_device_register(&leds_gpio);
 
+	/* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
+	 * for starting USB tranceiver
+	 */
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
+		u8 val;
+		twl_i2c_read_u8(TWL4030_MODULE_GPIO, &val, REG_GPIODATADIR1);
+		val |= 0x04; /* TWL4030.GPIO2DIR BIT at GPIODATADIR1(0x9B) */
+		twl_i2c_write_u8(TWL4030_MODULE_GPIO, val, REG_GPIODATADIR1);
+	}
 	return 0;
 }
 
-- 
1.7.5.4

