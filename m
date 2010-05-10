From: Alexander Shishkin <virtuoso@slind.org>
Subject: [PATCH v3] omap i2c: add a timeout to the busy waiting
Date: Mon, 10 May 2010 13:02:27 +0300
Message-ID: <1273485747-31533-1-git-send-email-virtuoso@slind.org>
References: <4BAB7551.6040203@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33484 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab0EJKDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 06:03:13 -0400
In-Reply-To: <4BAB7551.6040203@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: ben-linux@fluff.org, nm@ti.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>

The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
context, which may lead to kernel hangs. The problem can be reproduced
by running the bus with wrong (too high) speed.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index ef73483..00fd02e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -763,17 +763,25 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
  */
 static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 {
-	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
+	unsigned long timeout = 10000;
+
+	while (--timeout && !(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
 							OMAP_I2C_STAT_XDR));
 			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
+
 		cpu_relax();
 		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
 
+	if (!timeout) {
+		dev_err(dev->dev, "timeout waiting on XUDF bit\n");
+		return 0;
+	}
+
 	return 0;
 }
 
-- 
1.7.1.1.g15764

