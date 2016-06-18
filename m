From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 18/19] HSI: omap_ssi_port: use rpm autosuspend API
Date: Sat, 18 Jun 2016 18:27:08 +0200
Message-ID: <1466267229-25012-19-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Instead of immediately sending the SSI module to
sleep, wait some time in case of new incoming or
outgoing traffic.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_port.c | 68 +++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 7717c769c4dd..f95efabc27b0 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -126,7 +126,7 @@ static int ssi_debug_port_show(struct seq_file *m, void *p __maybe_unused)
 		seq_printf(m, "BUFFER_CH%d\t: 0x%08x\n", ch,
 				readl(base + SSI_SSR_BUFFER_CH_REG(ch)));
 	}
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -150,7 +150,7 @@ static int ssi_div_get(void *data, u64 *val)
 
 	pm_runtime_get_sync(omap_port->pdev);
 	*val = readl(omap_port->sst_base + SSI_SST_DIVISOR_REG);
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -166,7 +166,7 @@ static int ssi_div_set(void *data, u64 val)
 	pm_runtime_get_sync(omap_port->pdev);
 	writel(val, omap_port->sst_base + SSI_SST_DIVISOR_REG);
 	omap_port->sst.divisor = val;
-	pm_runtime_put_sync(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -245,7 +245,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 
 	if (!pm_runtime_active(omap_port->pdev)) {
 		dev_warn(&port->device, "ssi_start_dma called without runtime PM!\n");
-		pm_runtime_put(omap_port->pdev);
+		pm_runtime_put_autosuspend(omap_port->pdev);
 		return -EREMOTEIO;
 	}
 
@@ -254,7 +254,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 							DMA_FROM_DEVICE);
 		if (err < 0) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
-			pm_runtime_put(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
 			return err;
 		}
 		csdp = SSI_DST_BURST_4x32_BIT | SSI_DST_MEMORY_PORT |
@@ -271,7 +271,7 @@ static int ssi_start_dma(struct hsi_msg *msg, int lch)
 							DMA_TO_DEVICE);
 		if (err < 0) {
 			dev_dbg(&ssi->device, "DMA map SG failed !\n");
-			pm_runtime_put(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
 			return err;
 		}
 		csdp = SSI_SRC_BURST_4x32_BIT | SSI_SRC_MEMORY_PORT |
@@ -317,7 +317,7 @@ static int ssi_start_pio(struct hsi_msg *msg)
 
 	if (!pm_runtime_active(omap_port->pdev)) {
 		dev_warn(&port->device, "ssi_start_pio called without runtime PM!\n");
-		pm_runtime_put(omap_port->pdev);
+		pm_runtime_put_autosuspend(omap_port->pdev);
 		return -EREMOTEIO;
 	}
 
@@ -332,7 +332,7 @@ static int ssi_start_pio(struct hsi_msg *msg)
 						msg->ttype ? "write" : "read");
 	val |= readl(omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
 	writel(val, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 	msg->actual_len = 0;
 	msg->status = HSI_STATUS_PROCEEDING;
 
@@ -390,7 +390,8 @@ static int ssi_async_break(struct hsi_msg *msg)
 		spin_unlock_bh(&omap_port->lock);
 	}
 out:
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return err;
 }
@@ -428,7 +429,8 @@ static int ssi_async(struct hsi_msg *msg)
 		msg->status = HSI_STATUS_ERROR;
 	}
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 	dev_dbg(&port->device, "msg status %d ttype %d ch %d\n",
 				msg->status, msg->ttype, msg->channel);
 
@@ -530,7 +532,8 @@ static int ssi_setup(struct hsi_client *cl)
 	omap_port->ssr.mode = cl->rx_cfg.mode;
 out:
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return err;
 }
@@ -561,7 +564,7 @@ static int ssi_flush(struct hsi_client *cl)
 			continue;
 		writew_relaxed(0, omap_ssi->gdd + SSI_GDD_CCR_REG(i));
 		if (msg->ttype == HSI_MSG_READ)
-			pm_runtime_put(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
 		omap_ssi->gdd_trn[i].msg = NULL;
 	}
 	/* Flush all SST buffers */
@@ -585,7 +588,7 @@ static int ssi_flush(struct hsi_client *cl)
 	for (i = 0; i < omap_port->channels; i++) {
 		/* Release write clocks */
 		if (!list_empty(&omap_port->txqueue[i]))
-			pm_runtime_put(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
 		ssi_flush_queue(&omap_port->txqueue[i], NULL);
 		ssi_flush_queue(&omap_port->rxqueue[i], NULL);
 	}
@@ -595,7 +598,8 @@ static int ssi_flush(struct hsi_client *cl)
 	pinctrl_pm_select_default_state(omap_port->pdev);
 
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 
 	return 0;
 }
