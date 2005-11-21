From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] camera: c99 style structure
Date: Mon, 21 Nov 2005 06:00:48 -0800 (PST)
Message-ID: <20051121140048.12059.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1191481125-1132581648=:10949"
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

--0-1191481125-1132581648=:10949
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

I have attached the patch to update the structures in 16xxcam.c and
sensor file to c99 way and fixes compilation of drivers on h3.

Jian,
I am planning to move sensor_powerup/powerdown to board specific file
(here omap16xxcam.c), before start porting camera driver to 24xx, any
suggestions?

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
--0-1191481125-1132581648=:10949
Content-Type: text/plain; name="fix.patch"
Content-Description: 2116858835-fix.patch
Content-Disposition: inline; filename="fix.patch"

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 077d2b0..e9e84b1 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -32,7 +32,7 @@
 #include <linux/ctype.h>
 #include <linux/pagemap.h>
 #include <linux/mm.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/videodev.h>
diff --git a/drivers/media/video/omap/omap16xxcam.c b/drivers/media/video/omap/omap16xxcam.c
index 6f85bd2..2e90557 100644
--- a/drivers/media/video/omap/omap16xxcam.c
+++ b/drivers/media/video/omap/omap16xxcam.c
@@ -566,18 +566,18 @@ omap16xxcam_init(void)
 }
 
 struct camera_hardware camera_hardware_if = {
-	version		: 0x01, 
-	name		: "OMAP16xx Camera Parallel", 
-	init		: omap16xxcam_init,
-	cleanup		: omap16xxcam_cleanup,
-	open 		: omap16xxcam_open, 
-	close  		: omap16xxcam_close,
-	enable 		: omap16xxcam_enable, 
-	disable  	: omap16xxcam_disable,
-	abort		: omap16xxcam_abort,
-	set_xclk	: omap16xxcam_set_xclk,
-	init_dma	: omap16xxcam_init_dma,
-	start_dma	: omap16xxcam_start_dma,
-	finish_dma	: omap16xxcam_finish_dma,
+	.version	= 0x01, 
+	.name		= "OMAP16xx Camera Parallel", 
+	.init		= omap16xxcam_init,
+	.cleanup	= omap16xxcam_cleanup,
+	.open		= omap16xxcam_open, 
+	.close		= omap16xxcam_close,
+	.enable		= omap16xxcam_enable, 
+	.disable	= omap16xxcam_disable,
+	.abort		= omap16xxcam_abort,
+	.set_xclk	= omap16xxcam_set_xclk,
+	.init_dma	= omap16xxcam_init_dma,
+	.start_dma	= omap16xxcam_start_dma,
+	.finish_dma	= omap16xxcam_finish_dma,
 };
 
diff --git a/drivers/media/video/omap/sensor_ov9640.c b/drivers/media/video/omap/sensor_ov9640.c
index c48f401..9581a64 100644
--- a/drivers/media/video/omap/sensor_ov9640.c
+++ b/drivers/media/video/omap/sensor_ov9640.c
@@ -1152,19 +1152,19 @@ ov9640sensor_init(struct v4l2_pix_format
 }
 
 struct camera_sensor camera_sensor_if = {
-	version: 	0x01,
-	name:		"OV9640",
-	init: 		ov9640sensor_init,
-	cleanup:	ov9640sensor_cleanup, 
-	enum_pixformat:	ov9640sensor_enum_pixformat,
-	try_format:	ov9640sensor_try_format,
-	calc_xclk:	ov9640sensor_calc_xclk,
-	configure:	ov9640sensor_configure,
-	query_control:	ov9640sensor_query_control, 
-	get_control:	ov9640sensor_get_control, 
-	set_control:	ov9640sensor_set_control,
-	power_on:	ov9640sensor_power_on,
-	power_off:	ov9640sensor_power_off,
+	.version	= 0x01,
+	.name		= "OV9640",
+	.init		= ov9640sensor_init,
+	.cleanup	= ov9640sensor_cleanup, 
+	.enum_pixformat = ov9640sensor_enum_pixformat,
+	.try_format	= ov9640sensor_try_format,
+	.calc_xclk	= ov9640sensor_calc_xclk,
+	.configure	= ov9640sensor_configure,
+	.query_control	= ov9640sensor_query_control, 
+	.get_control	= ov9640sensor_get_control, 
+	.set_control	= ov9640sensor_set_control,
+	.power_on	= ov9640sensor_power_on,
+	.power_off	= ov9640sensor_power_off,
 };
 
 void print_ov9640_regs(void *priv)
diff --git a/drivers/net/irda/omap1610-ir.c b/drivers/net/irda/omap1610-ir.c
index 8d503ba..88163b7 100644
--- a/drivers/net/irda/omap1610-ir.c
+++ b/drivers/net/irda/omap1610-ir.c
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irmod.h>

--0-1191481125-1132581648=:10949
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--0-1191481125-1132581648=:10949--
