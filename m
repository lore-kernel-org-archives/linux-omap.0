From: David Brownell <david-b@pacbell.net>
Subject: [2.6.28-rc2-omap] board-h4: list those eeproms
Date: Wed, 29 Oct 2008 00:11:22 -0700
Message-ID: <200810290011.22441.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:38700 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752073AbYJ2HLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 03:11:24 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Declare the two 1Kbit EEPROMs included in the H4 board stack.
One is on the CPU card; the other is on the mainboard.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-h4.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -22,6 +22,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
+#include <linux/i2c/at24.h>
 #include <linux/i2c/menelaus.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc210x.h>
@@ -627,6 +628,11 @@ static struct ov9640_platform_data h4_ov
 };
 #endif
 
+static struct at24_platform_data m24c01 = {
+	.byte_len	= SZ_1K / 8,
+	.page_size	= 16,
+};
+
 static struct i2c_board_info __initdata h4_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("rv5c387a", 0x32),
@@ -646,6 +652,14 @@ static struct i2c_board_info __initdata 
 		.platform_data = &h4_ov9640_platform_data,
 	},
 #endif
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
