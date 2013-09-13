From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] arm: omap: display: Don't build device for DMM
Date: Fri, 13 Sep 2013 14:44:39 +0530
Message-ID: <1379063679-4869-5-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379063679-4869-1-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

DMM exists on omap4+ platforms, these platforms will always boot with DT. Remove
the previous method of searching the dmm hwmod and building the device by
ourselves. Addition of a DMM nodes in DT will ensure a DMM device is built.

For OMAP4, the address and irq data for most hwmods were removed, so the older
method doesn't work anyway.

Cc: Andy Gross <andygro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/display.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index d097d23..e0642bd 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -126,20 +126,8 @@ static int __init omapdrm_init(void)
 {
 	int r = 0;
 
-	/* create DRM and DMM device */
+	/* create DRM device(DMM device created via DT) */
 	if (omap_drm_device != NULL) {
-		struct omap_hwmod *oh = NULL;
-		struct platform_device *pdev;
-
-		/* lookup and populate the DMM information, if present - OMAP4+ */
-		oh = omap_hwmod_lookup("dmm");
-		if (oh) {
-			pdev = omap_device_build(oh->name, -1, oh, NULL, 0);
-			WARN(IS_ERR(pdev),
-				"Could not build omap_device for %s\n",
-				oh->name);
-		}
-
 		platform_drm_data.omaprev = GET_OMAP_TYPE;
 
 		r = platform_device_register(omap_drm_device);
@@ -464,7 +452,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		}
 	}
 
-	/* create DRM and DMM device */
+	/* create DRM device */
 	r = omapdrm_init();
 	if (r < 0) {
 		pr_err("Unable to register omapdrm device\n");
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
