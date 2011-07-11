From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 1/2] OMAP: I2C: Add a device reset field to platform data
Date: Mon, 11 Jul 2011 15:25:12 +0530
Message-ID: <1310378113-28098-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36523 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1GKJz2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 05:55:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6B9tP0C028500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:55:27 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6B9tNmR019065
	for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 15:25:24 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

Under some conditions the driver may want to do a reset
of the device. Adding a reset field field to the platform
data.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 98ae49b..8aa91b6 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
 	int		(*device_idle) (struct platform_device *pdev);
+	int		(*device_reset) (struct device *dev);
 };
 
 #endif
-- 
1.7.1

