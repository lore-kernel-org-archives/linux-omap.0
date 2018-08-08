From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 12/28] ARM: davinci: da850-evm: use nvmem lookup for mac address
Date: Wed,  8 Aug 2018 17:31:34 +0200
Message-ID: <20180808153150.23444-13-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6d5beb11bd96..5a634a04ec69 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
@@ -99,6 +100,19 @@ static struct mtd_partition da850evm_spiflash_part[] = {
 	},
 };
 
+static struct nvmem_cell_lookup da850evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x0,
+		.bytes = ETH_ALEN,
+	},
+	/*
+	 * The nvmem name differs from the partition name because of the
+	 * internal works of the nvmem framework.
+	 */
+	.nvmem_name = "MAC-Address0",
+};
+
 static struct flash_platform_data da850evm_spiflash_data = {
 	.name		= "m25p80",
 	.parts		= da850evm_spiflash_part,
@@ -1447,6 +1461,8 @@ static __init void da850_evm_init(void)
 		pr_warn("%s: spi info registration failed: %d\n", __func__,
 			ret);
 
+	nvmem_add_lookup_table(&da850evm_mac_address_cell, 1);
+
 	ret = da8xx_register_spi_bus(1, ARRAY_SIZE(da850evm_spi_info));
 	if (ret)
 		pr_warn("%s: SPI 1 registration failed: %d\n", __func__, ret);
-- 
2.18.0
