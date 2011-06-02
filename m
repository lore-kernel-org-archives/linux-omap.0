From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 06/18] I2C: OMAP1: set IP revision in platform data
Date: Wed,  1 Jun 2011 17:19:32 -0700
Message-ID: <1306973984-15165-7-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306973984-15165-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Andy Green <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>

All OMAP1 are using "IP revision 1" in terms of register
layout.  We set this information in omap1_i2c_add_bus() so
we don't have to use cpu_is_xxx() any more in the omap i2c
driver.

Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Reported-by: Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/i2c.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..a938df0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -108,6 +108,9 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	res[1].start = INT_I2C;
 	pdata = &i2c_pdata[bus_id - 1];
 
+	/* all OMAP1 have IP version 1 register set */
+	pdata->rev = OMAP_I2C_IP_VERSION_1;
+
 	return platform_device_register(pdev);
 }
 
-- 
1.7.4
