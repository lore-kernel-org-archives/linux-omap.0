From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 13/17] drivers: mtd: m25p80: Add api to configure master register.
Date: Tue, 26 Nov 2013 13:05:09 +0530
Message-ID: <1385451313-1875-14-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

These can be used to fill information needed to configure 
master controller registers.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 7dc2c14..6a27677 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -490,6 +490,23 @@ static inline int m25p80_dummy_cycles_read(struct m25p *flash)
 }
 
 /*
+ * This API can be used to transfer flash information to
+ * SPI controller which needs some of its registers to get
+ * configured on flash.
+ */
+static void m25p80_fill_flash_information(struct m25p *flash)
+{
+	struct spi_master *master = flash->spi->master;
+	u8 info[4];
+	info[0] = flash->read_opcode;
+	info[1] = flash->program_opcode;
+	info[2] = flash->addr_width;
+	info[3] = m25p80_dummy_cycles_read(flash);
+
+	master->configure_from_slave(flash->spi, info);
+}
+
+/*
  * Read an address range from the flash chip.  The address range
  * may be any size provided it is within the physical boundaries.
  */
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
