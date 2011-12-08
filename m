From: Alexander Aring <a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] i2c_omap: correct OMAP_I2C_SYSC_REG offset
Date: Thu, 8 Dec 2011 15:43:53 +0100
Message-ID: <1323355433-8508-1-git-send-email-a.aring@phytec.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Aring <a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Correct OMAP_I2C_SYSC_REG offset in omap4 register map.
Offset 0x20 is reserved and OMAP_I2C_SYSC_REG has 0x10 as offset.

Signed-off-by: Alexander Aring <a.aring-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a43d002..fc3bb37 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -235,7 +235,7 @@ static const u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_BUF_REG] = 0x94,
 	[OMAP_I2C_CNT_REG] = 0x98,
 	[OMAP_I2C_DATA_REG] = 0x9c,
-	[OMAP_I2C_SYSC_REG] = 0x20,
+	[OMAP_I2C_SYSC_REG] = 0x10,
 	[OMAP_I2C_CON_REG] = 0xa4,
 	[OMAP_I2C_OA_REG] = 0xa8,
 	[OMAP_I2C_SA_REG] = 0xac,
-- 
1.7.0.4
