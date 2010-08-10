From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: Re: [PATCH] OMAP: DSS2: don't power off a panel twice
Date: Tue, 10 Aug 2010 15:04:06 -0700
Message-ID: <AANLkTi=rq_myAkvRJLdZ3yHHTNr7sPYF2K9pEK-QEMtB@mail.gmail.com>
References: <1281442585-6511-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64816 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933486Ab0HJWEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 18:04:08 -0400
Received: by wwj40 with SMTP id 40so13460923wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 15:04:06 -0700 (PDT)
In-Reply-To: <1281442585-6511-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

On Tue, Aug 10, 2010 at 5:16 AM, Stanley.Miao
<stanley.miao@windriver.com> wrote:
> If we blank the panel by
> echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
>
> Then, we reboot the sytem, the kernel will crash at
> drivers/video/omap2/dss/core.c:323
>
> This is because the panel is closed twice. Now add a variable panel_e=
nabled
> to forbid a panel is power on or power off twice.
>
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
> =C2=A0drivers/video/omap2/displays/panel-generic.c =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 11 +++++++++++
> =C2=A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =C2=A0 11 =
+++++++++++
> =C2=A0.../video/omap2/displays/panel-sharp-ls037v7dw01.c | =C2=A0 11 =
+++++++++++
> =C2=A0drivers/video/omap2/displays/panel-taal.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A06 ++++++
> =C2=A0.../video/omap2/displays/panel-toppoly-tdo35s.c =C2=A0 =C2=A0| =
=C2=A0 11 +++++++++++
> =C2=A0.../video/omap2/displays/panel-tpo-td043mtea1.c =C2=A0 =C2=A0| =
=C2=A0 =C2=A09 +++++++++
> =C2=A06 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/v=
ideo/omap2/displays/panel-generic.c
> index 300eff5..607f11a 100644
> --- a/drivers/video/omap2/displays/panel-generic.c
> +++ b/drivers/video/omap2/displays/panel-generic.c
> @@ -22,6 +22,8 @@
>
> =C2=A0#include <plat/display.h>
>
> +static int panel_enabled;
> +
> =C2=A0static struct omap_video_timings generic_panel_timings =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 640 x 480 @ 60 Hz =C2=A0Reduced blankin=
g VESA CVT 0.31M3-R */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.x_res =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 640,
> @@ -39,6 +41,9 @@ static int generic_panel_power_on(struct omap_dss_d=
evice *dssdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
>
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D omapdss_dpi_display_enable(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err0;
> @@ -48,6 +53,7 @@ static int generic_panel_power_on(struct omap_dss_d=
evice *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err1:
> @@ -58,10 +64,14 @@ err0:
>
> =C2=A0static void generic_panel_power_off(struct omap_dss_device *dss=
dev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdev->platform_disable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dssdev->platfo=
rm_disable(dssdev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omapdss_dpi_display_disable(dssdev);
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0}
>
> =C2=A0static int generic_panel_probe(struct omap_dss_device *dssdev)
> @@ -155,6 +165,7 @@ static struct omap_dss_driver generic_driver =3D =
{
>
> =C2=A0static int __init generic_panel_drv_init(void)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return omap_dss_register_driver(&generic_d=
river);
> =C2=A0}
>
> diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b=
/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> index 1026746..b5205d4 100644
> --- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> @@ -24,6 +24,8 @@
>
> =C2=A0#include <plat/display.h>
>
> +static int panel_enabled;
> +
> =C2=A0static struct omap_video_timings sharp_lq_timings =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.x_res =3D 480,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.y_res =3D 272,
> @@ -43,6 +45,9 @@ static int sharp_lq_panel_power_on(struct omap_dss_=
device *dssdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
>
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D omapdss_dpi_display_enable(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err0;
> @@ -55,6 +60,7 @@ static int sharp_lq_panel_power_on(struct omap_dss_=
device *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err1:
> @@ -65,6 +71,9 @@ err0:
>
> =C2=A0static void sharp_lq_panel_power_off(struct omap_dss_device *ds=
sdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdev->platform_disable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dssdev->platfo=
rm_disable(dssdev);
>
> @@ -72,6 +81,7 @@ static void sharp_lq_panel_power_off(struct omap_ds=
s_device *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(100);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omapdss_dpi_display_disable(dssdev);
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0}
>
> =C2=A0static int sharp_lq_panel_probe(struct omap_dss_device *dssdev)
> @@ -146,6 +156,7 @@ static struct omap_dss_driver sharp_lq_driver =3D=
 {
>
> =C2=A0static int __init sharp_lq_panel_drv_init(void)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return omap_dss_register_driver(&sharp_lq_=
driver);
> =C2=A0}
>
> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b=
/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> index 7d9eb2b..3750fdc 100644
> --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> @@ -31,6 +31,8 @@ struct sharp_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct backlight_device *bl;
> =C2=A0};
>
> +static int panel_enabled;
> +
> =C2=A0static struct omap_video_timings sharp_ls_timings =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.x_res =3D 480,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.y_res =3D 640,
> @@ -135,6 +137,9 @@ static int sharp_ls_power_on(struct omap_dss_devi=
ce *dssdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r =3D 0;
>
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D omapdss_dpi_display_enable(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err0;
> @@ -147,6 +152,7 @@ static int sharp_ls_power_on(struct omap_dss_devi=
ce *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err1:
> @@ -157,6 +163,9 @@ err0:
>
> =C2=A0static void sharp_ls_power_off(struct omap_dss_device *dssdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdev->platform_disable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dssdev->platfo=
rm_disable(dssdev);
>
> @@ -165,6 +174,7 @@ static void sharp_ls_power_off(struct omap_dss_de=
vice *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(100);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omapdss_dpi_display_disable(dssdev);
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0}
>
> =C2=A0static int sharp_ls_panel_enable(struct omap_dss_device *dssdev=
)
> @@ -213,6 +223,7 @@ static struct omap_dss_driver sharp_ls_driver =3D=
 {
>
> =C2=A0static int __init sharp_ls_panel_drv_init(void)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return omap_dss_register_driver(&sharp_ls_=
driver);
> =C2=A0}
>
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/vide=
o/omap2/displays/panel-taal.c
> index aaf5d30..db65577 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -635,6 +635,9 @@ static int taal_power_on(struct omap_dss_device *=
dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 id1, id2, id3;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
>
> + =C2=A0 =C2=A0 =C2=A0 if (td->enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdev->platform_enable) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D dssdev->=
platform_enable(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> @@ -715,6 +718,9 @@ static void taal_power_off(struct omap_dss_device=
 *dssdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct taal_data *td =3D dev_get_drvdata(&=
dssdev->dev);
>
> + =C2=A0 =C2=A0 =C2=A0 if (td->enabled =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dsi_bus_lock();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cancel_delayed_work(&td->esd_work);
> diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/dr=
ivers/video/omap2/displays/panel-toppoly-tdo35s.c
> index fa434ca..da279d8 100644
> --- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> +++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> @@ -26,6 +26,8 @@
>
> =C2=A0#include <plat/display.h>
>
> +static int panel_enabled;
> +
> =C2=A0static struct omap_video_timings toppoly_tdo_panel_timings =3D =
{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 640 x 480 @ 60 Hz =C2=A0Reduced blankin=
g VESA CVT 0.31M3-R */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.x_res =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 480,
> @@ -46,6 +48,9 @@ static int toppoly_tdo_panel_power_on(struct omap_d=
ss_device *dssdev)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
>
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D omapdss_dpi_display_enable(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err0;
> @@ -55,6 +60,7 @@ static int toppoly_tdo_panel_power_on(struct omap_d=
ss_device *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto err1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err1:
> @@ -65,10 +71,14 @@ err0:
>
> =C2=A0static void toppoly_tdo_panel_power_off(struct omap_dss_device =
*dssdev)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 if (panel_enabled =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dssdev->platform_disable)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dssdev->platfo=
rm_disable(dssdev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omapdss_dpi_display_disable(dssdev);
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0}
>
> =C2=A0static int toppoly_tdo_panel_probe(struct omap_dss_device *dssd=
ev)
> @@ -141,6 +151,7 @@ static struct omap_dss_driver generic_driver =3D =
{
>
> =C2=A0static int __init toppoly_tdo_panel_drv_init(void)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 panel_enabled =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return omap_dss_register_driver(&generic_d=
river);
> =C2=A0}
>
> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/dr=
ivers/video/omap2/displays/panel-tpo-td043mtea1.c
> index e866e76..9f09150 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -57,6 +57,7 @@ struct tpo_td043_device {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mode;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 hmirror:1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 vmirror:1;
> + =C2=A0 =C2=A0 =C2=A0 int enabled;
> =C2=A0};
>
> =C2=A0static int tpo_td043_write(struct spi_device *spi, u8 addr, u8 =
data)
> @@ -269,6 +270,9 @@ static int tpo_td043_power_on(struct omap_dss_dev=
ice *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int nreset_gpio =3D dssdev->reset_gpio;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
>
> + =C2=A0 =C2=A0 =C2=A0 if (tpo_td043->enabled)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D omapdss_dpi_display_enable(dssdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err0;
> @@ -295,6 +299,7 @@ static int tpo_td043_power_on(struct omap_dss_dev=
ice *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tpo_td043_write_mirror(tpo_td043->spi, tpo=
_td043->hmirror,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0tpo_td043->vmirror);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tpo_td043_write_gamma(tpo_td043->spi, tpo_=
td043->gamma);
> + =C2=A0 =C2=A0 =C2=A0 tpo_td043->enabled =3D 1;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0err1:
> @@ -308,6 +313,9 @@ static void tpo_td043_power_off(struct omap_dss_d=
evice *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tpo_td043_device *tpo_td043 =3D dev=
_get_drvdata(&dssdev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int nreset_gpio =3D dssdev->reset_gpio;
>
> + =C2=A0 =C2=A0 =C2=A0 if (tpo_td043->enabled =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tpo_td043_write(tpo_td043->spi, 3,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
>
> @@ -325,6 +333,7 @@ static void tpo_td043_power_off(struct omap_dss_d=
evice *dssdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dssdev->platfo=
rm_disable(dssdev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omapdss_dpi_display_disable(dssdev);
> + =C2=A0 =C2=A0 =C2=A0 tpo_td043->enabled =3D 0;
> =C2=A0}
>
> =C2=A0static int tpo_td043_enable(struct omap_dss_device *dssdev)
> --
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Instead of adding a new variable and a bunch of extra code, I solved
this problem on my local tree by just not doing anything if we're
already not active. See the follwoing for the generic panel driver.

diff --git a/drivers/video/omap2/displays/panel-generic.c
b/drivers/video/omap2/displays/panel-generic.c
index 300eff5..abc03f4 100644
--- a/drivers/video/omap2/displays/panel-generic.c
+++ b/drivers/video/omap2/displays/panel-generic.c
@@ -91,9 +91,12 @@ static int generic_panel_enable(struct
omap_dss_device *dssdev)

 static void generic_panel_disable(struct omap_dss_device *dssdev)
 {
-	generic_panel_power_off(dssdev);
+	if(dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
+	{
+		generic_panel_power_off(dssdev);

-	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
+		dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
+	}
 }

 static int generic_panel_suspend(struct omap_dss_device *dssdev)
--=20
1.6.3.3

--=20
Laine Walker-Avina
=46irmware Engineer
PASCO scientific
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
