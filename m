From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 13/19] HSI: omap_ssi_port: avoid pm_runtime_get_sync in ssi_start_dma and ssi_start_pio
Date: Sat, 18 Jun 2016 18:27:03 +0200
Message-ID: <1466267229-25012-14-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

These functions may be called from atomic context,
so avoid synchronous runtime pm calls.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_port.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index f62f0c482cea..f7ed59ba3b2c 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -225,11 +225,21 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 	u32 d_addr;
 	u32 tmp;
 
+	/* Hold clocks during the transfer */
+	pm_runtime_get(omap_port->pdev);
+
+	if (!pm_runtime_active(omap_port->pdev)) {
+		dev_warn(&port->device, "ssi_start_dma called without runtime PM!\n");
+		pm_runtime_put(omap_port->pdev);
+		return -EREMOTEIO;
+	}
+
 	if (msg->ttype == HSI_MSG_READ) {
 		err = dma_map_sg(&ssi->device, msg->sgt.sgl, msg->sgt.nents,
 							DMA_FROM_DEVICE);
 		if (err < 0) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
+			pm_runtime_put(omap_port->pdev);
 			return err;
 		}
 		csdp = SSI_DST_BURST_4x32_BIT | SSI_DST_MEMORY_PORT |
@@ -246,6 +256,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 							DMA_TO_DEVICE);
 		if (err < 0) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
+			pm_runtime_put(omap_port->pdev);
 			return err;
 		}
 		csdp = SSI_SRC_BURST_4x32_BIT | SSI_SRC_MEMORY_PORT |
@@ -261,9 +272,6 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 	dev_dbg(&ssi->device, "lch %d cdsp %08x ccr %04x s_addr %08x d_addr %08x\n",
 		lch, csdp, ccr, s_addr, d_addr);
 
-	/* Hold clocks during the transfer */
-	pm_runtime_get_sync(omap_port->pdev);
-
 	writew_relaxed(csdp, gdd + SSI_GDD_CSDP_REG(lch));
 	writew_relaxed(SSI_BLOCK_IE | SSI_TOUT_IE, gdd + SSI_GDD_CICR_REG(lch));
 	writel_relaxed(d_addr, gdd + SSI_GDD_CDSA_REG(lch));
@@ -290,11 +298,18 @@ static int ssi_start_pio(struct hsi_msg *msg)
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
 	u32 val;
 
-	pm_runtime_get_sync(omap_port->pdev);
+	pm_runtime_get(omap_port->pdev);
+
+	if (!pm_runtime_active(omap_port->pdev)) {
+		dev_warn(&port->device, "ssi_start_pio called without runtime PM!\n");
+		pm_runtime_put(omap_port->pdev);
+		return -EREMOTEIO;
+	}
+
 	if (msg->ttype == HSI_MSG_WRITE) {
 		val = SSI_DATAACCEPT(msg->channel);
 		/* Hold clocks for pio writes */
-		pm_runtime_get_sync(omap_port->pdev);
+		pm_runtime_get(omap_port->pdev);
 	} else {
 		val = SSI_DATAAVAILABLE(msg->channel) | SSI_ERROROCCURED;
 	}
@@ -302,7 +317,7 @@ static int ssi_start_pio(struct hsi_msg *msg)
 						msg->ttype ? "write" : "read");
 	val |= readl(omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
 	writel(val, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put(omap_port->pdev);
 	msg->actual_len = 0;
 	msg->status = HSI_STATUS_PROCEEDING;
 
@@ -388,6 +403,8 @@ static int ssi_async(struct hsi_msg *msg)
 		queue = &omap_port->rxqueue[msg->channel];
 	}
 	msg->status = HSI_STATUS_QUEUED;
+
+	pm_runtime_get_sync(omap_port->pdev);
 	spin_lock_bh(&omap_port->lock);
 	list_add_tail(&msg->link, queue);
 	err = ssi_start_transfer(queue);
@@ -396,6 +413,7 @@ static int ssi_async(struct hsi_msg *msg)
 		msg->status = HSI_STATUS_ERROR;
 	}
 	spin_unlock_bh(&omap_port->lock);
+	pm_runtime_put(omap_port->pdev);
 	dev_dbg(&port->device, "msg status %d ttype %d ch %d\n",
 				msg->status, msg->ttype, msg->channel);
 
-- 
2.8.1
