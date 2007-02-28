From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP2: Camera: Modify sensor interface.
Date: Wed, 28 Feb 2007 17:59:15 +0200
Message-ID: <11726783561918-git-send-email-sakari.ailus@nokia.com>
References: <45E5A489.2040108@nokia.com>
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
	<11726783562842-git-send-email-sakari.ailus@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11726783562842-git-send-email-sakari.ailus@nokia.com>
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

Clean up sensor interface.

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
---
 drivers/media/video/omap/sensor_if.h |   59 +++++++++++++++++++++++++--------
 1 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/media/video/omap/sensor_if.h b/drivers/media/video/omap/sensor_if.h
index 47bb716..cda2686 100644
--- a/drivers/media/video/omap/sensor_if.h
+++ b/drivers/media/video/omap/sensor_if.h
@@ -20,31 +20,60 @@
 
 #define OMAP_SENSOR_NAME_LEN		31
 
+struct omap_camera_sensor;
+
+struct omap_camera {
+	void *priv;
+	/*
+	 * Tell camera to reset the sensor, i.e. power down and up
+	 * again.
+	 */
+	int (*sensor_register)(struct omap_camera *oc,
+			       struct omap_camera_sensor *os);
+	void (*sensor_unregister)(struct omap_camera *oc,
+				  struct omap_camera_sensor *os);
+	void (*sensor_reset)(struct omap_camera *oc,
+			     struct omap_camera_sensor *os);
+};
+
 struct omap_camera_sensor {
 	unsigned int version;
 	char name[OMAP_SENSOR_NAME_LEN + 1];
 
-	void *(*init)(struct v4l2_pix_format *);
-	int (*cleanup)(void *);
+	struct module *module;
+	void *priv; /* sensor's private data */
 
-	int (*power_on)(void *);
-	int (*power_off)(void *);
+	int (*init)(struct omap_camera_sensor *os, struct v4l2_pix_format *pix,
+		    struct omap_camera *oc);
+	int (*cleanup)(struct omap_camera_sensor *os);
 
-	int (*enum_pixformat)(struct v4l2_fmtdesc *, void *);
-	int (*try_format)(struct v4l2_pix_format *, void *);
+	int (*power_on)(struct omap_camera_sensor *os);
+	int (*power_off)(struct omap_camera_sensor *os);
 
-	unsigned long (*calc_xclk)(struct v4l2_pix_format *,
-				   struct v4l2_fract *, void *);
+	int (*frame_check)(struct omap_camera_sensor *os,
+			   struct v4l2_pix_format *pix, void *buf);
 
-	int (*configure)(struct v4l2_pix_format *, unsigned long,
-			 struct v4l2_fract *, void *);
+	int (*enum_pixformat)(struct omap_camera_sensor *os,
+			      struct v4l2_fmtdesc *fmtdesc);
+	int (*try_format)(struct omap_camera_sensor *os,
+			  struct v4l2_pix_format *fmt);
 
-	int (*query_control) (struct v4l2_queryctrl *, void *);
-	int (*get_control)(struct v4l2_control *, void *);
-	int (*set_control)(struct v4l2_control *, void *);
+	unsigned long (*calc_xclk)(struct omap_camera_sensor *os,
+				   struct v4l2_pix_format *fmt,
+				   struct v4l2_fract *fract);
 
-};
+	int (*configure)(struct omap_camera_sensor *os,
+			 struct v4l2_pix_format *fmt, unsigned long,
+			 struct v4l2_fract *fract);
 
-extern struct omap_camera_sensor camera_sensor_if;
+	int (*query_control) (struct omap_camera_sensor *os,
+			      struct v4l2_queryctrl *ctrl);
+	int (*get_control)(struct omap_camera_sensor *os,
+			   struct v4l2_control *ctrl);
+	int (*set_control)(struct omap_camera_sensor *os,
+			   struct v4l2_control *ctrl);
+};
+	
+extern struct omap_camera omap24xxcam_camera;
 
 #endif
-- 
1.5.0.1
