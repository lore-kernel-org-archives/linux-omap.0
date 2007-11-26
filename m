From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 02/17] MMC: OMAP: New release dma and abort xfer functions
Date: Mon, 26 Nov 2007 12:01:09 -0400
Message-ID: <474AEDC5.4010608@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

From: Juha Yrjola <juha.yrjola@solidboot.com>

New functions to support MMC multislot:
mmc_omap_release_dma() and mmc_omap_abort_xfer().

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
---
 drivers/mmc/host/omap.c |   79 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 9887889..51b3bcb 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -343,26 +343,32 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
 }
 
 static void
+mmc_omap_release_dma(struct mmc_omap_host *host, struct mmc_data *data,
+		     int abort)
+{
+	enum dma_data_direction dma_data_dir;
+
+	BUG_ON(host->dma_ch < 0);
+	if (data->error)
+		omap_stop_dma(host->dma_ch);
+	/* Release DMA channel lazily */
+	mod_timer(&host->dma_timer, jiffies + HZ);
+	if (data->flags & MMC_DATA_WRITE)
+		dma_data_dir = DMA_TO_DEVICE;
+	else
+		dma_data_dir = DMA_FROM_DEVICE;
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
+		     dma_data_dir);
+}
+
+static void
 mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 {
-	if (host->dma_in_use) {
-		enum dma_data_direction dma_data_dir;
-
-		BUG_ON(host->dma_ch < 0);
-		if (data->error)
-			omap_stop_dma(host->dma_ch);
-		/* Release DMA channel lazily */
-		mod_timer(&host->dma_timer, jiffies + HZ);
-		if (data->flags & MMC_DATA_WRITE)
-			dma_data_dir = DMA_TO_DEVICE;
-		else
-			dma_data_dir = DMA_FROM_DEVICE;
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
-			     dma_data_dir);
-	}
+	if (host->dma_in_use)
+		mmc_omap_release_dma(host, data, data->error);
+
 	host->data = NULL;
 	host->sg_len = 0;
-	clk_disable(host->fclk);
 
 	/* NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
 	 * dozens of requests until the card finishes writing data.
@@ -370,8 +376,12 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 	 */
 
 	if (!data->stop) {
+		struct mmc_host *mmc;
+
 		host->mrq = NULL;
-		mmc_request_done(host->mmc, data->mrq);
+		mmc = host->mmc;
+		mmc_omap_release_slot(host->current_slot);
+		mmc_request_done(mmc, data->mrq);
 		return;
 	}
 
@@ -379,6 +389,32 @@ mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
 }
 
 static void
+mmc_omap_abort_xfer(struct mmc_omap_host *host, struct mmc_data *data)
+{
+	int loops;
+	u16 ie;
+
+	if (host->dma_in_use)
+		mmc_omap_release_dma(host, data, 1);
+
+	host->data = NULL;
+	host->sg_len = 0;
+
+	ie = OMAP_MMC_READ(host, IE);
+	OMAP_MMC_WRITE(host, IE, 0);
+	OMAP_MMC_WRITE(host, CMD, 1 << 7);
+	loops = 0;
+	while (!(OMAP_MMC_READ(host, STAT) & OMAP_MMC_STAT_END_OF_CMD)) {
+		udelay(1);
+		loops++;
+		if (loops == 100000)
+			break;
+	}
+	OMAP_MMC_WRITE(host, STAT, OMAP_MMC_STAT_END_OF_CMD);
+	OMAP_MMC_WRITE(host, IE, ie);
+}
+
+static void
 mmc_omap_end_of_data(struct mmc_omap_host *host, struct mmc_data *data)
 {
 	unsigned long flags;
@@ -455,9 +491,14 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 	}
 
 	if (host->data == NULL || cmd->error) {
+		struct mmc_host *mmc;
+
+		if (host->data != NULL)
+			mmc_omap_abort_xfer(host, host->data);
 		host->mrq = NULL;
-		clk_disable(host->fclk);
-		mmc_request_done(host->mmc, cmd->mrq);
+		mmc = host->mmc;
+		mmc_omap_release_slot(host->current_slot);
+		mmc_request_done(mmc, cmd->mrq);
 	}
 }
 
-- 1.5.3.GIT
