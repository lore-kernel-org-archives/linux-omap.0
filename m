From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/17] spi/spi.h: Add get_buf/put_buf support in spi master..
Date: Tue, 26 Nov 2013 13:04:57 +0530
Message-ID: <1385451313-1875-2-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add get_buf, put_buf api support in spi master.
This can be used in a scenario where spi controller
supports memory mapped operations(typically with flash devices).
So, the memcpy needs top be done in slave devices which need the
required memory mapped address. These api can be used to get that
master address.

These can also be used to turm the master controller clock, as usually
the clocks get turned in spi core. But, in memory mapped case, we will
bypass the spi core and hence needa way out to turn on the controller clock.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 include/linux/spi/spi.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba7..3b3743d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -291,6 +291,10 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
  *
+ * @get_buf: used for memory mapped cases, when the slave device wants to
+ *       know the address to be used for memcopy.
+ * @put_buf: Used for memory mapped cases after get_buf, after the memcpy
+ *       has finished.
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
  * but not chip select signals.  Each device may be configured to use a
@@ -421,6 +425,9 @@ struct spi_master {
 	int (*transfer_one)(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *transfer);
 
+	void	(*get_buf)(struct spi_master *master);
+	void	(*put_buf)(struct spi_master *master);
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
