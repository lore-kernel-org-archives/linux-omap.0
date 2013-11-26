From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 10/17] spi/spi.h: Add mmap flag in spi master.
Date: Tue, 26 Nov 2013 13:05:06 +0530
Message-ID: <1385451313-1875-11-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43846 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab3KZHg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 02:36:26 -0500
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: computersforpeace@gmail.com, broonie@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, Sourav Poddar <sourav.poddar@ti.com>

Add "mmap" flag which can be used to show that the master
controller supports memory mapped operations.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 include/linux/spi/spi.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 72565ff..9425ea4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -299,6 +299,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *      to be configured from slave specifics information(typical use case for
  *      SPI flash device).
  * @mem: memory mapped address to be filled by master controller driver.
+ * @mmap: Shows that master controller supports memory mapped operation.
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
  * but not chip select signals.  Each device may be configured to use a
@@ -437,6 +438,7 @@ struct spi_master {
 
 	/* gpio chip select */
 	int			*cs_gpios;
+	bool	mmap;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.7.1

