From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [RESEND][PATCH v5 3/3] mtd: devices: m25p80: add support for mmap read request
Date: Mon, 1 Feb 2016 12:14:25 +0530
Message-ID: <1454309065-11493-4-git-send-email-vigneshr@ti.com>
References: <1454309065-11493-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454309065-11493-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Certain spi controllers may provide accelerated interface to read from
m25p80 type flash devices. This interface provides better read
performance than regular SPI interface.
Call spi_flash_read(), if supported, to make use of such interface.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

Resend v5:
Rebased on top of v4.5-rc1

v5: No changes

 drivers/mtd/devices/m25p80.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c9c3b7fa3051..7730e633d7d3 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -131,6 +131,26 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	dummy /= 8;
 
+	if (spi_flash_read_supported(spi)) {
+		struct spi_flash_read_message msg;
+		int ret;
+
+		msg.buf = buf;
+		msg.from = from;
+		msg.len = len;
+		msg.read_opcode = nor->read_opcode;
+		msg.addr_width = nor->addr_width;
+		msg.dummy_bytes = dummy;
+		/* TODO: Support other combinations */
+		msg.opcode_nbits = SPI_NBITS_SINGLE;
+		msg.addr_nbits = SPI_NBITS_SINGLE;
+		msg.data_nbits = m25p80_rx_nbits(nor);
+
+		ret = spi_flash_read(spi, &msg);
+		*retlen = msg.retlen;
+		return ret;
+	}
+
 	spi_message_init(&m);
 	memset(t, 0, (sizeof t));
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
