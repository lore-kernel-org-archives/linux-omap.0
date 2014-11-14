From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 1/8] can: c_can: Add timeout to c_can_hw_raminit_ti()
Date: Fri, 14 Nov 2014 19:09:44 +0100
Message-ID: <1415988591-6032-2-git-send-email-mkl@pengutronix.de>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

TI's RAMINIT DONE mechanism is buggy on AM43xx SoC and may not always
be set after the START bit is set. Although it seems to work fine even
in that case. So add a timeout mechanism to c_can_hw_raminit_wait_ti().
Don't bail out in that failure case but just print an error message.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index fb279d6ae484..106c203fc5eb 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -75,10 +75,19 @@ static void c_can_plat_write_reg_aligned_to_32bit(const struct c_can_priv *priv,
 static void c_can_hw_raminit_wait_ti(const struct c_can_priv *priv, u32 mask,
 				  u32 val)
 {
+	int timeout = 0;
+
 	/* We look only at the bits of our instance. */
 	val &= mask;
-	while ((readl(priv->raminit_ctrlreg) & mask) != val)
+	while ((readl(priv->raminit_ctrlreg) & mask) != val) {
 		udelay(1);
+		timeout++;
+
+		if (timeout == 1000) {
+			dev_err(&priv->dev->dev, "%s: time out\n", __func__);
+			break;
+		}
+	}
 }
 
 static void c_can_hw_raminit_ti(const struct c_can_priv *priv, bool enable)
-- 
2.1.1

