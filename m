From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] [RFC] Remove the debug print noise
Date: Mon,  2 Aug 2010 18:17:51 +0530
Message-ID: <1280753271-21182-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756Ab0HBMr4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Aug 2010 08:47:56 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o72Clrnm014812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 Aug 2010 07:47:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

This patch intends to make the i2cdetect more readable.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7674efb..3a97d2c 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -626,7 +626,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	if (r < 0)
 		return r;
 	if (r == 0) {
-		dev_err(dev->dev, "controller timed out\n");
+		dev_dbg(dev->dev, "controller timed out\n");
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
 	}
-- 
1.7.0.4

