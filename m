From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 8/9] OMAP: HSMMC: Implement scatter-gather emulation
Date: Fri, 21 Nov 2008 11:25:26 +0200
Message-ID: <49267E86.307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58567 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYKUJRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 04:17:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Instead of using the bounce buffer, using scatter-gather emulation
(as in the OMAP1/2 MMC driver) removes the need of one extra memory
copy and improves performance.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
---
 drivers/mmc/host/omap_hsmmc.c |  174 ++++++++++++++++++++++------------------
 1 files changed, 96 insertions(+), 78 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d81f9af..6058a70 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -98,9 +98,6 @@
 #define OMAP_MMC1_DEVID		0
 #define OMAP_MMC2_DEVID		1
 
-#define OMAP_MMC_DATADIR_NONE	0
-#define OMAP_MMC_DATADIR_READ	1
-#define OMAP_MMC_DATADIR_WRITE	2
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
 #define DRIVER_NAME		"mmci-omap"
@@ -139,16 +136,14 @@ struct mmc_omap_host {
 	resource_size_t		mapbase;
 	unsigned int		id;
 	unsigned int		dma_len;
-	unsigned int		dma_dir;
+	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
-	unsigned char		datadir;
 	u32			*buffer;
 	u32			bytesleft;
 	int			suspended;
 	int			irq;
 	int			carddetect;
 	int			use_dma, dma_ch;
-	int			initstr;
 	int			slot_id;
 	int			dbclk_enabled;
 
@@ -316,6 +311,15 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd,
 	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
 }
 
+static int
+mmc_omap_get_dma_dir(struct mmc_omap_host *host, struct mmc_data *data)
+{
+	if (data->flags & MMC_DATA_WRITE)
+		return DMA_TO_DEVICE;
+	else
+		return DMA_FROM_DEVICE;
+}
+
 /*
  * Notify the transfer complete to MMC core
  */
@@ -326,9 +330,7 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 
 	if (host->use_dma && host->dma_ch != -1)
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
-			host->dma_dir);
-
-	host->datadir = OMAP_MMC_DATADIR_NONE;
+			mmc_omap_get_dma_dir(host, data));
 
 	if (!data->error)
 		data->bytes_xfered += data->blocks * (data->blksz);
@@ -380,13 +382,12 @@ static void mmc_dma_cleanup(struct mmc_omap_host *host)
 
 	if (host->use_dma && host->dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
-			host->dma_dir);
+			mmc_omap_get_dma_dir(host, host->data));
 		omap_free_dma(host->dma_ch);
 		host->dma_ch = -1;
 		up(&host->sem);
 	}
 	host->data = NULL;
-	host->datadir = OMAP_MMC_DATADIR_NONE;
 }
 
 /*
@@ -598,6 +599,55 @@ static irqreturn_t omap_mmc_cd_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mmc_omap_get_dma_sync_dev(struct mmc_omap_host *host,
+				     struct mmc_data *data)
+{
+	int sync_dev;
+
+	if (data->flags & MMC_DATA_WRITE) {
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_TX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_TX;
+	} else {
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_RX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_RX;
+	}
+	return sync_dev;
+}
+
+static void mmc_omap_config_dma_params(struct mmc_omap_host *host,
+				       struct mmc_data *data,
+				       struct scatterlist *sgl)
+{
+	int blksz, nblk, dma_ch;
+
+	dma_ch = host->dma_ch;
+	if (data->flags & MMC_DATA_WRITE) {
+		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
+			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
+			sg_dma_address(sgl), 0, 0);
+	} else {
+		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
+					(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
+			sg_dma_address(sgl), 0, 0);
+	}
+
+	blksz = host->data->blksz;
+	nblk = sg_dma_len(sgl) / blksz;
+
+	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
+			blksz / 4, nblk, OMAP_DMA_SYNC_FRAME,
+			mmc_omap_get_dma_sync_dev(host, data),
+			!(data->flags & MMC_DATA_WRITE));
+
+	omap_start_dma(dma_ch);
+}
+
 /*
  * DMA call back function
  */
@@ -611,6 +661,14 @@ static void mmc_omap_dma_cb(int lch, u16 ch_status, void *data)
 	if (host->dma_ch < 0)
 		return;
 
