From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/17] spi/spi.h: Add "mem" variable in spi master.
Date: Tue, 26 Nov 2013 13:05:05 +0530
Message-ID: <1385451313-1875-10-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add "mem" variable in spi_master, which can be used to hold on the
memory mapped address.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 include/linux/spi/spi.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4be969a..72565ff 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -298,6 +298,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @configure_from_slave: Used when SPI controller has registers which need
  *      to be configured from slave specifics information(typical use case for
  *      SPI flash device).
+ * @mem: memory mapped address to be filled by master controller driver.
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
  * but not chip select signals.  Each device may be configured to use a
@@ -432,6 +433,8 @@ struct spi_master {
 	void	(*put_buf)(struct spi_master *master);
 	void	(*configure_from_slave)(struct spi_device *spi, u8 *val);
 
+	void __iomem *mem;
+
 	/* gpio chip select */
 	int			*cs_gpios;
 };
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
