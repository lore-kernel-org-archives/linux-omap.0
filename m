From: Tony Lindgren <tony@atomide.com>
Subject: Re: [OMAPZOOM][PATCH] OMAP34XXCAM: PM: Fix ifdefs to CONFIG_OMAP3_PM
Date: Tue, 3 Feb 2009 10:37:33 -0800
Message-ID: <20090203183731.GF7215@atomide.com>
References: <A24693684029E5489D1D202277BE8944164DF3B2@dlee02.ent.ti.com> <20090114125434.GI29324@atomide.com> <FCCFB4CDC6E5564B9182F639FC3560870251462D75@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57173 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZBCShh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 13:37:37 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870251462D75@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [090114 07:02]:
> 
> >From: Tony Lindgren [mailto:tony@atomide.com]
> >Sent: Wednesday, January 14, 2009 6:55 AM
> >To: Aguirre Rodriguez, Sergio Alberto
> >Cc: linux-omap@vger.kernel.org; Pandita, Vikram
> >Subject: Re: [OMAPZOOM][PATCH] OMAP34XXCAM: PM: Fix ifdefs to CONFIG_OMAP3_PM
> >
> >
> >These ifdefs are completely getting out of control in the omap-zoom
> >tree. There should be absolutely no need for CONFIG_OMAP3_PM.
> 
> There is an absolute need for such an ifdef. 
> This is an old discussion happened so many times and has been a trigger for the omapzoom.org TI tree.
> 
> In l-o tree we do not have complete PM functionality and there are customers that want to go to actual "Products" in market. Eg: Latest Palm Pre and others
> 
> The current PM code shaping up on L-O tree is no doubt clean but what about the functionality complete aspect and Time to market.
> 
> Till then #ifdefs are the only option.

Yet the other platforms don't need silly ifdefs like that?

Believe me writing code based on ifdefs makes it unmaintainable
within months.

Tony


> 
> 
> >
> >
> >
> >
> >> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> >> Reported-by: Anand Gadiyar <gadiyar@ti.com>
> >> ---
> >>  drivers/media/video/omap34xxcam.c |   16 ++++++++--------
> >>  1 files changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/media/video/omap34xxcam.c b/drivers/media/video/omap34xxcam.c
> >> index 818ec6e..43eeb1c 100644
> >> --- a/drivers/media/video/omap34xxcam.c
> >> +++ b/drivers/media/video/omap34xxcam.c
> >> @@ -34,7 +34,7 @@
> >>  #include <media/v4l2-common.h>
> >>  #include <media/v4l2-ioctl.h>
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  #include <mach/resource.h>
> >>  #endif
> >>
> >> @@ -48,7 +48,7 @@
> >>  /* global variables */
> >>  static struct omap34xxcam_device *omap34xxcam;
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	struct constraint_handle *co_opp_camera_vdd1;
> >>  	struct constraint_handle *co_opp_camera_vdd2;
> >>  	struct constraint_handle *co_opp_camera_latency;
> >> @@ -61,7 +61,7 @@ static int omap34xxcam_remove(struct platform_device *pdev);
> >>  struct omap34xxcam_fh *camfh_saved;
> >>
> >>  /* constraint */
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	static struct constraint_id cnstr_id_vdd1 = {
> >>  		.type = RES_OPP_CO,
> >>  		.data = (void *)"vdd1_opp",
> >> @@ -725,7 +725,7 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
> >>  	isp_af_notify(0);
> >>  	isp_sgdma_init();
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	if (system_rev >= OMAP3430_REV_ES2_0) {
> >>  		if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
> >>  			/* Setting constraint for VDD1 */
> >> @@ -786,7 +786,7 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
> >>
> >>  	omap34xxcam_slave_power_set(vdev, V4L2_POWER_STANDBY);
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	if (system_rev >= OMAP3430_REV_ES2_0) {
> >>  		if (ofh->pix.width >= 640 && ofh->pix.height >= 480) {
> >>  			/* Removing constraint for VDD1 */
> >> @@ -1456,7 +1456,7 @@ static int omap34xxcam_release(struct inode *inode, struct file *file)
> >>  	}
> >>  	mutex_unlock(&vdev->mutex);
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	if (system_rev >= OMAP3430_REV_ES2_0) {
> >>  		if (remove_constraints) {
> >>  			if (fh->pix.width >= 640 && fh->pix.height >= 480) {
> >> @@ -1828,7 +1828,7 @@ static int omap34xxcam_probe(struct platform_device *pdev)
> >>
> >>  	omap34xxcam = cam;
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	if (system_rev >= OMAP3430_REV_ES2_0) {
> >>  		/* Getting constraint for VDD1 and VDD2 */
> >>  		co_opp_camera_latency = constraint_get("omap34xxcam",
> >> @@ -1882,7 +1882,7 @@ static int omap34xxcam_remove(struct platform_device *pdev)
> >>  		cam->mmio_base_phys = 0;
> >>  	}
> >>
> >> -#ifdef CONFIG_PM
> >> +#ifdef CONFIG_OMAP3_PM
> >>  	if (system_rev >= OMAP3430_REV_ES2_0) {
> >>  		constraint_put(co_opp_camera_vdd1);
> >>  		constraint_put(co_opp_camera_vdd2);
> >> --
> >> 1.5.6.5
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
