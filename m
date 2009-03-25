From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PM PATCH] OMAP3: PM: Save and restore I2C wakeup sources
Date: Wed, 25 Mar 2009 15:38:20 +0200
Message-ID: <1237988300-25985-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62511 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbZCYNir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 09:38:47 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2PDc6l4021986
	for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 08:38:46 -0500
Received: from localhost.localdomain (esdhcp043221.research.nokia.com [172.21.43.221])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2PDcKRV031738
	for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 15:38:21 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Save and restore I2C wakeup sources.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 50f3285..5ce055c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -183,6 +183,7 @@ struct omap_i2c_dev {
 	u16			sclhstate;
 	u16			bufstate;
 	u16			syscstate;
+	u16			westate;
 };
 
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
@@ -242,6 +243,7 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 	}
 	dev->idle = 0;
 	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
@@ -316,8 +318,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * WFI instruction.
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							OMAP_I2C_WE_ALL);
+			dev->westate = OMAP_I2C_WE_ALL;
+			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 
 		}
 	}
-- 
1.5.4.3

