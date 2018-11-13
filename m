From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 24/25] ARM: davinci: mityomapl138: use device properties for at24 eeprom
Date: Tue, 13 Nov 2018 15:01:32 +0100
Message-ID: <20181113140133.17385-25-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index ac1a1699d185..a381b26328d8 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -14,13 +14,13 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mtd/partitions.h>
 #include <linux/notifier.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -192,10 +192,10 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data mityomapl138_fd_chip = {
-	.byte_len	= 256,
-	.page_size	= 8,
-	.flags		= AT24_FLAG_READONLY | AT24_FLAG_IRUGO,
+static const struct property_entry mityomapl138_fd_chip_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 8),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	{ }
 };
 
 static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
@@ -324,7 +324,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
 	},
 	{
 		I2C_BOARD_INFO("24c02", 0x50),
-		.platform_data = &mityomapl138_fd_chip,
+		.properties = mityomapl138_fd_chip_properties,
 	},
 };
 
-- 
2.19.1
