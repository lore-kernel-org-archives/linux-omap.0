From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 18/28] ARM: davinci: mityomapl138: don't read the MAC address from machine code
Date: Wed,  8 Aug 2018 17:31:40 +0200
Message-ID: <20180808153150.23444-19-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is now done by the emac driver using a registered nvmem cell.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index b5be51c0451e..5c0a0557a361 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -120,7 +120,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 {
 	int ret;
 	const char *partnum = NULL;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
 	if (!IS_BUILTIN(CONFIG_NVMEM)) {
 		pr_warn("Factory Config not available without CONFIG_NVMEM\n");
@@ -146,13 +145,6 @@ static void read_factory_config(struct nvmem_device *nvmem, void *context)
 		goto bad_config;
 	}
 
-	pr_info("Found MAC = %pM\n", factory_config.mac);
-	if (is_valid_ether_addr(factory_config.mac))
-		memcpy(soc_info->emac_pdata->mac_addr,
-			factory_config.mac, ETH_ALEN);
-	else
-		pr_warn("Invalid MAC found in factory config block\n");
-
 	partnum = factory_config.partnum;
 	pr_info("Part Number = %s\n", partnum);
 
-- 
2.18.0
