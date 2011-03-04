From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] i2c-omap: Program I2C_WE on OMAP4 to enable i2c wakeup
Date: Fri,  4 Mar 2011 19:02:24 +0530
Message-ID: <1299245544-23790-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35850 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab1CDNcn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 08:32:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ben-linux@fluff.org, paul@pwsan.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

For the I2C module to be wakeup capable, programming I2C_WE
register (which was skipped for OMAP4430) is needed
even on OMAP4.
This fixes i2c controller timeouts which were seen recently
with the static dependency being cleared between MPU and
L4PER clockdomains.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
Patch is based on 2.6.38-rc7 kernel.

 drivers/i2c/busses/i2c-omap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 829a2a1..58a58c7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -378,9 +378,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
 			dev->westate = OMAP_I2C_WE_ALL;
-			if (dev->rev < OMAP_I2C_REV_ON_4430)
-				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-								dev->westate);
+			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-- 
1.7.0.4

