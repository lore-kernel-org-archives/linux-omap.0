From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: Select SPI_SPLIT" to the spi tree
Date: Fri, 08 Jul 2016 10:49:15 +0200
Message-ID: <E1bLRTH-0004lu-Mz@finisterre>
References: <1467911871-4508-3-git-send-email-fcooper@ti.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467911871-4508-3-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.orglinux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The patch

   spi: omap2-mcspi: Select SPI_SPLIT

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2b32e987c48c65a1a40b3b4294435f761e063b6b Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Date: Thu, 7 Jul 2016 12:17:49 -0500
Subject: [PATCH] spi: omap2-mcspi: Select SPI_SPLIT

The function sg_split will be used by spi-omap2-mcspi to handle a SoC
workaround in the SPI driver. Therefore, select SG_SPLIT so this function
is available to the driver.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b931ec8d90b..d6fb8d4b7786 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
