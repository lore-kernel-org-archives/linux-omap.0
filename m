From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC] [PATCH v3 2/4] spi: spi-omap2-mcspi: Select SPI_SPLIT
Date: Thu,  7 Jul 2016 12:17:49 -0500
Message-ID: <1467911871-4508-3-git-send-email-fcooper@ti.com>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467911871-4508-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, robh+dt@kernel.org, broonie@kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, andy.shevchenko@gmail.com, robert.jarzmik@free.fr, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

The function spi_split will be used by spi-omap2-mcspi to handle a SoC
workaround in the SPI driver. Therefore, select SPI_SPLIT so this function
is available to the driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b931ec..d6fb8d4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -411,6 +411,7 @@ config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
 	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	select SG_SPLIT
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.
-- 
2.7.0
