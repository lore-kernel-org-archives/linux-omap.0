From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [RFC] ARM: OMAP2+ i2c NACK without STP
Date: Tue, 14 Jun 2011 12:05:59 +0200
Message-ID: <1308045959-24269-1-git-send-email-j.weitzel@phytec.de>
References: <87oc30t81u.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:37885 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908Ab1FNKGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 06:06:07 -0400
In-Reply-To: <87oc30t81u.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, b-cousson@ti.com, andy.green@linaro.org, patches@linaro.org
Cc: andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, khilman@ti.com, Jan Weitzel <j.weitzel@phytec.de>

On OMAP4 OMAP_I2C_STAT_NACK is causing a timeout on the next access.
The isr cleans all flags in OMAP_I2C_CON_REG by setting OMAP_I2C_CON_STP
OMAP_I2C_CON_STP is also set in omap_i2c_xfer_msg on the last message.

According to the TI TSR the sequence for OMAP_I2C_STAT_NACK and
OMAP_I2C_STAT_AL are nearly the same.
Removing the OMAP_I2C_CON_STP part in the isr fix the problem.
Tested on OMAP4430 and OMAP3530 (here NACK was not a problem)

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 58a58c7..670f2a2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -836,11 +836,9 @@ complete:
 				~(OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
 				OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
 
-		if (stat & OMAP_I2C_STAT_NACK) {
+		if (stat & OMAP_I2C_STAT_NACK)
 			err |= OMAP_I2C_STAT_NACK;
-			omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
-					   OMAP_I2C_CON_STP);
-		}
+
 		if (stat & OMAP_I2C_STAT_AL) {
 			dev_err(dev->dev, "Arbitration lost\n");
 			err |= OMAP_I2C_STAT_AL;
-- 
1.7.0.4

