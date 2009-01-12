From: "Curran, Dominic" <dcurran@ti.com>
Subject: RE: [OMAPZOOM][PATCH v2 2/2] OMAP3: CAM: PM: Set VPP constraints
Date: Mon, 12 Jan 2009 13:01:20 -0600
Message-ID: <96DA7A230D3B2F42BA3EF203A7A1B3B5011E86C868@dlee07.ent.ti.com>
References: <A24693684029E5489D1D202277BE894416328C90@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbZALTB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 14:01:28 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n0CJ1L6L003859
	for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 13:01:26 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n0CJ1LDa018844
	for <linux-omap@vger.kernel.org>; Mon, 12 Jan 2009 13:01:21 -0600 (CST)
In-Reply-To: <A24693684029E5489D1D202277BE894416328C90@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre Rodriguez, Sergio Alberto
> Sent: Wednesday, January 07, 2009 6:13 PM
> To: linux-omap@vger.kernel.org
> Cc: Pandita, Vikram
> Subject: [OMAPZOOM][PATCH v2 2/2] OMAP3: CAM: PM: Set VPP constraints
>
> From 4b5990f22778c428b17b3b3675676d22eb0b857b Mon Sep 17 00:00:00 2001
> From: Sergio Aguirre <saaguirre@ti.com>
> Date: Wed, 7 Jan 2009 17:08:53 -0600
> Subject: [PATCH] OMAP3: CAM: PM: Set VPP constraints
>
> This patch is for making camera work as expected when TI PM is enabled.
>
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Ack-by: Dominic Curran <dcurran@ti.com>

This patch has worked for me when tested with a Sony sensor.

