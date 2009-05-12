From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: RE: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
Date: Tue, 12 May 2009 13:02:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030560165E@dbde02.ent.ti.com>
References: <90b950fc0904300549t26a3104u4fa1399753ec193c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <90b950fc0904300549t26a3104u4fa1399753ec193c@mail.gmail.com>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: InKi Dae <daeinki@gmail.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Inki,
I was on vacation just came,=20
Below are my comments.

> -----Original Message-----
> From: InKi Dae [mailto:daeinki@gmail.com]
> Sent: Thursday, April 30, 2009 6:19 PM
> To: Shah, Hardik
> Cc: tomi.valkeinen@nokia.com; linux-media@vger.kernel.org; linux-
> omap@vger.kernel.org; Jadav, Brijesh R; Hiremath, Vaibhav
> Subject: Re: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
>=20
> Thank you Shah, Hardik.
> I have patched your driver through that git.
>=20
> but your patch recognizes video2 layer as video1 device node in case
> that DSS2 has fb0 and fb1.
[Shah, Hardik] There is no need to change the nodes.  If there is only =
one video device present than it should be /dev/video1 and not /dev/vid=
eo2.  Its upto the driver to use which video pipeline 1 or 2. So let th=
e node nomenclature be same.

Regards,
Hardik=20
>=20
> you said my patch will give rise to couple of more bugs related to
> global_alpha and pixel formats
> maybe that would be because of vout->vid_info.id =3D k + vout_count;
>=20
> so I have applied your patch to my way.
> this patch is more flexible and recognizes video2 layer correctly as
> video2 device node.
> ---------------------------------------------------------------------=
---------
> ---------------------------------------------------------------------=
---
> --- a/drivers/media/video/omap/omap_vout.c
> +++ b/drivers/media/video/omap/omap_vout.c
> @@ -2204,7 +2204,7 @@ free_buffers:
>  /* Create video out devices */
>  static int __init omap_vout_create_video_devices(struct platform_dev=
ice
> *pdev)
>  {
> -       int r =3D 0, k;
> +       int r =3D 0, k, vout_count;
>         struct omap_vout_device *vout;
>         struct video_device *vfd =3D NULL;
>         struct v4l2_device *v4l2_dev =3D platform_get_drvdata(pdev);
> @@ -2212,6 +2212,8 @@ static int __init
> omap_vout_create_video_devices(struct platform_device *pdev)
>         struct omap2video_device *vid_dev =3D container_of(v4l2_dev, =
struct
>                         omap2video_device, v4l2_dev);
>=20
> +       vout_count =3D 3 - pdev->num_resources;
> +
>         for (k =3D 0; k < pdev->num_resources; k++) {
>=20
>                 vout =3D kmalloc(sizeof(struct omap_vout_device), GFP=
_KERNEL);
> @@ -2225,12 +2227,7 @@ static int __init
> omap_vout_create_video_devices(struct platform_device *pdev)
>                 vout->vid =3D k;
>                 vid_dev->vouts[k] =3D vout;
>                 vout->vid_dev =3D vid_dev;
> -               /* Select video2 if only 1 overlay is controlled by V=
4L2 */
> -               if (pdev->num_resources =3D=3D 1)
> -                       vout->vid_info.overlays[0] =3D vid_dev->overl=
ays[k + 2];
> -               else
> -                       /* Else select video1 and video2 one by one. =
*/
> -                       vout->vid_info.overlays[0] =3D vid_dev->overl=
ays[k + 1];
> +               vout->vid_info.overlays[0] =3D vid_dev->overlays[k +
> vout_count];
>                 vout->vid_info.num_overlays =3D 1;
>                 vout->vid_info.id =3D k + 1;
>                 vid_dev->num_videos++;
> @@ -2253,7 +2250,7 @@ static int __init
> omap_vout_create_video_devices(struct platform_device *pdev)
>                 /* Register the Video device with V4L2
>                 */
>                 vfd =3D vout->vfd;
> -               if (video_register_device(vfd, VFL_TYPE_GRABBER, k + =
1) < 0) {
> +               if (video_register_device(vfd, VFL_TYPE_GRABBER, k +
> vout_count) < 0) {
>                         printk(KERN_ERR VOUT_NAME ": could not regist=
er "
>                                         "Video for Linux device\n");
>                         vfd->minor =3D -1
> ---------------------------------------------------------------------=
---------
> ---------------------------------------------------------------------=
---------
> ---------
>=20
> 2009/4/30 Shah, Hardik <hardik.shah@ti.com>:
>=20
> >
> >> -----Original Message-----
> >> From: linux-media-owner@vger.kernel.org [mailto:linux-media-
> >> owner@vger.kernel.org] On Behalf Of Shah, Hardik
> >> Sent: Thursday, April 30, 2009 11:51 AM
> >> To: InKi Dae
> >> Cc: tomi.valkeinen@nokia.com; linux-media@vger.kernel.org; linux-
> >> omap@vger.kernel.org; Jadav, Brijesh R; Hiremath, Vaibhav
> >> Subject: RE: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
> >>
> >>
> >>
> >> > -----Original Message-----
> >> > From: InKi Dae [mailto:daeinki@gmail.com]
> >> > Sent: Thursday, April 30, 2009 11:48 AM
> >> > To: Shah, Hardik
> >> > Cc: tomi.valkeinen@nokia.com; linux-media@vger.kernel.org; linux=
-
> >> > omap@vger.kernel.org; Jadav, Brijesh R; Hiremath, Vaibhav
> >> > Subject: Re: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
> >> >
> >> > hello Shah, Hardik..
> >> >
> >> > your omap_vout.c has the problem that it disables video1 or fb1.
> >> > so I have modified your code.
> >> >
> >> > I defined and set platform_data for DSS2 in machine code.(or boa=
rd file)
> >> >
> >> > static struct omapfb_platform_data xxx_dss_platform_data =3D {
> >> > =A0 =A0 .mem_desc.region[0].format =3D OMAPFB_COLOR_ARGB32,
> >> > =A0 =A0 .mem_desc.region[0].format_used=3D1,
> >> >
> >> > =A0 =A0 .mem_desc.region[1].format =3D OMAPFB_COLOR_RGB24U,
> >> > =A0 =A0 .mem_desc.region[1].format_used=3D1,
> >> >
> >> > =A0 =A0 .mem_desc.region[2].format =3D OMAPFB_COLOR_ARGB32,
> >> > =A0 =A0 .mem_desc.region[2].format_used=3D1,
> >> > };
> >> >
> >> > omapfb_set_platform_data(&xxx_dss_platform_data);
> >> >
> >> > after that, omap_vout has resource count got referring to frameb=
uffer
> count,
> >> > registers overlay as vout's one and would decide to use which ov=
erlay.
> >> >
> >> > at that time, your code would face with impact on some overlay(f=
b or
> video).
> >> >
> >> > this patch would solve that problem.
> >> > when it sets overlay to vout, vout would get overlay array index=
 to
> >> > avoid overlapping with other overlay.
> >> >
> >> >
> >> > sighed-off-by: InKi Dae. <inki.dae@samsung.com>
> >> > ---
> >> > diff --git a/drivers/media/video/omap/omap_vout.c
> >> > b/drivers/media/video/omap/omap_vout.c
> >> > index 9b4a0d7..051298a 100644
> >> > --- a/drivers/media/video/omap/omap_vout.c
> >> > +++ b/drivers/media/video/omap/omap_vout.c
> >> > @@ -2246,11 +2246,13 @@ free_buffers:
> >> > =A0/* Create video out devices */
> >> > =A0static int __init omap_vout_create_video_devices(struct platf=
orm_device
> >> > *pdev)
> >> > =A0{
> >> > - =A0 int r =3D 0, k;
> >> > + =A0 int r =3D 0, k, vout_count;
> >> > =A0 =A0 struct omap_vout_device *vout;
> >> > =A0 =A0 struct video_device *vfd =3D NULL;
> >> > =A0 =A0 struct omap2video_device *vid_dev =3D platform_get_drvda=
ta(pdev);
> >> >
> >> > + =A0 vout_count =3D 3 - pdev->num_resources;
> >> > +
> >> > =A0 =A0 for (k =3D 0; k < pdev->num_resources; k++) {
> >> >
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vout =3D kmalloc(sizeof(struct omap_vout=
_device), GFP_KERNEL);
> >> > @@ -2266,9 +2268,9 @@ static int __init
> >> > omap_vout_create_video_devices(struct platform_device *pdev)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vout->vid =3D k;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->vouts[k] =3D vout;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.vid_dev =3D vid_dev;
> >> > - =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays[0] =3D vid_dev->ov=
erlays[k + 1];
> >> > + =A0 =A0 =A0 =A0 =A0 vout->vid_info.overlays[0] =3D vid_dev->ov=
erlays[k +
> vout_count];
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vout->vid_info.num_overlays =3D 1;
> >> > - =A0 =A0 =A0 =A0 =A0 vout->vid_info.id =3D k + 1;
> >> > + =A0 =A0 =A0 =A0 =A0 vout->vid_info.id =3D k + vout_count;
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vid_dev->num_videos++;
> >> >
> >> > =A0 =A0 =A0 =A0 =A0 =A0 /* Setup the default configuration for t=
he video devices
> >> > @@ -2289,7 +2291,7 @@ static int __init
> >> > omap_vout_create_video_devices(struct platform_device *pdev)
> >> > =A0 =A0 =A0 =A0 =A0 =A0 /* Register the Video device with V4L2
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> > =A0 =A0 =A0 =A0 =A0 =A0 vfd =3D vout->vfd;
> >> > - =A0 =A0 =A0 =A0 =A0 if (video_register_device(vfd, VFL_TYPE_GR=
ABBER, k + 1) < 0)
> {
> >> > + =A0 =A0 =A0 =A0 =A0 if (video_register_device(vfd, VFL_TYPE_GR=
ABBER, k +
> vout_count) <
> >> > 0) {
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR VOUT_NAM=
E ": could not register \
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 Video for Linux device\n");
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vfd->minor =3D -1;
> >> >
> >> >
> >> > 2009/4/22 Shah, Hardik <hardik.shah@ti.com>:
> >> [Shah, Hardik] Yes this is correct,
> >> I will apply this patch. =A0I already found it and fixed it in dif=
ferent way
> but
> >> any way I will apply your patch.
> > [Shah, Hardik] Further on this inki. =A0Solving this bug will give =
rise to
> couple of more bugs related to global_alpha and pixel formats. That a=
lso is
> fixed. You can refer http://arago-project.org/git/people/vaibhav/ti-p=
sp-omap-
> video.git?p=3Dpeople/vaibhav/ti-psp-omap-video.git;a=3Dsummary
> >> > >
> >> > >
> >> > >> -----Original Message-----
> >> > >> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> >> > >> Sent: Wednesday, April 22, 2009 1:53 PM
> >> > >> To: Shah, Hardik
> >> > >> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; =
Jadav,
> >> Brijesh
> >> > R;
> >> > >> Hiremath, Vaibhav
> >> > >> Subject: Re: [PATCH 3/3] OMAP2/3 V4L2 Display Driver
> >> > >>
> >> > >> Hi,
> >> > >>
> >> > >> On Wed, 2009-04-22 at 08:25 +0200, ext Hardik Shah wrote:
> >> > >> > This is the version 5th of the Driver.
> >> > >> >
> >> > >> > Following are the features supported.
> >> > >> > 1. Provides V4L2 user interface for the video pipelines of =
DSS
> >> > >> > 2. Basic streaming working on LCD and TV.
> >> > >> > 3. Support for various pixel formats like YUV, UYVY, RGB32,=
 RGB24,
> >> RGB565
> >> > >> > 4. Supports Alpha blending.
> >> > >> > 5. Supports Color keying both source and destination.
> >> > >> > 6. Supports rotation with RGB565 and RGB32 pixels formats.
> >> > >> > 7. Supports cropping.
> >> > >> > 8. Supports Background color setting.
> >> > >> > 9. Works on latest DSS2 library from Tomi
> >> > >> > http://www.bat.org/~tomba/git/linux-omap-dss.git/
> >> > >> > 10. 1/4x scaling added. =A0Detail testing left
> >> > >> >
> >> > >> > TODOS
> >> > >> > 1. Ioctls needs to be added for color space conversion matr=
ix
> >> > >> > coefficient programming.
> >> > >> > 2. To be tested on DVI resolutions.
> >> > >> >
> >> > >> > Comments fixed from community.
> >> > >> > 1. V4L2 Driver for OMAP3/3 DSS.
> >> > >> > 2. =A0Conversion of the custom ioctls to standard V4L2 ioct=
ls like
> alpha
> >> > >> blending,
> >> > >> > color keying, rotation and back ground color setting
> >> > >> > 3. =A0Re-organised the code as per community comments.
> >> > >> > 4. =A0Added proper copyright year.
> >> > >> > 5. =A0Added module name in printk
> >> > >> > 6. =A0Kconfig option copy/paste error
> >> > >> > 7. =A0Module param desc addded.
> >> > >> > 8. =A0Query control implemented using standard query_fill
> >> > >> > 9. =A0Re-arranged if-else constructs.
> >> > >> > 10. Changed to use mutex instead of semaphore.
> >> > >> > 11. Removed dual usage of rotation angles.
> >> > >> > 12. Implemented function to convert the V4L2 angle to DSS a=
ngle.
> >> > >> > 13. Y-position was set half by video driver for TV output
> >> > >> > Now its done by DSS so removed that.
> >> > >> > 14. Minor cleanup
> >> > >> > 15. Added support to pass the page offset to application.
> >> > >> > 14. Minor cleanup
> >> > >> > 15. Added support to pass the page offset to application.
> >> > >> > 16. Renamed V4L2_CID_ROTATION to V4L2_CID_ROTATE
> >> > >> > 17. Major comment from Hans fixed.
> >> > >> > 18. Copy right year changed.
> >> > >> > 19. Added module name for each error/warning print message.
> >> > >> >
> >> > >> > Changes from Previous Version.
> >> > >> > 1. Supported YUV rotation.
> >> > >> > 2. Supported Flipping.
> >> > >> > 3. Rebased line with Tomi's latest DSS2 master branch with =
commit
> =A0id
> >> > >> > f575a02edf2218a18d6f2ced308b4f3e26b44ce2.
> >> > >> > 4. Kconfig option removed to select between the TV and LCD.
> >> > >> > Now supported dynamically by DSS2 library.
> >> > >> > 5. Kconfig option for the NTSC_M and PAL_BDGHI mode but not
> >> > >> > supported by DSS2. =A0so it will not work now.
> >> > >>
> >> > >> There is basic support for this. See the DSS doc:
> >> > >>
> >> > >> /sys/devices/platform/omapdss/display? directory:
> >> > >> ...
> >> > >> timings =A0 =A0 =A0 =A0 Display timings
> >> > (pixclock,xres/hfp/hbp/hsw,yres/vfp/vbp/vsw)
> >> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 When writing, two special tim=
ings are accepted for tv-
> >> out:
> >> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "pal" and "ntsc"
> >> > > [Shah, Hardik] I was not aware of it will remove the compile t=
ime
> option
> >> and
> >> > for now let the sysfs entry change the standard. =A0In future I =
will try to
> do
> >> > it with the S_STD and G_STD ioctls of the V4L2 framework.
> >> > >>
> >> > >> =A0Tomi
> >> > >>
> >> > >>
> >> > >
> >> > > --
> >> > > To unsubscribe from this list: send the line "unsubscribe linu=
x-media"
> in
> >> > > the body of a message to majordomo@vger.kernel.org
> >> > > More majordomo info at =A0http://vger.kernel.org/majordomo-inf=
o.html
> >> > >
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-me=
dia" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> >

--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
