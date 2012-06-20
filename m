From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Wed, 20 Jun 2012 17:14:51 +0800
Message-ID: <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60465 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab2FTJP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 05:15:28 -0400
In-Reply-To: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com

This was chosen by following the trace on the schematic from component U131
and U134 to the CPEN pin on the USB3320 device.

TWL4030.GPIO2-...->(T2_GPIO2_3V3)U131-..>nUSB2_EN-..>U134-..>EXP_nUSB2_1V8
which starts EHCI tranceiver USB3320.

This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.

Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 1bfbe42..02d8047 100644
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

