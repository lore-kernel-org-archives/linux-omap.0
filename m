From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 12/18] I2C: OMAP1/OMAP2+: add flags field to omap i2c platform data
Date: Wed,  1 Jun 2011 17:19:38 -0700
Message-ID: <1306973984-15165-13-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306973984-15165-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Andy Green <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>

OMAP I2C driver can access the configuration flags through
its platform data.

Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Reported-by: Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 include/linux/i2c-omap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index b321211..776c8e1 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -18,6 +18,7 @@
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
+	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
 	int		(*device_enable) (struct platform_device *pdev);
 	int		(*device_shutdown) (struct platform_device *pdev);
-- 
1.7.4
