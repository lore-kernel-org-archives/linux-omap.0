From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V3] OMAP: DSS2: don't power off a panel twice
Date: Thu, 21 Oct 2010 12:02:04 +0300
Message-ID: <AANLkTin_ap=CcLXUVC6Ztw_GJ=arymNrK_ByOf8agvQq@mail.gmail.com>
References: <1283483028-1970-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61376 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab0JUJCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 05:02:05 -0400
In-Reply-To: <1283483028-1970-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org, bryan.wu@canonical.com, mathieu.poirier@canonical.com, linux-fbdev@vger.kernel.org

Tomi can you queue this? This has been tested by multiple people now,
also see here:
http://marc.info/?l=3Dlinux-omap&m=3D128759415821646&w=3D2

On Fri, Sep 3, 2010 at 6:03 AM, Stanley.Miao <stanley.miao@windriver.co=
m> wrote:
> If we blank the panel by
> echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank
>
> Then, we reboot the sytem, the kernel will crash at
> drivers/video/omap2/dss/core.c:323
>
> This is because the panel is closed twice. Now check the state of a d=
ssdev
> to forbid a panel is power on or power off twice.
>
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
> =A0drivers/video/omap2/displays/panel-acx565akm.c =A0 =A0 | =A0 =A06 =
++++++
> =A0drivers/video/omap2/displays/panel-generic.c =A0 =A0 =A0 | =A0 =A0=
6 ++++++
> =A0.../video/omap2/displays/panel-sharp-lq043t1dg01.c | =A0 =A06 ++++=
++
> =A0.../video/omap2/displays/panel-sharp-ls037v7dw01.c | =A0 =A06 ++++=
++
> =A0.../video/omap2/displays/panel-toppoly-tdo35s.c =A0 =A0| =A0 =A06 =
++++++
> =A0.../video/omap2/displays/panel-tpo-td043mtea1.c =A0 =A0| =A0 =A06 =
++++++
> =A06 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers=
/video/omap2/displays/panel-acx565akm.c
> index 07fbb8a..e773106 100644
> --- a/drivers/video/omap2/displays/panel-acx565akm.c
> +++ b/drivers/video/omap2/displays/panel-acx565akm.c
> @@ -587,6 +587,9 @@ static int acx_panel_power_on(struct omap_dss_dev=
ice *dssdev)
>
> =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
>
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
>
> =A0 =A0 =A0 =A0r =3D omapdss_sdi_display_enable(dssdev);
> @@ -644,6 +647,9 @@ static void acx_panel_power_off(struct omap_dss_d=
evice *dssdev)
>
> =A0 =A0 =A0 =A0dev_dbg(&dssdev->dev, "%s\n", __func__);
>
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0mutex_lock(&md->mutex);
>
> =A0 =A0 =A0 =A0if (!md->enabled) {
> diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/v=
ideo/omap2/displays/panel-generic.c
> index 300eff5..395a68d 100644
> --- a/drivers/video/omap2/displays/panel-generic.c
> +++ b/drivers/video/omap2/displays/panel-generic.c
> @@ -39,6 +39,9 @@ static int generic_panel_power_on(struct omap_dss_d=
evice *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -58,6 +61,9 @@ err0:
>
> =A0static void generic_panel_power_off(struct omap_dss_device *dssdev=
)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b=
/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> index 1026746..0c6896c 100644
> --- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
> @@ -43,6 +43,9 @@ static int sharp_lq_panel_power_on(struct omap_dss_=
device *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -65,6 +68,9 @@ err0:
>
> =A0static void sharp_lq_panel_power_off(struct omap_dss_device *dssde=
v)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b=
/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> index 7d9eb2b..9a138f6 100644
> --- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> +++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
> @@ -135,6 +135,9 @@ static int sharp_ls_power_on(struct omap_dss_devi=
ce *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r =3D 0;
>
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -157,6 +160,9 @@ err0:
>
> =A0static void sharp_ls_power_off(struct omap_dss_device *dssdev)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/dr=
ivers/video/omap2/displays/panel-toppoly-tdo35s.c
> index e320e67..526e906 100644
> --- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> +++ b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
> @@ -46,6 +46,9 @@ static int toppoly_tdo_panel_power_on(struct omap_d=
ss_device *dssdev)
> =A0{
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -65,6 +68,9 @@ err0:
>
> =A0static void toppoly_tdo_panel_power_off(struct omap_dss_device *ds=
sdev)
> =A0{
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0if (dssdev->platform_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dssdev->platform_disable(dssdev);
>
> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/dr=
ivers/video/omap2/displays/panel-tpo-td043mtea1.c
> index e866e76..dbe9d43 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -269,6 +269,9 @@ static int tpo_td043_power_on(struct omap_dss_dev=
ice *dssdev)
> =A0 =A0 =A0 =A0int nreset_gpio =3D dssdev->reset_gpio;
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 if (dssdev->state =3D=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0r =3D omapdss_dpi_display_enable(dssdev);
> =A0 =A0 =A0 =A0if (r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err0;
> @@ -308,6 +311,9 @@ static void tpo_td043_power_off(struct omap_dss_d=
evice *dssdev)
> =A0 =A0 =A0 =A0struct tpo_td043_device *tpo_td043 =3D dev_get_drvdata=
(&dssdev->dev);
> =A0 =A0 =A0 =A0int nreset_gpio =3D dssdev->reset_gpio;
>
> + =A0 =A0 =A0 if (dssdev->state !=3D OMAP_DSS_DISPLAY_ACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> =A0 =A0 =A0 =A0tpo_td043_write(tpo_td043->spi, 3,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TPO_R03_VAL_STANDBY | =
TPO_R03_EN_PWM);
>
> --
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
