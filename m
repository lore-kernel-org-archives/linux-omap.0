From: Muralidharan Karicheri <mkaricheri@gmail.com>
Subject: Re: [PATCH 1/2] OMAP2/3 V4L2: Add support for OMAP2/3 V4L2 driver on
	top of DSS2
Date: Fri, 2 Apr 2010 16:03:14 -0400
Message-ID: <z2j55a3e0ce1004021303rdf3092f7r87b119cd97687f9b@mail.gmail.com>
References: <hvaibhav@ti.com>
	 <1270115880-21404-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f217.google.com ([209.85.218.217]:61629 "EHLO
	mail-bw0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0DBUKi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 16:10:38 -0400
In-Reply-To: <1270115880-21404-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-media@vger.kernel.org, m-karicheri2@ti.com, mchehab@redhat.com, linux-omap@vger.kernel.org, tony@atomide.com

Vaibhav,

I have some comments on this patch. Please address them.

> +
> +#include <asm/processor.h>

Add a line here??

> +#include <plat/dma.h>
> +#include <plat/vram.h>
> +#include <plat/vrfb.h>
> +#include <plat/display.h>
> +
> +#include "omap_voutlib.h"
> +#include "omap_voutdef.h"
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("OMAP Video for Linux Video out driver");
> +MODULE_LICENSE("GPL");
> +
> +
> +/* Driver Configuration macros */
> +#define VOUT_NAME =A0 =A0 =A0 =A0 =A0 =A0 =A0"omap_vout"
> +
> +enum omap_vout_channels {
> + =A0 =A0 =A0 OMAP_VIDEO1 =3D 0,
Why do we have to initialize this to 0. It always start with a value 0
by default.

> + =A0 =A0 =A0 OMAP_VIDEO2,
> +};
> +
> +enum dma_channel_state {
> + =A0 =A0 =A0 DMA_CHAN_NOT_ALLOTED =3D 0,

Ditto.

> + =A0 =A0 =A0 DMA_CHAN_ALLOTED,
> +};
> +
> +#define QQVGA_WIDTH =A0 =A0 =A0 =A0 =A0 =A0160
> +#define QQVGA_HEIGHT =A0 =A0 =A0 =A0 =A0 120
> +
> +/* Max Resolution supported by the driver */
> +#define VID_MAX_WIDTH =A0 =A0 =A0 =A0 =A01280 =A0 =A0/* Largest widt=
h */
> +#define VID_MAX_HEIGHT =A0 =A0 =A0 =A0 720 =A0 =A0 /* Largest height=
 */
> +

-------------------------------------

> +
> +module_param(debug, bool, S_IRUGO);
> +MODULE_PARM_DESC(debug, "Debug level (0-1)");
> +
> +/* Local Helper functions */
> +static void omap_vout_isr(void *arg, unsigned int irqstatus);
> +static void omap_vout_cleanup_device(struct omap_vout_device *vout);
> +

Is there a reason why you need these prototypes? I think we could
remove these prototypes and move the function ahead in the file before
it is called.

> +/* list of image formats supported by OMAP2 video pipelines */
> +const static struct v4l2_fmtdesc omap_formats[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Note: =A0V4L2 defines RGB565 as:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0Byte 0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Byte 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0g2 g1 g0 r4 r3 r2 r1 r0=
 =A0 b4 b3 b2 b1 b0 g5 g4 g3
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We interpret RGB565 as:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0Byte 0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Byte 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0g2 g1 g0 b4 b3 b2 b1 b0=
 =A0 r4 r3 r2 r1 r0 g5 g4 g3
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .description =3D "RGB565, le",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixelformat =3D V4L2_PIX_FMT_RGB565,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Note: =A0V4L2 defines RGB32 as: RGB-=
8-8-8-8 =A0we use
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0this for RGB24 unpack mode, the=
 last 8 bits are ignored
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .description =3D "RGB32, le",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixelformat =3D V4L2_PIX_FMT_RGB32,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Note: =A0V4L2 defines RGB24 as: RGB-=
8-8-8 =A0we use
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 =A0 =A0this for RGB24 pack=
ed mode
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .description =3D "RGB24, le",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixelformat =3D V4L2_PIX_FMT_RGB24,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .description =3D "YUYV (YUV 4:2:2), pac=
ked",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixelformat =3D V4L2_PIX_FMT_YUYV,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .description =3D "UYVY, packed",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixelformat =3D V4L2_PIX_FMT_UYVY,
> + =A0 =A0 =A0 },
> +};
> +
> +#define NUM_OUTPUT_FORMATS (ARRAY_SIZE(omap_formats))
> +
> +/*
> + * Allocate buffers
> + */

----------------------------------

> +
> +/*
> + * omap_vout_uservirt_to_phys: This inline function is used to conve=
rt user
> + * space virtual address to physical address.
> + */
> +static u32 omap_vout_uservirt_to_phys(u32 virtp)
> +{
> + =A0 =A0 =A0 unsigned long physp =3D 0;
> + =A0 =A0 =A0 struct vm_area_struct *vma;
> + =A0 =A0 =A0 struct mm_struct *mm =3D current->mm;
> +
> + =A0 =A0 =A0 vma =3D find_vma(mm, virtp);
> + =A0 =A0 =A0 /* For kernel direct-mapped memory, take the easy way *=
/
> + =A0 =A0 =A0 if (virtp >=3D PAGE_OFFSET) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D virt_to_phys((void *) virtp);
> + =A0 =A0 =A0 } else if (vma && (vma->vm_flags & VM_IO)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && vma->vm_pgoff) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this will catch, kernel-allocated,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmaped-to-usermode addresses */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D (vma->vm_pgoff << PAGE_SHIFT)=
 + (virtp - vma->vm_start);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* otherwise, use get_user_pages() for =
general userland pages */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int res, nr_pages =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct page *pages;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 down_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D get_user_pages(current, current=
->mm, virtp, nr_pages,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, 0, &=
pages, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up_read(&current->mm->mmap_sem);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D nr_pages) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 physp =3D =A0__pa(page_=
address(&pages[0]) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (virtp & ~PAGE_MASK));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING VOU=
T_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "get_user_pages failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return physp;
> +}

Shouldn't we remove omap_vout_uservirt_to_phys() and use videobuf_ioloc=
k()
instead as we have done in vpfe_capture.c?

-------------------------------------------------


> +
> +/*
> + * Convert V4L2 rotation to DSS rotation
> + * =A0 =A0 V4L2 understand 0, 90, 180, 270.
> + * =A0 =A0 Convert to 0, 1, 2 and 3 repsectively for DSS
> + */
> +static int v4l2_rot_to_dss_rot(int v4l2_rotation, enum dss_rotation =
*rotation,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool mirror)
> +{
Suggest adding a variable int ret =3D 0;
and return ret at the end of the function instead of return at each cas=
e.

> + =A0 =A0 =A0 switch (v4l2_rotation) {
> + =A0 =A0 =A0 case 90:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rotation =3D dss_rotation_90_degree;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
use break instead of return here
> + =A0 =A0 =A0 case 180:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rotation =3D dss_rotation_180_degree;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
Ditto
> + =A0 =A0 =A0 case 270:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rotation =3D dss_rotation_270_degree;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
Ditto
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *rotation =3D dss_rotation_0_degree;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
Ditto
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;

ret =3D -EINVAL;

> + =A0 =A0 =A0 }

return ret;
> +
> +}

