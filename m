From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 04/15] ARM: davinci: dm646x-evm: use nvmem lookup for mac address
Date: Tue, 26 Jun 2018 12:22:34 +0200
Message-ID: <20180626102245.30711-5-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 584064fdabf5..4c82d38033b6 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -37,6 +37,7 @@
 #include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -310,6 +311,15 @@ static struct pcf857x_platform_data pcf_data = {
  *  - ... newer boards may have more
  */
 
+static struct nvmem_cell_lookup dm646x_evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x7f00,
+		.bytes = ETH_ALEN,
+	},
+	.nvmem_name = "1-00500",
+};
+
 static struct at24_platform_data eeprom_info = {
 	.byte_len       = (256*1024) / 8,
 	.page_size      = 64,
@@ -802,6 +812,8 @@ static __init void evm_init(void)
 		davinci_init_ide();
 
 	soc_info->emac_pdata->phy_id = DM646X_EVM_PHY_ID;
+
+	nvmem_register_lookup(&dm646x_evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
-- 
2.17.1
