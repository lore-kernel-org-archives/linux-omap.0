From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 09/17] i2c: omap: ack IRQ in parts
Date: Thu, 14 Jun 2012 19:24:19 +0300
Message-ID: <1339691067-919-10-git-send-email-balbi@ti.com>
References: <1339691067-919-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339691067-919-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ben-linux@fluff.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, w.sang@pengutronix.de, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

According to flow diagrams on OMAP TRMs,
we should ACK the IRQ as they happen.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a035d16..83ae06a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -894,21 +894,19 @@ omap_i2c_isr(int this_irq, void *dev_id)
 		}
 
 complete:
-		/*
-		 * Ack the stat in one go, but [R/X]DR and [R/X]RDY should be
-		 * acked after the data operation is complete.
-		 * Ref: TRM SWPU114Q Figure 18-31
-		 */
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, stat &
-				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
-				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-
-		if (stat & OMAP_I2C_STAT_NACK)
+		if (stat & OMAP_I2C_STAT_NACK) {
 			err |= OMAP_I2C_STAT_NACK;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
+		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_NACK);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		/*
@@ -989,12 +987,18 @@ complete:
 
 		if (stat & OMAP_I2C_STAT_ROVR) {
 			dev_err(dev->dev, "Receive overrun\n");
-			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
+			err |= OMAP_I2C_STAT_ROVR;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ROVR);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 
 		if (stat & OMAP_I2C_STAT_XUDF) {
 			dev_err(dev->dev, "Transmit underflow\n");
-			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
+			err |= OMAP_I2C_STAT_XUDF;
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XUDF);
+			omap_i2c_complete_cmd(dev, err);
+			return IRQ_HANDLED;
 		}
 	} while (stat);
 
-- 
1.7.10.4