------------------------------------------------------------



> +/*
> + * Convert V4L2 pixel format to DSS pixel format
> + */
> +static enum omap_color_mode video_mode_to_dss_mode(struct omap_vout_=
device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *vout)
> +{
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &vout->pix;
> +
> + =A0 =A0 =A0 ovid =3D &vout->vid_info;
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 switch (pix->pixelformat) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_YUYV:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_YUV2;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_UYVY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_UYVY;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB565:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGB16;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB24:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGB24P;
> +
> + =A0 =A0 =A0 case V4L2_PIX_FMT_RGB32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (ovl->id =3D=3D OMAP_DSS_VIDEO1)=
 ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_COLOR_RGB24U :=
 OMAP_DSS_COLOR_ARGB32;
> + =A0 =A0 =A0 case V4L2_PIX_FMT_BGR32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGBX32;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;

Also return type is eum and you are returning a negative number here ??=
?

> +}

Similar comment for this function as well. return at the end of the fun=
ction.

> +
> +/*
> + * Setup the overlay
> + */
> +int omapvid_setup_overlay(struct omap_vout_device *vout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl, int posx, int=
 posy, int outw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int outh, u32 addr)

-----------------------------------------------------------------



> +
> +static int vidioc_try_fmt_vid_out(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_format *f)
> +{
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_video_timings *timing;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh;
> +
> + =A0 =A0 =A0 if (vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;

When application calls a TRY_FMT, I think as per v4l spec, driver
shouldn't change the state. So why should we return -EBUSY here?

> +
> + =A0 =A0 =A0 ovid =3D &vout->vid_info;
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 timing =3D &ovl->manager->device->panel.timings;
> +
> + =A0 =A0 =A0 vout->fbuf.fmt.height =3D timing->y_res;
> + =A0 =A0 =A0 vout->fbuf.fmt.width =3D timing->x_res;
> +
> + =A0 =A0 =A0 omap_vout_try_format(&f->fmt.pix);
> + =A0 =A0 =A0 return 0;
> +}
> +

---------------------------------------------------------------------


> +
> +static int vidioc_g_ctrl(struct file *file, void *fh, struct v4l2_co=
ntrol *ctrl)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh;
> +
> + =A0 =A0 =A0 switch (ctrl->id) {
> + =A0 =A0 =A0 case V4L2_CID_ROTATE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl->value =3D vout->control[0].value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 case V4L2_CID_BG_COLOR:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_manager_info info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D vout->vid_info.overlays[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->get=
_manager_info)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->get_manager_info(ovl->man=
ager, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl->value =3D info.default_color;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_CID_VFLIP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl->value =3D vout->control[2].value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +}

Return at the end and use break for each case.

> +
> +static int vidioc_s_ctrl(struct file *file, void *fh, struct v4l2_co=
ntrol *a)
> +{
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh;
> +
> + =A0 =A0 =A0 switch (a->id) {
> + =A0 =A0 =A0 case V4L2_CID_ROTATE:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int rotation =3D a->value;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&vout->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rotation &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->pix.pixelformat =3D=
=3D V4L2_PIX_FMT_RGB24) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->loc=
k);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((v4l2_rot_to_dss_rot(rotation, &vou=
t->rotation,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->m=
irror))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->loc=
k);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->control[0].value =3D rotation;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_CID_BG_COLOR:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int =A0color =3D a->value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_manager_info info;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D vout->vid_info.overlays[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->get=
_manager_info) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->loc=
k);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->get_manager_info(ovl->man=
ager, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.default_color =3D color;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager->set_manager_info(ovl-=
>manager, &info)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->loc=
k);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->control[1].value =3D color;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_CID_VFLIP:
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int =A0mirror =3D a->value;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovid =3D &vout->vid_info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&vout->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mirror =A0&& vout->pix.pixelformat =
=3D=3D V4L2_PIX_FMT_RGB24) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->loc=
k);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->mirror =3D mirror;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->control[2].value =3D mirror;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&vout->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +

Ditto,

--------------------------------------------------------------



