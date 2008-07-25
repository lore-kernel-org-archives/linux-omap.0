From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 2/3]HSMMC fix for hotplug scenario with I/O in progress
Date: Fri, 25 Jul 2008 16:03:21 +0530 (IST)
Message-ID: <40116.192.168.10.88.1216982001.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:57110 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbYGYKd2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jul 2008 06:33:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

ARM: OMAP3: HSMMC fix for hotplug scenario.

This patch fixes the inconsistancy noted if the card is removed from the slot
duing an active I/O.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
Signed-off-by: Romit Dasgupta <romit@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-omap-ti.git-07142008.orig/drivers/mmc/host/omap_hsmmc.c	2008-07-17
16:07:05.000000000 +0530
+++ linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c	2008-07-17
16:08:48.000000000 +0530
@@ -85,6 +85,7 @@
 #define INIT_STREAM_CMD		0x00000000
 #define DUAL_VOLT_OCR_BIT	7
 #define SRC			(1 << 25)
+#define SRD			(1 << 26)

 #define OMAP_MMC1_DEVID		1
 #define OMAP_MMC2_DEVID		2
@@ -301,6 +302,7 @@ static void mmc_dma_cleanup(struct mmc_o
 static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 {
 	struct mmc_omap_host *host = dev_id;
+	struct mmc_data *data;
 	int end_cmd = 0, end_trans = 0, status;

 	if (host->cmd == NULL && host->data == NULL) {
@@ -309,6 +311,7 @@ static irqreturn_t mmc_omap_irq(int irq,
 		return IRQ_HANDLED;
 	}

+	data = host->data;
 	status = OMAP_HSMMC_READ(host->base, STAT);
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);

@@ -356,7 +359,7 @@ static irqreturn_t mmc_omap_irq(int irq,
 	if (end_cmd || (status & CC))
 		mmc_omap_cmd_done(host, host->cmd);
 	if (end_trans || (status & TC))
-		mmc_omap_xfer_done(host, host->data);
+		mmc_omap_xfer_done(host, data);

 	return IRQ_HANDLED;
 }
@@ -436,8 +439,12 @@ static void mmc_omap_detect(struct work_
 				host->mmc->ios.vdd = vdd;
 		}
 		mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-	} else
+	} else {
+		OMAP_HSMMC_WRITE(host->base, SYSCTL,
+			OMAP_HSMMC_READ(host->base, SYSCTL) | SRD);
+		while (OMAP_HSMMC_READ(host->base, SYSCTL) & SRD) ;
 		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
+	}
 }

 /*


