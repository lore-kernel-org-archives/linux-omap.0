From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Date: Thu,  8 Aug 2019 23:22:16 +0200
Message-ID: <20190808212234.2213262-8-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Boris Brezillon <bbrezillon@kernel.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The driver has always had a FIXME about this, and it seems
like this trivial code move avoids a mach header inclusion,
so just do it.

With that out of the way, and the header file inclusions
changed to global files, the driver can also be compile-tested
on other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-perseus2.c |  6 ++++++
 drivers/spi/Kconfig                  |  2 +-
 drivers/spi/spi-omap-uwire.c         | 15 +++------------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 1aeeb7337d29..da0155107d85 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -289,6 +289,12 @@ static void __init omap_perseus2_init(void)
 	omap_cfg_reg(F4_7XX_KBC3);
 	omap_cfg_reg(E3_7XX_KBC4);
 
+	if (IS_ENABLED(CONFIG_SPI_OMAP_UWIRE)) {
+		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
+		int val = omap_readl(OMAP7XX_IO_CONF_9) & ~0x00EEE000;
+		omap_writel(val | 0x00AAA000, OMAP7XX_IO_CONF_9);
+	}
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	omap_serial_init();
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 949b18ed9d6b..4e67c155229e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -464,7 +464,7 @@ config SPI_OCTEON
 
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-	depends on ARCH_OMAP1
+	depends on ARCH_OMAP1 || (ARM && COMPILE_TEST)
 	select SPI_BITBANG
 	help
 	  This hooks up to the MicroWire controller on OMAP1 chips.
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index ce8dbdbce312..278d42a2ec49 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -44,13 +44,10 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-
-#include <mach/mux.h>
-
-#include <mach/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
-
+#include <linux/soc/ti/omap1-io.h>
+#include <linux/soc/ti/omap1-soc.h>
+#include <linux/soc/ti/omap1-mux.h>
 
 /* FIXME address is now a platform device resource,
  * and irqs should show there too...
@@ -541,12 +538,6 @@ static int __init omap_uwire_init(void)
 		omap_cfg_reg(N14_1610_UWIRE_CS0);
 		omap_cfg_reg(N15_1610_UWIRE_CS1);
 	}
-	if (machine_is_omap_perseus2()) {
-		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
-		int val = omap_readl(OMAP7XX_IO_CONF_9) & ~0x00EEE000;
-		omap_writel(val | 0x00AAA000, OMAP7XX_IO_CONF_9);
-	}
-
 	return platform_driver_register(&uwire_driver);
 }
 
-- 
2.20.0
