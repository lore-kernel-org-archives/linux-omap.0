From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] OMAP: DSS2: Delay regulator_get() calls
Date: Wed, 23 Feb 2011 22:09:24 +0800
Message-ID: <AANLkTik0tfAzLT=vYSo3QVbxVwYPYVAokZx5t555g9wz@mail.gmail.com>
References: <1298466484-19324-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:42047 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab1BWOJp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 09:09:45 -0500
Received: by yib19 with SMTP id 19so213359yib.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 06:09:44 -0800 (PST)
In-Reply-To: <1298466484-19324-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Mathieu Poirier <mathieu.poirier@canonical.com>, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Cc: linux-omap@vger.kernel.org

Tomi,

Thanks for this real fix instead of the patch came from us for the
regulator issue.
I think this is the right way to fix the root cause.

Mathieu and Richardo, I believe this patch can replace our local patche=
s.

-Bryan

On Wed, Feb 23, 2011 at 9:08 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> DSS submodules DPI/SDI/DSI/VENC require a regulator to function.
> However, if the board doesn't use, say, SDI, the board shouldn't need=
 to
> configure vdds_sdi regulator required by the SDI module.
>
> Currently the regulators are acquired when the DSS driver is loaded.
> This means that if the kernel is configured with SDI, vdds_sdi regula=
tor
> is needed for all boards.
>
> This patch changes the DSS driver to acquire the regulators only when=
 a
