From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 6/6] OMAP1: CAMERA: Remove unecessary files from Makefile
	and Kconfig.
Date: Tue,  9 Oct 2007 08:52:33 -0400
Message-ID: <1191934353-24072-7-git-send-email-edubezval@gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
	<1191934353-24072-2-git-send-email-edubezval@gmail.com>
	<1191934353-24072-3-git-send-email-edubezval@gmail.com>
	<1191934353-24072-4-git-send-email-edubezval@gmail.com>
	<1191934353-24072-5-git-send-email-edubezval@gmail.com>
	<1191934353-24072-6-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1191934353-24072-6-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

- Once ov9640 is implemented using v4l2-int-device API,
this patch removes unecessary files from Makefile and Kconfig.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 drivers/media/video/omap/Kconfig  |    6 ------
 drivers/media/video/omap/Makefile |    3 ---
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
index 809193b..0fb0686 100644
--- a/drivers/media/video/omap/Kconfig
+++ b/drivers/media/video/omap/Kconfig
@@ -4,9 +4,3 @@ config VIDEO_OMAP_CAMERA
 	depends on VIDEO_DEV && (ARCH_OMAP16XX || ARCH_OMAP24XX)
 	help
 	  V4L2 camera driver support for OMAP1/2 based boards.
-	
-config VIDEO_CAMERA_SENSOR_OV9640
-	tristate "OV9640 sensor support"
-	depends on VIDEO_OMAP_CAMERA
-	help
-	  OmniVision 9640 camera sensor support
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 36ae615..9b4a998 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -1,11 +1,8 @@
 # Makefile for OMAP1/2 camera driver
 
 obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
-obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o camera_core.o
-objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
-objs-y$(CONFIG_MACH_OMAP_H4) += h4_sensor_power.o
 
 omapcamera-objs := $(objs-yy)
 
-- 
1.5.3.4.206.g58ba4
