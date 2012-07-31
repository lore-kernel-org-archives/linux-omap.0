From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 03/11] usb: musb: am335x: add support for dual instance
Date: Tue, 31 Jul 2012 16:46:52 +0300
Message-ID: <20120731134650.GA8804@arwen.pp.htv.fi>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
 <1343377927-7850-3-git-send-email-ravibabu@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1343377927-7850-3-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 27, 2012 at 02:01:59PM +0530, Ravi B wrote:
> From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>=20
> AM335x and TI81xx platform has dual musb controller so updating the
> musb_dspc.c to support the same.
>=20
> Changes:
> 	- Moved otg_workaround timer to glue structure
> 	- Moved static local variable last_timer to glue structure
> 	- PHY on/off related cleanups
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/musb/musb_dsps.c |  118 +++++++++++++++++++++++++-----------=
-----
>  1 files changed, 72 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 2174699..2fd5dc8 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -105,6 +105,8 @@ struct dsps_musb_wrapper {
>  	/* miscellaneous stuff */
>  	u32		musb_core_offset;
>  	u8		poll_seconds;
> +	/* number of musb instances */
> +	u8		instances;
>  };
> =20
>  /**
> @@ -112,16 +114,18 @@ struct dsps_musb_wrapper {
>   */
>  struct dsps_glue {
>  	struct device *dev;
> -	struct platform_device *musb;	/* child musb pdev */
> +	struct platform_device *musb[2];	/* child musb pdev */
>  	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
> -	struct timer_list timer;	/* otg_workaround timer */
> -	u32 __iomem *usb_ctrl;
> +	struct timer_list timer[2];	/* otg_workaround timer */
> +	unsigned long last_timer[2];    /* last timer data for each instance */
> +	u32 __iomem *usb_ctrl[2];
>  	u8      usbss_rev;
>  };
> =20
>  /**
>   * musb_dsps_phy_control - phy on/off
>   * @glue: struct dsps_glue *
> + * @id: musb instance
>   * @on: flag for phy to be switched on or off
>   *
>   * This is to enable the PHY using usb_ctrl register in system control
> @@ -130,11 +134,11 @@ struct dsps_glue {
>   * XXX: This function will be removed once we have a seperate driver for
>   * control module
>   */
> -static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
> +static void musb_dsps_phy_control(struct dsps_glue *glue, u8 id, u8 on)
>  {
>  	u32 usbphycfg;
> =20
> -	usbphycfg =3D __raw_readl(glue->usb_ctrl);
> +	usbphycfg =3D __raw_readl(glue->usb_ctrl[id]);
> =20
>  	if (on) {
>  		if (glue->usbss_rev =3D=3D MUSB_USBSS_REV_816X) {
> @@ -157,7 +161,7 @@ static void musb_dsps_phy_control(struct dsps_glue *g=
lue, u8 on)
>  				glue->usbss_rev =3D=3D MUSB_USBSS_REV_33XX)
>  			usbphycfg |=3D USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
>  	}
> -	__raw_writel(usbphycfg, glue->usb_ctrl);
> +	__raw_writel(usbphycfg, glue->usb_ctrl[id]);
>  }
>  /**
>   * dsps_musb_enable - enable interrupts
> @@ -207,8 +211,9 @@ static void otg_timer(unsigned long _musb)
>  	struct musb *musb =3D (void *)_musb;
>  	void __iomem *mregs =3D musb->mregs;
>  	struct device *dev =3D musb->controller;
> -	struct platform_device *pdev =3D to_platform_device(dev->parent);
> -	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct platform_device *parent_pdev =3D to_platform_device(dev->parent);
> +	struct dsps_glue *glue =3D platform_get_drvdata(parent_pdev);
>  	const struct dsps_musb_wrapper *wrp =3D glue->wrp;
>  	u8 devctl;
>  	unsigned long flags;
> @@ -247,7 +252,7 @@ static void otg_timer(unsigned long _musb)
> =20
>  		devctl =3D dsps_readb(mregs, MUSB_DEVCTL);
>  		if (devctl & MUSB_DEVCTL_BDEVICE)
> -			mod_timer(&glue->timer,
> +			mod_timer(&glue->timer[pdev->id],
>  					jiffies + wrp->poll_seconds * HZ);
>  		else
>  			musb->xceiv->state =3D OTG_STATE_A_IDLE;
> @@ -261,9 +266,9 @@ static void otg_timer(unsigned long _musb)
>  static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
>  {
>  	struct device *dev =3D musb->controller;
> -	struct platform_device *pdev =3D to_platform_device(dev->parent);
> -	struct dsps_glue *glue =3D platform_get_drvdata(pdev);
> -	static unsigned long last_timer;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct platform_device *parent_pdev =3D to_platform_device(dev->parent);
> +	struct dsps_glue *glue =3D platform_get_drvdata(parent_pdev);

just one thing that could be cleaned on a later patch:

if parent_pdev is only used to get to struct dsps_glue, you could just:

struct dsps_glue *glue =3D dev_get_drvdata(dev->parent);

with no need to do a container_of() to the platform_device ;-)

--=20
balbi

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQF+HKAAoJEIaOsuA1yqREEgMP/01uYOylDI+tWPCsy+IwC9il
g1q4orjUeMUXjMAeMLI1HWN3BpTQuoJvy3f8J2BklGMKJFPejh8IHogiKHvP5G69
lSFFHqE2zScGfniFg8tOVgE19A1SUJOhDP4hR+OBeyZdEs/TRJsRRdfamka31stF
jwRwpOb4V20GCsko4Qjj+E2emzswVKM/id7+qpqlya7dYASB7TqFaFmmvmx51y4J
+0RLlsjiKnWFvaCpfR7KOkd6UdxJkAvgUVOFgKdj6Av+B86YnQaDt5lw+5NG3HZP
sh9peQ+GwJTA4xi6A8+0G7ng5p3PfmhL5pU4f+AZr+ADhCBWyrsOqVVDywYnfq/C
ZkB/3CAVMyB/vhwBGlerkiTPMqw+eWZ700kQCNfVrbgVNWJI96MCMlVgRFcVi5lP
L3CL3HpE3mLcz1rBsLYEmfT9SRghbeQVnOyccQxBLiluagLtjq4lSl6SclT/NaCm
YZBkTt0qNSK1+xt1N5N+cTu+Uojg0IVz/i9HPpkKCFEO+WHzcL2fxWwljQsKQshj
4rpOXnHvs9FVp7HVggoLF5W3RgcPapLDQBcOu/okAL0E1wfN1ScJ8wa3/8Aj/4JX
lA5B3hqyQi9qdfT3vR8m7QJ2lwHxkCQxzRr7tMmbJUTy4noqxRhFGShWdLwd/thQ
0z4dMw1DU62D6P+aNLuZ
=D2cD
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