> display of particular type is initialized. For example, vdds_sdi is
> acquired when sdi_init_display() is called.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> =A0drivers/video/omap2/dss/dpi.c =A0| =A0 21 +++++++++++++--------
> =A0drivers/video/omap2/dss/dsi.c =A0| =A0 36 +++++++++++++-----------=
------------
> =A0drivers/video/omap2/dss/sdi.c =A0| =A0 18 +++++++++++++-----
> =A0drivers/video/omap2/dss/venc.c | =A0 31 +++++++++++++-------------=
-----
> =A04 files changed, 52 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/=
dpi.c
> index 746f1b6..026702b 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -303,22 +303,27 @@ int dpi_init_display(struct omap_dss_device *ds=
sdev)
> =A0{
> =A0 =A0 =A0 =A0DSSDBG("init_display\n");
>
> - =A0 =A0 =A0 return 0;
> -}
> + =A0 =A0 =A0 if (cpu_is_omap34xx() && dpi.vdds_dsi_reg =3D=3D NULL) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator *vdds_dsi;
>
> -int dpi_init(struct platform_device *pdev)
> -{
> - =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpi.vdds_dsi_reg =3D dss_get_vdds_dsi()=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(dpi.vdds_dsi_reg)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdds_dsi =3D dss_get_vdds_dsi();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(vdds_dsi)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DSSERR("can't get VDDS=
_DSI regulator\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(dpi.vdds=
_dsi_reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(vdds_dsi=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpi.vdds_dsi_reg =3D vdds_dsi;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +int dpi_init(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0void dpi_exit(void)
> =A0{
> =A0}
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/=
dsi.c
> index e189e45..0207065 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -291,20 +291,6 @@ static inline u32 dsi_read_reg(const struct dsi_=
reg idx)
> =A0 =A0 =A0 =A0return __raw_readl(dsi.base + idx.idx);
> =A0}
>
> -static struct regulator *dsi_get_vdds_dsi(void)
> -{
> - =A0 =A0 =A0 struct regulator *reg;
> -
> - =A0 =A0 =A0 if (dsi.vdds_dsi_reg !=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dsi.vdds_dsi_reg;
> -
> - =A0 =A0 =A0 reg =3D regulator_get(&dsi.pdev->dev, "vdds_dsi");
> - =A0 =A0 =A0 if (!IS_ERR(reg))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi.vdds_dsi_reg =3D reg;
> -
> - =A0 =A0 =A0 return reg;
> -}
> -
>
> =A0void dsi_save_context(void)
> =A0{
> @@ -3236,6 +3222,19 @@ int dsi_init_display(struct omap_dss_device *d=
ssdev)
> =A0 =A0 =A0 =A0dsi.vc[0].dssdev =3D dssdev;
> =A0 =A0 =A0 =A0dsi.vc[1].dssdev =3D dssdev;
>
> + =A0 =A0 =A0 if (dsi.vdds_dsi_reg =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator *vdds_dsi;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdds_dsi =3D regulator_get(&dsi.pdev->d=
ev, "vdds_dsi");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(vdds_dsi)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDS_=
DSI regulator\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(vdds_dsi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi.vdds_dsi_reg =3D vdds_dsi;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -3295,13 +3294,6 @@ static int dsi_init(struct platform_device *pd=
ev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dsi.vdds_dsi_reg =3D dsi_get_vdds_dsi();
> - =A0 =A0 =A0 if (IS_ERR(dsi.vdds_dsi_reg)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDS_DSI regulator\n"=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D PTR_ERR(dsi.vdds_dsi_reg);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0enable_clocks(1);
>
> =A0 =A0 =A0 =A0rev =3D dsi_read_reg(DSI_REVISION);
> @@ -3311,8 +3303,6 @@ static int dsi_init(struct platform_device *pde=
v)
> =A0 =A0 =A0 =A0enable_clocks(0);
>
> =A0 =A0 =A0 =A0return 0;
> -err2:
> - =A0 =A0 =A0 iounmap(dsi.base);
> =A0err1:
> =A0 =A0 =A0 =A0destroy_workqueue(dsi.workqueue);
> =A0 =A0 =A0 =A0return r;
> diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/=
sdi.c
> index 8272fc1..9f10a0d 100644
> --- a/drivers/video/omap2/dss/sdi.c
> +++ b/drivers/video/omap2/dss/sdi.c
> @@ -157,6 +157,19 @@ int sdi_init_display(struct omap_dss_device *dss=
dev)
> =A0{
> =A0 =A0 =A0 =A0DSSDBG("SDI init\n");
>
> + =A0 =A0 =A0 if (sdi.vdds_sdi_reg =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator *vdds_sdi;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdds_sdi =3D dss_get_vdds_sdi();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(vdds_sdi)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDS_=
SDI regulator\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(vdds_sdi=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdi.vdds_sdi_reg =3D vdds_sdi;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -165,11 +178,6 @@ int sdi_init(bool skip_init)
> =A0 =A0 =A0 =A0/* we store this for first display enable, then clear =
it */
> =A0 =A0 =A0 =A0sdi.skip_init =3D skip_init;
>
> - =A0 =A0 =A0 sdi.vdds_sdi_reg =3D dss_get_vdds_sdi();
> - =A0 =A0 =A0 if (IS_ERR(sdi.vdds_sdi_reg)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDS_SDI regulator\n"=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(sdi.vdds_sdi_reg);
> - =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Enable clocks already here, otherwise there would b=
e a toggle
> =A0 =A0 =A0 =A0 * of them until sdi_display_enable is called.
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss=
/venc.c
> index 2adae12..9cfcc36 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -305,17 +305,6 @@ static inline u32 venc_read_reg(int idx)
> =A0 =A0 =A0 =A0return l;
> =A0}
>
> -static struct regulator *venc_get_vdda_dac(void)
> -{
> - =A0 =A0 =A0 struct regulator *reg;
> -
> - =A0 =A0 =A0 reg =3D regulator_get(&venc.pdev->dev, "vdda_dac");
> - =A0 =A0 =A0 if (!IS_ERR(reg))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 venc.vdda_dac_reg =3D reg;
> -
> - =A0 =A0 =A0 return reg;
> -}
> -
> =A0static void venc_write_config(const struct venc_config *config)
> =A0{
> =A0 =A0 =A0 =A0DSSDBG("write venc conf\n");
> @@ -655,6 +644,19 @@ int venc_init_display(struct omap_dss_device *ds=
sdev)
> =A0{
> =A0 =A0 =A0 =A0DSSDBG("init_display\n");
>
> + =A0 =A0 =A0 if (venc.vdda_dac_reg =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct regulator *vdda_dac;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdda_dac =3D regulator_get(&venc.pdev->=
dev, "vdda_dac");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(vdda_dac)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDA_=
DAC regulator\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(vdda_dac=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 venc.vdda_dac_reg =3D vdda_dac;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -734,13 +736,6 @@ static int omap_venchw_probe(struct platform_dev=
ice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 venc.vdda_dac_reg =3D venc_get_vdda_dac();
> - =A0 =A0 =A0 if (IS_ERR(venc.vdda_dac_reg)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(venc.base);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("can't get VDDA_DAC regulator\n"=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(venc.vdda_dac_reg);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0venc_enable_clocks(1);
>
> =A0 =A0 =A0 =A0rev_id =3D (u8)(venc_read_reg(VENC_REV_ID) & 0xff);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
