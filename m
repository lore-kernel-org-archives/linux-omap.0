From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 28/29] ARM: davinci: mityomapl138: use device properties for at24 eeprom
Date: Fri, 10 Aug 2018 10:05:25 +0200
Message-ID: <20180810080526.27207-29-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index dacc5292f9bd..db50fcce5976 100644
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
@@ -185,10 +185,10 @@ static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
 	}
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
@@ -317,7 +317,7 @@ static struct i2c_board_info __initdata mityomap_tps65023_info[] = {
 	},
 	{
 		I2C_BOARD_INFO("24c02", 0x50),
-		.platform_data = &mityomapl138_fd_chip,
+		.properties = mityomapl138_fd_chip_properties,
 	},
 };
 
-- 
2.18.0
