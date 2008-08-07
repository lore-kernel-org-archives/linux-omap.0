From: "chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 1/1]  Patch for I2C transmit overflow error
Date: Thu, 7 Aug 2008 19:40:51 +0530 (IST)
Message-ID: <54576.192.168.10.89.1218118251.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35970 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbYHGOK6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Aug 2008 10:10:58 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m77EAqnw032084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Aug 2008 09:10:57 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m77EAmQj013734
	for <linux-omap@vger.kernel.org>; Thu, 7 Aug 2008 09:10:50 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch is to fix I2C transmit overflow error.
I guess it should fix the OSK5912 error. I dont have the board to test it.

Regards,
Chandra Shekhar

Signed-off-by: Chandra Shekhar< x0044955@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/busses/i2c-omap.c	2008-08-07
19:30:00.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/busses/i2c-omap.c	2008-08-07 19:30:19.000000000
+0530
@@ -661,6 +661,7 @@
 				}
 			}
 			omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR));
+			continue;
 		}
 		if (stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR)) {
 			u8 num_bytes = 1;
@@ -694,13 +695,14 @@
 				omap_i2c_write_reg(dev, OMAP_I2C_DATA_REG, w);
 			}
 			omap_i2c_ack_stat(dev, stat & (OMAP_I2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
+			continue;
 		}
 		if (stat & OMAP_I2C_STAT_ROVR) {
 			dev_err(dev->dev, "Receive overrun\n");
 			dev->cmd_err |= OMAP_I2C_STAT_ROVR;
 		}
 		if (stat & OMAP_I2C_STAT_XUDF) {
-			dev_err(dev->dev, "Transmit overflow\n");
+			dev_err(dev->dev, "Transmit underflow\n");
 			dev->cmd_err |= OMAP_I2C_STAT_XUDF;
 		}
 	}


