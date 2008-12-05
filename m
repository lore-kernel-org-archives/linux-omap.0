From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: OMAP2: bard-h4: list those eeproms
Date: Thu, 04 Dec 2008 18:40:49 -0800
Message-ID: <20081205024049.3868.8046.stgit@localhost>
References: <20081205023737.3868.78857.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51343 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247AbYLECkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 21:40:51 -0500
In-Reply-To: <20081205023737.3868.78857.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Declare the two 1Kbit EEPROMs included in the H4 board stack.
One is on the CPU card; the other is on the mainboard.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 2fef2c8..7de0506 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/i2c.h>
+#include <linux/i2c/at24.h>
 #include <linux/input.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -392,11 +393,24 @@ static struct omap_board_config_kernel h4_config[] = {
 	{ OMAP_TAG_LCD,		&h4_lcd_config },
 };
 
+static struct at24_platform_data m24c01 = {
+	.byte_len	= SZ_1K / 8,
+	.page_size	= 16,
+};
+
 static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("isp1301_omap", 0x2d),
 		.irq		= OMAP_GPIO_IRQ(125),
 	},
+	{	/* EEPROM on mainboard */
+		I2C_BOARD_INFO("24c01", 0x52),
+		.platform_data	= &m24c01,
+	},
+	{	/* EEPROM on cpu card */
+		I2C_BOARD_INFO("24c01", 0x57),
+		.platform_data	= &m24c01,
+	},
 };
 
 static void __init omap_h4_init(void)

