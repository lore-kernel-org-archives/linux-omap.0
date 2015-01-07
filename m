From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] can: c_can: use regmap_update_bits() to modify RAMINIT register
Date: Wed, 7 Jan 2015 16:32:42 +0200
Message-ID: <1420641162-8634-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: tomi.valkeinen@ti.com, linux-can@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

use of regmap_read() and regmap_write() in c_can_hw_raminit_syscon()
is not safe as the RAMINIT register can be shared between different drivers
at least for TI SoCs.

To make the modification atomic we switch to using regmap_update_bits().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/net/can/c_can/c_can_platform.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index f363972..364209a 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -110,6 +110,10 @@ static void c_can_hw_raminit_syscon(const struct c_can_priv *priv, bool enable)
 	 */
 	ctrl &= ~(1 << raminit->bits.start);
 	ctrl |= 1 << raminit->bits.done;
+
+	/* we can't use regmap_update_bits here as it will bypass the write
+	 * if START is already 0 and DONE is already 1.
+	 */
 	regmap_write(raminit->syscon, raminit->reg, ctrl);
 
 	ctrl &= ~(1 << raminit->bits.done);
@@ -118,12 +122,13 @@ static void c_can_hw_raminit_syscon(const struct c_can_priv *priv, bool enable)
 	if (enable) {
 		/* Set start bit and wait for the done bit. */
 		ctrl |= 1 << raminit->bits.start;
-		regmap_write(raminit->syscon, raminit->reg, ctrl);
+		regmap_update_bits(raminit->syscon, raminit->reg, mask, ctrl);
 
 		/* clear START bit if start pulse is needed */
 		if (raminit->needs_pulse) {
 			ctrl &= ~(1 << raminit->bits.start);
-			regmap_write(raminit->syscon, raminit->reg, ctrl);
+			regmap_update_bits(raminit->syscon, raminit->reg,
+					   mask, ctrl);
 		}
 
 		ctrl |= 1 << raminit->bits.done;
-- 
2.1.0

