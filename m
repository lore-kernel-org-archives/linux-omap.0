From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 20/28] [OMAPZOOM] OMAP: CAM: DW9710: RESUME Removal
Date: Wed, 15 Oct 2008 20:32:27 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568854@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbYJPBce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:32:34 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1WSPL031872
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:32:33 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1WSI3018286
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:32:28 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: DW9710: RESUME Removal

This patch removes the use of the V4L2_POWER_RESUME state, as it has
been rejected in video4linux list

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/dw9710.c  |    6 +++---
 drivers/media/video/mt9p012.c |   14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

Index: omapkernel/drivers/media/video/dw9710.c
===================================================================
--- omapkernel.orig/drivers/media/video/dw9710.c        2008-10-14 18:51:36.000000000 -0500
+++ omapkernel/drivers/media/video/dw9710.c     2008-10-14 18:51:53.000000000 -0500
@@ -421,8 +421,6 @@

        rval = lens->pdata->power_set(on);

-       lens->power_state = on;
-
        if ((on == V4L2_POWER_ON) && (lens->state == LENS_NOT_DETECTED)) {
                rval = dw9710_detect(c);
                if (rval < 0) {
@@ -437,9 +435,11 @@
                pr_info(DRIVER_NAME " lens HW detected\n");
        }

-       if ((on == V4L2_POWER_RESUME) && (lens->state == LENS_DETECTED))
+       if ((lens->power_state == V4L2_POWER_STANDBY) && (on == V4L2_POWER_ON)
+                                       && (lens->state == LENS_DETECTED))
                dw9710_af_setfocus(lens->current_lens_posn);

+       lens->power_state = on;
        return 0;
 }

