From: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] OMAP3 : Fix I2C lockup during timeout/error cases
Date: Fri, 11 Dec 2009 11:09:08 +0530
Message-ID: <1260509948-12774-1-git-send-email-manjugk@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "Varadarajan, Charu Latha" <charu-l0cyMroinI0@public.gmane.org>, "George, Harith" <harith-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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


Tested on Zoom2, Zoom3, 3430SDP and 3630SDP

Signed-off-by: Manjunatha GK <manjugk-l0cyMroinI0@public.gmane.org>
Signed-off-by: George, Harith<harith-l0cyMroinI0@public.gmane.org>
Acked-by: Varadarajan, Charu Latha<charu-l0cyMroinI0@public.gmane.org>
---
v1 : Initital version
v2 : Removed delay since time taken for disabling I2C controller is zero
     jiffies

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
