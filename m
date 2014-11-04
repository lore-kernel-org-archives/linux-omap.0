From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 5/8] net: can: c_can: Add support for START pulse in RAMINIT sequence
Date: Tue, 4 Nov 2014 12:20:58 +0200
Message-ID: <1415096461-25576-6-git-send-email-rogerq@ti.com>
References: <1415096461-25576-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1415096461-25576-1-git-send-email-rogerq@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: wsa@the-dreams.de, tony@atomide.com, tglx@linutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Some SoCs e.g. (TI DRA7xx) need a START pulse to start the
RAMINIT sequence i.e. START bit must be set and cleared before
checking for the DONE bit status.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/net/can/c_can/c_can_platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index d0ce439..ef1f5ce 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -124,6 +124,12 @@ static void c_can_hw_raminit_syscon(const struct c_can_priv *priv, bool enable)
 		ctrl |= 1 << start_bit;
 		regmap_write(raminit->syscon, raminit->reg, ctrl);
 
+		/* clear START bit if start pulse is needed */
+		if (priv->drvdata->raminit_pulse) {
+			ctrl &= ~(1 << start_bit);
+			regmap_write(raminit->syscon, raminit->reg, ctrl);
+		}
+
 		ctrl |= 1 << done_bit;
 		c_can_hw_raminit_wait_syscon(priv, mask, ctrl);
 	}
-- 
1.8.3.2
