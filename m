From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 09/18] ARM: davinci: da850-evm: remove dead MTD code
Date: Thu, 28 Jun 2018 16:32:35 +0200
Message-ID: <20180628143244.4561-10-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We no longer need to register the MTD notifier to read the MAC address
as it's now being done in the emac address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 28 -------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e22fb40e34bc..4de075458d83 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -124,32 +124,6 @@ static struct spi_board_info da850evm_spi_info[] = {
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
@@ -1455,8 +1429,6 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: SATA registration failed: %d\n", __func__, ret);
 
-	da850_evm_setup_mac_addr();
-
 	ret = da8xx_register_rproc();
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
-- 
2.17.1
