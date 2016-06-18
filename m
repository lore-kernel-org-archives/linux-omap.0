From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 02/19] HSI: omap_ssi: do not reset module
Date: Sat, 18 Jun 2016 18:26:52 +0200
Message-ID: <1466267229-25012-3-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

module reset and power management rule setup
is already done by hwmod. Remove this cruft,
which predates hwmod.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.h      |  2 --
 drivers/hsi/controllers/omap_ssi_core.c | 19 +------------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index 7b4dec2c69ff..ba2f92722c09 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -138,7 +138,6 @@ struct gdd_trn {
  * @fck_rate: clock rate
  * @loss_count: To follow if we need to restore context or not
  * @max_speed: Maximum TX speed (Kb/s) set by the clients.
- * @sysconfig: SSI controller saved context
  * @gdd_gcr: SSI GDD saved context
  * @get_loss: Pointer to omap_pm_get_dev_context_loss_count, if any
  * @port: Array of pointers of the ports of the controller
@@ -158,7 +157,6 @@ struct omap_ssi_controller {
 	u32			loss_count;
 	u32			max_speed;
 	/* OMAP SSI Controller context */
-	u32			sysconfig;
 	u32			gdd_gcr;
 	int			(*get_loss)(struct device *dev);
 	struct omap_ssi_port	**port;
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index a3e0febfb64a..54943e439488 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -452,8 +452,6 @@ out_err:
 static int ssi_hw_init(struct hsi_controller *ssi)
 {
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
-	unsigned int i;
-	u32 val;
 	int err;
 
 	err = pm_runtime_get_sync(ssi->device.parent);
@@ -461,27 +459,12 @@ static int ssi_hw_init(struct hsi_controller *ssi)
 		dev_err(&ssi->device, "runtime PM failed %d\n", err);
 		return err;
 	}
-	/* Reseting SSI controller */
-	writel_relaxed(SSI_SOFTRESET, omap_ssi->sys + SSI_SYSCONFIG_REG);
-	val = readl(omap_ssi->sys + SSI_SYSSTATUS_REG);
-	for (i = 0; ((i < 20) && !(val & SSI_RESETDONE)); i++) {
-		msleep(20);
-		val = readl(omap_ssi->sys + SSI_SYSSTATUS_REG);
-	}
-	if (!(val & SSI_RESETDONE)) {
-		dev_err(&ssi->device, "SSI HW reset failed\n");
-		pm_runtime_put_sync(ssi->device.parent);
-		return -EIO;
-	}
 	/* Reseting GDD */
 	writel_relaxed(SSI_SWRESET, omap_ssi->gdd + SSI_GDD_GRST_REG);
 	/* Get FCK rate in KHz */
 	omap_ssi->fck_rate = DIV_ROUND_CLOSEST(ssi_get_clk_rate(ssi), 1000);
 	dev_dbg(&ssi->device, "SSI fck rate %lu KHz\n", omap_ssi->fck_rate);
-	/* Set default PM settings */
-	val = SSI_AUTOIDLE | SSI_SIDLEMODE_SMART | SSI_MIDLEMODE_SMART;
-	writel_relaxed(val, omap_ssi->sys + SSI_SYSCONFIG_REG);
-	omap_ssi->sysconfig = val;
+
 	writel_relaxed(SSI_CLK_AUTOGATING_ON, omap_ssi->sys + SSI_GDD_GCR_REG);
 	omap_ssi->gdd_gcr = SSI_CLK_AUTOGATING_ON;
 	pm_runtime_put_sync(ssi->device.parent);
-- 
2.8.1
