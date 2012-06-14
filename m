From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 02/17] i2c: omap: decrease indentation level on data
 handling
Date: Thu, 14 Jun 2012 19:24:12 +0300
Message-ID: <1339691067-919-3-git-send-email-balbi@ti.com>
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

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   63 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9b532cd..39d5583 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -856,22 +856,7 @@ complete:
 							>> 8) & 0x3F;
 			}
 			while (num_bytes--) {
-				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
-				if (dev->buf_len) {
-					*dev->buf++ = w;
-					dev->buf_len--;
-					/*
-					 * Data reg in 2430, omap3 and
-					 * omap4 is 8 bit wide
-					 */
-					if (dev->flags &
-						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
-						if (dev->buf_len) {
-							*dev->buf++ = w >> 8;
-							dev->buf_len--;
-						}
-					}
-				} else {
+				if (!dev->buf_len) {
 					if (stat & OMAP_I2C_STAT_RRDY)
 						dev_err(dev->dev,
 							"RRDY IRQ while no data"
@@ -882,6 +867,21 @@ complete:
 								" requested\n");
 					break;
 				}
+
+				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
+				*dev->buf++ = w;
+				dev->buf_len--;
+				/*
+				 * Data reg in 2430, omap3 and
+				 * omap4 is 8 bit wide
+				 */
+				if (dev->flags &
+						OMAP_I2C_FLAG_16BIT_DATA_REG) {
+					if (dev->buf_len) {
+						*dev->buf++ = w >> 8;
+						dev->buf_len--;
+					}
+				}
 			}
 			omap_i2c_ack_stat(dev,
 				stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
@@ -898,22 +898,7 @@ complete:
 							& 0x3F;
 			}
 			while (num_bytes--) {
-				w = 0;
-				if (dev->buf_len) {
-					w = *dev->buf++;
-					dev->buf_len--;
-					/*
-					 * Data reg in 2430, omap3 and
-					 * omap4 is 8 bit wide
-					 */
-					if (dev->flags &
-						 OMAP_I2C_FLAG_16BIT_DATA_REG) {
-						if (dev->buf_len) {
-							w |= *dev->buf++ << 8;
-							dev->buf_len--;
-						}
-					}
-				} else {
+				if (!dev->buf_len) {
 					if (stat & OMAP_I2C_STAT_XRDY)
 						dev_err(dev->dev,
 							"XRDY IRQ while no "
@@ -925,6 +910,20 @@ complete:
 					break;
 				}
 
+				w = *dev->buf++;
+				dev->buf_len--;
+				/*
+				 * Data reg in 2430, omap3 and
+				 * omap4 is 8 bit wide
+				 */
+				if (dev->flags &
+						OMAP_I2C_FLAG_16BIT_DATA_REG) {
+					if (dev->buf_len) {
+						w |= *dev->buf++ << 8;
+						dev->buf_len--;
+					}
+				}
+
 				if ((dev->errata & I2C_OMAP3_1P153) &&
 				    errata_omap3_1p153(dev, &stat, &err))
 					goto complete;
-- 
1.7.10.4
