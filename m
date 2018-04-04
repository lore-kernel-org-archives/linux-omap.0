From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] ARM: omap1: osk: use device properties for at24 eeprom
Date: Wed,  4 Apr 2018 14:38:22 +0200
Message-ID: <20180404123822.5664-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-omap@vger.kernel.org

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/mach-omap1/board-osk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index c66372ed29e2..9ffa8d755a59 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -303,22 +303,22 @@ static const struct omap_lcd_config osk_lcd_config __initconst = {
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 
 #include <linux/input.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
 #include <linux/platform_data/keypad-omap.h>
 
-static struct at24_platform_data at24c04 = {
-	.byte_len	= SZ_4K / 8,
-	.page_size	= 16,
+static const struct property_entry mistral_at24_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 16),
+	{ }
 };
 
 static struct i2c_board_info __initdata mistral_i2c_board_info[] = {
 	{
 		/* NOTE:  powered from LCD supply */
 		I2C_BOARD_INFO("24c04", 0x50),
-		.platform_data	= &at24c04,
+		.properties = mistral_at24_properties,
 	},
 	/* TODO when driver support is ready:
 	 *  - optionally ov9640 camera sensor at 0x30
-- 
2.16.3
