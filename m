From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Fri, 31 Aug 2012 15:23:43 +0300
Message-ID: <20120831122342.GC24861@arwen.pp.htv.fi>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <1346411399-23964-2-git-send-email-ravibabu@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1346411399-23964-2-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 31, 2012 at 04:39:47PM +0530, Ravi Babu wrote:
> From: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
>=20
> AM335x uses NOP transceiver driver and need to enable builtin PHY
> by writing into usb_ctrl register available in system control
> module register space. This is being added at musb glue driver
> layer untill a separate system control module driver is available.
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>

Kishon, you were adding a real phy driver for OMAP's internal phy logic
on one of your patches and I believe this will conflict with your
changes, right ?

How does this look to you ? Is this at least correct ? I suppose the
correct way would be to actually have the system control module driver
which we have been waiting, right ?

> ---
>  arch/arm/mach-omap2/board-ti8168evm.c   |    1 -
>  arch/arm/mach-omap2/omap_phy_internal.c |   35 ------------
>  arch/arm/plat-omap/include/plat/usb.h   |    5 +-
>  drivers/usb/musb/musb_dsps.c            |   87 +++++++++++++++++++++++++=
------
>  4 files changed, 73 insertions(+), 55 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/=
board-ti8168evm.c
> index d4c8392..0c7c098 100644
> --- a/arch/arm/mach-omap2/board-ti8168evm.c
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -26,7 +26,6 @@
>  #include <plat/usb.h>
> =20
>  static struct omap_musb_board_data musb_board_data =3D {
> -	.set_phy_power	=3D ti81xx_musb_phy_power,
>  	.interface_type	=3D MUSB_INTERFACE_ULPI,
>  	.mode           =3D MUSB_OTG,
>  	.power		=3D 500,
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap=
2/omap_phy_internal.c
> index d52651a..d80bb16 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -254,38 +254,3 @@ void am35x_set_mode(u8 musb_mode)
> =20
>  	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>  }
> -
> -void ti81xx_musb_phy_power(u8 on)
> -{
> -	void __iomem *scm_base =3D NULL;
> -	u32 usbphycfg;
> -
> -	scm_base =3D ioremap(TI81XX_SCM_BASE, SZ_2K);
> -	if (!scm_base) {
> -		pr_err("system control module ioremap failed\n");
> -		return;
> -	}
> -
> -	usbphycfg =3D __raw_readl(scm_base + USBCTRL0);
> -
> -	if (on) {
> -		if (cpu_is_ti816x()) {
> -			usbphycfg |=3D TI816X_USBPHY0_NORMAL_MODE;
> -			usbphycfg &=3D ~TI816X_USBPHY_REFCLK_OSC;
> -		} else if (cpu_is_ti814x()) {
> -			usbphycfg &=3D ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> -				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> -			usbphycfg |=3D (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> -				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> -		}
> -	} else {
> -		if (cpu_is_ti816x())
> -			usbphycfg &=3D ~TI816X_USBPHY0_NORMAL_MODE;
> -		else if (cpu_is_ti814x())
> -			usbphycfg |=3D USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> -
> -	}
> -	__raw_writel(usbphycfg, scm_base + USBCTRL0);
> -
> -	iounmap(scm_base);
> -}
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/i=
nclude/plat/usb.h
> index 548a4c8..c2aa4ae 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -95,7 +95,6 @@ extern void am35x_musb_reset(void);
>  extern void am35x_musb_phy_power(u8 on);
>  extern void am35x_musb_clear_irq(void);
>  extern void am35x_set_mode(u8 musb_mode);
> -extern void ti81xx_musb_phy_power(u8 on);
> =20
>  /* AM35x */
>  /* USB 2.0 PHY Control */
> @@ -120,8 +119,8 @@ extern void ti81xx_musb_phy_power(u8 on);
>  #define CONF2_DATPOL		(1 << 1)
> =20
>  /* TI81XX specific definitions */
> -#define USBCTRL0	0x620
> -#define USBSTAT0	0x624
> +#define MUSB_USBSS_REV_816X	0x9
> +#define MUSB_USBSS_REV_814X	0xb
> =20
>  /* TI816X PHY controls bits */
>  #define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 84d8181..960258d 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -116,9 +116,46 @@ struct dsps_glue {
>  	struct platform_device *musb;	/* child musb pdev */
>  	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
>  	struct timer_list timer;	/* otg_workaround timer */
> +	u32 __iomem *usb_ctrl;
> +	u8      usbss_rev;
>  };
> =20
>  /**
> + * musb_dsps_phy_control - phy on/off
> + * @glue: struct dsps_glue *
> + * @on: flag for phy to be switched on or off
> + *
> + * This is to enable the PHY using usb_ctrl register in system control
> + * module space.
> + *
> + * XXX: This function will be removed once we have a seperate driver for
> + * control module
> + */
> +static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
> +{
> +	u32 usbphycfg;
> +
> +	usbphycfg =3D __raw_readl(glue->usb_ctrl);
> +
> +	if (on) {
> +		if (glue->usbss_rev =3D=3D MUSB_USBSS_REV_816X) {
> +			usbphycfg |=3D TI816X_USBPHY0_NORMAL_MODE;
> +			usbphycfg &=3D ~TI816X_USBPHY_REFCLK_OSC;
> +		} else if (glue->usbss_rev =3D=3D MUSB_USBSS_REV_814X) {
> +			usbphycfg &=3D ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> +				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> +			usbphycfg |=3D (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> +				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> +		}
> +	} else {
> +		if (glue->usbss_rev =3D=3D MUSB_USBSS_REV_816X)
> +			usbphycfg &=3D ~TI816X_USBPHY0_NORMAL_MODE;
> +		else if (glue->usbss_rev =3D=3D MUSB_USBSS_REV_814X)
> +			usbphycfg |=3D USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> +	}
> +	__raw_writel(usbphycfg, glue->usb_ctrl);
> +}
> +/**
>   * dsps_musb_enable - enable interrupts
>   */
>  static void dsps_musb_enable(struct musb *musb)
> @@ -356,11 +393,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>  static int dsps_musb_init(struct musb *musb)
>  {
>  	struct device *dev =3D musb->controller;
> -	struct musb_hdrc_platform_data *plat =3D dev->platform_data;
>  	struct platform_device *pdev =3D to_platform_device(dev->parent);
>  	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
>  	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
> -	struct omap_musb_board_data *data =3D plat->board_data;
>  	void __iomem *reg_base =3D musb->ctrl_base;
>  	u32 rev, val;
>  	int status;
> @@ -387,8 +422,7 @@ static int dsps_musb_init(struct musb *musb)
>  	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
> =20
>  	/* Start the on-chip PHY and its PLL. */
> -	if (data->set_phy_power)
> -		data->set_phy_power(1);
> +	musb_dsps_phy_control(glue, 1);
> =20
>  	musb->isr =3D dsps_interrupt;
> =20
> @@ -410,16 +444,13 @@ err0:
>  static int dsps_musb_exit(struct musb *musb)
>  {
>  	struct device *dev =3D musb->controller;
> -	struct musb_hdrc_platform_data *plat =3D dev->platform_data;
> -	struct omap_musb_board_data *data =3D plat->board_data;
>  	struct platform_device *pdev =3D to_platform_device(dev->parent);
>  	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
> =20
>  	del_timer_sync(&glue->timer);
> =20
>  	/* Shutdown the on-chip PHY and its PLL. */
> -	if (data->set_phy_power)
> -		data->set_phy_power(0);
> +	musb_dsps_phy_control(glue, 0);
> =20
>  	/* NOP driver needs change if supporting dual instance */
>  	usb_put_phy(musb->xceiv);
> @@ -451,6 +482,21 @@ static int __devinit dsps_create_musb_pdev(struct ds=
ps_glue *glue, u8 id)
>  	char res_name[10];
>  	int ret;
> =20
> +	/* get memory resource for usb control register */
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 2 * id + 2);
> +	if (!res) {
> +		dev_err(dev, "%s get mem resource failed\n", res_name);
> +		ret =3D -ENODEV;
> +		goto err0;
> +	}
> +
> +	glue->usb_ctrl =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (glue->usb_ctrl =3D=3D NULL) {
> +		dev_err(dev, "Failed to obtain usb_ctrl%d memory\n", id);
> +		ret =3D -ENODEV;
> +		goto err0;
> +	}
> +
>  	/* get memory resource */
>  	sprintf(res_name, "musb%d", id);
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
> @@ -529,6 +575,7 @@ static int __devinit dsps_probe(struct platform_devic=
e *pdev)
>  				(struct dsps_musb_wrapper *)id->driver_data;
>  	struct dsps_glue *glue;
>  	struct resource *iomem;
> +	u32 __iomem *usbss;
>  	int ret;
> =20
>  	/* allocate glue */
> @@ -547,6 +594,13 @@ static int __devinit dsps_probe(struct platform_devi=
ce *pdev)
>  		goto err1;
>  	}
> =20
> +	usbss =3D devm_request_and_ioremap(&pdev->dev, iomem);
> +	if (usbss =3D=3D NULL) {
> +		dev_err(&pdev->dev, "Failed to obtain usbss memory\n");
> +		ret =3D -ENODEV;
> +		goto err1;
> +	}
> +
>  	glue->dev =3D &pdev->dev;
> =20
>  	glue->wrp =3D kmemdup(wrp, sizeof(*wrp), GFP_KERNEL);
> @@ -573,6 +627,9 @@ static int __devinit dsps_probe(struct platform_devic=
e *pdev)
>  		goto err3;
>  	}
> =20
> +	/* read the usbss revision register */
> +	glue->usbss_rev =3D __raw_readl(usbss);
> +
>  	return 0;
> =20
>  err3:
> @@ -603,24 +660,22 @@ static int __devexit dsps_remove(struct platform_de=
vice *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int dsps_suspend(struct device *dev)
>  {
> -	struct musb_hdrc_platform_data *plat =3D dev->platform_data;
> -	struct omap_musb_board_data *data =3D plat->board_data;
> +	struct platform_device *pdev =3D to_platform_device(dev->parent);
> +	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
> =20
>  	/* Shutdown the on-chip PHY and its PLL. */
> -	if (data->set_phy_power)
> -		data->set_phy_power(0);
> +	musb_dsps_phy_control(glue, 0);
> =20
>  	return 0;
>  }
> =20
>  static int dsps_resume(struct device *dev)
>  {
> -	struct musb_hdrc_platform_data *plat =3D dev->platform_data;
> -	struct omap_musb_board_data *data =3D plat->board_data;
> +	struct platform_device *pdev =3D to_platform_device(dev->parent);
> +	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
> =20
>  	/* Start the on-chip PHY and its PLL. */
> -	if (data->set_phy_power)
> -		data->set_phy_power(1);
> +	musb_dsps_phy_control(glue, 1);
> =20
>  	return 0;
>  }
> --=20
> 1.7.0.4
>=20

--=20
balbi

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQQKzOAAoJEIaOsuA1yqREG/8QAIVlxywp8sqC8V1rTFKy/oH/
MWLHMm2rY1FuhzIL5iEsHeVgtxxn4tMDhyzCc6tGmThFJ5xxlqRGlrUnaU8mfhR2
mU1/y4sJmjhVAILVBhcLxg4w2gYlAUn8P3cjNVN6Ph1BbuLqPoKpZSuIZaCKUSO+
pWMhROfZk61gFcj+SSpbSmw0O0H/czJF4t9JbxTHFhVcTteFcO5OtThvlEFzHhWx
U/MYuITr8o4zIl5st53pvPt+p9dwlC4g9c8EiaYrn54BbOPVUf6UPBtfMITN0DUe
r1/WxkKMbUWtc7NJImnVvA8xJCELM8CSN3e6kMq81gNJnutzap5awU10AUxsazY0
e4RCi0EK6CDDPClp8aKqAwa2lTkOuUUT+6nFb6dAYziEpZe54g6iQWg97Z2o7Kdy
HluUGknaCXfvPGbNEErXgdyZ0nnPcni/XJTIwO27Ycmge7FJToyq3nYW5oNjg3ns
FhemPgqMC0vXVLXkX3sTOgkfyRJx7xLe4I5oBNwd0yyVALT5/8hWYS3ps8WHdlnG
0WXSyl3H1zgU6dKzsbwXq0xat3pNJ2S1plcXxQ2AKkg7AsXx5mijraxLkqzVx9hd
J9IbVbTXUy6bJDhm+MRztakMEQmX+7OpyVl7A2TDHFiBcVsc168Kq16XuueoKtco
YkNUwkjJDX2HvFX0zEVb
=K+kI
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
