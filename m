From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] camera: build infrastructure
Date: Tue, 22 Nov 2005 22:50:38 -0800 (PST)
Message-ID: <20051123065038.91202.qmail@web32906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-124754106-1132728638=:91181"
Content-Transfer-Encoding: 8bit
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

--0-124754106-1132728638=:91181
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

I have attached patch which updates omap camera build infrastructure.
Making a place for OMAP2 stuff. If we are agree on this then defconfigs
needs update, which I can submit next. 

Tested with building h3 and h2 defconfigs.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
--0-124754106-1132728638=:91181
Content-Type: text/plain; name="cambuild.patch"
Content-Description: 3461369905-cambuild.patch
Content-Disposition: inline; filename="cambuild.patch"

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 0c7f1e1..4208417 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -347,9 +347,6 @@ config VIDEO_DECODER
 	  Say Y here to compile drivers for SAA7115, SAA7127 and CX25840
 	  video  decoders.
 
-config VIDEO_OMAP_CAMERA
-	tristate "OMAP Video for Linux camera driver"
-	depends on VIDEO_DEV && ARCH_OMAP16XX
-	select VIDEO_BUF
+source drivers/media/video/omap/Kconfig
 
 endmenu
diff --git a/drivers/media/video/omap/Kconfig b/drivers/media/video/omap/Kconfig
new file mode 100644
index 0000000..809193b
--- /dev/null
+++ b/drivers/media/video/omap/Kconfig
@@ -0,0 +1,12 @@
+config VIDEO_OMAP_CAMERA
+	tristate "OMAP Camera support (EXPERIMENTAL)"
+	select VIDEO_BUF
+	depends on VIDEO_DEV && (ARCH_OMAP16XX || ARCH_OMAP24XX)
+	help
+	  V4L2 camera driver support for OMAP1/2 based boards.
+	
+config VIDEO_CAMERA_SENSOR_OV9640
+	tristate "OV9640 sensor support"
+	depends on VIDEO_OMAP_CAMERA
+	help
+	  OmniVision 9640 camera sensor support
diff --git a/drivers/media/video/omap/Makefile b/drivers/media/video/omap/Makefile
index 1f6476a..e9b82e0 100644
--- a/drivers/media/video/omap/Makefile
+++ b/drivers/media/video/omap/Makefile
@@ -1,7 +1,12 @@
-# Makefile for camera driver for H2/H3
+# Makefile for OMAP1/2 camera driver
 
-omapCamera-objs :=  camera_core.o omap16xxcam.o sensor_ov9640.o  
+obj-$(CONFIG_VIDEO_OMAP_CAMERA) += omapcamera.o
+obj-$(CONFIG_VIDEO_CAMERA_SENSOR_OV9640) += sensor_ov9640.o
 
-obj-y += omapCamera.o
+objs-yy := camera_core.o
+
+objs-y$(CONFIG_ARCH_OMAP16XX) += omap16xxcam.o
+
+omapcamera-objs := $(objs-yy) 
 
 EXTRA_CFLAGS = -I$(src)/..

--0-124754106-1132728638=:91181
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--0-124754106-1132728638=:91181--
