From: Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 3/3] V4L2 Driver for OMAP3/3 DSS.
Date: Fri, 20 Mar 2009 15:32:06 +0300
Message-ID: <208cbae30903200532v763f0ce1vf1306d75efd6123e@mail.gmail.com>
References: <1237526408-14249-1-git-send-email-hardik.shah@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46053 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbZCTMcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 08:32:10 -0400
In-Reply-To: <1237526408-14249-1-git-send-email-hardik.shah@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hardik Shah <hardik.shah@ti.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Brijesh Jadav <brijesh.j@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

<snip>

Hello again,
my previous message due to bad connection was send with no end.
Sorry about that.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid =3D k;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->vouts[k] =3D vout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.vid_dev =3D vid_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays[0] =3D vid_dev-=
>overlays[k + 1];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.num_overlays =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.id =3D k + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->num_videos++;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the default configuration for =
the video devices
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_vout_setup_video_data(vout) !=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Register the Video device with V4L2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd =3D vout->vfd;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (video_register_device(vfd, VFL_TYPE=
_GRABBER, k + 1) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME ": could not register \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 Video for Linux device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd->minor =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (k =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v1out =3D vout;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v2out =3D vout;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_changes(vid_dev->vo=
uts[k], 0, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto success;
> +error2:
> + =A0 =A0 =A0 omap_vout_release_vrfb(vout);
> + =A0 =A0 =A0 omap_vout_free_buffers(vout);
> +error1:
> + =A0 =A0 =A0 video_device_release(vfd);
> +error:
> + =A0 =A0 =A0 kfree(vout);
> + =A0 =A0 =A0 return r;
> +
> +success:
> + =A0 =A0 =A0 printk(KERN_INFO VOUT_NAME ": registered and initialize=
d\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 video device %d [v4l2]\=
n", vfd->minor);
> + =A0 =A0 =A0 if (k =3D=3D (pdev->num_resources - 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -ENODEV;
> +
> +}
> +
> +int omapvid_apply_changes(struct omap_vout_device *vout, u32 addr, i=
nt init)
> +{
> + =A0 =A0 =A0 int r =3D 0;
> + =A0 =A0 =A0 struct omapvideo_info *ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 int posx, posy;
> + =A0 =A0 =A0 int outw, outh, temp, rotation;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct v4l2_window *win;
> + =A0 =A0 =A0 struct omap_video_timings *timing;
> + =A0 =A0 =A0 struct omap_display *cur_display;
> +
> + =A0 =A0 =A0 win =3D &vout->win;
> + =A0 =A0 =A0 rotation =3D vout->rotation;
> + =A0 =A0 =A0 for (i =3D 0; i < ovid->num_overlays; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl =3D ovid->overlays[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->dis=
play)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timing =3D &ovl->manager->display->pane=
l->timings;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_display =3D ovl->manager->display;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (init || (ovl->caps & OMAP_DSS_OVL_C=
AP_SCALE) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D win->w.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D win->w.height;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D win->w.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D win->w.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (init) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (rotation) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Inve=
rt the height and widht for 90
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* an=
d 270 degree rotation
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D=
 outw;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D=
 outh;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D=
 temp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 (timing->y_res - win->w.width)-
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 (timing->x_res - win->w.width) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 (timing->y_res - win->w.height) -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 3:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D=
 outw;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outw =3D=
 outh;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh =3D=
 temp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 (timing->x_res - win->w.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 - win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posx =3D=
 win->w.left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D=
 win->w.top;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cur_display->type =3D=3D OMAP_DISPL=
AY_TYPE_VENC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 posy =3D posy/2;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_setup_overlay(vout, ovl, =
posx, posy, outw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outh, a=
ddr, vout->tv_field1_offset, init);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!init && ovl->manager)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ovl->manager->apply(ovl=
->manager);
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +err:
> + =A0 =A0 =A0 printk(KERN_WARNING "apply_changes failed\n");

Module name here ?

> + =A0 =A0 =A0 return r;
> +}
> +
> +int omapvid_setup_overlay(struct omap_vout_device *vout,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_overlay *ovl, int posx, int=
 posy, int outw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int outh, u32 addr, int tv_field1_offse=
t, int init)
> +{
> + =A0 =A0 =A0 int r =3D 0;
> + =A0 =A0 =A0 enum omap_color_mode mode =3D 0;
> + =A0 =A0 =A0 int rotation, mirror;
> + =A0 =A0 =A0 int cropheight, cropwidth, pixheight, pixwidth;
> + =A0 =A0 =A0 struct omap_overlay_info info;
> +
> + =A0 =A0 =A0 if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) =3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (outw !=3D vout->pix.wi=
dth || outh !=3D vout->pix.height)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mode =3D video_mode_to_dss_mode(vout);
> +
> + =A0 =A0 =A0 if (mode =3D=3D -EINVAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rotation =3D vout->rotation;
> + =A0 =A0 =A0 mirror =3D 0;
> +
> + =A0 =A0 =A0 /* Setup the input plane parameters according to
> + =A0 =A0 =A0 =A0* rotation value selected.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (rotation =3D=3D 1 || rotation =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropheight =3D vout->crop.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropwidth =3D vout->crop.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixheight =3D vout->pix.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixwidth =3D vout->pix.height;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropheight =3D vout->crop.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cropwidth =3D vout->crop.width;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixheight =3D vout->pix.height;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pixwidth =3D vout->pix.width;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ovl->get_overlay_info(ovl, &info);
> + =A0 =A0 =A0 info.paddr =3D addr;
> + =A0 =A0 =A0 info.vaddr =3D NULL;
> + =A0 =A0 =A0 if (vout->rotation >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.screen_width =3D 2048;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.screen_width =3D pixwidth;
> + =A0 =A0 =A0 info.width =3D cropwidth;
> + =A0 =A0 =A0 info.height =3D cropheight;
> + =A0 =A0 =A0 info.color_mode =3D mode;
> + =A0 =A0 =A0 info.rotation =3D rotation;
> + =A0 =A0 =A0 info.mirror =3D mirror;
> + =A0 =A0 =A0 info.pos_x =3D posx;
> + =A0 =A0 =A0 info.pos_y =3D posy;
> + =A0 =A0 =A0 info.out_width =3D outw;
> + =A0 =A0 =A0 info.out_height =3D outh;
> + =A0 =A0 =A0 info.rotation =3D 0;
> + =A0 =A0 =A0 info.mirror =3D 0;
> + =A0 =A0 =A0 info.global_alpha =3D vout->win.global_alpha;
> +
> + =A0 =A0 =A0 r =3D ovl->set_overlay_info(ovl, &info);
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 return 0;
> +err:
> + =A0 =A0 =A0 printk(KERN_WARNING "setup_overlay failed\n");

Module name ?

> + =A0 =A0 =A0 return r;
> +}
> +
> +static enum omap_color_mode video_mode_to_dss_mode(struct omap_vout_=
device
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *vout)
> +{
> + =A0 =A0 =A0 struct v4l2_pix_format *pix =3D &vout->pix;
> + =A0 =A0 =A0 switch (pix->pixelformat) {
> +
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
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->vid =3D=3D OMAP_VIDEO1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_R=
GB24U;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_A=
RGB32;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 case V4L2_PIX_FMT_BGR32:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_DSS_COLOR_RGBX32;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static struct platform_driver omap_vout_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D VOUT_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .probe =3D omap_vout_probe,
> + =A0 =A0 =A0 .remove =3D omap_vout_remove,
> +};
> +
> +void omap_vout_isr(void *arg, unsigned int irqstatus)
> +{
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 struct timeval timevalue;
> + =A0 =A0 =A0 struct omap_vout_device *vout =3D
> + =A0 =A0 =A0 =A0 =A0 (struct omap_vout_device *) arg;
> + =A0 =A0 =A0 u32 addr, fid;
> + =A0 =A0 =A0 struct omapvideo_info *ovid;
> + =A0 =A0 =A0 struct omap_overlay *ovl;
> + =A0 =A0 =A0 struct omap_display *cur_display;
> +
> + =A0 =A0 =A0 if (!vout->streaming)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 ovid =3D &(vout->vid_info);
> + =A0 =A0 =A0 ovl =3D ovid->overlays[0];
> + =A0 =A0 =A0 /* get the display device attached to the overlay */
> + =A0 =A0 =A0 if (!ovl->manager || !ovl->manager->display)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 cur_display =3D ovl->manager->display;
> +
> + =A0 =A0 =A0 spin_lock(&vout->vbq_lock);
> + =A0 =A0 =A0 do_gettimeofday(&timevalue);
> + =A0 =A0 =A0 if (cur_display->type =3D=3D OMAP_DISPLAY_TYPE_DPI) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(irqstatus & DISPC_IRQ_VSYNC))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!vout->first_int && (vout->curFrm !=
=3D vout->nextFrm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->ts =3D ti=
mevalue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->state =3D=
 VIDEOBUF_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&=
vout->curFrm->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm =3D vout->=
nextFrm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->first_int =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&vout->dma_queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm =3D list_entry(vout->dma_=
queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct videobuf_buffer, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&vout->nextFrm->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm->state =3D VIDEOBUF_ACTIV=
E;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (unsigned long) vout->queued_b=
uf_addr[vout->nextFrm->i] +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->c=
ropped_offset ;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_changes(vout, addr,=
 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NA=
ME "failed to change mode\n");
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->first_int) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->first_int =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqstatus & DISPC_IRQ_EVSYNC_ODD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fid =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (irqstatus & DISPC_IRQ_EVSYNC=
_EVEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fid =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->field_id ^=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fid !=3D vout->field_id) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D fid)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->f=
ield_id =3D fid;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&vout->vbq_=
lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (0 =3D=3D fid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vout->curFrm =3D=3D=
 vout->nextFrm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock(&vout->vbq_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->ts =3D ti=
mevalue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm->state =3D=
 VIDEOBUF_DONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_interruptible(&=
vout->curFrm->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->curFrm =3D vout->=
nextFrm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (1 =3D=3D fid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&vout->d=
ma_queue) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (vout->curFrm !=
=3D vout->nextFrm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock(&vout->vbq_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm =3D list_=
entry(vout->dma_queue.next,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct videobuf_buffer, queue);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&vout->nextFrm=
->queue);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->nextFrm->state =3D=
 VIDEOBUF_ACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D (unsigned long=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->queued_bu=
f_addr[vout->nextFrm->i] +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vout->cropped_o=
ffset =A0 =A0 =A0 =A0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D omapvid_apply_cha=
nges(vout, addr, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR VOUT_NAME "failed to\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 change mode\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock(&vout->vbq_lock);
> +}
> +
> +static void omap_vout_cleanup_device(struct omap_vout_device *vout)
> +{
> +
> + =A0 =A0 =A0 struct video_device *vfd;
> +
> + =A0 =A0 =A0 if (!vout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 vfd =3D vout->vfd;
> +
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
> +
> + =A0 =A0 =A0 omap_vout_free_buffers(vout);
> +
> + =A0 =A0 =A0 kfree(vout);
> +
> + =A0 =A0 =A0 if (!(vout->vid))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v1out =3D NULL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 saved_v2out =3D NULL;
> +}
> +
> +static int __init omap_vout_init(void)
> +{
> +
> + =A0 =A0 =A0 if (platform_driver_register(&omap_vout_driver) !=3D 0)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAME ": could not =
register \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Video d=
river\n");
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
> +MODULE_AUTHOR("Texas Instruments.");
> +MODULE_DESCRIPTION("OMAP Video for Linux Video out driver");
> +MODULE_LICENSE("GPL");
> +
> +late_initcall(omap_vout_init);
> +module_exit(omap_vout_cleanup);
> diff --git a/drivers/media/video/omap/omap_voutdef.h b/drivers/media/=
video/omap/omap_voutdef.h
> new file mode 100644
> index 0000000..d9bbc10
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutdef.h
> @@ -0,0 +1,137 @@
> +/*
> + * drivers/media/video/omap/omap_voutdef.h
> + *
> + * Copyright (C) 2005 Texas Instruments.
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
> +#include <mach/display.h>
> +
> +#define YUYV_BPP =A0 =A0 =A0 =A02
> +#define RGB565_BPP =A0 =A0 =A02
> +#define RGB24_BPP =A0 =A0 =A0 3
> +#define RGB32_BPP =A0 =A0 =A0 4
> +#define TILE_SIZE =A0 =A0 =A0 32
> +#define YUYV_VRFB_BPP =A0 2
> +#define RGB_VRFB_BPP =A0 =A01
> +#define MAX_CID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> +
> +
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
> + =A0 =A0 =A0 struct omap_overlay *overlays[3];
> + =A0 =A0 =A0 struct omap2video_device *vid_dev;
> +};
> +
> +struct omap2video_device {
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct mutex =A0mtx;
> +
> + =A0 =A0 =A0 int state;
> +
> + =A0 =A0 =A0 int num_videos;
> + =A0 =A0 =A0 struct omap_vout_device *vouts[10];
> +
> + =A0 =A0 =A0 int num_displays;
> + =A0 =A0 =A0 struct omap_display *displays[10];
> + =A0 =A0 =A0 int num_overlays;
> + =A0 =A0 =A0 struct omap_overlay *overlays[10];
> + =A0 =A0 =A0 int num_managers;
> + =A0 =A0 =A0 struct omap_overlay_manager *managers[10];
> +};
> +
> +/* per-device data structure */
> +struct omap_vout_device {
> +
> + =A0 =A0 =A0 struct omapvideo_info vid_info;
> + =A0 =A0 =A0 struct device dev;
> + =A0 =A0 =A0 struct video_device *vfd;
> + =A0 =A0 =A0 int vid;
> + =A0 =A0 =A0 int opened;
> +
> + =A0 =A0 =A0 /* we don't allow to change image fmt/size once buffer =
has
> + =A0 =A0 =A0 =A0* been allocated
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 int buffer_allocated;
> + =A0 =A0 =A0 /* allow to reuse previosuly allocated buffer which is =
big enough */
> + =A0 =A0 =A0 int buffer_size;
> + =A0 =A0 =A0 /* keep buffer info accross opens */
> + =A0 =A0 =A0 unsigned long buf_virt_addr[VIDEO_MAX_FRAME];
> + =A0 =A0 =A0 unsigned long buf_phy_addr[VIDEO_MAX_FRAME];
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
> + =A0 =A0 =A0 struct omap_vout_fh *streaming;
> +
> + =A0 =A0 =A0 struct v4l2_pix_format pix;
> + =A0 =A0 =A0 struct v4l2_rect crop;
> + =A0 =A0 =A0 struct v4l2_window win;
> + =A0 =A0 =A0 struct v4l2_framebuffer fbuf;
> +
> + =A0 =A0 =A0 /* Lock to protect the shared data structures in ioctl =
*/
> + =A0 =A0 =A0 struct semaphore lock;
> +
> +
> + =A0 =A0 =A0 /* V4L2 control structure for different control id */
> + =A0 =A0 =A0 struct v4l2_control control[MAX_CID];
> + =A0 =A0 =A0 int rotation;
> + =A0 =A0 =A0 int mirror;
> + =A0 =A0 =A0 int flicker_filter;
> + =A0 =A0 =A0 /* V4L2 control structure for different control id */
> +
> + =A0 =A0 =A0 int bpp; /* bytes per pixel */
> + =A0 =A0 =A0 int vrfb_bpp; /* bytes per pixel with respect to VRFB *=
/
> +
> + =A0 =A0 =A0 struct vid_vrfb_dma vrfb_dma_tx;
> + =A0 =A0 =A0 unsigned int smsshado_phy_addr[4];
> + =A0 =A0 =A0 unsigned int smsshado_virt_addr[4];
> + =A0 =A0 =A0 struct vrfb vrfb_context[4];
> + =A0 =A0 =A0 unsigned int smsshado_size;
> + =A0 =A0 =A0 unsigned char pos;
> +
> + =A0 =A0 =A0 int ps, vr_ps, line_length, first_int, field_id;
> + =A0 =A0 =A0 enum v4l2_memory memory;
> + =A0 =A0 =A0 struct videobuf_buffer *curFrm, *nextFrm;
> + =A0 =A0 =A0 struct list_head dma_queue;
> + =A0 =A0 =A0 u8 *queued_buf_addr[32];
> + =A0 =A0 =A0 u32 cropped_offset;
> + =A0 =A0 =A0 s32 tv_field1_offset;
> + =A0 =A0 =A0 void *isr_handle;
> +
> +};
> +
> +/* per-filehandle data structure */
> +struct omap_vout_fh {
> + =A0 =A0 =A0 struct omap_vout_device *vout;
> + =A0 =A0 =A0 enum v4l2_buf_type type;
> + =A0 =A0 =A0 struct videobuf_queue vbq;
> + =A0 =A0 =A0 int io_allowed;
> +};
> +
> +#endif /* ifndef OMAP_VOUTDEF_H */
> diff --git a/drivers/media/video/omap/omap_voutlib.c b/drivers/media/=
video/omap/omap_voutlib.c
> new file mode 100644
> index 0000000..c51a413
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutlib.c
> @@ -0,0 +1,281 @@
> +/*
> + * drivers/media/video/omap/omap_voutlib.c
> + *
> + * Copyright (C) 2008 Texas Instruments.
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
> + * Copyright (C) 2004 Texas Instruments.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/smp_lock.h>
> +#include <linux/kdev_t.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <linux/videodev2.h>
> +#include <linux/semaphore.h>
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
> + =A0 =A0 =A0 new_win->field =3D /*V4L2_FIELD_NONE*/V4L2_FIELD_ANY;
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
> + =A0 =A0 =A0 if ((crop->height/win->w.height) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum vertical downsizing rati=
o is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->height =3D win->w.height * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((crop->width/win->w.width) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum horizontal downsizing ra=
tio is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->width =3D win->w.width * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (crop->width > 768) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The OMAP2420 vertical resizing line =
buffer is 768 pixels
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wide. =A0If the cropped image is w=
ider than 768 pixels then it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cannot be vertically resized.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (crop->height !=3D win->w.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crop->width =3D 768;
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
> + =A0 =A0 =A0 if (vresize > 2048)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vresize =3D 2048;
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
> + =A0 =A0 =A0 if (hresize > 2048)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hresize =3D 2048;
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
> + =A0 =A0 =A0 if ((try_crop.height/win->w.height) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum vertical downsizing rati=
o is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.height =3D win->w.height * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((try_crop.width/win->w.width) >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The maximum horizontal downsizing ra=
tio is 2:1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D win->w.width * 2;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (try_crop.width > 768) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The OMAP2420 vertical resizing line =
buffer is 768 pixels
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* wide. =A0If the cropped image is w=
ider than 768 pixels then it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* cannot be vertically resized.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (try_crop.height !=3D win->w.height)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 try_crop.width =3D 768;
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
> +MODULE_AUTHOR("Texas Instruments.");
> +MODULE_DESCRIPTION("OMAP Video library");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/video/omap/omap_voutlib.h b/drivers/media/=
video/omap/omap_voutlib.h
> new file mode 100644
> index 0000000..d98f659
> --- /dev/null
> +++ b/drivers/media/video/omap/omap_voutlib.h
> @@ -0,0 +1,34 @@
> +/*
> + * drivers/media/video/omap/omap_voutlib.h
> + *
> + * Copyright (C) 2008 Texas Instruments.
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
> +#endif /* #ifndef OMAP_LIB_H */

Please, also check years in patch.

--=20
Best regards, Klimov Alexey
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
