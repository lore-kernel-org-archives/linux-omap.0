From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Adding check_timings and set_timings for panel-taal
Date: Wed, 1 Dec 2010 17:04:32 +0530
Message-ID: <AANLkTik2CN1B0q+4hODpWT9FC9sagZiVi6vN4kd-1oHp@mail.gmail.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB0322C02A6E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35158 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308Ab0LALfO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 06:35:14 -0500
Received: by mail-iw0-f178.google.com with SMTP id 1so8706897iwn.23
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 03:35:13 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB0322C02A6E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Janorkar, Mayuresh" <mayur@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Mayuresh,

One minor comment below.

On Wed, Dec 1, 2010 at 16:29, Janorkar, Mayuresh <mayur@ti.com> wrote:
> From: Mayuresh Janorkar <mayur@ti.com>
>
> This patch would add two APIs for panel-taal:
> check_timings and set_timings.
>
> These are required by omapfb in case we wish to set default mode thro=
ugh bootargs.
> e.g.: omapfb.mode=3D"lcd:640x480-16" (display device:width X height -=
 bits per pixel)
>
> omapfb_set_def_mode function in omapfb-main.c essentially needs these=
 functions
> otherwise it would return -EINVAL and default mode sent through boota=
rgs
> would be ignored.
>
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> ---
> =A0drivers/video/omap2/displays/panel-taal.c | =A0 25 +++++++++++++++=
++++++++++
> =A01 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/vide=
o/omap2/displays/panel-taal.c
> index e1c765d..e29c308 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -476,6 +476,29 @@ static void taal_get_timings(struct omap_dss_dev=
ice *dssdev,
> =A0 =A0 =A0 =A0*timings =3D dssdev->panel.timings;
> =A0}
>
> +static void taal_set_timings(struct omap_dss_device *dssdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timin=
gs *timings)
> +{
> + =A0 =A0 =A0 /* TAAL panel's timing struct has only x_res and y_res
> + =A0 =A0 =A0 =A0* other timing parameters are not set
> + =A0 =A0 =A0 =A0*/

Check multi-line comment style

> + =A0 =A0 =A0 dssdev->panel.timings.x_res =3D timings->x_res;
> + =A0 =A0 =A0 dssdev->panel.timings.y_res =3D timings->y_res;
> +}
> +
> +static int taal_check_timings(struct omap_dss_device *dssdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_video_timin=
gs *timings)
> +{
> + =A0 =A0 =A0 /* TAAL panel's timing struct has only x_res and y_res
> + =A0 =A0 =A0 =A0* other timing parameters are not set
> + =A0 =A0 =A0 =A0*/

Ditto

> + =A0 =A0 =A0 if (!timings || timings->x_res !=3D dssdev->panel.timin=
gs.x_res ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timings->y_res !=3D dssdev->panel.timin=
gs.y_res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static void taal_get_resolution(struct omap_dss_device *dssdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 *xres, u16 *yres)
> =A0{
> @@ -1563,6 +1586,8 @@ static struct omap_dss_driver taal_driver =3D {
> =A0 =A0 =A0 =A0.memory_read =A0 =A0=3D taal_memory_read,
>
> =A0 =A0 =A0 =A0.get_timings =A0 =A0=3D taal_get_timings,
> + =A0 =A0 =A0 .set_timings =A0 =A0=3D taal_set_timings,
> + =A0 =A0 =A0 .check_timings =A0=3D taal_check_timings,
>
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "taal",
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
