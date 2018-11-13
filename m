From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 14/25] ARM: davinci: da850-evm: remove dead MTD code
Date: Tue, 13 Nov 2018 15:01:22 +0100
Message-ID: <20181113140133.17385-15-brgl@bgdev.pl>
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

We no longer need to register the MTD notifier to read the MAC address
as it's now being done in the emac driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6a29baf0a289..128dd7d8dff6 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -150,32 +150,6 @@ static struct spi_board_info da850evm_spi_info[] = {
 	},
 };
 
-#ifdef CONFIG_MTD
-static void da850_evm_m25p80_notify_add(struct mtd_info *mtd)
-{
-	char *mac_addr = davinci_soc_info.emac_pdata->mac_addr;
-	size_t retlen;
-
-	if (!strcmp(mtd->name, "MAC-Address")) {
-		mtd_read(mtd, 0, ETH_ALEN, &retlen, mac_addr);
-		if (retlen == ETH_ALEN)
-			pr_info("Read MAC addr from SPI Flash: %pM\n",
-				mac_addr);
-	}
-}
-
-static struct mtd_notifier da850evm_spi_notifier = {
-	.add	= da850_evm_m25p80_notify_add,
-};
-
-static void da850_evm_setup_mac_addr(void)
-{
-	register_mtd_user(&da850evm_spi_notifier);
-}
-#else
-static void da850_evm_setup_mac_addr(void) { }
-#endif
-
 static struct mtd_partition da850_evm_norflash_partition[] = {
 	{
 		.name           = "bootloaders + env",
@@ -1494,8 +1468,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.19.1