> ---
>  drivers/media/video/omap34xxcam.c |   86
> +++++++++++++++++++++++++++++++++++++
>  1 files changed, 86 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 drivers/media/video/omap34xxcam.c
>
> diff --git a/drivers/media/video/omap34xxcam.c
> b/drivers/media/video/omap34xxcam.c
> old mode 100644
> new mode 100755
> index 7fe3981..818ec6e
> --- a/drivers/media/video/omap34xxcam.c
> +++ b/drivers/media/video/omap34xxcam.c
> @@ -34,6 +34,10 @@
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ioctl.h>
>
> +#ifdef CONFIG_PM
> +#include <mach/resource.h>
> +#endif
> +
>  #include "omap34xxcam.h"
>  #include "isp/isph3a.h"
>  #include "isp/isp_af.h"
> @@ -44,12 +48,35 @@
>  /* global variables */
>  static struct omap34xxcam_device *omap34xxcam;
>
> +#ifdef CONFIG_PM
> +     struct constraint_handle *co_opp_camera_vdd1;
> +     struct constraint_handle *co_opp_camera_vdd2;
> +     struct constraint_handle *co_opp_camera_latency;
> +#endif
> +
>  /* module parameters */
>  static int omap34xxcam_device_register(struct v4l2_int_device *s);
>  static void omap34xxcam_device_unregister(struct v4l2_int_device *s);
>  static int omap34xxcam_remove(struct platform_device *pdev);
>  struct omap34xxcam_fh *camfh_saved;
>
> +/* constraint */
> +#ifdef CONFIG_PM
> +     static struct constraint_id cnstr_id_vdd1 = {
> +             .type = RES_OPP_CO,
> +             .data = (void *)"vdd1_opp",
> +     };
> +
> +     static struct constraint_id cnstr_id_vdd2 = {
> +             .type = RES_OPP_CO,
> +             .data = (void *)"vdd2_opp",
> +     };
> +
> +     static struct constraint_id cnstr_id_latency = {
> +             .type = RES_LATENCY_CO,
> +             .data = (void *)"latency",
> +     };
> +#endif
>  /*
>   *
>   * Sensor handling.
> @@ -697,6 +724,19 @@ static int vidioc_streamon(struct file *file, void *fh,
> enum v4l2_buf_type i)
>       isph3a_notify(0);
>       isp_af_notify(0);
>       isp_sgdma_init();
> +
> +#ifdef CONFIG_PM
> +     if (system_rev >= OMAP3430_REV_ES2_0) {
> +             if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
> +                     /* Setting constraint for VDD1 */
> +                     constraint_set(co_opp_camera_vdd1, CO_VDD1_OPP3);
> +             }
> +             /* Setting constraint for VDD2 */
> +             constraint_set(co_opp_camera_vdd2, CO_VDD2_OPP3);
> +             constraint_set(co_opp_camera_latency, CO_LATENCY_WFI);
> +     }
> +#endif
> +
>       rval = videobuf_streamon(&ofh->vbq);
>       if (rval) {
>               dev_dbg(vdev->cam->dev, "omap34xxcam_slave_power_set failed\n");
> @@ -746,6 +786,18 @@ static int vidioc_streamoff(struct file *file, void *fh,
> enum v4l2_buf_type i)
>
>       omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
>
> +#ifdef CONFIG_PM
> +     if (system_rev >= OMAP3430_REV_ES2_0) {
> +             if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
> +                     /* Removing constraint for VDD1 */
> +                     constraint_remove(co_opp_camera_vdd1);
> +             }
> +             /* Removing constraint for VDD2 */
> +             constraint_remove(co_opp_camera_vdd2);
> +             constraint_remove(co_opp_camera_latency);
> +     }
> +#endif
> +
>       mutex_unlock(&vdev->mutex);
>
>       return rval;
> @@ -1384,6 +1436,7 @@ static int omap34xxcam_release(struct inode *inode,
> struct file *file)
>  {
>       struct omap34xxcam_fh *fh = file->private_data;
>       struct omap34xxcam_videodev *vdev = fh->vdev;
> +     int remove_constraints = 0;
>       int i;
>
>       mutex_lock(&vdev->mutex);
> @@ -1394,6 +1447,7 @@ static int omap34xxcam_release(struct inode *inode,
> struct file *file)
>               videobuf_streamoff(&fh->vbq);
>               omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
>               vdev->streaming = NULL;
> +             remove_constraints = 1;
>       }
>
>       if (atomic_dec_return(&vdev->users) == 0) {
> @@ -1402,6 +1456,20 @@ static int omap34xxcam_release(struct inode *inode,
> struct file *file)
>       }
>       mutex_unlock(&vdev->mutex);
>
> +#ifdef CONFIG_PM
> +     if (system_rev >= OMAP3430_REV_ES2_0) {
> +             if (remove_constraints) {
> +                     if (fh->pix.width >= 640 && fh->pix.height >= 480) {
> +                             /* Removing constraint for VDD1 */
> +                             constraint_remove(co_opp_camera_vdd1);
> +                     }
> +                     /* Removing constraint for VDD2 */
> +                     constraint_remove(co_opp_camera_vdd2);
> +                     constraint_remove(co_opp_camera_latency);
> +             }
> +     }
> +#endif
> +
>       file->private_data = NULL;
>
>       for (i = 0; i <= OMAP34XXCAM_SLAVE_FLASH; i++)
> @@ -1760,6 +1828,16 @@ static int omap34xxcam_probe(struct platform_device
> *pdev)
>
>       omap34xxcam = cam;
>
> +#ifdef CONFIG_PM
> +     if (system_rev >= OMAP3430_REV_ES2_0) {
> +             /* Getting constraint for VDD1 and VDD2 */
> +             co_opp_camera_latency = constraint_get("omap34xxcam",
> +                                                             &cnstr_id_latency);
> +             co_opp_camera_vdd1 = constraint_get("omap34xxcam",
> &cnstr_id_vdd1);
> +             co_opp_camera_vdd2 = constraint_get("omap34xxcam",
> &cnstr_id_vdd2);
> +     }
> +#endif
> +
>       return 0;
>
>  err:
> @@ -1804,6 +1882,14 @@ static int omap34xxcam_remove(struct platform_device
> *pdev)
>               cam->mmio_base_phys = 0;
>       }
>
> +#ifdef CONFIG_PM
> +     if (system_rev >= OMAP3430_REV_ES2_0) {
> +             constraint_put(co_opp_camera_vdd1);
> +             constraint_put(co_opp_camera_vdd2);
> +             constraint_put(co_opp_camera_latency);
> +     }
> +#endif
> +
>       kfree(cam);
>
>       return 0;
> --
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

