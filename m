From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
Date: Thu, 10 Dec 2009 18:49:24 +0530
Message-ID: <1260451164-9459-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758043AbZLJNNt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Dec 2009 08:13:49 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBADDrKq019904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 07:13:55 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Nishanth Menon <nm@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Varadarajan, Charu Latha" <charu@ti.com>, "George, Harith" <harith@ti.com>

Current OMAP3 I2C driver code does not follow the correct sequence for soft
reset. Due to this, lock up issues are reported during timeout/error cases.

This patch fixes above issue by disabling I2C controller as per OMAP3430 TRM
for soft reset. As per TRM, I2C controller needs to be disabled as a first
step during soft reset.

Here is correct soft reset sequence:
a. Ensure that the module is disabled
(clear the I2Ci.I2C_CON[15] I2C_EN bit to 0).
b. Set the I2Ci.I2C_SYSC[1] SRST bit to 1.
c. Enable the module by setting I2Ci.I2C_CON[15] I2C_EN bit to 1.
d. Check the I2Ci.I2C_SYSS[0] RDONE bit until it is set to 1 to
indicate the software reset is complete.

v1 : Initital version
v2 : Removed delay since time taken for disabling I2C controller is zero
     jiffies

Tested on Zoom2 and Zoom3 

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: George, Harith<harith@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 827da08..74620c0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -265,6 +265,11 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long internal_clk = 0;
 
 	if (dev->rev >= OMAP_I2C_REV_2) {
+		/* Disable I2C controller before soft reset */
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
+			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
+				~(OMAP_I2C_CON_EN));
+
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
-- 
1.6.0.4

