From: Phaneendra Kumar Alapati <phani@embwise.com>
Subject: [PATCH] OMAP35xx: Added SDIO IRQ support
Date: Wed, 28 Oct 2009 18:48:38 +0530
Message-ID: <54d94f230910280618l1b770505lfc88af7592777763@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail10.myhsphere.biz ([64.71.235.184]:44375 "EHLO
	mail10.myhsphere.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbZJ1NS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 09:18:56 -0400
Received: by pzk26 with SMTP id 26so553537pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 06:18:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds SDIO IRQ support for omap hsmmc driver.

Signed-off-by: Phaneendra Kumar Alapati <phani@embwise.com>
---
 drivers/mmc/host/omap_hsmmc.c |    62 ++--
 1 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1cf9cfb..a540626 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -92,6 +92,10 @@
 #define DUAL_VOLT_OCR_BIT	7
 #define SRC			(1 << 25)
 #define SRD			(1 << 26)
+#define OMAP_HSMMC_CARD_INT	BIT(8)
+#define SDIO_INT_EN		BIT(8)
+#define CTPL			BIT(11)
+#define CLKEXTFREE		BIT(16)

 /*
  * FIXME: Most likely all the data using these _DEVID defines should come
@@ -149,6 +153,7 @@ struct mmc_omap_host {
 	int			slot_id;
 	int			dbclk_enabled;
 	int			response_busy;
+	int			sdio_int;
 	struct	omap_mmc_platform_data	*pdata;
 };

@@ -240,8 +245,13 @@ mmc_omap_start_command(struct mmc_omap_host
*host, struct mmc_command *cmd,
 	 * Clear status bits and enable interrupts
 	 */
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
-	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
-	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+	if (host->sdio_int) {
+		OMAP_HSMMC_WRITE(host->base, ISE, (INT_EN_MASK | SDIO_INT_EN));
+		OMAP_HSMMC_WRITE(host->base, IE, (INT_EN_MASK | SDIO_INT_EN));
+	} else {
+		OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
+		OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+	}

 	host->response_busy = 0;
 	if (cmd->flags & MMC_RSP_PRESENT) {
@@ -430,17 +440,27 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	struct mmc_data *data;
 	int end_cmd = 0, end_trans = 0, status;

+	data = host->data;
+	status = OMAP_HSMMC_READ(host->base, STAT);
+	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
+
+	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+		if (status & OMAP_HSMMC_CARD_INT) {
+			dev_dbg(mmc_dev(host->mmc),
+					" SDIO CARD interrupt status %x\n",
+					status);
+			mmc_signal_sdio_irq(host->mmc);
+		}
+	}
+
 	if (host->mrq == NULL) {
 		OMAP_HSMMC_WRITE(host->base, STAT,
-			OMAP_HSMMC_READ(host->base, STAT));
+				OMAP_HSMMC_READ(host->base, STAT));
 		/* Flush posted write */
 		OMAP_HSMMC_READ(host->base, STAT);
 		return IRQ_HANDLED;
 	}

-	data = host->data;
-	status = OMAP_HSMMC_READ(host->base, STAT);
-	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);

 	if (status & ERR) {
 #ifdef CONFIG_MMC_DEBUG
@@ -932,6 +952,29 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
 	return pdata->slots[0].get_ro(host->dev, 0);
 }

+static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+
+	host->sdio_int = enable;
+	if (enable) {
+		OMAP_HSMMC_WRITE(host->base, ISE,
+				(OMAP_HSMMC_READ(host->base, ISE) |
+				 OMAP_HSMMC_CARD_INT));
+		OMAP_HSMMC_WRITE(host->base, IE,
+				(OMAP_HSMMC_READ(host->base, IE) |
+				 OMAP_HSMMC_CARD_INT));
+	} else {
+		OMAP_HSMMC_WRITE(host->base, IE,
+				(OMAP_HSMMC_READ(host->base, IE) &
+				 (~OMAP_HSMMC_CARD_INT)));
+		OMAP_HSMMC_WRITE(host->base, ISE,
+				(OMAP_HSMMC_READ(host->base, ISE) &
+				 (~OMAP_HSMMC_CARD_INT)));
+	}
+
+}
+
 static void omap_hsmmc_init(struct mmc_omap_host *host)
 {
 	u32 hctl, capa, value;
@@ -964,7 +1007,7 @@ static struct mmc_host_ops mmc_omap_ops = {
 	.set_ios = omap_mmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
 	.get_ro = omap_hsmmc_get_ro,
-	/* NYET -- enable_sdio_irq */
+	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };

 static int __init omap_mmc_probe(struct platform_device *pdev)
@@ -1011,6 +1054,7 @@ static int __init omap_mmc_probe(struct
platform_device *pdev)
 	host->irq	= irq;
 	host->id	= pdev->id;
 	host->slot_id	= 0;
+	host->sdio_int 	= 0;
 	host->mapbase	= res->start;
 	host->base	= ioremap(host->mapbase, SZ_4K);

@@ -1080,6 +1124,10 @@ static int __init omap_mmc_probe(struct
platform_device *pdev)
 	else if (pdata->slots[host->slot_id].wires >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;

+	mmc->caps |= MMC_CAP_SDIO_IRQ;
+	OMAP_HSMMC_WRITE(host->base, CON,
+			OMAP_HSMMC_READ(host->base, CON) | (CTPL | CLKEXTFREE));
+
 	omap_hsmmc_init(host);

 	/* Select DMA lines */
--
1.6.0.4
