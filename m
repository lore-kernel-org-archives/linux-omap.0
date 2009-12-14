From: Alexander Shishkin <virtuoso@slind.org>
Subject: [PATCH] omap i2c: add timeout to a busy loop in isr
Date: Mon, 14 Dec 2009 15:21:04 +0200
Message-ID: <1260796864-8560-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44355 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113AbZLNNVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 08:21:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 drivers/i2c/busses/i2c-omap.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 75bf3ad..7617f18 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -803,15 +803,20 @@ complete:
 				 */
 
 				if (dev->rev <= OMAP_I2C_REV_ON_3430) {
-						while (!(stat & OMAP_I2C_STAT_XUDF)) {
-							if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
-								omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
-								err |= OMAP_I2C_STAT_XUDF;
-								goto complete;
-							}
-							cpu_relax();
-							stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+					unsigned long timeout = 10000;
+
+					while (!(stat & OMAP_I2C_STAT_XUDF) && --timeout) {
+						if (stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
+							omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+							err |= OMAP_I2C_STAT_XUDF;
+							goto complete;
 						}
+						cpu_relax();
+						stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+					}
+
+					if (!timeout)
+						dev_err(dev->dev, "timeout waiting on XUDF bit\n");
 				}
 
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
-- 
1.6.3.3

