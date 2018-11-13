From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 06/25] ARM: davinci: da830-evm: use cell nvmem lookup for mac address
Date: Tue, 13 Nov 2018 15:01:14 +0100
Message-ID: <20181113140133.17385-7-brgl@bgdev.pl>
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

We now support nvmem lookups and cell definitions for machine code.
Add relevant data structures for the mac-address stored in at24 EEPROM.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 7d8ab36ff83d..e52ec1619b70 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -30,6 +30,7 @@
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_data/ti-aemif.h>
 #include <linux/regulator/machine.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -435,6 +436,27 @@ static inline void da830_evm_init_lcdc(int mux_mode)
 static inline void da830_evm_init_lcdc(int mux_mode) { }
 #endif
 
+static struct nvmem_cell_info da830_evm_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table da830_evm_nvmem_cell_table = {
+	.nvmem_name	= "1-00500",
+	.cells		= da830_evm_nvmem_cells,
+	.ncells		= ARRAY_SIZE(da830_evm_nvmem_cells),
+};
+
+static struct nvmem_cell_lookup da830_evm_nvmem_cell_lookup = {
+	.nvmem_name	= "1-00500",
+	.cell_name	= "macaddr",
+	.dev_id		= "davinci_emac.1",
+	.con_id		= "mac-address",
+};
+
 static struct at24_platform_data da830_evm_i2c_eeprom_info = {
 	.byte_len	= SZ_256K / 8,
 	.page_size	= 64,
@@ -620,6 +642,10 @@ static __init void da830_evm_init(void)
 			__func__, ret);
 
 	davinci_serial_init(da8xx_serial_device);
+
+	nvmem_add_cell_table(&da830_evm_nvmem_cell_table);
+	nvmem_add_cell_lookups(&da830_evm_nvmem_cell_lookup, 1);
+
 	i2c_register_board_info(1, da830_evm_i2c_devices,
 			ARRAY_SIZE(da830_evm_i2c_devices));
 
-- 
2.19.1