@@ -649,7 +653,9 @@ static int ssi_stop_tx(struct hsi_client *cl)
 	writel(SSI_WAKE(0), omap_ssi->sys + SSI_CLEAR_WAKE_REG(port->num));
 	spin_unlock_bh(&omap_port->wk_lock);
 
-	pm_runtime_put(omap_port->pdev); /* Release clocks */
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev); /* Release clocks */
+
 
 	return 0;
 }
@@ -675,7 +681,8 @@ static void ssi_transfer(struct omap_ssi_port *omap_port,
 		}
 	}
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
 }
 
 static void ssi_cleanup_queues(struct hsi_client *cl)
@@ -704,7 +711,8 @@ static void ssi_cleanup_queues(struct hsi_client *cl)
 			txbufstate |= (1 << i);
 			status |= SSI_DATAACCEPT(i);
 			/* Release the clocks writes, also GDD ones */
-			pm_runtime_put(omap_port->pdev);
+			pm_runtime_mark_last_busy(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
 		}
 		ssi_flush_queue(&omap_port->txqueue[i], cl);
 	}
@@ -758,8 +766,10 @@ static void ssi_cleanup_gdd(struct hsi_controller *ssi, struct hsi_client *cl)
 		 * Clock references for write will be handled in
 		 * ssi_cleanup_queues
 		 */
-		if (msg->ttype == HSI_MSG_READ)
-			pm_runtime_put(omap_port->pdev);
+		if (msg->ttype == HSI_MSG_READ) {
+			pm_runtime_mark_last_busy(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
+		}
 		omap_ssi->gdd_trn[i].msg = NULL;
 	}
 	tmp = readl_relaxed(omap_ssi->sys + SSI_GDD_MPU_IRQ_ENABLE_REG);
@@ -807,7 +817,7 @@ static int ssi_release(struct hsi_client *cl)
 		WARN_ON(omap_port->wk_refcount != 0);
 	}
 	spin_unlock_bh(&omap_port->lock);
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_put_sync(omap_port->pdev);
 
 	return 0;
 }
@@ -954,7 +964,8 @@ static void ssi_pio_complete(struct hsi_port *port, struct list_head *queue)
 	reg = readl(omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
 	if (msg->ttype == HSI_MSG_WRITE) {
 		/* Release clocks for write transfer */
-		pm_runtime_put(omap_port->pdev);
+		pm_runtime_mark_last_busy(omap_port->pdev);
+		pm_runtime_put_autosuspend(omap_port->pdev);
 	}
 	reg &= ~val;
 	writel_relaxed(reg, omap_ssi->sys + SSI_MPU_ENABLE_REG(port->num, 0));
@@ -998,7 +1009,9 @@ static irqreturn_t ssi_pio_thread(int irq, void *ssi_port)
 		/* TODO: sleep if we retry? */
 	} while (status_reg);
 
-	pm_runtime_put(omap_port->pdev);
+	pm_runtime_mark_last_busy(omap_port->pdev);
+	pm_runtime_put_autosuspend(omap_port->pdev);
+
 	return IRQ_HANDLED;
 }
 
@@ -1032,8 +1045,10 @@ static irqreturn_t ssi_wake_thread(int irq __maybe_unused, void *ssi_port)
 				omap_ssi->sys + SSI_CLEAR_WAKE_REG(port->num));
 		}
 		hsi_event(port, HSI_EVENT_STOP_RX);
-		if (test_and_clear_bit(SSI_WAKE_EN, &omap_port->flags))
-			pm_runtime_put_sync(omap_port->pdev);
+		if (test_and_clear_bit(SSI_WAKE_EN, &omap_port->flags)) {
+			pm_runtime_mark_last_busy(omap_port->pdev);
+			pm_runtime_put_autosuspend(omap_port->pdev);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -1222,6 +1237,9 @@ static int ssi_port_probe(struct platform_device *pd)
 	omap_port->dev = &port->device;
 
 	pm_runtime_irq_safe(omap_port->pdev);
+
+	pm_runtime_use_autosuspend(omap_port->pdev);
+	pm_runtime_set_autosuspend_delay(omap_port->pdev, 250);
 	pm_runtime_enable(omap_port->pdev);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1266,6 +1284,8 @@ static int ssi_port_remove(struct platform_device *pd)
 
 	omap_ssi->port[omap_port->port_id] = NULL;
 	platform_set_drvdata(pd, NULL);
+
+	pm_runtime_dont_use_autosuspend(&pd->dev);
 	pm_runtime_disable(&pd->dev);
 
 	return 0;
-- 
2.8.1
