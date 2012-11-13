From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] wdt: twl4030: Change TWL4030_MODULE_PM_RECEIVER to TWL_MODULE_PM_RECEIVER
Date: Tue, 13 Nov 2012 10:40:22 +0100
Message-ID: <1352799622-22280-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

To facilitate upcoming cleanup in twl stack.
No functional changes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/watchdog/twl4030_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 249f113..0501638 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -49,8 +49,8 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 
 static int twl4030_wdt_write(unsigned char val)
 {
-	return twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
-					TWL4030_WATCHDOG_CFG_REG_OFFS);
+	return twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, val,
+				TWL4030_WATCHDOG_CFG_REG_OFFS);
 }
 
 static int twl4030_wdt_enable(struct twl4030_wdt *wdt)
-- 
1.8.0
