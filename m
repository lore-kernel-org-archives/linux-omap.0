From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 07/25] ARM: davinci: mityomapl138: use cell nvmem lookup for mac address
Date: Tue, 13 Nov 2018 15:01:15 +0100
Message-ID: <20181113140133.17385-8-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Nicolas Ferre <nicolas.ferre@microchip.com>, "David S . Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups and cell definitions for machine code.
Add relevant data structures for the mac-address stored in at24 EEPROM.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2933e0c87cfa..8df16e81b69e 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -15,6 +15,7 @@
 #include <linux/console.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
+#include <linux/nvmem-provider.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/at24.h>
@@ -161,6 +162,31 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+/*
+ * We don't define a cell for factory config as it will be accessed from the
+ * board file using the nvmem notifier chain.
+ */
+static struct nvmem_cell_info mityomapl138_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x64,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table mityomapl138_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= mityomapl138_nvmem_cells,
+	.ncells		= ARRAY_SIZE(mityomapl138_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup mityomapl138_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -543,6 +569,9 @@ static void __init mityomapl138_init(void)
 
 	davinci_serial_init(da8xx_serial_device);
 
+	nvmem_add_cell_table(&mityomapl138_nvmem_cell_table);
+	nvmem_add_cell_lookups(&mityomapl138_nvmem_cell_lookup, 1);
+
 	ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
 	if (ret)
 		pr_warn("i2c0 registration failed: %d\n", ret);
-- 
2.19.1
