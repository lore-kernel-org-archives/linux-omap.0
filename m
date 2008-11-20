From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [Review Patch] V4L2 driver on Tomis DSS patches
Date: Thu, 20 Nov 2008 08:08:09 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E8E6795C@dbde02.ent.ti.com>
References: <1227131551.4553.23.camel@tux.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <1227131551.4553.23.camel@tux.localhost>
Content-Language: en-US
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Alexey Klimov <klimov.linux@gmail.com>, "Shah, Hardik" <hardik.shah@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Alexey Klimov
> Sent: Thursday, November 20, 2008 3:23 AM
> To: Shah, Hardik
> Cc: video4linux-list@redhat.com; linux-omap@vger.kernel.org; linux-
> fbdev-devel@lists.sourceforge.net
> Subject: Re: [Review Patch] V4L2 driver on Tomis DSS patches
>
> Hello, Hardik
>
> May i suggest few things here ?
>

[Hiremath, Vaibhav] Definitely, If we have some gaps or implementation is=
sues then definitely we have to address.

> On Wed, 2008-11-19 at 12:18 +0530, Hardik Shah wrote:
> > This is the initial version of the V4L2 display driver
> > controlling the video pipelines of DSS.
> >
> > +
> > +   r =3D def_display->enable(def_display);
> > +   if (r) {
> > +           /* Here we are not considering a error as display may be
> > +              enabled by frame buffer driver */
> > +           printk(KERN_WARNING "Display already enabled\n");
>
> You use printk(KERN_WARNING ..) here. Few line above you use
> dev_err.
> Why didn't you use dev_warn(&pdev->dev, ..) instead of printk ?
> As i know using dev_* macro is more preferred if possible.
>
>
[Hiremath, Vaibhav] Valid point, taken.

> > +   }
> > +
> > +   /* set the update mode */
> > +   if (def_display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
> > +#ifdef CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE
> > +           if (def_display->set_update_mode)
> > +                   def_display->set_update_mode(def_display,
> > +                                   OMAP_DSS_UPDATE_AUTO);
> > +           if (def_display->enable_te)
> > +                   def_display->enable_te(def_display, 1);
> > +#else
> > +           if (def_display->set_update_mode)
> > +                   def_display->set_update_mode(def_display,
> > +                                   OMAP_DSS_UPDATE_MANUAL);
> > +           if (def_display->enable_te)
> > +                   def_display->enable_te(def_display, 0);
> > +#endif
> > +   } else {
> > +           if (def_display->set_update_mode)
> > +                   def_display->set_update_mode(def_display,
> > +                                   OMAP_DSS_UPDATE_AUTO);
> > +   }
> > +
> > +   for (i =3D 0; i < vid_dev->num_displays; i++) {
> > +           struct omap_display *display =3D vid_dev->displays[i];
> > +
> > +           if (display->update)
> > +                   display->update(display,
> > +                                   0, 0,
> > +                                   display->x_res, display->y_res);
> > +   }
> > +   printk(KERN_INFO "display->updated\n");
> > +   return 0;
>
> and dev_info here ?
>
[Hiremath, Vaibhav] Valid point, taken.
> > +
> > +error0:
> > +   kfree(vid_dev);
> > +   return r;
> > +}
> > +
> > +static int omapvout_create_vout_devices(struct platform_device
> *pdev)
> > +{
> > +   int r =3D 0, i, k;
> > +   struct omap_vout_device *vout;
> > +   struct video_device *vfd;
> > +   struct v4l2_pix_format *pix;
> > +   u32 numbuffers;
> > +   int index_i, index_j;
> > +   struct omap2video_device *vid_dev =3D
> platform_get_drvdata(pdev);
> > +
> > +   for (k =3D 0; k < pdev->num_resources; k++) {
> > +           vout =3D kmalloc(sizeof(struct omap_vout_device),
> GFP_KERNEL);
> > +           if (!vout) {
> > +                   printk(KERN_ERR VOUT_NAME ": could not allocate \
> > +                                   memory\n");
>
> As i know, using slash "\" isn't good way (may be i'm wrong). May be
> it's better to make smth like this:
>
>               if (!vout) {
>                       printk(KERN_ERR VOUT_NAME
>                               ": could not allocate memory\n");
>
>
>
[Hiremath, Vaibhav] Not sure on this. But still at-least code will be mor=
e readable. No harm in changing that.

> > +                   return -ENOMEM;
> > +           }
> > +
> > +           memset(vout, 0, sizeof(struct omap_vout_device));
> > +           vout->vid =3D k + 1;
> > +
> > +           /* set the default pix */
> > +           pix =3D &vout->pix;
> > +
> > +           /* Set the default picture of QVGA  */
> > +           pix->width =3D QQVGA_WIDTH;
> > +           pix->height =3D QQVGA_HEIGHT;
> > +
> > +           /* Default pixel format is RGB 5-6-5 */
> > +           pix->pixelformat =3D V4L2_PIX_FMT_RGB565;
> > +           pix->field =3D V4L2_FIELD_ANY;
> > +           pix->bytesperline =3D pix->width * 2;
> > +           pix->sizeimage =3D pix->bytesperline * pix->height;
> > +           pix->priv =3D 0;
> > +           pix->colorspace =3D V4L2_COLORSPACE_JPEG;
> > +
> > +           vout->bpp =3D RGB565_BPP;
> > +
> > +           vout->fbuf.fmt.width =3D def_display->x_res;
> > +           vout->fbuf.fmt.height =3D def_display->y_res;
> > +
> > +           omap_vout_new_format(pix, &vout->fbuf, &vout->crop,
> &vout->win);
> > +
> > +           /* initialize the video_device struct */
> > +           vfd =3D vout->vfd =3D video_device_alloc();
> > +
> > +           if (!vfd) {
> > +                   printk(KERN_ERR VOUT_NAME ": could not allocate
> video \
> > +                                   device struct\n");
>
> As i see, you use VOUT_NAME definition. If you want to use dev_err
> and
> &dev->dev->dev isn't provide you what you want there is exist one
> solution. Few weeks ago i was cought up by this thing and David
> Ellingsworth proposed such method(adapted for this module):
>
> #define voute_dev_err(dev, fmt, arg...)                               \
>                 dev_err(dev, VOUT_NAME " - " fmt, ##arg)
>
> So, you can use voute_dev_err with module name.
> May be you can use something like this.
>
>
[Hiremath, Vaibhav] Again I believe valid point, taken.

> > +                   kfree(vout);
> > +                   return -ENOMEM;
> > +           }
> > +           vfd->release =3D video_device_release;
> > +           vfd->ioctl_ops =3D &vout_ioctl_ops;
> > +
> > +           strncpy(vfd->name, VOUT_NAME, sizeof(vfd->name));
> > +           vfd->vfl_type =3D VID_TYPE_OVERLAY | VID_TYPE_CHROMAKEY;
> > +           /* need to register for a VID_HARDWARE_* ID in
> videodev.h */
> > +           vfd->fops =3D &omap_vout_fops;
> > +           video_set_drvdata(vfd, vout);
> > +           vfd->minor =3D -1;
> > +
> > +           index_i =3D 4;
> > +           index_j =3D 0;
> > +
> > +           numbuffers =3D (k =3D=3D 0) ?
> > +                   video1_numbuffers : video2_numbuffers;
> > +           vout->buffer_size =3D (k =3D=3D 0) ?
> > +                   video1_bufsize : video2_bufsize;
> > +           printk(KERN_INFO "Buffer Size =3D %d\n", vout-
> >buffer_size);
> > +           for (i =3D 0; i < numbuffers; i++) {
> > +                   vout->buf_virt_addr[i] =3D
> > +                           omap_vout_alloc_buffer(vout->buffer_size,
> > +                                           (u32 *) &vout->buf_phy_ad=
dr[i]);
> > +                   if (!vout->buf_virt_addr[i]) {
> > +                           numbuffers =3D i;
> > +                           goto error;
> > +                   }
> > +           }
> > +
> > +           vout->suspended =3D 0;
> > +           init_waitqueue_head(&vout->suspend_wq);
> > +           init_MUTEX(&vout->lock);
> > +
> > +           if (video_register_device(vfd, VFL_TYPE_GRABBER, k) < 0)
> {
> > +                   printk(KERN_ERR VOUT_NAME ": could not register \
> > +                                   Video for Linux device\n");
> > +                   vfd->minor =3D -1;
> > +                   goto error;
> > +           }
> > +
> > +           printk(KERN_INFO VOUT_NAME ": registered device video%d
> \
> > +                           [v4l2]\n",
> > +                           vfd->minor);
> > +
> > +           if (k =3D=3D 0)
> > +                   saved_v1out =3D vout;
> > +           else
> > +                   saved_v2out =3D vout;
> > +
> > +           vid_dev->vouts[k] =3D vout;
> > +           vout->vid_info.vid_dev =3D vid_dev;
> > +           vout->vid_info.overlays[0] =3D vid_dev->overlays[k + 1];
> > +           vout->vid_info.num_overlays =3D 1;
> > +           vout->vid_info.id =3D k + 1;
> > +           vid_dev->num_videos++;
> > +
> > +           r =3D omapvid_apply_changes(vid_dev->vouts[k], 0, 1);
> > +
> > +           if (!r)
> > +                   return 0;
> > +
> > +           printk(KERN_ERR VOUT_NAME ": could not register Video
> for \
> > +                                   Linux device\n");
> > +error:
> > +           for (i =3D 0; i < numbuffers; i++) {
> > +                   omap_vout_free_buffer(vout->buf_virt_addr[i],
> > +                                   vout->buf_phy_addr[i],
> > +                                   vout->buffer_size);
> > +                   vout->buf_virt_addr[i] =3D 0;
> > +                   vout->buf_phy_addr[i] =3D 0;
> > +           }
> > +           video_device_release(vfd);
> > +           kfree(vout);
> > +           return r;
> > +   }
> > +   return -ENODEV;
> > +}
> > +
> > +int omapvid_apply_changes(struct omap_vout_device *vout, u32
> addr, int init)
> > +{
> > +   int r =3D 0;
> > +   struct omapvideo_info *ovid =3D &(vout->vid_info);
> > +   struct omap_overlay *ovl;
> > +   int posx, posy;
> > +   int outw, outh;
> > +   int i;
> > +
> > +   for (i =3D 0; i < ovid->num_overlays; i++) {
> > +           ovl =3D ovid->overlays[i];
> > +
> > +           if (init || (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) =3D=3D 0=
) {
> > +                   outw =3D vout->win.w.width;
> > +                   outh =3D vout->win.w.height;
> > +
> > +           } else {
> > +                   outw =3D vout->win.w.width;
> > +                   outh =3D vout->win.w.height;
> > +           }
> > +           if (init) {
> > +                   posx =3D 0;
> > +                   posy =3D 0;
> > +           } else {
> > +                   posx =3D vout->win.w.left;
> > +                   posy =3D vout->win.w.top;
> > +           }
> > +
> > +           r =3D omapvid_setup_overlay(vout, ovl, posx, posy, outw,
> > +                           outh, addr);
> > +           if (r)
> > +                   goto err;
> > +
> > +           /* disabled for now. if the display has changed, var
> > +            * still contains the old timings. */
> > +#if 0
> > +           if (display && display->set_timings) {
> > +                   struct omap_video_timings timings;
> > +                   timings.pixel_clock =3D PICOS2KHZ(var->pixclock);
> > +                   timings.hfp =3D var->left_margin;
> > +                   timings.hbp =3D var->right_margin;
> > +                   timings.vfp =3D var->upper_margin;
> > +                   timings.vbp =3D var->lower_margin;
> > +                   timings.hsw =3D var->hsync_len;
> > +                   timings.vsw =3D var->vsync_len;
> > +
> > +                   display->set_timings(display, &timings);
> > +           }
> > +#endif
> > +   if (!init && ovl->manager)
> > +                   ovl->manager->apply(ovl->manager);
> > +
> > +   }
> > +   return 0;
> > +err:
> > +   printk("apply_changes failed\n");
> > +   return r;
> > +}
> > +
> > +int omapvid_setup_overlay(struct omap_vout_device *vout,
> > +           struct omap_overlay *ovl, int posx, int posy, int outw,
> > +           int outh, u32 addr)
> > +{
> > +   int r =3D 0;
> > +   enum omap_color_mode mode =3D 0;
> > +
> > +   if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) =3D=3D 0 &&
> > +                   (outw !=3D vout->pix.width || outh !=3D vout-
> >pix.height)) {
> > +           r =3D -EINVAL;
> > +           goto err;
> > +   }
> > +
> > +   mode =3D video_mode_to_dss_mode(&(vout->pix));
> > +
> > +   if (mode =3D=3D -EINVAL) {
> > +           r =3D -EINVAL;
> > +           goto err;
> > +   }
> > +
> > +   r =3D ovl->setup_input(ovl, (u32)addr, (void *)addr, vout-
> >pix.width,
> > +                   vout->crop.width, vout->crop.height, mode);
> > +
> > +   if (r)
> > +           goto err;
> > +
> > +   r =3D ovl->setup_output(ovl, posx, posy, outw, outh);
> > +
> > +   if (r)
> > +           goto err;
> > +
> > +   return 0;
> > +
> > +err:
> > +   printk(KERN_WARNING "setup_overlay failed\n");
> > +   return r;
> > +}
> > +
> > +static enum omap_color_mode video_mode_to_dss_mode(struct
> v4l2_pix_format *pix)
> > +{
> > +   switch (pix->pixelformat) {
> > +
> > +   case 0:
> > +           break;
> > +   case V4L2_PIX_FMT_YUYV:
> > +           return OMAP_DSS_COLOR_YUV2;
> > +
> > +   case V4L2_PIX_FMT_UYVY:
> > +           return OMAP_DSS_COLOR_UYVY;
> > +
> > +   case V4L2_PIX_FMT_RGB565:
> > +           return OMAP_DSS_COLOR_RGB16;
> > +
> > +   case V4L2_PIX_FMT_RGB24:
> > +           return OMAP_DSS_COLOR_RGB24P;
> > +
> > +   default:
> > +           return -EINVAL;
> > +   }
> > +
> > +   return -EINVAL;
> > +}
> > +
> > +static struct platform_driver omap_vout_driver =3D {
> > +   .driver =3D {
> > +              .name =3D VOUT_NAME,
> > +              },
> > +   .probe =3D omap_vout_probe,
> > +   .remove =3D omap_vout_remove,
> > +};
> > +
> > +void
> > +omap_vout_isr(void *arg, unsigned int irqstatus)
> > +{
> > +   int r;
> > +
> > +   struct timeval timevalue;
> > +   struct omap_vout_device *vout =3D
> > +       (struct omap_vout_device *) arg;
> > +   u32 addr;
> > +
> > +   if (!vout->streaming)
> > +           return;
> > +
> > +   spin_lock(&vout->vbq_lock);
> > +   do_gettimeofday(&timevalue);
> > +
> > +   if (!(irqstatus & DISPC_IRQSTATUS_VSYNC))
> > +           return;
> > +
> > +   if (!vout->first_int && (vout->curFrm !=3D vout->nextFrm)) {
> > +           vout->curFrm->ts =3D timevalue;
> > +           vout->curFrm->state =3D VIDEOBUF_DONE;
> > +           wake_up_interruptible(&vout->curFrm->done);
> > +           vout->curFrm =3D vout->nextFrm;
> > +   }
> > +   vout->first_int =3D 0;
> > +   if (list_empty(&vout->dma_queue)) {
> > +           spin_unlock(&vout->vbq_lock);
> > +           return;
> > +   }
> > +
> > +   vout->nextFrm =3D list_entry(vout->dma_queue.next,
> > +                              struct videobuf_buffer, queue);
> > +   list_del(&vout->nextFrm->queue);
> > +
> > +   vout->nextFrm->state =3D VIDEOBUF_ACTIVE;
> > +
> > +   addr =3D (unsigned long) vout->queued_buf_addr[vout->nextFrm->i]
> +
> > +               vout->cropped_offset;
> > +
> > +   r =3D omapvid_apply_changes(vout, addr, 0);
> > +   if (r)
> > +           printk(KERN_ERR VOUT_NAME "failed to change mode\n");
> > +   spin_unlock(&vout->vbq_lock);
> > +}
> > +
> > +static void omap_vout_cleanup_device(struct omap_vout_device
> *vout)
> > +{
> > +
> > +   struct video_device *vfd;
> > +   int i, numbuffers;
> > +
> > +   if (!vout)
> > +           return;
> > +   vfd =3D vout->vfd;
> > +
> > +   if (vfd) {
> > +           if (vfd->minor =3D=3D -1) {
> > +                   /*
> > +                    * The device was never registered, so release th=
e
> > +                    * video_device struct directly.
> > +                    */
> > +                   video_device_release(vfd);
> > +           } else {
> > +                   /*
> > +                    * The unregister function will release the
> video_device
> > +                    * struct as well as unregistering it.
> > +                    */
> > +                   video_unregister_device(vfd);
> > +           }
> > +   }
> > +
> > +   /* Allocate memory for the buffes */
> > +   numbuffers =3D (vout->vid) ?  video2_numbuffers :
> video1_numbuffers;
> > +   vout->buffer_size =3D (vout->vid) ? video2_bufsize :
> video1_bufsize;
> > +
> > +   for (i =3D 0; i < numbuffers; i++) {
> > +           omap_vout_free_buffer(vout->buf_virt_addr[i],
> > +                    vout->buf_phy_addr[i], vout->buffer_size);
> > +           vout->buf_phy_addr[i] =3D 0;
> > +           vout->buf_virt_addr[i] =3D 0;
> > +   }
> > +
> > +   kfree(vout);
> > +
> > +   if (!(vout->vid))
> > +           saved_v1out =3D NULL;
> > +   else
> > +           saved_v2out =3D NULL;
> > +}
> > +
> > +static int __init omap_vout_init(void)
> > +{
> > +
> > +   if (platform_driver_register(&omap_vout_driver) !=3D 0) {
> > +           printk(KERN_ERR VOUT_NAME ": could not register \
> > +                           Video driver\n");
>
> Here is less important thing. There are exist macroses: pr_err and
> pr_info. It can be used here. Btw, in places where you can't use
> dev_
> you can use pr_ as i know.
> It's all that i can suggest.
>
> > +           return -EINVAL;
> > +   }
> > +   return 0;
> > +}
> > +
> > +static void omap_vout_cleanup(void)
> > +{
> > +   platform_driver_unregister(&omap_vout_driver);
> > +}
> > +
> > +MODULE_AUTHOR("Texas Instruments.");
> > +MODULE_DESCRIPTION("OMAP Video for Linux Video out driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +late_initcall(omap_vout_init);
> > +module_exit(omap_vout_cleanup);
> > diff --git a/drivers/media/video/omap/omap_voutdef.h
> b/drivers/media/video/omap/omap_voutdef.h
> > new file mode 100644
> > index 0000000..9e96540
> > --- /dev/null
> > +++ b/drivers/media/video/omap/omap_voutdef.h
> > @@ -0,0 +1,138 @@
> > +/*
> > + * drivers/media/video/omap/omap_voutdef.h
> > + *
> > + * Copyright (C) 2005 Texas Instruments.
> > + *
> > + * This file is licensed under the terms of the GNU General
> Public License
> > + * version 2. This program is licensed "as is" without any
> warranty of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +#ifndef OMAP_VOUTDEF_H
> > +#define OMAP_VOUTDEF_H
> > +
> > +#include <mach/display.h>
> > +
> > +#define YUYV_BPP        2
> > +#define RGB565_BPP      2
> > +#define RGB24_BPP       3
> > +#define RGB32_BPP       4
> > +#define TILE_SIZE       32
> > +#define YUYV_VRFB_BPP   2
> > +#define RGB_VRFB_BPP    1
> > +
> > +/*
> > + * This structure is used to store the DMA transfer parameters
> > + * for VRFB hidden buffer
> > + */
> > +struct vid_vrfb_dma {
> > +   int dev_id;
> > +   int dma_ch;
> > +   int req_status;
> > +   int tx_status;
> > +   wait_queue_head_t wait;
> > +};
> > +
> > +struct omapvideo_info {
> > +   int id;
> > +   int num_overlays;
> > +   struct omap_overlay *overlays[3];
> > +   struct omap2video_device *vid_dev;
> > +};
> > +
> > +struct omap2video_device {
> > +   struct device *dev;
> > +   struct mutex  mtx;
> > +
> > +   int state;
> > +
> > +   int num_videos;
> > +   struct omap_vout_device *vouts[10];
> > +
> > +   int num_displays;
> > +   struct omap_display *displays[10];
> > +   int num_overlays;
> > +   struct omap_overlay *overlays[10];
> > +   int num_managers;
> > +   struct omap_overlay_manager *managers[10];
> > +};
> > +
> > +/* per-device data structure */
> > +struct omap_vout_device {
> > +
> > +   struct omapvideo_info vid_info;
> > +   struct device dev;
> > +   struct video_device *vfd;
> > +   int vid;
> > +   int opened;
> > +
> > +   /* Power management suspend lockout stuff */
> > +   int suspended;
> > +   wait_queue_head_t suspend_wq;
> > +
> > +   /* we don't allow to change image fmt/size once buffer has
> > +    * been allocated
> > +    */
> > +   int buffer_allocated;
> > +   /* allow to reuse previosuly allocated buffer which is big
> enough */
> > +   int buffer_size;
> > +   /* keep buffer info accross opens */
> > +   unsigned long buf_virt_addr[VIDEO_MAX_FRAME];
> > +   unsigned long buf_phy_addr[VIDEO_MAX_FRAME];
> > +   unsigned int buf_memory_type;
> > +
> > +   /* we don't allow to request new buffer when old buffers are
> > +    * still mmaped
> > +    */
> > +   int mmap_count;
> > +
> > +   spinlock_t vbq_lock;            /* spinlock for videobuf queues
> */
> > +   unsigned long field_count;      /* field counter for
> videobuf_buffer */
> > +
> > +   /* non-NULL means streaming is in progress. */
> > +   struct omap_vout_fh *streaming;
> > +
> > +   struct v4l2_pix_format pix;
> > +   struct v4l2_rect crop;
> > +   struct v4l2_window win;
> > +   struct v4l2_framebuffer fbuf;
> > +
> > +   /* Lock to protect the shared data structures in ioctl */
> > +   struct semaphore lock;
> > +
> > +   /* rotation variablse goes here */
> > +   unsigned long sms_rot_virt[4]; /* virtual addresss for four
> angles */
> > +                                   /* four angles */
> > +   dma_addr_t sms_rot_phy[4][4];
> > +
> > +   /* V4L2 control structure for different control id */
> > +
> > +   int bpp; /* bytes per pixel */
> > +   int vrfb_bpp; /* bytes per pixel with respect to VRFB */
> > +
> > +   struct vid_vrfb_dma vrfb_dma_tx;
> > +   unsigned int smsshado_phy_addr[4];
> > +   unsigned int smsshado_virt_addr[4];
> > +   unsigned int vrfb_context[4];
> > +   unsigned int smsshado_size;
> > +   unsigned char pos;
> > +
> > +   int ps, vr_ps, line_length, first_int, field_id;
> > +   enum v4l2_memory memory;
> > +   struct videobuf_buffer *curFrm, *nextFrm;
> > +   struct list_head dma_queue;
> > +   u8 *queued_buf_addr[32];
> > +   u32 cropped_offset;
> > +   s32 tv_field1_offset;
> > +
> > +};
> > +
> > +/* per-filehandle data structure */
> > +struct omap_vout_fh {
> > +   struct omap_vout_device *vout;
> > +   enum v4l2_buf_type type;
> > +   struct videobuf_queue vbq;
> > +   int io_allowed;
> > +};
> > +
> > +#endif     /* ifndef OMAP_VOUTDEF_H */
> > diff --git a/drivers/media/video/omap/omap_voutlib.c
> b/drivers/media/video/omap/omap_voutlib.c
> > new file mode 100644
> > index 0000000..c51a413
> > --- /dev/null
> > +++ b/drivers/media/video/omap/omap_voutlib.c
> > @@ -0,0 +1,281 @@
> > +/*
> > + * drivers/media/video/omap/omap_voutlib.c
> > + *
> > + * Copyright (C) 2008 Texas Instruments.
> > + *
> > + * This file is licensed under the terms of the GNU General
> Public License
> > + * version 2. This program is licensed "as is" without any
> warranty of any
> > + * kind, whether express or implied.
> > + *
> > + * Based on the OMAP2 camera driver
> > + * Video-for-Linux (Version 2) camera capture driver for
> > + * the OMAP24xx camera controller.
> > + *
> > + * Author: Andy Lowe (source@mvista.com)
> > + *
> > + * Copyright (C) 2004 MontaVista Software, Inc.
> > + * Copyright (C) 2004 Texas Instruments.
> > + *
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/slab.h>
> > +#include <linux/sched.h>
> > +#include <linux/smp_lock.h>
> > +#include <linux/kdev_t.h>
> > +#include <linux/types.h>
> > +#include <linux/wait.h>
> > +#include <linux/videodev2.h>
> > +#include <linux/semaphore.h>
> > +
> > +/* Return the default overlay cropping rectangle in crop given
> the image
> > + * size in pix and the video display size in fbuf.  The default
> > + * cropping rectangle is the largest rectangle no larger than the
> capture size
> > + * that will fit on the display.  The default cropping rectangle
> is centered in
> > + * the image.  All dimensions and offsets are rounded down to
> even numbers.
> > + */
> > +void omap_vout_default_crop(struct v4l2_pix_format *pix,
> > +             struct v4l2_framebuffer *fbuf, struct v4l2_rect *crop)
> > +{
> > +   crop->width =3D (pix->width < fbuf->fmt.width) ?
> > +           pix->width : fbuf->fmt.width;
> > +   crop->height =3D (pix->height < fbuf->fmt.height) ?
> > +           pix->height : fbuf->fmt.height;
> > +   crop->width &=3D ~1;
> > +   crop->height &=3D ~1;
> > +   crop->left =3D ((pix->width - crop->width) >> 1) & ~1;
> > +   crop->top =3D ((pix->height - crop->height) >> 1) & ~1;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_vout_default_crop);
> > +/* Given a new render window in new_win, adjust the window to the
> > + * nearest supported configuration.  The adjusted window
> parameters are
> > + * returned in new_win.
> > + * Returns zero if succesful, or -EINVAL if the requested window
> is
> > + * impossible and cannot reasonably be adjusted.
> > + */
> > +int omap_vout_try_window(struct v4l2_framebuffer *fbuf,
> > +                   struct v4l2_window *new_win)
> > +{
> > +   struct v4l2_rect try_win;
> > +
> > +   /* make a working copy of the new_win rectangle */
> > +   try_win =3D new_win->w;
> > +
> > +   /* adjust the preview window so it fits on the display by
> clipping any
> > +    * offscreen areas
> > +    */
> > +   if (try_win.left < 0) {
> > +           try_win.width +=3D try_win.left;
> > +           try_win.left =3D 0;
> > +   }
> > +   if (try_win.top < 0) {
> > +           try_win.height +=3D try_win.top;
> > +           try_win.top =3D 0;
> > +   }
> > +   try_win.width =3D (try_win.width < fbuf->fmt.width) ?
> > +           try_win.width : fbuf->fmt.width;
> > +   try_win.height =3D (try_win.height < fbuf->fmt.height) ?
> > +           try_win.height : fbuf->fmt.height;
> > +   if (try_win.left + try_win.width > fbuf->fmt.width)
> > +           try_win.width =3D fbuf->fmt.width - try_win.left;
> > +   if (try_win.top + try_win.height > fbuf->fmt.height)
> > +           try_win.height =3D fbuf->fmt.height - try_win.top;
> > +   try_win.width &=3D ~1;
> > +   try_win.height &=3D ~1;
> > +
> > +   if (try_win.width <=3D 0 || try_win.height <=3D 0)
> > +           return -EINVAL;
> > +
> > +   /* We now have a valid preview window, so go with it */
> > +   new_win->w =3D try_win;
> > +   new_win->field =3D /*V4L2_FIELD_NONE*/V4L2_FIELD_ANY;
> > +   return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_vout_try_window);
> > +
> > +/* Given a new render window in new_win, adjust the window to the
> > + * nearest supported configuration.  The image cropping window in
> crop
> > + * will also be adjusted if necessary.  Preference is given to
> keeping the
> > + * the window as close to the requested configuration as
> possible.  If
> > + * successful, new_win, vout->win, and crop are updated.
> > + * Returns zero if succesful, or -EINVAL if the requested preview
> window is
> > + * impossible and cannot reasonably be adjusted.
> > + */
> > +int omap_vout_new_window(struct v4l2_rect *crop,
> > +           struct v4l2_window *win, struct v4l2_framebuffer *fbuf,
> > +           struct v4l2_window *new_win)
> > +{
> > +   int err;
> > +
> > +   err =3D omap_vout_try_window(fbuf, new_win);
> > +   if (err)
> > +           return err;
> > +
> > +   /* update our preview window */
> > +   win->w =3D new_win->w;
> > +   win->field =3D new_win->field;
> > +   win->chromakey =3D new_win->chromakey;
> > +
> > +   /* adjust the cropping window to allow for resizing
> limitations */
> > +   if ((crop->height/win->w.height) >=3D 2) {
> > +           /* The maximum vertical downsizing ratio is 2:1 */
> > +           crop->height =3D win->w.height * 2;
> > +   }
> > +   if ((crop->width/win->w.width) >=3D 2) {
> > +           /* The maximum horizontal downsizing ratio is 2:1 */
> > +           crop->width =3D win->w.width * 2;
> > +   }
> > +   if (crop->width > 768) {
> > +           /* The OMAP2420 vertical resizing line buffer is 768
> pixels
> > +            * wide.  If the cropped image is wider than 768 pixels
> then it
> > +            * cannot be vertically resized.
> > +            */
> > +           if (crop->height !=3D win->w.height)
> > +                   crop->width =3D 768;
> > +   }
> > +   return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_vout_new_window);
> > +
> > +/* Given a new cropping rectangle in new_crop, adjust the
> cropping rectangle to
> > + * the nearest supported configuration.  The image render window
> in win will
> > + * also be adjusted if necessary.  The preview window is adjusted
> such that the
> > + * horizontal and vertical rescaling ratios stay constant.  If
> the render
> > + * window would fall outside the display boundaries, the cropping
> rectangle
> > + * will also be adjusted to maintain the rescaling ratios.  If
> successful, crop
> > + * and win are updated.
> > + * Returns zero if succesful, or -EINVAL if the requested
> cropping rectangle is
> > + * impossible and cannot reasonably be adjusted.
> > + */
> > +int omap_vout_new_crop(struct v4l2_pix_format *pix,
> > +         struct v4l2_rect *crop, struct v4l2_window *win,
> > +         struct v4l2_framebuffer *fbuf, const struct v4l2_rect
> *new_crop)
> > +{
> > +   struct v4l2_rect try_crop;
> > +   unsigned long vresize, hresize;
> > +
> > +   /* make a working copy of the new_crop rectangle */
> > +   try_crop =3D *new_crop;
> > +
> > +   /* adjust the cropping rectangle so it fits in the image */
> > +   if (try_crop.left < 0) {
> > +           try_crop.width +=3D try_crop.left;
> > +           try_crop.left =3D 0;
> > +   }
> > +   if (try_crop.top < 0) {
> > +           try_crop.height +=3D try_crop.top;
> > +           try_crop.top =3D 0;
> > +   }
> > +   try_crop.width =3D (try_crop.width < pix->width) ?
> > +           try_crop.width : pix->width;
> > +   try_crop.height =3D (try_crop.height < pix->height) ?
> > +           try_crop.height : pix->height;
> > +   if (try_crop.left + try_crop.width > pix->width)
> > +           try_crop.width =3D pix->width - try_crop.left;
> > +   if (try_crop.top + try_crop.height > pix->height)
> > +           try_crop.height =3D pix->height - try_crop.top;
> > +   try_crop.width &=3D ~1;
> > +   try_crop.height &=3D ~1;
> > +   if (try_crop.width <=3D 0 || try_crop.height <=3D 0)
> > +           return -EINVAL;
> > +
> > +   if (crop->height !=3D win->w.height) {
> > +           /* If we're resizing vertically, we can't support a crop
> width
> > +            * wider than 768 pixels.
> > +            */
> > +           if (try_crop.width > 768)
> > +                   try_crop.width =3D 768;
> > +   }
> > +   /* vertical resizing */
> > +   vresize =3D (1024 * crop->height) / win->w.height;
> > +   if (vresize > 2048)
> > +           vresize =3D 2048;
> > +   else if (vresize =3D=3D 0)
> > +           vresize =3D 1;
> > +   win->w.height =3D ((1024 * try_crop.height) / vresize) & ~1;
> > +   if (win->w.height =3D=3D 0)
> > +           win->w.height =3D 2;
> > +   if (win->w.height + win->w.top > fbuf->fmt.height) {
> > +           /* We made the preview window extend below the bottom of
> the
> > +            * display, so clip it to the display boundary and
> resize the
> > +            * cropping height to maintain the vertical resizing
> ratio.
> > +            */
> > +           win->w.height =3D (fbuf->fmt.height - win->w.top) & ~1;
> > +           if (try_crop.height =3D=3D 0)
> > +                   try_crop.height =3D 2;
> > +   }
> > +   /* horizontal resizing */
> > +   hresize =3D (1024 * crop->width) / win->w.width;
> > +   if (hresize > 2048)
> > +           hresize =3D 2048;
> > +   else if (hresize =3D=3D 0)
> > +           hresize =3D 1;
> > +   win->w.width =3D ((1024 * try_crop.width) / hresize) & ~1;
> > +   if (win->w.width =3D=3D 0)
> > +           win->w.width =3D 2;
> > +   if (win->w.width + win->w.left > fbuf->fmt.width) {
> > +           /* We made the preview window extend past the right side
> of the
> > +            * display, so clip it to the display boundary and
> resize the
> > +            * cropping width to maintain the horizontal resizing
> ratio.
> > +            */
> > +           win->w.width =3D (fbuf->fmt.width - win->w.left) & ~1;
> > +           if (try_crop.width =3D=3D 0)
> > +                   try_crop.width =3D 2;
> > +   }
> > +
> > +   /* Check for resizing constraints */
> > +   if ((try_crop.height/win->w.height) >=3D 2) {
> > +           /* The maximum vertical downsizing ratio is 2:1 */
> > +           try_crop.height =3D win->w.height * 2;
> > +   }
> > +   if ((try_crop.width/win->w.width) >=3D 2) {
> > +           /* The maximum horizontal downsizing ratio is 2:1 */
> > +           try_crop.width =3D win->w.width * 2;
> > +   }
> > +   if (try_crop.width > 768) {
> > +           /* The OMAP2420 vertical resizing line buffer is 768
> pixels
> > +            * wide.  If the cropped image is wider than 768 pixels
> then it
> > +            * cannot be vertically resized.
> > +            */
> > +           if (try_crop.height !=3D win->w.height)
> > +                   try_crop.width =3D 768;
> > +   }
> > +
> > +   /* update our cropping rectangle and we're done */
> > +   *crop =3D try_crop;
> > +   return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_vout_new_crop);
> > +
> > +/* Given a new format in pix and fbuf,  crop and win
> > + * structures are initialized to default values. crop
> > + * is initialized to the largest window size that will fit on the
> display.  The
> > + * crop window is centered in the image. win is initialized to
> > + * the same size as crop and is centered on the display.
> > + * All sizes and offsets are constrained to be even numbers.
> > + */
> > +void omap_vout_new_format(struct v4l2_pix_format *pix,
> > +           struct v4l2_framebuffer *fbuf, struct v4l2_rect *crop,
> > +           struct v4l2_window *win)
> > +{
> > +   /* crop defines the preview source window in the image capture
> > +    * buffer
> > +    */
> > +   omap_vout_default_crop(pix, fbuf, crop);
> > +
> > +   /* win defines the preview target window on the display */
> > +   win->w.width =3D crop->width;
> > +   win->w.height =3D crop->height;
> > +   win->w.left =3D ((fbuf->fmt.width - win->w.width) >> 1) & ~1;
> > +   win->w.top =3D ((fbuf->fmt.height - win->w.height) >> 1) & ~1;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_vout_new_format);
> > +
> > +MODULE_AUTHOR("Texas Instruments.");
> > +MODULE_DESCRIPTION("OMAP Video library");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/media/video/omap/omap_voutlib.h
> b/drivers/media/video/omap/omap_voutlib.h
> > new file mode 100644
> > index 0000000..d98f659
> > --- /dev/null
> > +++ b/drivers/media/video/omap/omap_voutlib.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * drivers/media/video/omap/omap_voutlib.h
> > + *
> > + * Copyright (C) 2008 Texas Instruments.
> > + *
> > + * This file is licensed under the terms of the GNU General
> Public License
> > + * version 2. This program is licensed "as is" without any
> warranty of any
> > + * kind, whether express or implied.
> > + *
> > + */
> > +
> > +#ifndef OMAP_VOUTLIB_H
> > +#define OMAP_VOUTLIB_H
> > +
> > +extern void omap_vout_default_crop(struct v4l2_pix_format *pix,
> > +           struct v4l2_framebuffer *fbuf, struct v4l2_rect *crop);
> > +
> > +extern int omap_vout_new_crop(struct v4l2_pix_format *pix,
> > +           struct v4l2_rect *crop, struct v4l2_window *win,
> > +           struct v4l2_framebuffer *fbuf,
> > +           const struct v4l2_rect *new_crop);
> > +
> > +extern int omap_vout_try_window(struct v4l2_framebuffer *fbuf,
> > +           struct v4l2_window *new_win);
> > +
> > +extern int omap_vout_new_window(struct v4l2_rect *crop,
> > +           struct v4l2_window *win, struct v4l2_framebuffer *fbuf,
> > +           struct v4l2_window *new_win);
> > +
> > +extern void omap_vout_new_format(struct v4l2_pix_format *pix,
> > +           struct v4l2_framebuffer *fbuf, struct v4l2_rect *crop,
> > +           struct v4l2_window *win);
> > +#endif     /* #ifndef OMAP_LIB_H */
> > +
> > --
> > 1.5.6
> >
> > --
> > video4linux-list mailing list
> > Unsubscribe mailto:video4linux-list-
> request@redhat.com?subject=3Dunsubscribe
> > https://www.redhat.com/mailman/listinfo/video4linux-list
> --
> Best regards, Klimov Alexey
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
