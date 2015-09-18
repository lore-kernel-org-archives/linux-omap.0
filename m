From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 09/27] mtd: nand: omap2: manage NAND interrupts
Date: Fri, 18 Sep 2015 17:53:31 +0300
Message-ID: <1442588029-13769-10-git-send-email-rogerq@ti.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1442588029-13769-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, computersforpeace@gmail.com, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Manage NAND interrupts here using the GPMC IRQ ops.

This causes performance in prefetch-irq mode to be increased

from
[   38.252811] mtd_speedtest: eraseblock write speed is 5576 KiB/s
[   39.265259] mtd_speedtest: eraseblock read speed is 8192 KiB/s

to
[   35.666446] mtd_speedtest: eraseblock write speed is 6537 KiB/s
[   36.444842] mtd_speedtest: eraseblock read speed is 10680 KiB/s

Test results on dra7-evm using mtd_speedtest.ko

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mtd/nand/omap2.c | 65 +++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 0eb0b8c..267bcdd 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -162,8 +162,7 @@ struct omap_nand_info {
 	enum omap_ecc			ecc_opt;
 	struct completion		comp;
 	struct dma_chan			*dma;
-	int				gpmc_irq_fifo;
-	int				gpmc_irq_count;
+	int				gpmc_irq;
 	enum {
 		OMAP_NAND_IO_READ = 0,	/* read */
 		OMAP_NAND_IO_WRITE,	/* write */
@@ -579,12 +578,17 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 {
 	struct omap_nand_info *info = (struct omap_nand_info *) dev;
 	u32 bytes;
+	u32 irqstatus;
+
+	irqstatus = info->ops->nand_irq_status();
+	if (!irqstatus)
+		return IRQ_NONE;
 
 	bytes = readl(info->reg.gpmc_prefetch_status);
 	bytes = PREFETCH_STATUS_FIFO_CNT(bytes);
 	bytes = bytes  & 0xFFFC; /* io in multiple of 4 bytes */
 	if (info->iomode == OMAP_NAND_IO_WRITE) { /* checks for write io */
-		if (this_irq == info->gpmc_irq_count)
+		if (irqstatus & GPMC_IRQENABLE_TERMCOUNT)
 			goto done;
 
 		if (info->buf_len && (info->buf_len < bytes))
@@ -601,17 +605,25 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 						(u32 *)info->buf, bytes >> 2);
 		info->buf = info->buf + bytes;
 
-		if (this_irq == info->gpmc_irq_count)
+		if (irqstatus & GPMC_IRQENABLE_TERMCOUNT)
 			goto done;
 	}
 
+	/* Clear FIFOEVENT STATUS */
+	info->ops->nand_irq_clear(GPMC_NAND_IRQ_FIFOEVENT);
+
 	return IRQ_HANDLED;
 
 done:
 	complete(&info->comp);
 
-	disable_irq_nosync(info->gpmc_irq_fifo);
-	disable_irq_nosync(info->gpmc_irq_count);
+	/* Clear FIFOEVENT and TERMCOUNT STATUS */
+	info->ops->nand_irq_clear(GPMC_NAND_IRQ_FIFOEVENT);
+	info->ops->nand_irq_clear(GPMC_NAND_IRQ_TERMCOUNT);
+
+	/* Disable Interrupt generation */
+	info->ops->nand_irq_disable(GPMC_NAND_IRQ_FIFOEVENT);
+	info->ops->nand_irq_disable(GPMC_NAND_IRQ_TERMCOUNT);
 
 	return IRQ_HANDLED;
 }
@@ -646,8 +658,9 @@ static void omap_read_buf_irq_pref(struct mtd_info *mtd, u_char *buf, int len)
 
 	info->buf_len = len;
 
-	enable_irq(info->gpmc_irq_count);
-	enable_irq(info->gpmc_irq_fifo);
+	/* Enable Interrupt generation */
+	info->ops->nand_irq_enable(GPMC_NAND_IRQ_TERMCOUNT);
+	info->ops->nand_irq_enable(GPMC_NAND_IRQ_FIFOEVENT);
 
 	/* waiting for read to complete */
 	wait_for_completion(&info->comp);
@@ -696,8 +709,9 @@ static void omap_write_buf_irq_pref(struct mtd_info *mtd,
 
 	info->buf_len = len;
 
-	enable_irq(info->gpmc_irq_count);
-	enable_irq(info->gpmc_irq_fifo);
+	/* Enable Interrupt generation */
+	info->ops->nand_irq_enable(GPMC_NAND_IRQ_TERMCOUNT);
+	info->ops->nand_irq_enable(GPMC_NAND_IRQ_FIFOEVENT);
 
 	/* waiting for write to complete */
 	wait_for_completion(&info->comp);
@@ -1776,35 +1790,18 @@ static int omap_nand_probe(struct platform_device *pdev)
 		break;
 
 	case NAND_OMAP_PREFETCH_IRQ:
-		info->gpmc_irq_fifo = platform_get_irq(pdev, 0);
-		if (info->gpmc_irq_fifo <= 0) {
-			dev_err(&pdev->dev, "error getting fifo irq\n");
-			err = -ENODEV;
-			goto return_error;
-		}
-		err = devm_request_irq(&pdev->dev, info->gpmc_irq_fifo,
-					omap_nand_irq, IRQF_SHARED,
-					"gpmc-nand-fifo", info);
-		if (err) {
-			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-						info->gpmc_irq_fifo, err);
-			info->gpmc_irq_fifo = 0;
-			goto return_error;
-		}
-
-		info->gpmc_irq_count = platform_get_irq(pdev, 1);
-		if (info->gpmc_irq_count <= 0) {
-			dev_err(&pdev->dev, "error getting count irq\n");
+		info->gpmc_irq = platform_get_irq(pdev, 0);
+		if (info->gpmc_irq <= 0) {
+			dev_err(&pdev->dev, "error getting GPMC irq\n");
 			err = -ENODEV;
 			goto return_error;
 		}
-		err = devm_request_irq(&pdev->dev, info->gpmc_irq_count,
-					omap_nand_irq, IRQF_SHARED,
-					"gpmc-nand-count", info);
+		err = devm_request_irq(&pdev->dev, info->gpmc_irq,
+				       omap_nand_irq, IRQF_SHARED,
+				       DRIVER_NAME, info);
 		if (err) {
 			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
-						info->gpmc_irq_count, err);
-			info->gpmc_irq_count = 0;
+						info->gpmc_irq, err);
 			goto return_error;
 		}
 
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
