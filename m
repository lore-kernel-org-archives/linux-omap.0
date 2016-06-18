From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 10/19] HSI: omap_ssi_core: use pm_runtime_put instead of pm_runtime_put_sync
Date: Sat, 18 Jun 2016 18:27:00 +0200
Message-ID: <1466267229-25012-11-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

There is no need to disable the device synchronously, so
don't do it.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index a463420a0810..618db80577c3 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -58,7 +58,7 @@ static int ssi_debug_show(struct seq_file *m, void *p __maybe_unused)
 	seq_printf(m, "REVISION\t: 0x%08x\n",  readl(sys + SSI_REVISION_REG));
 	seq_printf(m, "SYSCONFIG\t: 0x%08x\n", readl(sys + SSI_SYSCONFIG_REG));
 	seq_printf(m, "SYSSTATUS\t: 0x%08x\n", readl(sys + SSI_SYSSTATUS_REG));
-	pm_runtime_put_sync(ssi->device.parent);
+	pm_runtime_put(ssi->device.parent);
 
 	return 0;
 }
@@ -112,7 +112,7 @@ static int ssi_debug_gdd_show(struct seq_file *m, void *p __maybe_unused)
 				readw(gdd + SSI_GDD_CLNK_CTRL_REG(lch)));
 	}
 
-	pm_runtime_put_sync(ssi->device.parent);
+	pm_runtime_put(ssi->device.parent);
 
 	return 0;
 }
@@ -193,7 +193,7 @@ void ssi_waketest(struct hsi_client *cl, unsigned int enable)
 	} else {
 		writel_relaxed(SSI_WAKE(0),
 				omap_ssi->sys +	SSI_CLEAR_WAKE_REG(port->num));
-		pm_runtime_put_sync(ssi->device.parent);
+		pm_runtime_put(ssi->device.parent);
 	}
 }
 EXPORT_SYMBOL_GPL(ssi_waketest);
@@ -217,7 +217,7 @@ static void ssi_gdd_complete(struct hsi_controller *ssi, unsigned int lch)
 	if (msg->ttype == HSI_MSG_READ) {
 		dir = DMA_FROM_DEVICE;
 		val = SSI_DATAAVAILABLE(msg->channel);
-		pm_runtime_put_sync(ssi->device.parent);
+		pm_runtime_put(omap_port->pdev);
 	} else {
 		dir = DMA_TO_DEVICE;
 		val = SSI_DATAACCEPT(msg->channel);
@@ -265,7 +265,7 @@ static void ssi_gdd_tasklet(unsigned long dev)
 	writel_relaxed(status_reg, sys + SSI_GDD_MPU_IRQ_STATUS_REG);
 	status_reg = readl(sys + SSI_GDD_MPU_IRQ_STATUS_REG);
 
-	pm_runtime_put_sync(ssi->device.parent);
+	pm_runtime_put(ssi->device.parent);
 
 	if (status_reg)
 		tasklet_hi_schedule(&omap_ssi->gdd_tasklet);
-- 
2.8.1
