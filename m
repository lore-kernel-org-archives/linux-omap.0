From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP: Put LCD drivers back to Makefile.
Date: Tue,  7 Aug 2007 16:06:17 +0300
Message-ID: <11864919772974-git-send-email-sakari.ailus@nokia.com>
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

Put back references to lcd_apollon.o, lcd_2430sdp.o and lcd_mipid.o that
were lost in merge to drivers/video/omap/Makefile.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/video/omap/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index de7c6bd..9211128 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -27,5 +27,9 @@ objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 objs-y$(CONFIG_MACH_SX1) += lcd_sx1.o
 
+objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
+objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
+objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
+
 omapfb-objs := $(objs-yy)
 
-- 
1.5.0.6
