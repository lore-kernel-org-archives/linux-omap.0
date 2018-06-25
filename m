From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 02/14] ARM: davinci: dm365-evm: use nvmem lookup for mac address
Date: Mon, 25 Jun 2018 17:50:13 +0200
Message-ID: <20180625155025.12567-3-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 435f7ec7d9af..df640d977bfa 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -169,6 +170,15 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
+static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
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
@@ -769,6 +779,8 @@ static __init void dm365_evm_init(void)
 
 	dm365_init_spi0(BIT(0), dm365_evm_spi_info,
 			ARRAY_SIZE(dm365_evm_spi_info));
+
+	nvmem_register_lookup(&dm365evm_mac_address_cell, 1);
 }
 
 MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
-- 
2.17.1
