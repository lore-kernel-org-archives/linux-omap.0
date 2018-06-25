From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 06/14] ARM: davinci: mityomapl138: add nvmem cells lookup entries
Date: Mon, 25 Jun 2018 17:50:17 +0200
Message-ID: <20180625155025.12567-7-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..2ec31ff61dbd 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -21,6 +21,7 @@
 #include <linux/etherdevice.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/nvmem-provider.h>
 
 #include <asm/io.h>
 #include <asm/mach-types.h>
@@ -160,6 +161,25 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 	mityomapl138_cpufreq_init(partnum);
 }
 
+static struct nvmem_cell_lookup mityomapl138_nvmem_cells[] = {
+	{
+		.info = {
+			.name = "factory-config",
+			.offset = 0x0,
+			.bytes = sizeof(struct factory_config),
+		},
+		.nvmem_name = "1-00500",
+	},
+	{
+		.info = {
+			.name = "mac-address",
+			.offset = 0x64,
+			.bytes = ETH_ALEN,
+		},
+		.nvmem_name = "1-00500",
+	}
+};
+
 static struct at24_platform_data mityomapl138_fd_chip = {
 	.byte_len	= 256,
 	.page_size	= 8,
@@ -534,6 +554,8 @@ static void __init mityomapl138_init(void)
 	if (ret)
 		pr_warn("spi 1 registration failed: %d\n", ret);
 
+	nvmem_register_lookup(mityomapl138_nvmem_cells,
+			      ARRAY_SIZE(mityomapl138_nvmem_cells));
 	mityomapl138_config_emac();
 
 	ret = da8xx_register_rtc();
-- 
2.17.1
