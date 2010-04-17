From: Bharathi Subramanian <bharathi.list@gmail.com>
Subject: [PATCH] DSS2: Code Clean-up
Date: Sat, 17 Apr 2010 10:59:03 +0530
Message-ID: <p2n2b3771721004162229te084607y2c87ecb573848986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:60614 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0DQF3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Apr 2010 01:29:06 -0400
Received: by pzk42 with SMTP id 42so2459640pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 22:29:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

* Removed duplicate return statement
* General code clean-up

My 1st patch.

---
diff --git a/drivers/video/omap2/dss/display.c
b/drivers/video/omap2/dss/display.c
index 6a74ea1..a5a6859 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -340,10 +340,11 @@ int omapdss_default_get_recommended_bpp(struct
omap_dss_device *dssdev)
 			return 24;
 		else
 			return 16;
+
 	case OMAP_DISPLAY_TYPE_VENC:
 	case OMAP_DISPLAY_TYPE_SDI:
 		return 24;
-		return 24;
+
 	default:
 		BUG();
 	}
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index f0ba573..0185782 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -450,10 +450,6 @@ static void venc_power_off(struct omap_dss_device *dssdev)
 	venc_enable_clocks(0);
 }

-
-
-
-
 /* driver */
 static int venc_panel_probe(struct omap_dss_device *dssdev)
 {
@@ -654,8 +650,6 @@ static struct omap_dss_driver venc_driver = {
 };
 /* driver end */

-
-
 int venc_init(struct platform_device *pdev)
 {
 	u8 rev_id;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
b/drivers/video/omap2/omapfb/omapfb-main.c
index 4a76917..6d72784 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1771,8 +1771,7 @@ static int omapfb_fb_init(struct omapfb2_device
*fbdev, struct fb_info *fbi)
 				var->bits_per_pixel = 32;
 				break;
 			default:
-				dev_err(fbdev->dev, "illegal display "
-						"bpp\n");
+				dev_err(fbdev->dev, "illegal display bpp\n");
 				return -EINVAL;
 			}
 		}
--
1.6.3.3
--
