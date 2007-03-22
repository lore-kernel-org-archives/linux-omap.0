From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: [PATCH] ARM: OMAP: Camera: Modify OMAP camera interface.
Date: Thu, 22 Mar 2007 19:07:01 +0200
Message-ID: <11745832253226-git-send-email-sakari.ailus@nokia.com>
References: <4602B745.7000006@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4602B745.7000006@nokia.com>
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
 drivers/media/video/omap/sensor_if.h |   98 ++++++++++++++++++++++++----------
 1 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/media/video/omap/sensor_if.h b/drivers/media/video/omap/sensor_if.h
index 47bb716..527b9c9 100644
--- a/drivers/media/video/omap/sensor_if.h
+++ b/drivers/media/video/omap/sensor_if.h
@@ -1,50 +1,92 @@
 /*
- * drivers/media/video/omap/sensor_if.h
+ * omap24xxcam.c
  *
- * Copyright (C) 2004 Texas Instruments, Inc. 
- * 
- * Sensor interface to OMAP camera capture drivers
- * Sensor driver should implement this interface
+ * An interface for OMAP camera sensors.
  *
- * This package is free software; you can redistribute it and/or modify 
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation. 
- * 
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR 
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED 
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
+ * Copyright (C) 2004 Texas Instruments.
+ * Copyright (C) 2007 Nokia Corporation.
+ *
+ * Contact: Sakari Ailus <sakari.ailus@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
  */
- 
+
 #ifndef OMAP_SENSOR_IF_H
 #define OMAP_SENSOR_IF_H
 
 #define OMAP_SENSOR_NAME_LEN		31
 
+struct omap_camera_sensor;
+
+/*
+ * Sensor -> camera interface.
+ */
+struct omap_camera {
+	void *priv;
+
+	int (*sensor_register)(struct omap_camera *oc,
+			       struct omap_camera_sensor *os);
+	void (*sensor_unregister)(struct omap_camera *oc,
+				  struct omap_camera_sensor *os);
+	/*
+	 * Tell camera to reset the sensor, i.e. power down and up
+	 * again.
+	 */
+	void (*sensor_reset)(struct omap_camera *oc,
+			     struct omap_camera_sensor *os);
+};
+
+/*
+ * Camera -> sensor interface.
+ */
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
+			 struct v4l2_pix_format *fmt, unsigned long xclk,
+			 struct v4l2_fract *fract);
 
-extern struct omap_camera_sensor camera_sensor_if;
+	int (*query_control) (struct omap_camera_sensor *os,
+			      struct v4l2_queryctrl *ctrl);
+	int (*get_control)(struct omap_camera_sensor *os,
+			   struct v4l2_control *ctrl);
+	int (*set_control)(struct omap_camera_sensor *os,
+			   struct v4l2_control *ctrl);
+};
 
 #endif
-- 
1.5.0.1
