From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/6] power: bq24190_charger: Call enable_irq() only at
 the end of probe()
Date: Thu, 12 Jan 2017 18:44:35 +0100
Message-ID: <20170112174435.fotlw2mrif4oubdt@earth>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u62cscn3wbkwh7yk"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112004154.31568-2-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org


--u62cscn3wbkwh7yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liam & Tony,

On Wed, Jan 11, 2017 at 04:41:49PM -0800, Tony Lindgren wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> The device specific data is not fully initialized after
> request_threaded_irq().
>=20
> This causes problems when the IRQ handler tries to reference them.
> Fix the issue by enabling IRQ only at the end of the probe.
>=20
> Fixes: d7bf353fd0aa3 ("bq24190_charger: Add support for TI BQ24190
> Battery Charger")
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> [tony@atomide.com: cleaned up patch description a bit]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1392,6 +1392,7 @@ static int bq24190_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
> =20
> +	irq_set_status_flags(bdi->irq, IRQ_NOAUTOEN);
>  	ret =3D devm_request_threaded_irq(dev, bdi->irq, NULL,
>  			bq24190_irq_handler_thread,
>  			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -1436,6 +1437,8 @@ static int bq24190_probe(struct i2c_client *client,
>  		goto out4;
>  	}
> =20
> +	enable_irq(bdi->irq);
> +
>  	return 0;
> =20
>  out4:

Can't you just move the irq request towards the end of the probe?
That way it will also be released before the power-supply structure
is released.

-- Sebastian

--u62cscn3wbkwh7yk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh3wIIACgkQ2O7X88g7
+pqTvg/+PXkHHqWAVbJYpqrrhURzetpamY6yGXdVZ7JrRa9AiMQzhyz3isXWyD+N
zT4VUtWql+EVsSy8o+3YE5m5B76h7NIcGUMmpPwP5NO6niXrF+CnsNqZqUw8Ja5+
WUvNPNUFrZIS0ZMFkJlMoYadB881hn8rvZg2wMnXVnI5x0+sf4pzP2B1s/0/GRSn
lxxyH7gdXR7x1M1GlIooivefhO2WqpWbApq0o17gVkDUOXQ2/8/KBxbmvlp6VTBN
W4AAk63ucZh3vsdvBvi2EFR771RMnuuXLvlmpovyeb1qQuABnL3NdX0q58dVGMF5
Bi4EMm208IuffwvGs9BtDKBuKfldcsYsMeNf3Ilg7LtC3g3LD45xOBl+MYVFADFC
Wh3dvmMuLEWo0nUkXwEvrt6pdA2Q4Igyi5WXEZI2uMfCOF9YxffEvoLK5Iq1e5pZ
YbFQJO2rIZfZEb4KMKLT2d3D61ORpiTW+qnXqiTr58e91ZaYqRsn1PR4O8sYhusa
hVR3xXFFB9Q8J4o/YAVhKCHKEO4yZHWbsrkv2PaDI+1K+akQpXM/stGZh3UJXywE
FNikNhlf4tqJX/DilBbvwscVRsPPdvjmzYQXmKcONt7Kwvn0gxzJB+bOk4bm4hqi
znJJ2zUaEN217ZDrLqhwUe9hDGt6sojtlNIGGzozgyNGNnoG3W4=
=Rsma
-----END PGP SIGNATURE-----

--u62cscn3wbkwh7yk--
