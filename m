From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/2] I2C: OMAP: remove unused function pointers from pdata
Date: Thu,  4 Aug 2011 08:10:22 -0700
Message-ID: <1312470622-30534-1-git-send-email-khilman@ti.com>
References: <1312469856-13276-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312469856-13276-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Now that this driver is using runtime PM, there is no longer a need
for the idle/enable/shutdown function pointers in pdata.

Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
Here's one more for the i2c-cleanup series

 include/linux/i2c-omap.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 56a9924..92a0dc7 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -35,9 +35,6 @@ struct omap_i2c_bus_platform_data {
 	u32		rev;
 	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
-	int		(*device_enable) (struct platform_device *pdev);
-	int		(*device_shutdown) (struct platform_device *pdev);
-	int		(*device_idle) (struct platform_device *pdev);
 };
 
 #endif
-- 
1.7.6
