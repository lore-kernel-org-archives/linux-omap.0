From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 08/18] I2C: OMAP2+: use platform_data ip revision to select register map
Date: Wed,  1 Jun 2011 17:19:34 -0700
Message-ID: <1306973984-15165-9-git-send-email-khilman@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1306973984-15165-1-git-send-email-khilman-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Andy Green <andy-/Zus8d0mwwtBDgjK7y7TUQ@public.gmane.org>

Change the register map names to reflect the IP revision they
are representing, and use the platform_data IP revision index
to select between them at init time.

Eliminates 1 of 17 cpu_...() calls in the driver.

Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Reported-by: Peter Maydell <peter.maydell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6a6b222..fbd4ec4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -205,7 +205,7 @@ struct omap_i2c_dev {
 	u16			errata;
 };
 
-const static u8 reg_map[] = {
+const static u8 reg_map_ip_v1[] = {
 	[OMAP_I2C_REV_REG] = 0x00,
 	[OMAP_I2C_IE_REG] = 0x01,
 	[OMAP_I2C_STAT_REG] = 0x02,
@@ -226,7 +226,7 @@ const static u8 reg_map[] = {
 	[OMAP_I2C_BUFSTAT_REG] = 0x10,
 };
 
-const static u8 omap4_reg_map[] = {
+const static u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_REV_REG] = 0x04,
 	[OMAP_I2C_IE_REG] = 0x2c,
 	[OMAP_I2C_STAT_REG] = 0x28,
@@ -1035,10 +1035,10 @@ omap_i2c_probe(struct platform_device *pdev)
 	else
 		dev->reg_shift = 2;
 
-	if (cpu_is_omap44xx())
-		dev->regs = (u8 *) omap4_reg_map;
+	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
+		dev->regs = (u8 *)reg_map_ip_v2;
 	else
-		dev->regs = (u8 *) reg_map;
+		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(&pdev->dev);
 	omap_i2c_unidle(dev);
-- 
1.7.4
