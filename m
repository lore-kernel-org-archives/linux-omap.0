From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 3/28] [OMAPZOOM] OMAP: CAM: Misc Camera driver fixes
Date: Wed, 15 Oct 2008 20:18:13 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568838@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36311 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585AbYJPBSV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:18:21 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1IFXd023717
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:18:20 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1IFkM004707
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:18:15 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: Misc Camera driver fixes

This patch includes fixes for the following:
 - Removal of unneeded headers
 - Changed order of steps to execute on vbq release on active
   streaming.
 - Fixed IOCTL Name for AF Request Statistics in vidioc_default
 - Removed isp_open and isp_close calls from driver open/close
 - Removed Timestamp capture for AEWB stats from update_vbq
 - Added field_count reporting to AF driver for stats mapping.
 - Added _notify calls for communication from Camera driver to SCM
 - Removed RESUME powerstate handling, as it wasn't aprooved in v4l
 - Removed g_priv_mem handling, as it wasn't aprooved in v4l

Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
Signed-off-by: Mohit Jalori <mjalori@ti.com>
Signed-off-by: Troy Laramy <t-laramy@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/omap34xxcam.c |   32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

Index: omapkernel/drivers/media/video/omap34xxcam.c
===================================================================
--- omapkernel.orig/drivers/media/video/omap34xxcam.c   2008-10-14 18:52:48.000000000 -0500
+++ omapkernel/drivers/media/video/omap34xxcam.c        2008-10-14 18:57:05.000000000 -0500
@@ -35,10 +35,6 @@
 #include <media/v4l2-ioctl.h>

 #include "omap34xxcam.h"
-#include "isp/isp.h"
-#include "isp/ispmmu.h"
-#include "isp/ispreg.h"
-#include "isp/ispccdc.h"
 #include "isp/isph3a.h"
 #include "isp/isp_af.h"

@@ -111,20 +107,22 @@
 {
        struct omap34xxcam_fh *fh = camfh_saved;
        struct omap34xxcam_videodev *vdev = fh->vdev;
-       struct isph3a_aewb_xtrastats xtrastats;
        int rval = 0;
+       struct isph3a_aewb_xtrastats xtrastats;
+       struct isp_af_xtrastats af_xtrastats;

        do_gettimeofday(&vb->ts);
        vb->field_count = atomic_add_return(2, &fh->field_count);
        vb->state = VIDEOBUF_DONE;

-       xtrastats.ts = vb->ts;
        xtrastats.field_count = vb->field_count;
+       af_xtrastats.field_count = vb->field_count;

        if (vdev->streaming)
                rval = 1;

        wake_up(&vb->done);
+       isp_af_setxtrastats(&af_xtrastats, AF_UPDATEXS_FIELDCOUNT);
        isph3a_aewb_setxtrastats(&xtrastats);

        return rval;
@@ -170,9 +168,9 @@
                                    struct videobuf_buffer *vb)
 {
        if (!vbq->streaming) {
-               isp_vbq_release(vbq, vb);
                videobuf_dma_unmap(vbq, videobuf_to_dma(vb));
                videobuf_dma_free(videobuf_to_dma(vb));
+               isp_vbq_release(vbq, vb);
                vb->state = VIDEOBUF_NEEDS_INIT;
        }
        return;
@@ -694,6 +692,8 @@
        }

        cam->dma_notify = 1;
+       isph3a_notify(0);
+       isp_af_notify(0);
        isp_sgdma_init();
        rval = videobuf_streamon(&ofh->vbq);
        if (rval) {
@@ -702,7 +702,7 @@
        }


-       rval = omap34xxcam_slave_power_set(vdev, V4L2_POWER_RESUME);
+       rval = omap34xxcam_slave_power_set(vdev, V4L2_POWER_ON);
        if (!rval)
                vdev->streaming = file;
        else
@@ -733,7 +733,8 @@
        int rval;

        mutex_lock(&vdev->mutex);
-
+       isph3a_notify(1);
+       isp_af_notify(1);
        if (vdev->streaming == file)
                isp_stop();

@@ -1163,7 +1164,7 @@
                        }
                }
                break;
-               case VIDIOC_PRIVATE_ISP_AF_CFG: {
+               case VIDIOC_PRIVATE_ISP_AF_REQ: {
                        /* Need to update lens first */
                        struct isp_af_data *data;
                        struct v4l2_control vc;
@@ -1193,10 +1194,6 @@
                        }
                }
                break;
-               case VIDIOC_G_PRIV_MEM:
-                       rval = vidioc_int_g_priv_mem(vdev->vdev_sensor,
-                                               (struct v4l2_priv_mem *)arg);
-                       goto out;
                }

                rval = isp_handle_private(cmd, arg);
@@ -1316,7 +1313,6 @@

        if (atomic_inc_return(&vdev->users) == 1) {
                isp_get();
-               isp_open();
                if (omap34xxcam_slave_power_set(vdev, V4L2_POWER_ON))
                        goto out_slave_power_set_standby;
                if (omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY))
@@ -1348,7 +1344,6 @@

 out_slave_power_set_standby:
        omap34xxcam_slave_power_set(vdev, V4L2_POWER_OFF);
-       isp_close();
        isp_put();
        atomic_dec(&vdev->users);
        mutex_unlock(&vdev->mutex);
@@ -1384,6 +1379,8 @@

        mutex_lock(&vdev->mutex);
        if (vdev->streaming == file) {
+               isph3a_notify(1);
+               isp_af_notify(1);
                isp_stop();
                videobuf_streamoff(&fh->vbq);
                omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
@@ -1392,7 +1389,6 @@

        if (atomic_dec_return(&vdev->users) == 0) {
                omap34xxcam_slave_power_set(vdev, V4L2_POWER_OFF);
-               isp_close();
                isp_put();
        }
        mutex_unlock(&vdev->mutex);
@@ -1558,7 +1554,6 @@
        vdev->slave_config[hwc.dev_type] = hwc;

        isp_get();
-       isp_open();
        rval = omap34xxcam_slave_power_set(vdev, V4L2_POWER_ON);
        if (!rval && hwc.dev_type == OMAP34XXCAM_SLAVE_SENSOR) {
                struct v4l2_format format;
@@ -1576,7 +1571,6 @@
                vdev->want_timeperframe = a.parm.capture.timeperframe;
        }
        omap34xxcam_slave_power_set(vdev, V4L2_POWER_OFF);
-       isp_close();
        isp_put();

        if (rval)
