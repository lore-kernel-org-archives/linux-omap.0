From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in lcd_palmz71
Date: Thu, 04 Jan 2007 19:32:44 +0100
Message-ID: <459D484C.3010202@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080107070101090408020500"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------080107070101090408020500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix warnings in lcd_palmz71.c about
"initialization from incompatible pointer type". Minor
formatting fix.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------080107070101090408020500
Content-Type: text/plain;
 name="lcd_palmz71_warnings_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lcd_palmz71_warnings_fix.txt"

Index: linux-osk/drivers/video/omap/lcd_palmz71.c
===================================================================
--- linux-osk.orig/drivers/video/omap/lcd_palmz71.c
+++ linux-osk/drivers/video/omap/lcd_palmz71.c
@@ -30,28 +30,29 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/omapfb.h>
 
-static int palmz71_panel_init(struct omapfb_device *panel)
+static int palmz71_panel_init(struct lcd_panel *panel,
+			      struct omapfb_device *fbdev)
 {
 	return 0;
 }
 
-static void palmz71_panel_cleanup(void)
+static void palmz71_panel_cleanup(struct lcd_panel *panel)
 {
 
 }
 
-static int palmz71_panel_enable(void)
+static int palmz71_panel_enable(struct lcd_panel *panel)
 {
 	return 0;
 }
 
-static void palmz71_panel_disable(void)
+static void palmz71_panel_disable(struct lcd_panel *panel)
 {
 }
 
-static unsigned long palmz71_panel_get_caps(void)
+static unsigned long palmz71_panel_get_caps(struct lcd_panel *panel)
 {
-return OMAPFB_CAPS_SET_BACKLIGHT;
+	return OMAPFB_CAPS_SET_BACKLIGHT;
 }
 
 struct lcd_panel palmz71_panel = {



--------------080107070101090408020500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080107070101090408020500--
