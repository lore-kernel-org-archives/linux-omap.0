From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/10] OMAP: HSMMC: Do dma cleanup also with data CRC errors
Date: Thu, 12 Mar 2009 18:22:59 +0200
Message-ID: <20090312162259.19421.70608.sendpatchset@ahunter-laptop>
References: <20090312162252.19421.34019.sendpatchset@ahunter-laptop>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757563AbZCLQX5@vger.kernel.org>
In-Reply-To: <20090312162252.19421.34019.sendpatchset@ahunter-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

>From 93cfc8673d2f41527c1786de8f061bef88f9ac28 Mon Sep 17 00:00:00 2001
From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Date: Fri, 5 Dec 2008 12:31:46 +0200
Subject: [PATCH] OMAP: HSMMC: Do dma cleanup also with data CRC errors

Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 576bfa7..5ff2ca2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -332,9 +332,9 @@ mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
 /*
  * DMA clean up for command errors
  */
-static void mmc_dma_cleanup(struct mmc_omap_host *host)
+static void mmc_dma_cleanup(struct mmc_omap_host *host, int errno)
 {
-	host->data->error = -ETIMEDOUT;
+	host->data->error = errno;
 
 	if (host->use_dma && host->dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
@@ -439,7 +439,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 				end_cmd = 1;
 			}
 			if (host->data) {
-				mmc_dma_cleanup(host);
+				mmc_dma_cleanup(host, -ETIMEDOUT);
 				mmc_omap_reset_controller_fsm(host, SRD);
 			}
 		}
@@ -447,9 +447,9 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 			(status & DATA_CRC)) {
 			if (host->data) {
 				if (status & DATA_TIMEOUT)
-					mmc_dma_cleanup(host);
+					mmc_dma_cleanup(host, -ETIMEDOUT);
 				else
-					host->data->error = -EILSEQ;
+					mmc_dma_cleanup(host, -EILSEQ);
 				mmc_omap_reset_controller_fsm(host, SRD);
 				end_trans = 1;
 			}
-- 
1.5.6.3
