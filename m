From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 13/18] I2C: OMAP2+: Pass flags up to omap i2c platform_data as well
Date: Wed,  1 Jun 2011 17:19:39 -0700
Message-ID: <1306973984-15165-14-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306973984-15165-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Andy Green <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>

This is how the driver can find the flags for its implementation
functionality in its platform_data

Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Reported-by: Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/i2c.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 0d3eda7..9098669 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -141,6 +141,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	struct omap_device *od;
 	char oh_name[MAX_OMAP_I2C_HWMOD_NAME_LEN];
 	struct omap_i2c_bus_platform_data *pdata;
+	struct omap_i2c_dev_attr *dev_attr;
 
 	omap2_i2c_mux_pins(bus_id);
 
@@ -156,10 +157,14 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	pdata = &i2c_pdata[bus_id - 1];
 	/*
 	 * pass the hwmod class's CPU-specific knowledge of I2C IP revision in
-	 * use up to the OMAP I2C driver via platform data
+	 * use, and functionality implementation flags, up to the OMAP I2C
+	 * driver via platform data
 	 */
 	pdata->rev = oh->class->rev;
 
+	dev_attr = (struct omap_i2c_dev_attr *)oh->dev_attr;
+	pdata->flags = dev_attr->flags;
+
 	/*
 	 * When waiting for completion of a i2c transfer, we need to
 	 * set a wake up latency constraint for the MPU. This is to
-- 
1.7.4