> +
> +static int vidioc_streamon(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum v4l2_buf_type i)
> +{
> + =A0 =A0 =A0 int ret =3D 0, j;
> + =A0 =A0 =A0 u32 addr =3D 0, mask =3D 0;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh;
> + =A0 =A0 =A0 struct videobuf_queue *q =3D &vout->vbq;
> + =A0 =A0 =A0 struct omapvideo_info *ovid =3D &vout->vid_info;
> +
> + =A0 =A0 =A0 mutex_lock(&vout->lock);
> +
> + =A0 =A0 =A0 if (vout->streaming) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto streamon_err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D videobuf_streamon(q);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto streamon_err;
> +
> + =A0 =A0 =A0 if (list_empty(&vout->dma_queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto streamon_err;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Get the next frame from the buffer queue */
> + =A0 =A0 =A0 vout->next_frm =3D vout->cur_frm =3D list_entry(vout->d=
ma_queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct videobuf_buffer,=
 queue);
> + =A0 =A0 =A0 /* Remove buffer from the buffer queue */
> + =A0 =A0 =A0 list_del(&vout->cur_frm->queue);
> + =A0 =A0 =A0 /* Mark state of the current frame to active */
> + =A0 =A0 =A0 vout->cur_frm->state =3D VIDEOBUF_ACTIVE;
> + =A0 =A0 =A0 /* Initialize field_id and started member */
> + =A0 =A0 =A0 vout->field_id =3D 0;
> +
> + =A0 =A0 =A0 /* set flag here. Next QBUF will start DMA */
> + =A0 =A0 =A0 vout->streaming =3D 1;
> +
> + =A0 =A0 =A0 vout->first_int =3D 1;
> +
> + =A0 =A0 =A0 if (omap_vout_calculate_offset(vout)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto streamon_err;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 addr =3D (unsigned long) vout->queued_buf_addr[vout->cu=
r_frm->i]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 + vout->cropped_offset;
> +
> + =A0 =A0 =A0 mask =3D DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_EVEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DISPC_IRQ_EVSYNC_ODD;
> +
> + =A0 =A0 =A0 omap_dispc_register_isr(omap_vout_isr, vout, mask);
> +
> + =A0 =A0 =A0 for (j =3D 0; j < ovid->num_overlays; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl =3D ovid->over=
lays[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl->manager->devic=
e) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_inf=
o info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->get_overlay_info(o=
vl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.enabled =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.paddr =3D addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->set_overlay_in=
fo(ovl, &info)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto st=
reamon_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* First save the configuration in ovelray structure */
> + =A0 =A0 =A0 ret =3D omapvid_init(vout, addr);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_err(&vout->vid_dev->v4l2_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 to set overlay info\n");
> + =A0 =A0 =A0 /* Enable the pipeline and set the Go bit */
> + =A0 =A0 =A0 ret =3D omapvid_apply_changes(vout);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_err(&vout->vid_dev->v4l2_dev, "fai=
led to change mode\n");
> +
> + =A0 =A0 =A0 ret =3D 0;
> +
> +streamon_err:

In some error cases,  the videobuf_streamon() is already called. So
you have to call videobuf_streamoff() before return

> + =A0 =A0 =A0 mutex_unlock(&vout->lock);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int vidioc_streamoff(struct file *file, void *fh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum v4l2_buf_type i)
> +{
> + =A0 =A0 =A0 u32 mask =3D 0;
> + =A0 =A0 =A0 int ret =3D 0, j;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D fh;
> + =A0 =A0 =A0 struct omapvideo_info *ovid =3D &vout->vid_info;
> +
> + =A0 =A0 =A0 if (!vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 vout->streaming =3D 0;
> + =A0 =A0 =A0 mask =3D DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_EVEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DISPC_IRQ_EVSYNC_ODD;
> +
> + =A0 =A0 =A0 omap_dispc_unregister_isr(omap_vout_isr, vout, mask);
> +
> + =A0 =A0 =A0 for (j =3D 0; j < ovid->num_overlays; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl =3D ovid->over=
lays[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl->manager->devic=
e) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay_inf=
o info;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->get_overlay_info(o=
vl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.enabled =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ovl->set_overla=
y_info(ovl, &info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_er=
r(&vout->vid_dev->v4l2_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed to update overlay info\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ret;

This is a failure.  In that case shouldn't we call videobuf_streamoff,
videobuf_queue_cancel etc as done below?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Turn of the pipeline */
> + =A0 =A0 =A0 ret =3D omapvid_apply_changes(vout);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v4l2_err(&vout->vid_dev->v4l2_dev, "fai=
led to change mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }

Ditto,

> + =A0 =A0 =A0 INIT_LIST_HEAD(&vout->dma_queue);
> + =A0 =A0 =A0 videobuf_streamoff(&vout->vbq);
> + =A0 =A0 =A0 videobuf_queue_cancel(&vout->vbq);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +


-----------------------------------------



> +
> +/* Init functions used during driver intitalization */
> +/* Initial setup of video_data */
> +static int __init omap_vout_setup_video_data(struct omap_vout_device=
 *vout)
> +{
> + =A0 =A0 =A0 struct video_device *vfd;
> + =A0 =A0 =A0 struct v4l2_pix_format *pix;
> + =A0 =A0 =A0 struct v4l2_control *control;
> + =A0 =A0 =A0 struct omap_dss_device *display =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays[0]->manager->de=
vice;
> +
> + =A0 =A0 =A0 /* set the default pix */
> + =A0 =A0 =A0 pix =3D &vout->pix;
> +
> + =A0 =A0 =A0 /* Set the default picture of QVGA =A0*/
> + =A0 =A0 =A0 pix->width =3D QQVGA_WIDTH;
> + =A0 =A0 =A0 pix->height =3D QQVGA_HEIGHT;
> +
> + =A0 =A0 =A0 /* Default pixel format is RGB 5-6-5 */
> + =A0 =A0 =A0 pix->pixelformat =3D V4L2_PIX_FMT_RGB565;
> + =A0 =A0 =A0 pix->field =3D V4L2_FIELD_ANY;
> + =A0 =A0 =A0 pix->bytesperline =3D pix->width * 2;
> + =A0 =A0 =A0 pix->sizeimage =3D pix->bytesperline * pix->height;
> + =A0 =A0 =A0 pix->priv =3D 0;
> + =A0 =A0 =A0 pix->colorspace =3D V4L2_COLORSPACE_JPEG;
> +
> + =A0 =A0 =A0 vout->bpp =3D RGB565_BPP;
> + =A0 =A0 =A0 vout->fbuf.fmt.width =A0=3D =A0display->panel.timings.x=
_res;
> + =A0 =A0 =A0 vout->fbuf.fmt.height =3D =A0display->panel.timings.y_r=
es;
> +
> + =A0 =A0 =A0 /* Set the data structures for the overlay parameters*/
> + =A0 =A0 =A0 vout->win.global_alpha =3D 255;
> + =A0 =A0 =A0 vout->fbuf.flags =3D 0;
> + =A0 =A0 =A0 vout->fbuf.capability =3D V4L2_FBUF_CAP_LOCAL_ALPHA |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4L2_FBUF_CAP_SRC_CHROMAKEY | V4L2_FBUF=
_CAP_CHROMAKEY;
> + =A0 =A0 =A0 vout->win.chromakey =3D 0;
> +
> + =A0 =A0 =A0 omap_vout_new_format(pix, &vout->fbuf, &vout->crop, &vo=
ut->win);
> +
> + =A0 =A0 =A0 /*Initialize the control variables for
> + =A0 =A0 =A0 =A0 rotation, flipping and background color. */
> + =A0 =A0 =A0 control =3D vout->control;
> + =A0 =A0 =A0 control[0].id =3D V4L2_CID_ROTATE;
> + =A0 =A0 =A0 control[0].value =3D 0;
> + =A0 =A0 =A0 vout->rotation =3D 0;
> + =A0 =A0 =A0 vout->mirror =3D 0;
> + =A0 =A0 =A0 vout->control[2].id =3D V4L2_CID_HFLIP;
> + =A0 =A0 =A0 vout->control[2].value =3D 0;
> + =A0 =A0 =A0 vout->vrfb_bpp =3D 2;
> +
> + =A0 =A0 =A0 control[1].id =3D V4L2_CID_BG_COLOR;
> + =A0 =A0 =A0 control[1].value =3D 0;
> +
> + =A0 =A0 =A0 /* initialize the video_device struct */
> + =A0 =A0 =A0 vfd =3D vout->vfd =3D video_device_alloc();
> +
> + =A0 =A0 =A0 if (!vfd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAME ": could not =
allocate"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " video=
 device struct\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vfd->release =3D video_device_release;
> + =A0 =A0 =A0 vfd->ioctl_ops =3D &vout_ioctl_ops;
> +
> + =A0 =A0 =A0 strlcpy(vfd->name, VOUT_NAME, sizeof(vfd->name));
> + =A0 =A0 =A0 vfd->vfl_type =3D VFL_TYPE_GRABBER;
> +
> + =A0 =A0 =A0 /* need to register for a VID_HARDWARE_* ID in videodev=
=2Eh */
> + =A0 =A0 =A0 vfd->fops =3D &omap_vout_fops;
> + =A0 =A0 =A0 mutex_init(&vout->lock);
> +
> + =A0 =A0 =A0 vfd->minor =3D -1;
> + =A0 =A0 =A0 return 0;
> +
> +}
> +
> +/* Setup video buffers */
> +static int __init omap_vout_setup_video_bufs(struct platform_device =
*pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int vid_num)
> +{
> + =A0 =A0 =A0 u32 numbuffers;
> + =A0 =A0 =A0 int ret =3D 0, i, j;
> + =A0 =A0 =A0 int image_width, image_height;
> + =A0 =A0 =A0 struct video_device *vfd;
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 int static_vrfb_allocation =3D 0, vrfb_num_bufs =3D 4;
> + =A0 =A0 =A0 struct v4l2_device *v4l2_dev =3D platform_get_drvdata(p=
dev);
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(v4l2_dev, struct omap2vide=
o_device, v4l2_dev);
> +
> + =A0 =A0 =A0 vout =3D vid_dev->vouts[vid_num];
> + =A0 =A0 =A0 vfd =3D vout->vfd;
> +
> + =A0 =A0 =A0 numbuffers =3D (vid_num =3D=3D 0) ? video1_numbuffers :=
 video2_numbuffers;
> + =A0 =A0 =A0 vout->buffer_size =3D (vid_num =3D=3D 0) ? video1_bufsi=
ze : video2_bufsize;
> + =A0 =A0 =A0 dev_info(&pdev->dev, "Buffer Size =3D %d\n", vout->buff=
er_size);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < numbuffers; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_alloc_buffer(=
vout->buffer_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (u32 *) &vout->buf_phy_addr[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->buf_virt_addr[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 numbuffers =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_buffers;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 4; i++) {

Can we replace magic number 4 with a #define? I see this number at
several places in the code.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vrfb_request_ctx(&vout->vrfb_c=
ontext[i])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, ":=
 VRFB allocation failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < i; j+=
+)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vr=
fb_release_ctx(&vout->vrfb_context[j]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_buffers;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vout->cropped_offset =3D 0;
> +
> + =A0 =A0 =A0 /* Calculate VRFB memory size */
> + =A0 =A0 =A0 /* allocate for worst case size */
> + =A0 =A0 =A0 image_width =3D VID_MAX_WIDTH / TILE_SIZE;
> + =A0 =A0 =A0 if (VID_MAX_WIDTH % TILE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 image_width++;
> +
> + =A0 =A0 =A0 image_width =3D image_width * TILE_SIZE;
> + =A0 =A0 =A0 image_height =3D VID_MAX_HEIGHT / TILE_SIZE;
> +
> + =A0 =A0 =A0 if (VID_MAX_HEIGHT % TILE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 image_height++;
> +
> + =A0 =A0 =A0 image_height =3D image_height * TILE_SIZE;
> + =A0 =A0 =A0 vout->smsshado_size =3D PAGE_ALIGN(image_width * image_=
height * 2 * 2);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Request and Initialize DMA, for DMA based VRFB tra=
nsfer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 vout->vrfb_dma_tx.dev_id =3D OMAP_DMA_NO_DEVICE;
> + =A0 =A0 =A0 vout->vrfb_dma_tx.dma_ch =3D -1;
> + =A0 =A0 =A0 vout->vrfb_dma_tx.req_status =3D DMA_CHAN_ALLOTED;
> + =A0 =A0 =A0 ret =3D omap_request_dma(vout->vrfb_dma_tx.dev_id, "VRF=
B DMA TX",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_vrfb_dma_tx_c=
allback,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *) &vout->vrfb_dm=
a_tx, &vout->vrfb_dma_tx.dma_ch);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_dma_tx.req_status =3D DMA_CH=
AN_NOT_ALLOTED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, ": failed to alloc=
ate DMA Channel for"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " video=
%d\n", vfd->minor);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 init_waitqueue_head(&vout->vrfb_dma_tx.wait);
> +
> + =A0 =A0 =A0 /* Allocate VRFB buffers if selected through bootargs *=
/
> + =A0 =A0 =A0 static_vrfb_allocation =3D (vid_num =3D=3D 0) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid1_static_vrfb_alloc : vid2_static_vr=
fb_alloc;
> +
> + =A0 =A0 =A0 /* statically allocated the VRFB buffer is done through
> + =A0 =A0 =A0 =A0 =A0commands line aruments */
> + =A0 =A0 =A0 if (static_vrfb_allocation) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vout_allocate_vrfb_buffers(vou=
t, &vrfb_num_bufs, -1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D =A0-ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_vrfb_ctx;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vrfb_static_allocation =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +
> +release_vrfb_ctx:
> + =A0 =A0 =A0 for (j =3D 0; j < 4; j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vrfb_release_ctx(&vout->vrfb_conte=
xt[j]);
> +
> +free_buffers:
> + =A0 =A0 =A0 for (i =3D 0; i < numbuffers; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffer(vout->buf_virt_ad=
dr[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 vout->buffer_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_virt_addr[i] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->buf_phy_addr[i] =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +
> +}
> +
> +/* Create video out devices */
> +static int __init omap_vout_create_video_devices(struct platform_dev=
ice *pdev)
> +{
> + =A0 =A0 =A0 int ret =3D 0, k;
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 struct video_device *vfd =3D NULL;
> + =A0 =A0 =A0 struct v4l2_device *v4l2_dev =3D platform_get_drvdata(p=
dev);
> +
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D container_of(v4l2=
_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap2video_devic=
e, v4l2_dev);
> +
> + =A0 =A0 =A0 for (k =3D 0; k < pdev->num_resources; k++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout =3D kmalloc(sizeof(struct omap_vou=
t_device), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, ": =
could not allocate memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(vout, 0, sizeof(struct omap_vout=
_device));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid =3D k;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->vouts[k] =3D vout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_dev =3D vid_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Select video2 if only 1 overlay is c=
ontrolled by V4L2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdev->num_resources =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays=
[0] =3D vid_dev->overlays[k + 2];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Else select video1 a=
nd video2 one by one. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays=
[0] =3D vid_dev->overlays[k + 1];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.num_overlays =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.id =3D k + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->num_videos++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the default configuration for =
the video devices
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vout_setup_video_data(vout) !=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allocate default number of buffers f=
or the video streaming
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and reserve the VRFB space for rot=
ation
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vout_setup_video_bufs(pdev, k)=
 !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the Video device with V4L2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd =3D vout->vfd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (video_register_device(vfd, VFL_TYPE=
_GRABBER, k + 1) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, ": =
Could not register "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "Video for Linux device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd->minor =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_set_drvdata(vfd, vout);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Configure the overlay structure */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omapvid_init(vid_dev->vouts[k],=
 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto success;
> +
> +error2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_release_vrfb(vout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_buffers(vout);
> +error1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_device_release(vfd);
> +error:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(vout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> +success:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, ": registered and =
initialized"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " video=
 device %d\n", vfd->minor);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (k =3D=3D (pdev->num_resources - 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +/* Driver functions */
> +static int omap_vout_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int k;
> + =A0 =A0 =A0 struct v4l2_device *v4l2_dev =3D platform_get_drvdata(p=
dev);
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D container_of(v4l2=
_dev, struct
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2video_device, v4l2=
_dev);
> +
> + =A0 =A0 =A0 v4l2_device_unregister(v4l2_dev);
> + =A0 =A0 =A0 for (k =3D 0; k < pdev->num_resources; k++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_cleanup_device(vid_dev->vouts=
[k]);
> +
> + =A0 =A0 =A0 for (k =3D 0; k < vid_dev->num_displays; k++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vid_dev->displays[k]->state !=3D OM=
AP_DSS_DISPLAY_DISABLED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->displays[k]->d=
isable(vid_dev->displays[k]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dss_put_device(vid_dev->displays[k=
]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(vid_dev);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __init omap_vout_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int ret =3D 0, i;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_dss_device *dssdev =3D NULL;
> + =A0 =A0 =A0 struct omap_dss_device *def_display;
> + =A0 =A0 =A0 struct omap2video_device *vid_dev =3D NULL;
> +
> + =A0 =A0 =A0 if (pdev->num_resources =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "probed for an unkn=
own device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vid_dev =3D kzalloc(sizeof(struct omap2video_device), G=
=46P_KERNEL);
> + =A0 =A0 =A0 if (vid_dev =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 vid_dev->num_displays =3D 0;
> + =A0 =A0 =A0 for_each_dss_dev(dssdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dss_get_device(dssdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->displays[vid_dev->num_displays=
++] =3D dssdev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (vid_dev->num_displays =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no displays\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto probe_err0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 vid_dev->num_overlays =3D omap_dss_get_num_overlays();
> + =A0 =A0 =A0 for (i =3D 0; i < vid_dev->num_overlays; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->overlays[i] =3D omap_dss_get_o=
verlay(i);
> +
> + =A0 =A0 =A0 vid_dev->num_managers =3D omap_dss_get_num_overlay_mana=
gers();
> + =A0 =A0 =A0 for (i =3D 0; i < vid_dev->num_managers; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->managers[i] =3D omap_dss_get_o=
verlay_manager(i);
> +
> + =A0 =A0 =A0 /* Get the Video1 overlay and video2 overlay.
> + =A0 =A0 =A0 =A0* Setup the Display attached to that overlays
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 1; i < 3; i++) {

Can we replace magic number 3 with a #define ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D omap_dss_get_overlay(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl->manager->devic=
e) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_display =3D ovl->ma=
nager->device;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "c=
annot find display\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_display =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D def_display->en=
able(def_display);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Here=
 we are not considering a error
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0=
as display may be enabled by frame
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0=
buffer driver
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_war=
n(&pdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "'%s' Display already enabled\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def_display->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set the update mode =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display->caps &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
> +#ifdef CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def=
_display->enable_te)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def_display->enable_te(def_display, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def=
_display->set_update_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def_display->set_update_mode(def_display,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_UPDATE_AUTO);
> +#else =A0/* MANUAL_UPDATE */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def=
_display->enable_te)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def_display->enable_te(def_display, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def=
_display->set_update_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def_display->set_update_mode(def_display,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_UPDATE_MANUAL);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def=
_display->set_update_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def_display->set_update_mode(def_display,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DSS_UPDATE_AUTO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (v4l2_device_register(&pdev->dev, &vid_dev->v4l2_dev=
) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "v4l2_device_regist=
er failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto probe_err1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D omap_vout_create_video_devices(pdev);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto probe_err2;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < vid_dev->num_displays; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_dss_device *display =3D vid=
_dev->displays[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (display->update)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 display->update(display=
, 0, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 display->panel.timings.x_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 display->panel.timings.y_res);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +
> +probe_err2:
> + =A0 =A0 =A0 v4l2_device_unregister(&vid_dev->v4l2_dev);
> +probe_err1:
> + =A0 =A0 =A0 for (i =3D 1; i < 3; i++) {

replace magic number 3 with #define constant.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_display =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D omap_dss_get_overlay(i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ovl->manager && ovl->manager->devic=
e)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_display =3D ovl->ma=
nager->device;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def_display)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def_display->disable(de=
f_display);
> + =A0 =A0 =A0 }
> +probe_err0:
> + =A0 =A0 =A0 kfree(vid_dev);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct platform_driver omap_vout_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D VOUT_NAME,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D omap_vout_probe,
> + =A0 =A0 =A0 .remove =3D omap_vout_remove,
> +};
> +
> +void omap_vout_isr(void *arg, unsigned int irqstatus)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u32 addr, fid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct timeval timevalue;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_dss_device *cur_display;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D (struct omap_vout_dev=
ice *)arg;
> +
> + =A0 =A0 =A0 if (!vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 ovid =3D &vout->vid_info;
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 cur_display =3D ovl->manager->device;
> +
> + =A0 =A0 =A0 spin_lock(&vout->vbq_lock);
> + =A0 =A0 =A0 do_gettimeofday(&timevalue);
> + =A0 =A0 =A0 if (cur_display->type =3D=3D OMAP_DISPLAY_TYPE_DPI) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(irqstatus & DISPC_IRQ_VSYNC))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vout_isr_err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->first_int && (vout->cur_frm =
!=3D vout->next_frm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cur_frm->ts =3D t=
imevalue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cur_frm->state =3D=
 VIDEOBUF_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&=
vout->cur_frm->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cur_frm =3D vout-=
>next_frm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->first_int =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&vout->dma_queue))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vout_isr_err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->next_frm =3D list_entry(vout->dma=
_queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
videobuf_buffer, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&vout->next_frm->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->next_frm->state =3D VIDEOBUF_ACTI=
VE;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (unsigned long) vout->queued_b=
uf_addr[vout->next_frm->i]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + vout->cropped_offset;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First save the configuration in ovel=
ray structure */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omapvid_init(vout, addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed to set overlay info\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the pipeline and set the Go b=
it */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omapvid_apply_changes(vout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME "failed to change mode\n");
> + =A0 =A0 =A0 } else {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->first_int) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->first_int =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vout_isr_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqstatus & DISPC_IRQ_EVSYNC_ODD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fid =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (irqstatus & DISPC_IRQ_EVSYNC_E=
VEN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fid =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vout_isr_err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->field_id ^=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fid !=3D vout->field_id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D fid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->f=
ield_id =3D fid;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vout_isr_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D fid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->cur_frm =3D=3D=
 vout->next_frm)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vo=
ut_isr_err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cur_frm->ts =3D t=
imevalue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cur_frm->state =3D=
 VIDEOBUF_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&=
vout->cur_frm->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cur_frm =3D vout-=
>next_frm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (1 =3D=3D fid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&vout->d=
ma_queue) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (vout->cur_frm !=3D vout->next_frm))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto vo=
ut_isr_err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->next_frm =3D list=
_entry(vout->dma_queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct videobuf_buffer, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&vout->next_fr=
m->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->next_frm->state =3D=
 VIDEOBUF_ACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (unsigned long=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->q=
ueued_buf_addr[vout->next_frm->i] +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->c=
ropped_offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* First save the confi=
guration in ovelray structure */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omapvid_init(vo=
ut, addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR VOUT_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "failed to set overlay info\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the pipeline =
and set the Go bit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omapvid_apply_c=
hanges(vout);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR VOUT_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "failed to change mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 }
> +
> +vout_isr_err:
> + =A0 =A0 =A0 spin_unlock(&vout->vbq_lock);
> +}
> +
> +static void omap_vout_cleanup_device(struct omap_vout_device *vout)
> +{
> + =A0 =A0 =A0 struct video_device *vfd;
> +
> + =A0 =A0 =A0 if (!vout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

Is this possible to happen since device is already initialized and
this would have been checked already?

> +
> + =A0 =A0 =A0 vfd =3D vout->vfd;
> + =A0 =A0 =A0 if (vfd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vfd->minor =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The device was nev=
er registered, so release the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* video_device struc=
t directly.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_device_release(vf=
d);

I think there is an v4l2 api to check if the device is registered
instead of checking the minor number. video_is_registered() can be
used here.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The unregister fun=
ction will release the video_device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* struct as well as =
unregistering it.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video_unregister_device=
(vfd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 omap_vout_release_vrfb(vout);
> + =A0 =A0 =A0 omap_vout_free_buffers(vout);
> + =A0 =A0 =A0 /* Free the VRFB buffer if allocated
> + =A0 =A0 =A0 =A0* init time
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (vout->vrfb_static_allocation)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_vout_free_vrfb_buffers(vout);
> +
> + =A0 =A0 =A0 kfree(vout);
> +}
> +
> +static int __init omap_vout_init(void)
> +{
> + =A0 =A0 =A0 if (platform_driver_register(&omap_vout_driver) !=3D 0)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAME ":Could not r=
egister Video driver\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void omap_vout_cleanup(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&omap_vout_driver);
> +}
> +
> +late_initcall(omap_vout_init);
> +module_exit(omap_vout_cleanup);
> diff --git a/drivers/media/video/omap/omap_voutdef.h b/drivers/media/=
video/omap/omap_voutdef.h
> new file mode 100644
> index 0000000..6d897f7
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutdef.h
> @@ -0,0 +1,148 @@
> +/*
> + * omap_voutdef.h
> + *
> + * Copyright (C) 2010 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef OMAP_VOUTDEF_H
> +#define OMAP_VOUTDEF_H
> +
> +#include <plat/display.h>
> +
> +#define YUYV_BPP =A0 =A0 =A0 =A02
> +#define RGB565_BPP =A0 =A0 =A02
> +#define RGB24_BPP =A0 =A0 =A0 3
> +#define RGB32_BPP =A0 =A0 =A0 4
> +#define TILE_SIZE =A0 =A0 =A0 32
> +#define YUYV_VRFB_BPP =A0 2
> +#define RGB_VRFB_BPP =A0 =A01
> +#define MAX_CID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> +#define MAC_VRFB_CTXS =A04
> +#define MAX_VOUT_DEV =A0 2
> +#define MAX_OVLS =A0 =A0 =A0 3
> +#define MAX_DISPLAYS =A0 3
> +#define MAX_MANAGERS =A0 3
> +
> +/* Enum for Rotation
> + * DSS understands rotation in 0, 1, 2, 3 context
> + * while V4L2 driver understands it as 0, 90, 180, 270
> + */
> +enum dss_rotation {
> + =A0 =A0 =A0 dss_rotation_0_degree =A0 =3D 0,
> + =A0 =A0 =A0 dss_rotation_90_degree =A0=3D 1,
> + =A0 =A0 =A0 dss_rotation_180_degree =3D 2,
> + =A0 =A0 =A0 dss_rotation_270_degree =3D 3,
> +};
> +/*
> + * This structure is used to store the DMA transfer parameters
> + * for VRFB hidden buffer
> + */
> +struct vid_vrfb_dma {
> + =A0 =A0 =A0 int dev_id;
> + =A0 =A0 =A0 int dma_ch;
> + =A0 =A0 =A0 int req_status;
> + =A0 =A0 =A0 int tx_status;
> + =A0 =A0 =A0 wait_queue_head_t wait;
> +};
> +
> +struct omapvideo_info {
> + =A0 =A0 =A0 int id;
> + =A0 =A0 =A0 int num_overlays;
> + =A0 =A0 =A0 struct omap_overlay *overlays[MAX_OVLS];
> +};
> +
> +struct omap2video_device {
> + =A0 =A0 =A0 struct mutex =A0mtx;
> +
> + =A0 =A0 =A0 int state;
> +
> + =A0 =A0 =A0 struct v4l2_device v4l2_dev;
> + =A0 =A0 =A0 int num_videos;
> + =A0 =A0 =A0 struct omap_vout_device *vouts[MAX_VOUT_DEV];
> +
> + =A0 =A0 =A0 int num_displays;
> + =A0 =A0 =A0 struct omap_dss_device *displays[MAX_DISPLAYS];
> + =A0 =A0 =A0 int num_overlays;
> + =A0 =A0 =A0 struct omap_overlay *overlays[MAX_OVLS];
> + =A0 =A0 =A0 int num_managers;
> + =A0 =A0 =A0 struct omap_overlay_manager *managers[MAX_MANAGERS];
> +};
> +
> +/* per-device data structure */
> +struct omap_vout_device {
> +
> + =A0 =A0 =A0 struct omapvideo_info vid_info;
> + =A0 =A0 =A0 struct video_device *vfd;
> + =A0 =A0 =A0 struct omap2video_device *vid_dev;
> + =A0 =A0 =A0 int vid;
> + =A0 =A0 =A0 int opened;
> +
> + =A0 =A0 =A0 /* we don't allow to change image fmt/size once buffer =
has
> + =A0 =A0 =A0 =A0* been allocated
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int buffer_allocated;
> + =A0 =A0 =A0 /* allow to reuse previously allocated buffer which is =
big enough */
> + =A0 =A0 =A0 int buffer_size;
> + =A0 =A0 =A0 /* keep buffer info across opens */
> + =A0 =A0 =A0 unsigned long buf_virt_addr[VIDEO_MAX_FRAME];
> + =A0 =A0 =A0 unsigned long buf_phy_addr[VIDEO_MAX_FRAME];
> + =A0 =A0 =A0 enum omap_color_mode dss_mode;
> +
> + =A0 =A0 =A0 /* we don't allow to request new buffer when old buffer=
s are
> + =A0 =A0 =A0 =A0* still mmaped
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int mmap_count;
> +
> + =A0 =A0 =A0 spinlock_t vbq_lock; =A0 =A0 =A0 =A0 =A0 =A0/* spinlock=
 for videobuf queues */
> + =A0 =A0 =A0 unsigned long field_count; =A0 =A0 =A0/* field counter =
for videobuf_buffer */
> +
> + =A0 =A0 =A0 /* non-NULL means streaming is in progress. */
> + =A0 =A0 =A0 bool streaming;
> +
> + =A0 =A0 =A0 struct v4l2_pix_format pix;
> + =A0 =A0 =A0 struct v4l2_rect crop;
> + =A0 =A0 =A0 struct v4l2_window win;
> + =A0 =A0 =A0 struct v4l2_framebuffer fbuf;
> +
> + =A0 =A0 =A0 /* Lock to protect the shared data structures in ioctl =
*/
> + =A0 =A0 =A0 struct mutex lock;
> +
> + =A0 =A0 =A0 /* V4L2 control structure for different control id */
> + =A0 =A0 =A0 struct v4l2_control control[MAX_CID];
> + =A0 =A0 =A0 enum dss_rotation rotation;
> + =A0 =A0 =A0 bool mirror;
> + =A0 =A0 =A0 int flicker_filter;
> + =A0 =A0 =A0 /* V4L2 control structure for different control id */
> +
> + =A0 =A0 =A0 int bpp; /* bytes per pixel */
> + =A0 =A0 =A0 int vrfb_bpp; /* bytes per pixel with respect to VRFB *=
/
> +
> + =A0 =A0 =A0 struct vid_vrfb_dma vrfb_dma_tx;
> + =A0 =A0 =A0 unsigned int smsshado_phy_addr[MAC_VRFB_CTXS];
> + =A0 =A0 =A0 unsigned int smsshado_virt_addr[MAC_VRFB_CTXS];
> + =A0 =A0 =A0 struct vrfb vrfb_context[MAC_VRFB_CTXS];
> + =A0 =A0 =A0 bool vrfb_static_allocation;
> + =A0 =A0 =A0 unsigned int smsshado_size;
> + =A0 =A0 =A0 unsigned char pos;
> +
> + =A0 =A0 =A0 int ps, vr_ps, line_length, first_int, field_id;
> + =A0 =A0 =A0 enum v4l2_memory memory;
> + =A0 =A0 =A0 struct videobuf_buffer *cur_frm, *next_frm;
> + =A0 =A0 =A0 struct list_head dma_queue;
> + =A0 =A0 =A0 u8 *queued_buf_addr[VIDEO_MAX_FRAME];
> + =A0 =A0 =A0 u32 cropped_offset;
> + =A0 =A0 =A0 s32 tv_field1_offset;
> + =A0 =A0 =A0 void *isr_handle;
> +
> + =A0 =A0 =A0 /* Buffer queue variables */
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 enum v4l2_buf_type type;
> + =A0 =A0 =A0 struct videobuf_queue vbq;
> + =A0 =A0 =A0 int io_allowed;
> +
> +};
> +#endif /* ifndef OMAP_VOUTDEF_H */
> diff --git a/drivers/media/video/omap/omap_voutlib.c b/drivers/media/=
video/omap/omap_voutlib.c
> new file mode 100644
> index 0000000..05c0e17
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutlib.c
> @@ -0,0 +1,258 @@
> +/*
> + * omap_voutlib.c
> + *
> + * Copyright (C) 2005-2010 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + *
> + * Based on the OMAP2 camera driver
> + * Video-for-Linux (Version 2) camera capture driver for
> + * the OMAP24xx camera controller.
> + *
> + * Author: Andy Lowe (source@mvista.com)
> + *
> + * Copyright (C) 2004 MontaVista Software, Inc.
> + * Copyright (C) 2010 Texas Instruments.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/videodev2.h>
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("OMAP Video library");
> +MODULE_LICENSE("GPL");
> +
> +/* Return the default overlay cropping rectangle in crop given the i=
mage
> + * size in pix and the video display size in fbuf. =A0The default
> + * cropping rectangle is the largest rectangle no larger than the ca=
pture size
> + * that will fit on the display. =A0The default cropping rectangle i=
s centered in
> + * the image. =A0All dimensions and offsets are rounded down to even=
 numbers.
> + */
> +void omap_vout_default_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, stru=
ct v4l2_rect *crop)
> +{
> + =A0 =A0 =A0 crop->width =3D (pix->width < fbuf->fmt.width) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->width : fbuf->fmt.width;
> + =A0 =A0 =A0 crop->height =3D (pix->height < fbuf->fmt.height) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pix->height : fbuf->fmt.height;
> + =A0 =A0 =A0 crop->width &=3D ~1;
> + =A0 =A0 =A0 crop->height &=3D ~1;
> + =A0 =A0 =A0 crop->left =3D ((pix->width - crop->width) >> 1) & ~1;
> + =A0 =A0 =A0 crop->top =3D ((pix->height - crop->height) >> 1) & ~1;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_default_crop);
> +
> +/* Given a new render window in new_win, adjust the window to the
> + * nearest supported configuration. =A0The adjusted window parameter=
s are
> + * returned in new_win.
> + * Returns zero if succesful, or -EINVAL if the requested window is
> + * impossible and cannot reasonably be adjusted.
> + */
> +int omap_vout_try_window(struct v4l2_framebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new=
_win)
> +{
> + =A0 =A0 =A0 struct v4l2_rect try_win;
> +
> + =A0 =A0 =A0 /* make a working copy of the new_win rectangle */
> + =A0 =A0 =A0 try_win =3D new_win->w;
> +
> + =A0 =A0 =A0 /* adjust the preview window so it fits on the display =
by clipping any
> + =A0 =A0 =A0 =A0* offscreen areas
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (try_win.left < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.width +=3D try_win.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.left =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (try_win.top < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.height +=3D try_win.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.top =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 try_win.width =3D (try_win.width < fbuf->fmt.width) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.width : fbuf->fmt.width;
> + =A0 =A0 =A0 try_win.height =3D (try_win.height < fbuf->fmt.height) =
?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.height : fbuf->fmt.height;
> + =A0 =A0 =A0 if (try_win.left + try_win.width > fbuf->fmt.width)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.width =3D fbuf->fmt.width - try=
_win.left;
> + =A0 =A0 =A0 if (try_win.top + try_win.height > fbuf->fmt.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_win.height =3D fbuf->fmt.height - t=
ry_win.top;
> + =A0 =A0 =A0 try_win.width &=3D ~1;
> + =A0 =A0 =A0 try_win.height &=3D ~1;
> +
> + =A0 =A0 =A0 if (try_win.width <=3D 0 || try_win.height <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* We now have a valid preview window, so go with it */
> + =A0 =A0 =A0 new_win->w =3D try_win;
> + =A0 =A0 =A0 new_win->field =3D V4L2_FIELD_ANY;
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_try_window);
> +
> +/* Given a new render window in new_win, adjust the window to the
> + * nearest supported configuration. =A0The image cropping window in =
crop
> + * will also be adjusted if necessary. =A0Preference is given to kee=
ping the
> + * the window as close to the requested configuration as possible. =A0=
If
> + * successful, new_win, vout->win, and crop are updated.
> + * Returns zero if succesful, or -EINVAL if the requested preview wi=
ndow is
> + * impossible and cannot reasonably be adjusted.
> + */
> +int omap_vout_new_window(struct v4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win, struct v4l2_fr=
amebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new_win)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D omap_vout_try_window(fbuf, new_win);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 /* update our preview window */
> + =A0 =A0 =A0 win->w =3D new_win->w;
> + =A0 =A0 =A0 win->field =3D new_win->field;
> + =A0 =A0 =A0 win->chromakey =3D new_win->chromakey;
> +
> + =A0 =A0 =A0 /* adjust the cropping window to allow for resizing lim=
itations */
> + =A0 =A0 =A0 if ((crop->height/win->w.height) >=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum vertical downsizing rati=
o is 4:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->height =3D win->w.height * 4;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((crop->width/win->w.width) >=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum horizontal downsizing ra=
tio is 4:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->width =3D win->w.width * 4;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_new_window);
> +
> +/* Given a new cropping rectangle in new_crop, adjust the cropping r=
ectangle to
> + * the nearest supported configuration. =A0The image render window i=
n win will
> + * also be adjusted if necessary. =A0The preview window is adjusted =
such that the
> + * horizontal and vertical rescaling ratios stay constant. =A0If the=
 render
> + * window would fall outside the display boundaries, the cropping re=
ctangle
> + * will also be adjusted to maintain the rescaling ratios. =A0If suc=
cessful, crop
> + * and win are updated.
> + * Returns zero if succesful, or -EINVAL if the requested cropping r=
ectangle is
> + * impossible and cannot reasonably be adjusted.
> + */
> +int omap_vout_new_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_rect *crop, struct v4l2_window =
*win,
> + =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, const struct=
 v4l2_rect *new_crop)
> +{
> + =A0 =A0 =A0 struct v4l2_rect try_crop;
> + =A0 =A0 =A0 unsigned long vresize, hresize;
> +
> + =A0 =A0 =A0 /* make a working copy of the new_crop rectangle */
> + =A0 =A0 =A0 try_crop =3D *new_crop;
> +
> + =A0 =A0 =A0 /* adjust the cropping rectangle so it fits in the imag=
e */
> + =A0 =A0 =A0 if (try_crop.left < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width +=3D try_crop.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.left =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (try_crop.top < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height +=3D try_crop.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.top =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 try_crop.width =3D (try_crop.width < pix->width) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width : pix->width;
> + =A0 =A0 =A0 try_crop.height =3D (try_crop.height < pix->height) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height : pix->height;
> + =A0 =A0 =A0 if (try_crop.left + try_crop.width > pix->width)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D pix->width - try_cro=
p.left;
> + =A0 =A0 =A0 if (try_crop.top + try_crop.height > pix->height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D pix->height - try_c=
rop.top;
> + =A0 =A0 =A0 try_crop.width &=3D ~1;
> + =A0 =A0 =A0 try_crop.height &=3D ~1;
> + =A0 =A0 =A0 if (try_crop.width <=3D 0 || try_crop.height <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (crop->height !=3D win->w.height) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If we're resizing vertically, we can=
't support a crop width
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wider than 768 pixels.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.width > 768)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D 768;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* vertical resizing */
> + =A0 =A0 =A0 vresize =3D (1024 * crop->height) / win->w.height;
> + =A0 =A0 =A0 if (vresize > 4096)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vresize =3D 4096;
> + =A0 =A0 =A0 else if (vresize =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vresize =3D 1;
> + =A0 =A0 =A0 win->w.height =3D ((1024 * try_crop.height) / vresize) =
& ~1;
> + =A0 =A0 =A0 if (win->w.height =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.height =3D 2;
> + =A0 =A0 =A0 if (win->w.height + win->w.top > fbuf->fmt.height) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We made the preview window extend be=
low the bottom of the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* display, so clip it to the display=
 boundary and resize the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cropping height to maintain the ve=
rtical resizing ratio.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.height =3D (fbuf->fmt.height - w=
in->w.top) & ~1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.height =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* horizontal resizing */
> + =A0 =A0 =A0 hresize =3D (1024 * crop->width) / win->w.width;
> + =A0 =A0 =A0 if (hresize > 4096)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hresize =3D 4096;
> + =A0 =A0 =A0 else if (hresize =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hresize =3D 1;
> + =A0 =A0 =A0 win->w.width =3D ((1024 * try_crop.width) / hresize) & =
~1;
> + =A0 =A0 =A0 if (win->w.width =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.width =3D 2;
> + =A0 =A0 =A0 if (win->w.width + win->w.left > fbuf->fmt.width) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We made the preview window extend pa=
st the right side of the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* display, so clip it to the display=
 boundary and resize the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cropping width to maintain the hor=
izontal resizing ratio.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 win->w.width =3D (fbuf->fmt.width - win=
->w.left) & ~1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.width =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D 2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Check for resizing constraints */
> + =A0 =A0 =A0 if ((try_crop.height/win->w.height) >=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum vertical downsizing rati=
o is 4:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D win->w.height * 4;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((try_crop.width/win->w.width) >=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum horizontal downsizing ra=
tio is 4:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D win->w.width * 4;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* update our cropping rectangle and we're done */
> + =A0 =A0 =A0 *crop =3D try_crop;
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_new_crop);
> +
> +/* Given a new format in pix and fbuf, =A0crop and win
> + * structures are initialized to default values. crop
> + * is initialized to the largest window size that will fit on the di=
splay. =A0The
> + * crop window is centered in the image. win is initialized to
> + * the same size as crop and is centered on the display.
> + * All sizes and offsets are constrained to be even numbers.
> + */
> +void omap_vout_new_format(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, struct v=
4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win)
> +{
> + =A0 =A0 =A0 /* crop defines the preview source window in the image =
capture
> + =A0 =A0 =A0 =A0* buffer
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 omap_vout_default_crop(pix, fbuf, crop);
> +
> + =A0 =A0 =A0 /* win defines the preview target window on the display=
 */
> + =A0 =A0 =A0 win->w.width =3D crop->width;
> + =A0 =A0 =A0 win->w.height =3D crop->height;
> + =A0 =A0 =A0 win->w.left =3D ((fbuf->fmt.width - win->w.width) >> 1)=
 & ~1;
> + =A0 =A0 =A0 win->w.top =3D ((fbuf->fmt.height - win->w.height) >> 1=
) & ~1;
> +}
> +EXPORT_SYMBOL_GPL(omap_vout_new_format);
> +
> diff --git a/drivers/media/video/omap/omap_voutlib.h b/drivers/media/=
video/omap/omap_voutlib.h
> new file mode 100644
> index 0000000..a60b16e
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutlib.h
> @@ -0,0 +1,34 @@
> +/*
> + * omap_voutlib.h
> + *
> + * Copyright (C) 2010 Texas Instruments.
> + *
> + * This file is licensed under the terms of the GNU General Public L=
icense
> + * version 2. This program is licensed "as is" without any warranty =
of any
> + * kind, whether express or implied.
> + *
> + */
> +
> +#ifndef OMAP_VOUTLIB_H
> +#define OMAP_VOUTLIB_H
> +
> +extern void omap_vout_default_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, struct v=
4l2_rect *crop);
> +
> +extern int omap_vout_new_crop(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_rect *crop, struct v4l2_win=
dow *win,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct v4l2_rect *new_crop);
> +
> +extern int omap_vout_try_window(struct v4l2_framebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new_win);
> +
> +extern int omap_vout_new_window(struct v4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win, struct v4l2_fr=
amebuffer *fbuf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *new_win);
> +
> +extern void omap_vout_new_format(struct v4l2_pix_format *pix,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_framebuffer *fbuf, struct v=
4l2_rect *crop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct v4l2_window *win);
> +#endif /* #ifndef OMAP_VOUTLIB_H */
> +
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Murali Karicheri
mkaricheri@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
