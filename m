From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: spi-ti-qspi: switch to polling mode for better r/w performance
Date: Tue, 13 Oct 2015 15:51:05 +0530
Message-ID: <1444731665-11359-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently word completion interrupt is fired for transfer of every
word(8bit to 128bit in size). This adds a lot of overhead, and decreases
r/w throughput. It hardly takes 3us(@48MHz) for 128bit r/w to complete,
hence its better to poll on word complete bit to be set in
QSPI_SPI_STATUS_REG instead of using interrupts.
This increases the throughput by 30% in both read and write case.

So, switch to polling mode instead of interrupts to determine completion
of word transfer.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
---

Tested on DRA74 Rev G EVM.

 drivers/spi/spi-ti-qspi.c | 74 +++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 54 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 81b84858cfee..69c1a95b0615 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -39,8 +39,6 @@ struct ti_qspi_regs {
 };
 
 struct ti_qspi {
-	struct completion       transfer_complete;
-
 	/* list synchronization */
 	struct mutex            list_lock;
 
@@ -62,10 +60,6 @@ struct ti_qspi {
 
 #define QSPI_PID			(0x0)
 #define QSPI_SYSCONFIG			(0x10)
-#define QSPI_INTR_STATUS_RAW_SET	(0x20)
-#define QSPI_INTR_STATUS_ENABLED_CLEAR	(0x24)
-#define QSPI_INTR_ENABLE_SET_REG	(0x28)
-#define QSPI_INTR_ENABLE_CLEAR_REG	(0x2c)
 #define QSPI_SPI_CLOCK_CNTRL_REG	(0x40)
 #define QSPI_SPI_DC_REG			(0x44)
 #define QSPI_SPI_CMD_REG		(0x48)
@@ -97,7 +91,6 @@ struct ti_qspi {
 #define QSPI_RD_DUAL			(3 << 16)
 #define QSPI_RD_QUAD			(7 << 16)
 #define QSPI_INVAL			(4 << 16)
-#define QSPI_WC_CMD_INT_EN			(1 << 14)
 #define QSPI_FLEN(n)			((n - 1) << 0)
 #define QSPI_WLEN_MAX_BITS		128
 #define QSPI_WLEN_MAX_BYTES		16
@@ -106,10 +99,6 @@ struct ti_qspi {
 #define BUSY				0x01
 #define WC				0x02
 
-/* INTERRUPT REGISTER */
-#define QSPI_WC_INT_EN				(1 << 1)
-#define QSPI_WC_INT_DISABLE			(1 << 1)
-
 /* Device Control */
 #define QSPI_DD(m, n)			(m << (3 + n * 8))
 #define QSPI_CKPHA(n)			(1 << (2 + n * 8))
@@ -217,6 +206,24 @@ static inline u32 qspi_is_busy(struct ti_qspi *qspi)
 	return stat & BUSY;
 }
 
+static inline int ti_qspi_poll_wc(struct ti_qspi *qspi)
+{
+	u32 stat;
+	unsigned long timeout = jiffies + QSPI_COMPLETION_TIMEOUT;
+
+	do {
+		stat = ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);
+		if (stat & WC)
+			return 0;
+		cpu_relax();
+	} while (time_after(timeout, jiffies));
+
+	stat = ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);
+	if (stat & WC)
+		return 0;
+	return  -ETIMEDOUT;
+}
+
 static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 {
 	int wlen, count, xfer_len;
@@ -275,8 +282,7 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 		}
 
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-		if (!wait_for_completion_timeout(&qspi->transfer_complete,
-						 QSPI_COMPLETION_TIMEOUT)) {
+		if (ti_qspi_poll_wc(qspi)) {
 			dev_err(qspi->dev, "write timed out\n");
 			return -ETIMEDOUT;
 		}
@@ -315,8 +321,7 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t)
 			return -EBUSY;
 
 		ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);
-		if (!wait_for_completion_timeout(&qspi->transfer_complete,
-						 QSPI_COMPLETION_TIMEOUT)) {
+		if (ti_qspi_poll_wc(qspi)) {
 			dev_err(qspi->dev, "read timed out\n");
 			return -ETIMEDOUT;
 		}
@@ -388,9 +393,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	qspi->cmd = 0;
 	qspi->cmd |= QSPI_EN_CS(spi->chip_select);
 	qspi->cmd |= QSPI_FLEN(frame_length);
-	qspi->cmd |= QSPI_WC_CMD_INT_EN;
 
-	ti_qspi_write(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
 	ti_qspi_write(qspi, qspi->dc, QSPI_SPI_DC_REG);
 
 	mutex_lock(&qspi->list_lock);
@@ -417,31 +420,6 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
 	return status;
 }
 
-static irqreturn_t ti_qspi_isr(int irq, void *dev_id)
-{
-	struct ti_qspi *qspi = dev_id;
-	u16 int_stat;
-	u32 stat;
-
-	irqreturn_t ret = IRQ_HANDLED;
-
-	int_stat = ti_qspi_read(qspi, QSPI_INTR_STATUS_ENABLED_CLEAR);
-	stat = ti_qspi_read(qspi, QSPI_SPI_STATUS_REG);
-
-	if (!int_stat) {
-		dev_dbg(qspi->dev, "No IRQ triggered\n");
-		ret = IRQ_NONE;
-		goto out;
-	}
-
-	ti_qspi_write(qspi, QSPI_WC_INT_DISABLE,
-				QSPI_INTR_STATUS_ENABLED_CLEAR);
-	if (stat & WC)
-		complete(&qspi->transfer_complete);
-out:
-	return ret;
-}
-
 static int ti_qspi_runtime_resume(struct device *dev)
 {
 	struct ti_qspi      *qspi;
@@ -550,22 +528,12 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, ti_qspi_isr, 0,
-			dev_name(&pdev->dev), qspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
-				irq);
-		goto free_master;
-	}
-
 	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(qspi->fclk)) {
 		ret = PTR_ERR(qspi->fclk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
 	}
 
-	init_completion(&qspi->transfer_complete);
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, QSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
@@ -595,8 +563,6 @@ static int ti_qspi_remove(struct platform_device *pdev)
 		return ret;
 	}
 
-	ti_qspi_write(qspi, QSPI_WC_INT_DISABLE, QSPI_INTR_ENABLE_CLEAR_REG);
-
 	pm_runtime_put(qspi->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
