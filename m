From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 07/19] HSI: omap_ssi_port: replace wkin_cken with atomic bitmap operations
Date: Sat, 18 Jun 2016 18:26:57 +0200
Message-ID: <1466267229-25012-8-git-send-email-sre@kernel.org>
References: <1466267229-25012-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466267229-25012-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This simplifies the code and avoids holding a spin_lock when
runtime pm calls are made. Once the irq_safe flag is removed
for omap_ssi's runtime pm, pm_runtime_get/put_sync can sleep,
which is a no-go while holding a spin_lock.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/omap_ssi.h      |  6 ++++--
 drivers/hsi/controllers/omap_ssi_port.c | 16 +++-------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index 88a523902a8f..6cdaad8805f7 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -35,6 +35,8 @@
 #define SSI_MAX_GDD_LCH		8
 #define SSI_BYTES_TO_FRAMES(x) ((((x) - 1) >> 2) + 1)
 
+#define SSI_WAKE_EN 0
+
 /**
  * struct omap_ssm_ctx - OMAP synchronous serial module (TX/RX) context
  * @mode: Bit transmission mode
@@ -75,7 +77,7 @@ struct omap_ssm_ctx {
  * @wake_irq: IRQ number for incoming wake line (-1 if none)
  * @wake_gpio: GPIO number for incoming wake line (-1 if none)
  * @pio_tasklet: Bottom half for PIO transfers and events
- * @wkin_cken: Keep track of clock references due to the incoming wake line
+ * @flags: flags to keep track of states
  * @wk_refcount: Reference count for output wake line
  * @sys_mpu_enable: Context for the interrupt enable register for irq 0
  * @sst: Context for the synchronous serial transmitter
@@ -99,7 +101,7 @@ struct omap_ssi_port {
 	struct gpio_desc	*wake_gpio;
 	struct tasklet_struct	pio_tasklet;
 	bool			wktest:1; /* FIXME: HACK to be removed */
-	bool			wkin_cken:1; /* Workaround */
+	unsigned long		flags;
 	unsigned int		wk_refcount;
 	/* OMAP SSI port context */
 	u32			sys_mpu_enable; /* We use only one irq */
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 9001b06312c3..0d3452393670 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -751,10 +751,8 @@ static int ssi_release(struct hsi_client *cl)
 		 * Drop the clock reference for the incoming wake line
 		 * if it is still kept high by the other side.
 		 */
-		if (omap_port->wkin_cken) {
+		if (test_and_clear_bit(SSI_WAKE_EN, &omap_port->flags))
 			pm_runtime_put_sync(omap_port->pdev);
-			omap_port->wkin_cken = 0;
-		}
 		pm_runtime_get_sync(omap_port->pdev);
 		/* Stop any SSI TX/RX without a client */
 		ssi_set_port_mode(omap_port, SSI_MODE_SLEEP);
@@ -981,12 +979,8 @@ static irqreturn_t ssi_wake_thread(int irq __maybe_unused, void *ssi_port)
 		 * This workaround will avoid breaking the clock reference
 		 * count when such a situation ocurrs.
 		 */
-		spin_lock(&omap_port->lock);
-		if (!omap_port->wkin_cken) {
-			omap_port->wkin_cken = 1;
+		if (!test_and_set_bit(SSI_WAKE_EN, &omap_port->flags))
 			pm_runtime_get_sync(omap_port->pdev);
-		}
-		spin_unlock(&omap_port->lock);
 		dev_dbg(&ssi->device, "Wake in high\n");
 		if (omap_port->wktest) { /* FIXME: HACK ! To be removed */
 			writel(SSI_WAKE(0),
@@ -1000,12 +994,8 @@ static irqreturn_t ssi_wake_thread(int irq __maybe_unused, void *ssi_port)
 				omap_ssi->sys + SSI_CLEAR_WAKE_REG(port->num));
 		}
 		hsi_event(port, HSI_EVENT_STOP_RX);
-		spin_lock(&omap_port->lock);
-		if (omap_port->wkin_cken) {
+		if (test_and_clear_bit(SSI_WAKE_EN, &omap_port->flags))
 			pm_runtime_put_sync(omap_port->pdev);
-			omap_port->wkin_cken = 0;
-		}
-		spin_unlock(&omap_port->lock);
 	}
 
 	return IRQ_HANDLED;
-- 
2.8.1
