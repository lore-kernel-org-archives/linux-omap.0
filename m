From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH V2 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Wed, 13 Jun 2012 09:44:08 +0800
Message-ID: <1339551850-20827-4-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: tony@atomide.com, jon-hunter@ti.com, grinberg@compulab.co.il, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Zumeng Chen <zumeng.chen@windriver.com>

This was chosen by following the trace on the schematic from component U131
and U134 to the CPEN pin on the USB3320 device.

TWL4030.GPIO2-...->(T2_GPIO2_3V3)U131-..>nUSB2_EN-..>U134-..>EXP_nUSB2_1V8
which starts EHCI tranceiver USB3320.

This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3c91534..63bb865 100644
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

