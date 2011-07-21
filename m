From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHV3 3/4] OMAP: I2C: Remove the SYSC register definition
Date: Thu, 21 Jul 2011 19:23:00 +0530
Message-ID: <1311256381-25548-4-git-send-email-shubhrajyoti@ti.com>
References: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab1GUNx0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 09:53:26 -0400
In-Reply-To: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com, santosh.shilimkar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

The SYSC register should not accessed in the driver removing the
define from the driver.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 8dc54d5..75bb62d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -63,7 +63,6 @@ enum {
 	OMAP_I2C_BUF_REG,
 	OMAP_I2C_CNT_REG,
 	OMAP_I2C_DATA_REG,
-	OMAP_I2C_SYSC_REG,
 	OMAP_I2C_CON_REG,
 	OMAP_I2C_OA_REG,
 	OMAP_I2C_SA_REG,
@@ -213,7 +212,6 @@ const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_BUF_REG] = 0x05,
 	[OMAP_I2C_CNT_REG] = 0x06,
 	[OMAP_I2C_DATA_REG] = 0x07,
-	[OMAP_I2C_SYSC_REG] = 0x08,
 	[OMAP_I2C_CON_REG] = 0x09,
 	[OMAP_I2C_OA_REG] = 0x0a,
 	[OMAP_I2C_SA_REG] = 0x0b,
@@ -234,7 +232,6 @@ const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_BUF_REG] = 0x94,
 	[OMAP_I2C_CNT_REG] = 0x98,
 	[OMAP_I2C_DATA_REG] = 0x9c,
-	[OMAP_I2C_SYSC_REG] = 0x20,
 	[OMAP_I2C_CON_REG] = 0xa4,
 	[OMAP_I2C_OA_REG] = 0xa8,
 	[OMAP_I2C_SA_REG] = 0xac,
@@ -281,7 +278,6 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
 		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 	}
-- 
1.7.1

