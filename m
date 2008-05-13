From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 1/1] OMAP3 EVM: Fix pixel_clock picoseconds/kHz error
Date: Mon, 12 May 2008 21:03:50 -0700
Message-ID: <5e088bd90805122103r7a4303b4r45ac312cfb8353f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:11501 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYEMEDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 00:03:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2009166fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2008 21:03:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Steve Sakoman <steve@sakoman.com>

Fix pixel_clock picoseconds/kHz error in LCD config, eliminate unused #define

Signed-off-by: Steve Sakoman <steve@sakoman.com>

---
 drivers/video/omap/lcd_omap3evm.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3evm.c
b/drivers/video/omap/lcd_omap3evm.c
index 04e40b6..4e0a64c 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -38,8 +38,7 @@

 #define LCD_XRES	 	480
 #define LCD_YRES 		640
-#define LCD_PIXCLOCK_MAX	41700 /* in pico seconds  */
-#define LCD_PIXCLOCK_MIN	38000 /* in pico seconds */
+#define LCD_PIXCLOCK		26000 /* in kHz  */

 #define ENABLE_VDAC_DEDICATED	0x03
 #define ENABLE_VDAC_DEV_GRP	0x20
@@ -111,7 +110,7 @@ struct lcd_panel omap3evm_panel = {
 	.vfp		= 2,		/* lower_margin */
 	.vbp		= 7,		/* upper_margin (8) - 1 */

-	.pixel_clock	= LCD_PIXCLOCK_MAX,
+	.pixel_clock	= LCD_PIXCLOCK,

 	.init		= omap3evm_panel_init,
 	.cleanup	= omap3evm_panel_cleanup,
-- 
1.5.4.5
