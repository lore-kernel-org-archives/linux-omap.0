From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 1/5] OMAP: I2C: Add a device reset field to platform data
Date: Thu, 21 Jul 2011 12:23:01 +0530
Message-ID: <1311231185-5503-2-git-send-email-shubhrajyoti@ti.com>
References: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43096 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1GUGxW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jul 2011 02:53:22 -0400
In-Reply-To: <1311231185-5503-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

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

