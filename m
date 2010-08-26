From: Mathias Nyman <mathias.nyman@nokia.com>
Subject: [PATCH] i2c-omap: Make sure i2c bus is free before setting it to idle
Date: Thu, 26 Aug 2010 10:36:44 +0300
Message-ID: <1282808204-1689-1-git-send-email-mathias.nyman@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39459 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0HZHhE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 03:37:04 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o7Q7aw78027216
	for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 10:37:00 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@nokia.com>

If the i2c bus receives an interrupt with both BB (bus busy) and
ARDY (register access ready) statuses set during the tranfer of the last message
the bus was put to idle while still busy.

This caused bus to timeout.

Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 824ac1c..3271ce1 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -602,6 +602,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	if (r == 0)
 		r = num;
+
+	omap_i2c_wait_for_bb(dev);
 out:
 	omap_i2c_idle(dev);
 	return r;
-- 
1.5.6.5

