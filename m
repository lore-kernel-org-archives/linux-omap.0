From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 5/8] can: c_can: Add support for START pulse in RAMINIT sequence
Date: Fri, 14 Nov 2014 19:09:48 +0100
Message-ID: <1415988591-6032-6-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

Some SoCs e.g. (TI DRA7xx) need a START pulse to start the
RAMINIT sequence i.e. START bit must be set and cleared before
checking for the DONE bit status.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.h          | 1 +
 drivers/net/can/c_can/c_can_platform.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 28a73d14ea8d..8acdc7fa4792 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -188,6 +188,7 @@ struct c_can_raminit {
 	struct regmap *syscon;	/* for raminit ctrl. reg. access */
 	unsigned int reg;	/* register index within syscon */
 	struct raminit_bits bits;
+	bool needs_pulse;
 };
 
 /* c_can private data structure */
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 1fbfa1d59c29..41fa460c3592 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -120,6 +120,12 @@ static void c_can_hw_raminit_syscon(const struct c_can_priv *priv, bool enable)
 		ctrl |= 1 << raminit->bits.start;
 		regmap_write(raminit->syscon, raminit->reg, ctrl);
 
+		/* clear START bit if start pulse is needed */
+		if (raminit->needs_pulse) {
+			ctrl &= ~(1 << raminit->bits.start);
+			regmap_write(raminit->syscon, raminit->reg, ctrl);
+		}
+
 		ctrl |= 1 << raminit->bits.done;
 		c_can_hw_raminit_wait_syscon(priv, mask, ctrl);
 	}
@@ -325,6 +331,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 			}
 
 			raminit->bits = drvdata->raminit_bits[id];
+			raminit->needs_pulse = drvdata->raminit_pulse;
 
 			priv->raminit = c_can_hw_raminit_syscon;
 		} else {
-- 
2.1.1

