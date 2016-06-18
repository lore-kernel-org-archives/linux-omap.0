From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 15/19] HSI: omap_ssi_port: replace pm_runtime_put_sync with non-sync variant
Date: Sat, 18 Jun 2016 18:27:05 +0200
Message-ID: <1466267229-25012-16-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

There is no need to wait for hardware to really reach idle states,
so just release runtime PM asynchronously.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_port.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 92064221dbab..aef5a8666d48 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -375,7 +375,7 @@ static int ssi_async_break(struct hsi_msg *msg)
 		spin_unlock_bh(&omap_port->lock);
 	}
 out:
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put(omap_port->pdev);
 
 	return err;
 }
@@ -515,7 +515,7 @@ static int ssi_setup(struct hsi_client *cl)
 	omap_port->ssr.mode = cl->rx_cfg.mode;
 out:
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put(omap_port->pdev);
 
 	return err;
 }
@@ -546,7 +546,7 @@ static int ssi_flush(struct hsi_client *cl)
 			continue;
 		writew_relaxed(0, omap_ssi->gdd + SSI_GDD_CCR_REG(i));
 		if (msg->ttype == HSI_MSG_READ)
-			pm_runtime_put_sync(omap_port->pdev);
+			pm_runtime_put(omap_port->pdev);
 		omap_ssi->gdd_trn[i].msg = NULL;
 	}
 	/* Flush all SST buffers */
@@ -570,7 +570,7 @@ static int ssi_flush(struct hsi_client *cl)
 	for (i = 0; i < omap_port->channels; i++) {
 		/* Release write clocks */
 		if (!list_empty(&omap_port->txqueue[i]))
-			pm_runtime_put_sync(omap_port->pdev);
+			pm_runtime_put(omap_port->pdev);
 		ssi_flush_queue(&omap_port->txqueue[i], NULL);
 		ssi_flush_queue(&omap_port->rxqueue[i], NULL);
 	}
@@ -580,7 +580,7 @@ static int ssi_flush(struct hsi_client *cl)
 	pinctrl_pm_select_default_state(omap_port->pdev);
 
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put(omap_port->pdev);
 
 	return 0;
 }
@@ -687,7 +687,7 @@ static void ssi_cleanup_queues(struct hsi_client *cl)
 			txbufstate |= (1 << i);
 			status |= SSI_DATAACCEPT(i);
 			/* Release the clocks writes, also GDD ones */
-			pm_runtime_put_sync(omap_port->pdev);
+			pm_runtime_put(omap_port->pdev);
 		}
 		ssi_flush_queue(&omap_port->txqueue[i], cl);
 	}
@@ -742,7 +742,7 @@ static void ssi_cleanup_gdd(struct hsi_controller *ssi, struct hsi_client *cl)
 		 * ssi_cleanup_queues
 		 */
 		if (msg->ttype == HSI_MSG_READ)
-			pm_runtime_put_sync(omap_port->pdev);
+			pm_runtime_put(omap_port->pdev);
 		omap_ssi->gdd_trn[i].msg = NULL;
 	}
 	tmp = readl_relaxed(omap_ssi->sys + SSI_GDD_MPU_IRQ_ENABLE_REG);
@@ -790,7 +790,7 @@ static int ssi_release(struct hsi_client *cl)
 		WARN_ON(omap_port->wk_refcount != 0);
 	}
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put(omap_port->pdev);
 
 	return 0;
 }
@@ -937,7 +937,7 @@ static void ssi_pio_complete(struct hsi_port *port, struct list_head *queue)
 	reg = readl(omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
 	if (msg->ttype == HSI_MSG_WRITE) {
 		/* Release clocks for write transfer */
-		pm_runtime_put_sync(omap_port->pdev);
+		pm_runtime_put(omap_port->pdev);
 	}
 	reg &= ~val;
 	writel_relaxed(reg, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
-- 
2.8.1
