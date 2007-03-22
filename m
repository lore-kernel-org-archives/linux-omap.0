From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP: Kconfig and Makefile changes for camera and
	TCM825x drivers.
Date: Thu, 22 Mar 2007 19:07:04 +0200
Message-ID: <11745832252663-git-send-email-sakari.ailus@nokia.com>
References: <4602B745.7000006@nokia.com>
	<11745832253226-git-send-email-sakari.ailus@nokia.com>
	<11745832251620-git-send-email-sakari.ailus@nokia.com>
	<11745832251952-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11745832251952-git-send-email-sakari.ailus@nokia.com>
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
Cc: eduardo.valentin@indt.org.br, ilias.biris@indt.org.br
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap/Kconfig  |    4 ++++
 drivers/media/video/omap/Makefile |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
index 809193b..8515c4c 100644
--- a/drivers/media/video/omap/Kconfig
+++ b/drivers/media/video/omap/Kconfig
@@ -10,3 +10,7 @@ config VIDEO_CAMERA_SENSOR_OV9640
 	depends on VIDEO_OMAP_CAMERA
 	help
 	  OmniVision 9640 camera sensor support
+
+config VIDEO_CAMERA_SENSOR_TCM825X
+	tristate "TCM825x sensor support"
+	depends on VIDEO_OMAP_CAMERA
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 36ae615..aac0b29 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -2,8 +2,10 @@
 
 obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
 obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
+obj-$(CONFIG_VIDEO_CAMERA_SENSOR_TCM825X) += sensor_tcm825x.o
 
 objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o camera_core.o
+objs-y$(CONFIG_ARCH_OMAP24XX) += omap24xxcam.o omap24xxcam-dma.o omap24xxcam-core.o omap24xxcam-sensor.o omap24xxcam-vbq.o
 objs-y$(CONFIG_MACH_OMAP_H3) += h3_sensor_power.o
 objs-y$(CONFIG_MACH_OMAP_H4) += h4_sensor_power.o
 
-- 
1.5.0.1
