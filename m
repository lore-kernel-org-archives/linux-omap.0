From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [RFC] i2c-omap: Don't wait needlessly
Date: Tue, 21 Oct 2008 19:19:08 +0300
Message-ID: <12246059481717-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25286 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYJUQTR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 12:19:17 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9LGI1f6031812
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 11:19:14 -0500
Received: from kaali.localdomain (kaali.localdomain [192.168.239.7])
	by maxwell.research.nokia.com (Postfix) with ESMTP id 7582227B097
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 19:19:08 +0300 (EEST)
Received: from sailus by kaali.localdomain with local (Exim 4.63)
	(envelope-from <sakari.ailus@nokia.com>)
	id 1KsJwq-00013V-6D
	for linux-omap@vger.kernel.org; Tue, 21 Oct 2008 19:19:08 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When the I2C controller is initialised, software reset is performed to
the controller. I've never seen that taking more than 1 ns while the
msleep call causes excessive delays in I2C transfers.

Tested on OMAP 3.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b2b0e2f..b19b851 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -40,6 +40,8 @@
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
+/* no more busyloop in ns */
+#define OMAP_I2C_MINOR_TIMEOUT		10
 
 #define OMAP_I2C_REV_REG		0x00
 #define OMAP_I2C_IE_REG			0x04
@@ -255,6 +257,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	unsigned long internal_clk = 0;
 
 	if (!dev->rev1) {
+		int delay = 0;
+
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
@@ -262,6 +266,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
 			 OMAP_I2C_SYSS_RDONE)) {
+			if (delay < OMAP_I2C_MINOR_TIMEOUT) {
+				ndelay(1);
+				delay++;
+				continue;
+			} else if (delay == OMAP_I2C_MINOR_TIMEOUT) {
+				dev_warn(dev->dev, "minor timeout not enough");
+				delay++;
+			}
 			if (time_after(jiffies, timeout)) {
 				dev_warn(dev->dev, "timeout waiting "
 						"for controller reset\n");
-- 
1.5.0.6

