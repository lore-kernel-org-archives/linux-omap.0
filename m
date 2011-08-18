From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] omap: musb: remove unneeded init code
Date: Thu, 18 Aug 2011 15:01:18 +0300
Message-ID: <20110818120117.GW14514@legolas.emea.dhcp.ti.com>
References: <1313658764-28907-1-git-send-email-ajay.gupta@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Y6L//1es8ezVqBy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:57513 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755706Ab1HRMBW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Aug 2011 08:01:22 -0400
Received: by bkd1 with SMTP id 1so1612681bkd.26
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 05:01:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313658764-28907-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Tony Lindgren <tony@atomide.com>


--/Y6L//1es8ezVqBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 18, 2011 at 02:42:44PM +0530, Ajay Kumar Gupta wrote:
> The .power and .mode parameter of 'musb_plat' is also now set dynamically
> in usb_musb_init() so remove them.
>=20
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

Tony, can you pick this up for next ?

> ---
>  arch/arm/mach-omap2/usb-musb.c |   15 +--------------
>  1 files changed, 1 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-mus=
b.c
> index a65145b..de48106 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -41,21 +41,8 @@ static struct musb_hdrc_config musb_config =3D {
>  };
> =20
>  static struct musb_hdrc_platform_data musb_plat =3D {
> -#ifdef CONFIG_USB_MUSB_OTG
> -	.mode		=3D MUSB_OTG,
> -#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
> -	.mode		=3D MUSB_HOST,
> -#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
> -	.mode		=3D MUSB_PERIPHERAL,
> -#endif
> -	/* .clock is set dynamically */
> +	/* .clock, .mode and .power is set dynamically */
>  	.config		=3D &musb_config,
> -
> -	/* REVISIT charge pump on TWL4030 can supply up to
> -	 * 100 mA ... but this value is board-specific, like
> -	 * "mode", and should be passed to usb_musb_init().
> -	 */
> -	.power		=3D 50,			/* up to 100 mA */
>  };
> =20
>  static u64 musb_dmamask =3D DMA_BIT_MASK(32);
> --=20
> 1.6.2.4
>=20

--=20
balbi

--/Y6L//1es8ezVqBy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOTP8NAAoJEAv8Txj19kN1r1kH/3cOw+iVX4KpkfBig+hLW0jK
auXBOZ+HjZCGR+diKsXZfIwzJUPivlAkH6bqt/cTE71dWN9s1kzhQaB2nGa9/7TO
AEyFV3yPhNKhI65081JfOyx6sHI8Qz8Vo1qXrG8CySxCkmRy9dqDwb3JXY3BJWP5
zWf5H8A/aDo/veuH0E/JDT629B90FGYUHo1V/UHhO8KBDxTNvEOZoX4xDePnfrzu
ZdUO+MBgMPIAggynrsbCwpmd76kdo2VoBuPBDcV0Z0RtCqlBDTSb7tmQdSLC8Ad9
RUZmNu4FrF8HgUIm3rStW7Pj3cBrDt6vMvpg4KYxCOxXivvtc4a/ELhKZLfTc0A=
=im8S
-----END PGP SIGNATURE-----

--/Y6L//1es8ezVqBy--
