From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/11] omap: n8x0: Register i2c2 and add board info with
	tlv320aic3xfor N810
Date: Thu, 23 Sep 2010 18:50:51 -0700
Message-ID: <20100924015051.10325.55550.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57606 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab0IXBuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:50:51 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

From: Jarkko Nikula <jhnikula@gmail.com>

Second i2c bus on Nokia N800 and N810 shares both common and hw specific
peripherals. Register now this bus and add board info with tlv320aic3x for
N810. Common peripherals may be added as an additional board info to
omap_register_i2c_bus(2, ...);

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 313ce5e..7863633 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
+#include <sound/tlv320aic3x.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -633,6 +634,17 @@ static struct i2c_board_info __initdata n8x0_i2c_board_info_1[] __initdata = {
 	},
 };
 
+static struct aic3x_pdata n810_aic33_data __initdata = {
+	.gpio_reset = 118,
+};
+
+static struct i2c_board_info n810_i2c_board_info_2[] __initdata = {
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+		.platform_data = &n810_aic33_data,
+	},
+};
+
 static void __init n8x0_map_io(void)
 {
 	omap2_set_globals_242x();
@@ -662,6 +674,10 @@ static void __init n8x0_init_machine(void)
 				ARRAY_SIZE(n800_spi_board_info));
 	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_1,
 			      ARRAY_SIZE(n8x0_i2c_board_info_1));
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	if (machine_is_nokia_n810())
+		i2c_register_board_info(2, n810_i2c_board_info_2,
+					ARRAY_SIZE(n810_i2c_board_info_2));
 
 	omap_serial_init();
 	n8x0_onenand_init();

