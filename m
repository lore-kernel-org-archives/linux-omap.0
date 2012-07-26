From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 03/11] usb: musb: am335x: add support for dual instance
Date: Thu, 26 Jul 2012 10:34:38 +0300
Message-ID: <20120726073437.GF29029@arwen.pp.htv.fi>
References: <1343218049-29917-1-git-send-email-ajay.gupta@ti.com>
 <1343218049-29917-4-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:43810 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331Ab2GZHhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 03:37:51 -0400
Received: by lahc1 with SMTP id c1so1116853lah.4
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 00:37:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343218049-29917-4-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2012 at 05:37:21PM +0530, Ajay Kumar Gupta wrote:
> AM335x and TI81xx platform has dual musb controller so updating the
> musb_dspc.c to support the same.
>=20
> Changes:
> 	- Moved otg_workaround timer to glue structure
> 	- Moved static local variable last_timer to glue structure
> 	- PHY on/off related cleanups
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
>  drivers/usb/musb/musb_dsps.c |   93 +++++++++++++++++++++++++-----------=
-----
>  1 files changed, 57 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 2174699..a2c8a06 100644
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
> @@ -247,7 +251,7 @@ static void otg_timer(unsigned long _musb)
> =20
>  		devctl =3D dsps_readb(mregs, MUSB_DEVCTL);
>  		if (devctl & MUSB_DEVCTL_BDEVICE)
> -			mod_timer(&glue->timer,
> +			mod_timer(&glue->timer[musb->id],

I believe this "musb" is a struct musb pointer, right ? Why would you
use that ID ? You can find the correct musb by grabbing its
platform_device with to_platform_device(musb->controller) and use that
pdev to get to the correct ID.

ditto to all others.

--=20
balbi

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEPMNAAoJEIaOsuA1yqREn5UP/0qvx2QMHHcAkCwCkAPFaYwO
6Zhc0eBrnfssCiyza/ApxSQ+6nTeW3oIScX91HrrDFlevWtjMgbWKAj8W6Sr4MXR
oj+NA4lwHzaG4ZSJvtsr9sPHRvDvkmXCyL3m9A2S9X3HC37F04/kf0frevTZ+sev
pyW4hK81FhKsG1Uhjw2lVAkNAs+MmUOeSwl/1JoRAm6aLyAtlBA2cAjCX7yfUCVV
tMJxNEfpAkgybooA/hhzFL9xry8IIwjJDPJ5FGYP4ZevycZXny2s8yicoH++M881
mwckVLHfD5vz82gBnQ7R4qtRqNytjQLG0FP7f+HVh1lDucf7PW1Bv7tTjY8/vlip
K1yJBv/1rE330bGPfyPLyGEMkhkxh3x+3Ob0eIOhSgwLvplYkoBBKU0RklnnDz34
cgLHFmRTdjKm3qbaJCjtVaP7wWxsJjNatq4n63ZJbWYCJPKBB80uifML8cJ7yMp0
a4V6dQGmnLsv6xkyz9Y/zRY+4ubjbekA5EAwNQonD9+BhMJ0emHbQ3O0guDhC4VL
E1lOlIAjGiIEB2uXP0o770zlZBE9fzhLHFxLtFE3Go4TiGqj+i/WEMhqPBqXiz3H
Mvhw/z0pykAsuC9mWTaf//BzAMoaNsoamHNKx8eeil2ONVc/eG4ouIYiGYPKj0HH
GuF9MFuKZfxn4hVhh0BE
=aiv8
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
