From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 06/17] spi/qspi: Add support to switc to memory mapped operation.
Date: Tue, 26 Nov 2013 13:05:02 +0530
Message-ID: <1385451313-1875-7-git-send-email-sourav.poddar@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385451313-1875-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

These add apis that can be used to switch to memory mapped operatons
by configuring control module and qspi registers.

Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 39aefd7..40f1c35 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -113,6 +113,10 @@ struct ti_qspi {
 #define QSPI_CSPOL(n)			(1 << (1 + n * 8))
 #define QSPI_CKPOL(n)			(1 << (n * 8))
 
+#define MM_SWITCH	(1 << 0)
+#define MEM_CS		(1 << 8)
+#define MEM_CS_DIS	(0 << 8)
+
 #define	QSPI_FRAME			4096
 
 #define QSPI_AUTOSUSPEND_TIMEOUT         2000
@@ -129,6 +133,30 @@ static inline void ti_qspi_write(struct ti_qspi *qspi,
 	writel(val, qspi->base + reg);
 }
 
+void enable_qspi_memory_mapped(struct ti_qspi *qspi)
+{
+	u32 val;
+
+	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val |= MEM_CS;
+		writel(val, qspi->ctrl_base);
+	}
+}
+
+void disable_qspi_memory_mapped(struct ti_qspi *qspi)
+{
+	u32 val;
+
+	ti_qspi_write(qspi, ~MM_SWITCH, QSPI_SPI_SWITCH_REG);
+	if (qspi->ctrl_mod) {
+		val = readl(qspi->ctrl_base);
+		val &= MEM_CS_DIS;
+		writel(val, qspi->ctrl_base);
+	}
+}
+
 static int ti_qspi_setup(struct spi_device *spi)
 {
 	struct ti_qspi	*qspi = spi_master_get_devdata(spi->master);
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
