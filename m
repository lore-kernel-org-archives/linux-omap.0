From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 3/5] mtd: devices: m25p80: add support for mmap read request
Date: Mon, 30 Nov 2015 10:45:13 +0530
Message-ID: <1448860515-28336-4-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Certain spi controllers may provide accelerated interface to read from
m25p80 type flash devices. This interface provides better read
performance than regular SPI interface.
Call spi_flash_read(), if supported, to make use of such interface.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

v4: 
 * Use spi_flash_read_message struct to pass args.
 * support passing of opcode/addr/data nbits.

 drivers/mtd/devices/m25p80.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fe9ceb7b5405..00094a668c62 100644
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
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
