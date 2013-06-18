From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] musb: musb: dsps: determine the number of instances
 at runtime
Date: Tue, 18 Jun 2013 11:31:08 +0300
Message-ID: <20130618083108.GH5461@arwen.pp.htv.fi>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
 <1371482014-5244-3-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371482014-5244-3-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2013 at 05:13:34PM +0200, Sebastian Andrzej Siewior wrote:
> There is no need to hardcode the number of instances here. It is better to
> determine them at runtime. Even if the device provides two instances one
> might only want to use one of them.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>  drivers/usb/musb/musb_dsps.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index d9ff390..0ac9934 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -110,8 +110,6 @@ struct dsps_musb_wrapper {
>  	/* miscellaneous stuff */
>  	u32		musb_core_offset;
>  	u8		poll_seconds;
> -	/* number of musb instances */
> -	u8		instances;
>  };
> =20
>  /**
> @@ -124,6 +122,7 @@ struct dsps_glue {
>  	struct timer_list timer[2];	/* otg_workaround timer */
>  	unsigned long last_timer[2];    /* last timer data for each instance */
>  	u32 __iomem *usb_ctrl[2];
> +	u8 instances;
>  };
> =20
>  #define	DSPS_AM33XX_CONTROL_MODULE_PHYS_0	0x44e10620
> @@ -646,6 +645,23 @@ static int dsps_probe(struct platform_device *pdev)
>  	}
>  	platform_set_drvdata(pdev, glue);
> =20
> +	i =3D 1;
> +	do {
> +		iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, i);

IIRC this index starts at zero, no ? Meaning that this should be:

i =3D 0
do {
	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
	if (!iomem)
		break;

	i++;
} while (true);

glue->instances =3D i + 1;

Also, why are you getting the resource and doing nothing with it ? Is it
just to figure out the amount of instances ? Isn't there a DT helper to
count how many child nodes a certain node has ?

--=20
balbi

--BXr400anF0jyguTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwBrMAAoJEIaOsuA1yqREw3EP/2G/CgRX+LBsXvanhT1buqaX
MUPbaNSKjE43tswlLc1FB3vKLmya7171DVvrKZqwiFAZKtH4RfnbrU/OZXxo6Juc
vM0tCzxGjgn6uyDWLwTC+9Lf68BN8C1ucPDTe5OJt4Wkpb0fBRIQNdHM163KierQ
dUci43/m3zB7mE/FDv/JHxe+giYrfoPDRyCF7qNsVt8gOfQdnEH3nHvqDepbP+Vm
gCduHl+i3SjOaZ7fBgQxP49XGe3vuwpfsgwznc2jvjn16F9c+si1Ee53vjHBEkqS
renSM8Wgq3PGLcG0n6Qlb405efRUbGAalQ1TpWvMGn9FWzfNlqSZWq9OFCN+9WUb
SD2NSuDRTnzzMUAx/EWjqFrinM79vpHNtR5reRXvgZRgcauamzHCl+kFVHS0nyVK
Vp63TmzRc0MSZCWVKhoEkh6TjRAKZJGDL/KtF73cz+4KOJ7d9CS3rwu7WO6WpepF
OrIbyhI4oPnpha73T5QLvZHGTLDdIvPu0ZlfB7f1U0YFQsnI6Vamt3lC+ZvfTGXH
konjikKkJ3xcVcn6IW/jwi4RNIhJcHv7T0FpidNxrj5Y/wPH1D9TvJWegGTToEBk
Dnq98Ulnf6wemXdnu8F3j8xDYiFC9oziDD/gXVnZbZEEex/REisUjKrI/d45tyWT
V4qDJEs+swxda15wYEEr
=sZMu
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
