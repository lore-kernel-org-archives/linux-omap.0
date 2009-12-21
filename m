From: Alexander Shishkin <virtuoso@slind.org>
Subject: [PATCH v2 2/2] omap i2c: add a timeout to the busy waiting
Date: Mon, 21 Dec 2009 13:29:59 +0200
Message-ID: <1261394999-20857-3-git-send-email-virtuoso@slind.org>
References: <1261394999-20857-1-git-send-email-virtuoso@slind.org>
 <1261394999-20857-2-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23001 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbZLULbt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Dec 2009 06:31:49 -0500
In-Reply-To: <1261394999-20857-2-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org
Cc: nm@ti.com, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Alexander Shishkin <virtuoso@slind.org>

The errata 1.153 workaround is busy waiting on XUDF bit in interrupt
context, which may lead to kernel hangs. The problem can be reproduced
by running the bus with wrong (too high) speed.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
CC: linux-i2c@vger.kernel.org
CC: linux-omap@vger.kernel.org
CC: nm@ti.com
---
 drivers/i2c/busses/i2c-omap.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2d146ac..7d56a25 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -678,6 +678,8 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
  */
 static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(1);
+
 	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
 		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
@@ -685,6 +687,12 @@ static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
 			*err |= OMAP_I2C_STAT_XUDF;
 			return -ETIMEDOUT;
 		}
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev->dev, "timeout waiting on XUDF bit\n");
+			return 0;
+		}
+
 		cpu_relax();
 		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
 	}
-- 
1.6.3.3

