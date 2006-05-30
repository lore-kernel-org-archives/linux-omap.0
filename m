From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] FB: OMAP: Make omapfb_blank use the FB_BLANK_* defines.
Date: Tue, 30 May 2006 16:05:23 +0100
Message-ID: <20060530150523.GQ14634@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

The current OMAP FB driver used the VESA_ defines for blanking, but the
rest of the FB drivers in the tree now use FB_BLANK_*. This patch
updates the OMAP FB driver to use these as well.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff -rupN -X linux-2.6.16-e3-00/Documentation/dontdiff linux-2.6.16-e3-07/drivers/video/omap/omapfb_main.c linux-2.6.16-e3-08/drivers/video/omap/omapfb_main.c
--- linux-2.6.16-e3-07/drivers/video/omap/omapfb_main.c	2006-04-06 22:25:32.545314000 +0100
+++ linux-2.6.16-e3-08/drivers/video/omap/omapfb_main.c	2006-05-26 19:10:54.790912250 +0100
@@ -325,7 +325,7 @@ static int omapfb_blank(int blank, struc
 
 	omapfb_rqueue_lock(fbdev);
 	switch (blank) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		if (fbdev->state == OMAPFB_SUSPENDED) {
 			if (fbdev->ctrl->resume)
 				fbdev->ctrl->resume();
@@ -336,7 +336,10 @@ static int omapfb_blank(int blank, struc
 				do_update = 1;
 		}
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
 		if (fbdev->state == OMAPFB_ACTIVE) {
 			fbdev->panel->disable();
 			if (fbdev->ctrl->suspend)
@@ -1437,7 +1440,7 @@ static int omapfb_suspend(struct platfor
 
 	DBGENTER(1);
 
-	omapfb_blank(VESA_POWERDOWN, fbdev->fb_info);
+	omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info);
 
 	DBGLEAVE(1);
 
@@ -1451,7 +1454,7 @@ static int omapfb_resume(struct platform
 
 	DBGENTER(1);
 
-	omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info);
+	omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info);
 
 	DBGLEAVE(1);
 	return 0;
-----

J.

-- 
 [           If I could, I would, but I can't, so I won't.            ]
