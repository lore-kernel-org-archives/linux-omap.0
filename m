From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 08/17] spi/qspi: Add api for get_buf/put_buf.
Date: Tue, 26 Nov 2013 13:05:04 +0530
Message-ID: <1385451313-1875-9-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adapt qspi driver to use (get_buf/put_buf) pointers added
earlier.
These can be called just before the memcpy operations to get hold
of the memory mapped address and to turn on the controller clocks.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 2323572..10bcb37 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -247,6 +247,21 @@ static void ti_qspi_configure_from_slave(struct spi_device *spi, u8 *val)
 	ti_qspi_write(qspi, memval, QSPI_SPI_SETUP0_REG);
 }
 
+static void ti_qspi_get_mem_buf(struct spi_master *master)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(master);
+
+	pm_runtime_get_sync(qspi->dev);
+	master->mem = qspi->mmap_base;
+}
+
+static void ti_qspi_put_mem_buf(struct spi_master *master)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(master);
+
+	pm_runtime_put(qspi->dev);
+}
+
 static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
 {
 	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
@@ -515,6 +530,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
 	master->configure_from_slave = ti_qspi_configure_from_slave;
+	master->get_buf = ti_qspi_get_mem_buf;
+	master->put_buf = ti_qspi_put_mem_buf;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
