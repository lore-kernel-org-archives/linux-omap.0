From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP2: ov9640 updates for H4
Date: Tue, 21 Mar 2006 05:58:37 -0800 (PST)
Message-ID: <20060321135837.55951.qmail@web32908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1685238506-1142949517=:54868"
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

--0-1685238506-1142949517=:54868
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony,

Attached patch should be applied after David's 24xx camera driver and
my h4sensor powerup down patch.

---
OMAP2: OV9640: Update sensor driver for H4 and new interface, and fix
               h3 build for camera.

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1685238506-1142949517=:54868
Content-Type: text/x-patch; name="h4ov9640.patch"
Content-Description: 2883723723-h4ov9640.patch
Content-Disposition: inline; filename="h4ov9640.patch"

diff --git a/drivers/media/video/omap/camera_core.c b/drivers/media/video/omap/camera_core.c
index 12c1fd1..023615e 100644
--- a/drivers/media/video/omap/camera_core.c
+++ b/drivers/media/video/omap/camera_core.c
@@ -1112,7 +1112,7 @@ camera_core_init(void)
 	cam->xclk = cam->cam_hardware->set_xclk(cam->xclk, cam->hardware_data);
 
 	/* initialize the sensor and define a default capture format cam->pix */
-	cam->sensor_data = cam->cam_sensor->init(&cam->pix);
+	cam->sensor_data = cam->cam_sensor->init(&cam->pix, &cam->pix2);
 	if (!cam->sensor_data) {
 		cam->cam_hardware->disable(cam->hardware_data);
 		printk(KERN_ERR CAM_NAME ": cannot initialize sensor\n");
diff --git a/drivers/media/video/omap/camera_core.h b/drivers/media/video/omap/camera_core.h
index 9ab336f..cffc263 100644
--- a/drivers/media/video/omap/camera_core.h
+++ b/drivers/media/video/omap/camera_core.h
@@ -104,6 +104,7 @@ struct camera_device {
 	 * VIDIOC_S_FMT/VIDIOC_G_FMT ioctls with a CAPTURE buffer type.
 	 */
 	struct v4l2_pix_format pix;
+	struct v4l2_pix_format pix2;
 
 	/* crop defines the size and offset of the video overlay source window 
 	 * within the framebuffer.  These parameters are set/queried by the 
diff --git a/drivers/media/video/omap/omap24xxcam.c b/drivers/media/video/omap/omap24xxcam.c
diff --git a/drivers/media/video/omap/sensor_ov9640.c b/drivers/media/video/omap/sensor_ov9640.c
index fe071e2..4c63e69 100644
--- a/drivers/media/video/omap/sensor_ov9640.c
+++ b/drivers/media/video/omap/sensor_ov9640.c
@@ -102,8 +102,12 @@ const static struct v4l2_fmtdesc ov9640_
 	}
 };
 
-#define NUM_CAPTURE_FORMATS (sizeof(ov9640_formats)/sizeof(ov9640_formats[0]))
+#define NUM_CAPTURE_FORMATS ARRAY_SIZE(ov9640_formats)
+#ifdef CONFIG_ARCH_OMAP24XX
+#define NUM_OVERLAY_FORMATS 4
+#else
 #define NUM_OVERLAY_FORMATS 2
+#endif
 
 /* register initialization tables for OV9640 */
 
@@ -114,9 +118,15 @@ const static struct v4l2_fmtdesc ov9640_
  * and frame rates
  */
 const static struct ov9640_reg ov9640_common[] = {
+#ifdef CONFIG_ARCH_OMAP24XX
+	{ 0x12, 0x80 }, { 0x11, 0x80 }, { 0x13, 0x8F },	/* COM7, CLKRC, COM8 */
+	{ 0x01, 0x80 }, { 0x02, 0x80 }, { 0x04, 0x00 },	/* BLUE, RED, COM1 */
+	{ 0x0E, 0x81 }, { 0x0F, 0x4F }, { 0x14, 0x4A },	/* COM5, COM6, COM9 */
+#else
 	{ 0x12, 0x80 }, { 0x11, 0x80 }, { 0x13, 0x88 },	/* COM7, CLKRC, COM8 */
 	{ 0x01, 0x58 }, { 0x02, 0x24 }, { 0x04, 0x00 },	/* BLUE, RED, COM1 */
 	{ 0x0E, 0x81 }, { 0x0F, 0x4F }, { 0x14, 0xcA },	/* COM5, COM6, COM9 */
+#endif
 	{ 0x16, 0x02 }, { 0x1B, 0x01 }, { 0x24, 0x70 },	/* ?, PSHFT, AEW */
 	{ 0x25, 0x68 }, { 0x26, 0xD3 }, { 0x27, 0x90 },	/* AEB, VPT, BBIAS */
 	{ 0x2A, 0x00 }, { 0x2B, 0x00 }, { 0x32, 0x24 },	/* EXHCH, EXHCL, HREF */
@@ -143,8 +153,12 @@ const static struct ov9640_reg ov9640_co
 	{ 0x81, 0x44 }, { 0x82, 0x52 }, { 0x83, 0x60 },	/* GST6, GST7, GST8 */
 	{ 0x84, 0x6C }, { 0x85, 0x78 }, { 0x86, 0x8C },	/* GST9, GST10,GST11 */
 	{ 0x87, 0x9E }, { 0x88, 0xBB }, { 0x89, 0xD2 },	/* GST12,GST13,GST14 */
+#ifdef CONFIG_ARCH_OMAP24XX
+	{ 0x8A, 0xE6 }, { 0x13, 0x8F }, { 0x00, 0x7F },	/* GST15, COM8 */
+#else
 	{ 0x8A, 0xE6 }, { 0x13, 0xaF }, { 0x15, 0x02 },	/* GST15, COM8 */
 	{ 0x22, 0x8a }, /* GROS */
+#endif
 	{ OV9640_REG_TERM, OV9640_VAL_TERM }
 };
 
@@ -419,7 +433,7 @@ static struct vcontrol {
           0, OV9640_MVFP, 0x10, 4 },
 };
 
-#define NUM_CONTROLS (sizeof(control)/sizeof(control[0]))
+#define NUM_CONTROLS ARRAY_SIZE(control)
 
 const static struct ov9640_reg *
 	ov9640_reg_init[NUM_PIXEL_FORMATS][NUM_IMAGE_SIZES] =
@@ -493,9 +507,9 @@ ov9640_write_reg_mask(struct i2c_client 
 	u8 oldval, newval;
 	int rc;
 
-	if (mask == 0xff) {
+	if (mask == 0xff) 
 		newval = *val;
-	} else {
+	else {
 		/* need to do read - modify - write */
 		if ((rc = ov9640_read_reg(client, reg, &oldval)))
 			return rc;
@@ -581,8 +595,16 @@ ov9640_clkrc(enum image_size isize, unsi
 	unsigned long fpm, fpm_max;	/* frames per minute */
 	unsigned long divisor;
 	const unsigned long divisor_max = 64;
+#ifdef CONFIG_ARCH_OMAP24XX
+	const static unsigned long clks_per_frame[] = 
+		{ 200000, 400000, 200000, 400000, 400000, 800000, 3200000 };
+      /*         QQCIF   QQVGA    QCIF    QVGA  CIF     VGA   	SXGA
+       *         199680,400000, 199680, 400000, 399360, 800000, 3200000
+       */
+#else
 	const static unsigned long clks_per_frame[] = 
 		{ 200000, 200000, 200000, 200000, 400000, 800000, 3200000 };
+#endif
 
 	if (fper->numerator > 0)
 		fpm = (fper->denominator*60)/fper->numerator;
@@ -1121,7 +1143,7 @@ static struct i2c_driver ov9640sensor_i2
  * initialization is successful.
  */
 static void *
-ov9640sensor_init(struct v4l2_pix_format *pix)
+ov9640sensor_init(struct v4l2_pix_format *pix, struct v4l2_pix_format *pix2)
 {
 	struct ov9640_sensor *sensor = &ov9640;
  	int err;
@@ -1142,10 +1164,9 @@ ov9640sensor_init(struct v4l2_pix_format
 			"Failed to detect OV9640 sensor chip.\n");
 		return NULL;
 	}
-	else {
+	else 
 		printk(KERN_INFO 
 			"OV9640 sensor chip version 0x%02x detected\n", sensor->ver);
-	}
 
 	/* Make the default capture format QCIF RGB565 */
 	pix->width = ov9640_sizes[QCIF].width;
@@ -1159,6 +1180,10 @@ ov9640sensor_init(struct v4l2_pix_format
 struct camera_sensor camera_sensor_if = {
 	.version	= 0x01,
 	.name		= "OV9640",
+	.parallel_mode	= PAR_MODE_NOBT8,
+	.hs_polarity	= SYNC_ACTIVE_HIGH,
+	.vs_polarity	= SYNC_ACTIVE_LOW,
+	.image_swap 	= 0,
 	.init		= ov9640sensor_init,
 	.cleanup	= ov9640sensor_cleanup,
 	.enum_pixformat = ov9640sensor_enum_pixformat,

--0-1685238506-1142949517=:54868
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1685238506-1142949517=:54868--
