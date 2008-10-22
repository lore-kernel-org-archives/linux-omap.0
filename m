From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 3/3] [OMAPZOOM] OMAP3ISP: Don't drop clocks before MMU
 unmapping
Date: Wed, 22 Oct 2008 16:48:39 -0500
Message-ID: <A24693684029E5489D1D202277BE894412705AF3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49004 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbYJVVsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 17:48:46 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9MLmedg013135
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:48:45 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9MLmeYJ017176
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 16:48:40 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sakari Ailus <sakari.ailus@nokia.com>
Date: Wed, 22 Oct 2008 18:11:42 +0300
Subject: [PATCH] OMAP3ISP: Don't drop clocks before MMU unmapping

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c
+++ omapkernel/drivers/media/video/isp/isp.c
@@ -2355,6 +2355,9 @@ int isp_put(void)
                if (--isp_obj.ref_count == 0) {
                        isp_save_ctx();
                        off_mode = 1;
+#if ISP_WORKAROUND
+                       isp_buf_free();
+#endif
                        isp_release_resources();
                        ispmodule_obj.isp_pipeline = 0;
                        clk_disable(isp_obj.cam_ick);
@@ -2365,9 +2368,6 @@ int isp_put(void)
                        clk_put(isp_obj.csi2_fck);
                        memset(&ispcroprect, 0, sizeof(ispcroprect));
                        memset(&cur_rect, 0, sizeof(cur_rect));
-#if ISP_WORKAROUND
-                       isp_buf_free();
-#endif
                }
        mutex_unlock(&(isp_obj.isp_mutex));
        DPRINTK_ISPCTRL("isp_put: new %d\n", isp_obj.ref_count);

