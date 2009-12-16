From: Alexander Shishkin <virtuoso@slind.org>
Subject: [PATCH 1/2] omap i2c: make errata 1.153 workaround a separate function
Date: Wed, 16 Dec 2009 15:43:04 +0200
Message-ID: <1260970986-26613-3-git-send-email-virtuoso@slind.org>
References: <1260970986-26613-1-git-send-email-virtuoso@slind.org>
 <1260970986-26613-2-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22502 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbZLPNoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 08:44:39 -0500
In-Reply-To: <1260970986-26613-2-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Alexander Shishkin <ext-alexander.shishkin@nokia.com>

From: Alexander Shishkin <ext-alexander.shishkin@nokia.com>

This is to avoid insanely long lines and levels of indentation.

Signed-off-by: Alexander Shishkin <ext-alexander.shishkin@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   43 ++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 75bf3ad..ad8242a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -671,6 +671,27 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
 #define omap_i2c_rev1_isr		NULL
 #endif
 
+/*
+ * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
+ * data to DATA_REG. Otherwise some data bytes can be lost while transferring
+ * them from the memory to the I2C interface.
+ */
+static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
+{
+	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
+		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
+			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
+							OMAP_I2C_STAT_XDR));
+			*err |= OMAP_I2C_STAT_XUDF;
+			return -1;
+		}
+		cpu_relax();
+		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	}
+
+	return 0;
+}
+
 static irqreturn_t
 omap_i2c_isr(int this_irq, void *dev_id)
 {
@@ -794,25 +815,9 @@ complete:
 					break;
 				}
 
-				/*
-				 * OMAP3430 Errata 1.153: When an XRDY/XDR
-				 * is hit, wait for XUDF before writing data
-				 * to DATA_REG. Otherwise some data bytes can
-				 * be lost while transferring them from the
-				 * memory to the I2C interface.
-				 */
-
-				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
-						while (!(stat & OMAP_I2C_STAT_XUDF)) {
-							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-								err |= OMAP_I2C_STAT_XUDF;
-								goto complete;
-							}
-							cpu_relax();
-							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-						}
-				}
+				if (dev->rev <= OMAP_I2C_REV_ON_3430 &&
+				    omap3430_workaround(dev, &stat, &err))
+					goto complete;
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
-- 
1.6.3.3

