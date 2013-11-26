From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 14/17] drivers: mtd: m25p80: Adapt driver to support memory mapped read.
Date: Tue, 26 Nov 2013 13:05:10 +0530
Message-ID: <1385451313-1875-15-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adapt driver to do a memory mapped read.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 6a27677..b7ed4be 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -514,6 +514,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	size_t *retlen, u_char *buf)
 {
 	struct m25p *flash = mtd_to_m25p(mtd);
+	struct spi_master *master = flash->spi->master;
 	struct spi_transfer t[2];
 	struct spi_message m;
 	uint8_t opcode;
@@ -522,6 +523,14 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(&flash->spi->dev),
 			__func__, (u32)from, len);
 
+	if (master->mmap) {
+		master->get_buf(master);
+		memcpy(buf, master->mem + from, len);
+		master->put_buf(master);
+		*retlen = len;
+		goto out;
+	}
+
 	spi_message_init(&m);
 	memset(t, 0, (sizeof t));
 
@@ -559,6 +568,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 	mutex_unlock(&flash->lock);
 
+out:
 	return 0;
 }
 
@@ -1285,6 +1295,9 @@ static int m25p_probe(struct spi_device *spi)
 		flash->addr_width = 3;
 	}
 
+	if (spi->master->configure_from_slave)
+		m25p80_fill_flash_information(flash);
+
 	dev_info(&spi->dev, "%s (%lld Kbytes)\n", id->name,
 			(long long)flash->mtd.size >> 10);
 
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