+	host->dma_sg_idx++;
+	if (host->dma_sg_idx < host->dma_len) {
+		/* Fire up the next transfer. */
+		mmc_omap_config_dma_params(host, host->data,
+					   host->data->sg + host->dma_sg_idx);
+		return;
+	}
+
 	omap_free_dma(host->dma_ch);
 	host->dma_ch = -1;
 	/*
@@ -621,38 +679,28 @@ static void mmc_omap_dma_cb(int lch, u16 ch_status, void *data)
 }
 
 /*
- * Configure dma src and destination parameters
- */
-static int mmc_omap_config_dma_param(int sync_dir, struct mmc_omap_host *host,
-				struct mmc_data *data)
-{
-	if (sync_dir == 0) {
-		omap_set_dma_dest_params(host->dma_ch, 0,
-			OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
-		omap_set_dma_src_params(host->dma_ch, 0,
-			OMAP_DMA_AMODE_POST_INC,
-			sg_dma_address(&data->sg[0]), 0, 0);
-	} else {
-		omap_set_dma_src_params(host->dma_ch, 0,
-			OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
-		omap_set_dma_dest_params(host->dma_ch, 0,
-			OMAP_DMA_AMODE_POST_INC,
-			sg_dma_address(&data->sg[0]), 0, 0);
-	}
-	return 0;
-}
-/*
  * Routine to configure and start DMA for the MMC card
  */
 static int
 mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 {
-	int sync_dev, sync_dir = 0;
-	int dma_ch = 0, ret = 0, err = 1;
+	int dma_ch = 0, ret = 0, err = 1, i;
 	struct mmc_data *data = req->data;
 
+	/* Sanity check: all the SG entries must be aligned by block size. */
+	for (i = 0; i < host->dma_len; i++) {
+		struct scatterlist *sgl;
+
+		sgl = data->sg + i;
+		if (sgl->length % data->blksz)
+			return -EINVAL;
+	}
+	if ((data->blksz % 4) != 0)
+		/* REVISIT: The MMC buffer increments only when MSB is written.
+		 * Return error for blksz which is non multiple of four.
+		 */
+		return -EINVAL;
+
 	/*
 	 * If for some reason the DMA transfer is still active,
 	 * we wait for timeout period and free the dma
@@ -671,49 +719,22 @@ mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
 			return err;
 	}
 
-	if (!(data->flags & MMC_DATA_WRITE)) {
-		host->dma_dir = DMA_FROM_DEVICE;
-		if (host->id == OMAP_MMC1_DEVID)
-			sync_dev = OMAP24XX_DMA_MMC1_RX;
-		else
-			sync_dev = OMAP24XX_DMA_MMC2_RX;
-	} else {
-		host->dma_dir = DMA_TO_DEVICE;
-		if (host->id == OMAP_MMC1_DEVID)
-			sync_dev = OMAP24XX_DMA_MMC1_TX;
-		else
-			sync_dev = OMAP24XX_DMA_MMC2_TX;
-	}
-
-	ret = omap_request_dma(sync_dev, "MMC/SD", mmc_omap_dma_cb,
-			host, &dma_ch);
+	ret = omap_request_dma(mmc_omap_get_dma_sync_dev(host, data), "MMC/SD",
+			       mmc_omap_dma_cb,host, &dma_ch);
 	if (ret != 0) {
-		dev_dbg(mmc_dev(host->mmc),
+		dev_err(mmc_dev(host->mmc),
 			"%s: omap_request_dma() failed with %d\n",
 			mmc_hostname(host->mmc), ret);
 		return ret;
 	}
 
 	host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
-			data->sg_len, host->dma_dir);
+			data->sg_len, mmc_omap_get_dma_dir(host, data));
 	host->dma_ch = dma_ch;
+	host->dma_sg_idx = 0;
 
-	if (!(data->flags & MMC_DATA_WRITE))
-		mmc_omap_config_dma_param(1, host, data);
-	else
-		mmc_omap_config_dma_param(0, host, data);
-
-	if ((data->blksz % 4) == 0)
-		omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
-			(data->blksz / 4), data->blocks, OMAP_DMA_SYNC_FRAME,
-			sync_dev, sync_dir);
-	else
-		/* REVISIT: The MMC buffer increments only when MSB is written.
-		 * Return error for blksz which is non multiple of four.
-		 */
-		return -EINVAL;
+	mmc_omap_config_dma_params(host, data, data->sg);
 
-	omap_start_dma(dma_ch);
 	return 0;
 }
 
@@ -763,7 +784,6 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 	host->data = req->data;
 
 	if (req->data == NULL) {
-		host->datadir = OMAP_MMC_DATADIR_NONE;
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		return 0;
 	}
@@ -772,9 +792,6 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 					| (req->data->blocks << 16));
 	set_data_timeout(host, req);
 
-	host->datadir = (req->data->flags & MMC_DATA_WRITE) ?
-			OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
-
 	if (host->use_dma) {
 		ret = mmc_omap_start_dma_transfer(host, req);
 		if (ret != 0) {
@@ -920,7 +937,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
-	int ret = 0, irq, reg;
+	int ret = 0, irq;
 	u32 hctl, capa;
 
 	if (pdata == NULL) {
@@ -1014,10 +1031,11 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 		else
 			host->dbclk_enabled = 1;
 
-#ifdef CONFIG_MMC_BLOCK_BOUNCE
-	mmc->max_phys_segs = 1;
-	mmc->max_hw_segs = 1;
-#endif
+	/* Since we do only SG emulation, we can have as many segs
+	 * as we want. */
+	mmc->max_phys_segs = 1024;
+	mmc->max_hw_segs = 1024;
+
 	mmc->max_blk_size = 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count = 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-- 
1.5.4.3
