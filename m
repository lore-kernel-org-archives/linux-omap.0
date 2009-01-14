From: Tony Lindgren <tony@atomide.com>
Subject: Re: [OMAPZOOM][PATCH] OMAP34XXCAM: PM: Fix ifdefs to
	CONFIG_OMAP3_PM
Date: Wed, 14 Jan 2009 14:54:35 +0200
Message-ID: <20090114125434.GI29324@atomide.com>
References: <A24693684029E5489D1D202277BE8944164DF3B2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49598 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbZANMyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 07:54:35 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE8944164DF3B2@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [090114 12:06]:
> From 61698ca9a061f99c8f1d970a0a13c6f4d61b8e61 Mon Sep 17 00:00:00 2001
> From: Sergio Aguirre <saaguirre@ti.com>
> Date: Tue, 13 Jan 2009 10:06:49 -0600
> Subject: [PATCH] OMAP34XXCAM: PM: Fix ifdefs to CONFIG_OMAP3_PM
> 
> This patch fixes ifdef checking around PM constraints for
> OMAP3. This fixes compilation without TI PM.

These ifdefs are completely getting out of control in the omap-zoom
tree. There should be absolutely no need for CONFIG_OMAP3_PM.

Any ifdefs like that just make it harder to test the code properly
and further increases the diff from the mainline kernel.

It will also create a nightmare for you trying merge back code from
the mainline kernel. The same for trying create patches to send
upstream.

Tony




> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Reported-by: Anand Gadiyar <gadiyar@ti.com>
> ---
>  drivers/media/video/omap34xxcam.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/video/omap34xxcam.c b/drivers/media/video/omap34xxcam.c
> index 818ec6e..43eeb1c 100644
> --- a/drivers/media/video/omap34xxcam.c
> +++ b/drivers/media/video/omap34xxcam.c
> @@ -34,7 +34,7 @@
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ioctl.h>
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  #include <mach/resource.h>
>  #endif
>  
> @@ -48,7 +48,7 @@
>  /* global variables */
>  static struct omap34xxcam_device *omap34xxcam;
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	struct constraint_handle *co_opp_camera_vdd1;
>  	struct constraint_handle *co_opp_camera_vdd2;
>  	struct constraint_handle *co_opp_camera_latency;
> @@ -61,7 +61,7 @@ static int omap34xxcam_remove(struct platform_device *pdev);
>  struct omap34xxcam_fh *camfh_saved;
>  
>  /* constraint */
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	static struct constraint_id cnstr_id_vdd1 = {
>  		.type = RES_OPP_CO,
>  		.data = (void *)"vdd1_opp",
> @@ -725,7 +725,7 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
>  	isp_af_notify(0);
>  	isp_sgdma_init();
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	if (system_rev >= OMAP3430_REV_ES2_0) {
>  		if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
>  			/* Setting constraint for VDD1 */
> @@ -786,7 +786,7 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
>  
>  	omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	if (system_rev >= OMAP3430_REV_ES2_0) {
>  		if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
>  			/* Removing constraint for VDD1 */
> @@ -1456,7 +1456,7 @@ static int omap34xxcam_release(struct inode *inode, struct file *file)
>  	}
>  	mutex_unlock(&vdev->mutex);
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	if (system_rev >= OMAP3430_REV_ES2_0) {
>  		if (remove_constraints) {
>  			if (fh->pix.width >= 640 && fh->pix.height >= 480) {
> @@ -1828,7 +1828,7 @@ static int omap34xxcam_probe(struct platform_device *pdev)
>  
>  	omap34xxcam = cam;
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	if (system_rev >= OMAP3430_REV_ES2_0) {
>  		/* Getting constraint for VDD1 and VDD2 */
>  		co_opp_camera_latency = constraint_get("omap34xxcam",
> @@ -1882,7 +1882,7 @@ static int omap34xxcam_remove(struct platform_device *pdev)
>  		cam->mmio_base_phys = 0;
>  	}
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_OMAP3_PM
>  	if (system_rev >= OMAP3430_REV_ES2_0) {
>  		constraint_put(co_opp_camera_vdd1);
>  		constraint_put(co_opp_camera_vdd2);
> -- 
> 1.5.6.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
