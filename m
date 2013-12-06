From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 05/10] spi/qspi: Add api for get_buf/put_buf.
Date: Fri, 6 Dec 2013 19:54:46 +0530
Message-ID: <1386339891-32717-6-git-send-email-sourav.poddar@ti.com>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386339891-32717-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adapt qspi driver to use (get_buf/put_buf) pointers added
earlier.
These can be called just before the memcpy operations to get hold
of the memory mapped address and to turn on the controller clocks.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
v1->v2:
 enable/disable memory mapped only when get_buf/put_buf is
 called (basicaaly only when memory mapped read operation is
 desired).
 drivers/spi/spi-ti-qspi.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index e4a8afc..b83583c 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -248,6 +248,23 @@ static void ti_qspi_configure_from_slave(struct spi_device *spi)
 	ti_qspi_write(qspi, memval, QSPI_SPI_SETUP0_REG);
 }
 
+static inline int  __iomem *ti_qspi_get_mem_buf(struct spi_master *master)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(master);
+
+	pm_runtime_get_sync(qspi->dev);
+	enable_qspi_memory_mapped(qspi);
+	return qspi->mmap_base;
+}
+
+static void ti_qspi_put_mem_buf(struct spi_master *master)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(master);
+
+	disable_qspi_memory_mapped(qspi);
+	pm_runtime_put(qspi->dev);
+}
+
 static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
 {
 	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
@@ -517,6 +534,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
 	master->mmap = true;
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
