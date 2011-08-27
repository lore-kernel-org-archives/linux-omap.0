From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/4] OMAP: OMAPFB: make omapfb start even when a display
 is missing a driver
Date: Sat, 27 Aug 2011 18:28:46 +0800
Message-ID: <CADqH6VybU7=rSAobaOKbvGwHouLeWuGwbUrc70xKgusE_+rqzQ@mail.gmail.com>
References: <1314001636-18036-1-git-send-email-tomi.valkeinen@ti.com>
	<1314001636-18036-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38635 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab1H0K2s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 06:28:48 -0400
In-Reply-To: <1314001636-18036-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

On Mon, Aug 22, 2011 at 4:27 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Currently omapfb wants that all the display devices have a driver,
> otherwise omapfb refuses to start. There's no real requirement to act
> like that, and this patch will make omapfb give a warning and skip th=
at
> device.

Hi Tomi,

Just a question, I am working with an out-of-tree hdmi driver for the
NXP TDA9984 with dm3730. This worked fine in 2.6.32 as a runtime
loaded dss display driver. That is:

+static struct omap_dss_device wiser2_hdmi_device =3D {
+       .type =3D OMAP_DISPLAY_TYPE_DPI,
+       .name =3D "hdmi",
+       .driver_name =3D "hdmi_panel",
+       .phy.dpi.data_lines =3D 24,
+       .platform_enable =3D wiser2_enable_hdmi,
+       .platform_disable =3D wiser2_disable_hdmi,
+};
+
+static struct omap_dss_device wiser2_tv_device =3D {
+       .name =3D "tv",
+       .driver_name =3D "venc",
+       .type =3D OMAP_DISPLAY_TYPE_VENC,
+       .phy.venc.type =3D OMAP_DSS_VENC_TYPE_SVIDEO,
+       .platform_enable =3D wiser2_panel_enable_tv,
+       .platform_disable =3D wiser2_panel_disable_tv,
+};
+
+static struct omap_dss_device *wiser2_dss_devices[] =3D {
+       &wiser2_dvi_device,
+       &wiser2_tv_device,
+       &wiser2_hdmi_device,
+};

so this hdmi_panel omap_dss_driver was being insmoded after init at
bootup and it worked fine, no problems with omaplfb so pvr stuff
worked fine.

I then switched to 2.6.37 (from TI devkit 2.1 gingerbread) and this
kernel wasn't so happy (panic at boot). I applied your patch below. I
also figured out that omap_vout had a similar problem as the one
you've fixed which was what was causing the panic (omap_vout tries to
call display->driver->update without checking if driver exists):
diff --git a/drivers/media/video/omap/omap_vout.c
b/drivers/media/video/omap/omap_vout.c
index 2aee372..36d69db 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -2574,24 +2591,32 @@ static int __init omap_vout_probe(struct
platform_device *pdev)
+       printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
        for (i =3D 0; i < vid_dev->num_displays; i++) {
                struct omap_dss_device *display =3D vid_dev->displays[i=
];

-               if (display->driver->update)
+       printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
+               if ((display->driver) && (display->driver->update)) {
+       printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
                        display->driver->update(display, 0, 0,
                                        display->panel.timings.x_res,
                                        display->panel.timings.y_res);
+               }
+       printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
        }
+       printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
        return 0;

After that change, it boots up cleanly but I don't get any display
output. I noticed that:
echo 1 > /sys/devices/omapdss/display2/enabled
no longer works. display2 stays enabled=3D0 rather than coming on.

I'm planning on debugging this some more when I have some free time.
But I figured I should ask first if this is a known problem, whether
anyone else is testing runtime loaded omap_dss_driver stuff and if
anyone has gotten it to work with kernels 2.6.37 and above.

Thanks,
jaya

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> =A0drivers/video/omap2/omapfb/omapfb-main.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video=
/omap2/omapfb/omapfb-main.c
> index e5a64b3..cd2cae8e 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2373,9 +2373,10 @@ static int omapfb_probe(struct platform_device=
 *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dss_get_device(dssdev);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!dssdev->driver) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no=
 driver for display: %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pdev->dev, "n=
o driver for display: %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev=
->name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dss_put_device(dss=
dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0d =3D &fbdev->displays[fbdev->num_disp=
lays++];
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
