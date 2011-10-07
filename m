From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/6 v3] omap: musb: ti81xx: Add phy power function
Date: Fri, 7 Oct 2011 11:57:53 +0300
Message-ID: <20111007085752.GF10910@legolas.emea.dhcp.ti.com>
References: <1315576070-7618-1-git-send-email-ajay.gupta@ti.com>
 <1315576070-7618-4-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1315576070-7618-4-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2011 at 07:17:47PM +0530, Ajay Kumar Gupta wrote:
> Adding ti81xx_musb_phy_power() which will be used by musb driver through
> its function pointer in board_data.
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>

this should go through OMAP tree.

> ---
>  arch/arm/mach-omap2/omap_phy_internal.c |   24 +++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/usb.h   |   32 +++++++++++++++++++++++++=
++++++
>  2 files changed, 56 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap=
2/omap_phy_internal.c
> index 58775e3..d5e8497 100644
> --- a/arch/arm/mach-omap2/omap_phy_internal.c
> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
> @@ -260,3 +260,27 @@ void am35x_set_mode(u8 musb_mode)
> =20
>  	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
>  }
> +
> +void ti81xx_musb_phy_power(u8 on)
> +{
> +	u32 usbphycfg =3D omap_ctrl_readl(USBCTRL0);
> +
> +	if (on) {
> +		if (cpu_is_ti816x()) {
> +			usbphycfg |=3D TI816X_USBPHY0_NORMAL_MODE;
> +			usbphycfg &=3D ~TI816X_USBPHY_REFCLK_OSC;
> +		} else if (cpu_is_ti814x()) {
> +			usbphycfg &=3D ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
> +				| USBPHY_DPINPUT | USBPHY_DMINPUT);
> +			usbphycfg |=3D (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
> +				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
> +		}
> +	} else {
> +		if (cpu_is_ti816x())
> +			usbphycfg &=3D ~TI816X_USBPHY0_NORMAL_MODE;
> +		else if (cpu_is_ti814x())
> +			usbphycfg |=3D USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
> +
> +	}
> +	omap_ctrl_writel(usbphycfg, USBCTRL0);

don't use omap_ctrl_*(). ioremap your memory space.

> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/i=
nclude/plat/usb.h
> index 17d3c93..c616385 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -114,6 +114,7 @@ extern void am35x_musb_reset(void);
>  extern void am35x_musb_phy_power(u8 on);
>  extern void am35x_musb_clear_irq(void);
>  extern void am35x_set_mode(u8 musb_mode);
> +extern void ti81xx_musb_phy_power(u8 on);
> =20
>  /*
>   * FIXME correct answer depends on hmc_mode,
> @@ -273,6 +274,37 @@ static inline void omap2_usbfs_init(struct omap_usb_=
config *pdata)
>  #define CONF2_OTGPWRDN		(1 << 2)
>  #define CONF2_DATPOL		(1 << 1)
> =20
> +/* TI81XX specific definitions */
> +#define USBCTRL0	0x620
> +#define USBSTAT0	0x624
> +
> +/* TI816X PHY controls bits */
> +#define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
> +#define TI816X_USBPHY_REFCLK_OSC	(1 << 8)
> +
> +/* TI814X PHY controls bits */
> +#define USBPHY_CM_PWRDN		(1 << 0)
> +#define USBPHY_OTG_PWRDN	(1 << 1)
> +#define USBPHY_CHGDET_DIS	(1 << 2)
> +#define USBPHY_CHGDET_RSTRT	(1 << 3)
> +#define USBPHY_SRCONDM		(1 << 4)
> +#define USBPHY_SINKONDP		(1 << 5)
> +#define USBPHY_CHGISINK_EN	(1 << 6)
> +#define USBPHY_CHGVSRC_EN	(1 << 7)
> +#define USBPHY_DMPULLUP		(1 << 8)
> +#define USBPHY_DPPULLUP		(1 << 9)
> +#define USBPHY_CDET_EXTCTL	(1 << 10)
> +#define USBPHY_GPIO_MODE	(1 << 12)
> +#define USBPHY_DPOPBUFCTL	(1 << 13)
> +#define USBPHY_DMOPBUFCTL	(1 << 14)
> +#define USBPHY_DPINPUT		(1 << 15)
> +#define USBPHY_DMINPUT		(1 << 16)
> +#define USBPHY_DPGPIO_PD	(1 << 17)
> +#define USBPHY_DMGPIO_PD	(1 << 18)
> +#define USBPHY_OTGVDET_EN	(1 << 19)
> +#define USBPHY_OTGSESSEND_EN	(1 << 20)
> +#define USBPHY_DATA_POLARITY	(1 << 23)
> +
>  #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_USB)
>  u32 omap1_usb0_init(unsigned nwires, unsigned is_device);
>  u32 omap1_usb1_init(unsigned nwires);
> --=20
> 1.6.2.4
>=20

--=20
balbi

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjr8QAAoJEAv8Txj19kN1CogH/320ZB0W2VCzCEfaj4TEQVs6
ta7iFRxKRNDMF62NoPbZ7pULHOezbigrnM5k1S35buhz/RTgzPWXuPK4U+6BYPhg
HqhEdUbQpHbNM/FT6eoBw8JiU87ADQlLKaf8y1jyXwpyjFrOLrrCTGoWnT9kvXxm
LCoUCXmd44qoxGchEhe8WA8MsGpSSEnnQZdQJlIUwLKGvNhYNYLkfKE9rJ5FdI7f
/BlPqz5R+G21q8MNy/SwI0T2RFdlaJFVPn+LhDQeWO9XBInZiyQnXSFxQAiF2ryD
NMU0TViyZNOmnDo88bnq/JcqFQikR5OH+GrvdzOsTDad57nFaq784mAqHiEYC7c=
=wVQw
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
