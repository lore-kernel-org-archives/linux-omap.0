From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: 2430SDP: minor fixups for fb driver
Date: Tue,  5 Jun 2007 18:00:33 -0700
Message-ID: <11810916333338-git-send-email-khilman@mvista.com>
References: <11810916331121-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11810916331121-git-send-email-khilman@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove redundant #defines
Fix LCD pixelclock to 5.4 MHz

Signed-off-by: Hunyue Yau <hyau@mvista.com>
Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 drivers/video/omap/lcd_2430sdp.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
index 0c50d10..6e5b603 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -31,14 +31,10 @@
 
 #define LCD_PANEL_BACKLIGHT_GPIO	91
 #define LCD_PANEL_ENABLE_GPIO		154
-#define H4_LCD_PIXCLOCK_MAX		185186 /* freq 5.4 MHz */
+#define LCD_PIXCLOCK_MAX		5400 /* freq 5.4 MHz */
 #define PM_RECEIVER             TWL4030_MODULE_PM_RECIEVER
 #define ENABLE_VAUX2_DEDICATED  0x09
 #define ENABLE_VAUX2_DEV_GRP    0x20
-#define TWL4030_VAUX2_DEV_GRP           0x1B
-#define TWL4030_VAUX2_DEDICATED         0x1E
-#define TWL4030_MODULE_PM_RECIEVER  0x13
-
 
 
 #define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
@@ -99,7 +95,7 @@ struct lcd_panel sdp2430_panel = {
 	.vfp		= 2,		/* lower_margin */
 	.vbp		= 7,		/* upper_margin (8) - 1 */
 
-	.pixel_clock	= H4_LCD_PIXCLOCK_MAX,
+	.pixel_clock	= LCD_PIXCLOCK_MAX,
 
 	.init		= sdp2430_panel_init,
 	.cleanup	= sdp2430_panel_cleanup,
-- 
1.5.2
