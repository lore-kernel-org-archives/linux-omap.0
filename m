From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RESEND] twl4030_charger: fix charging current
 out-of-bounds
Date: Sun, 30 Sep 2018 22:16:42 +0200
Message-ID: <20180930201642.GC23554@amd>
References: <20180917052035.12234-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917052035.12234-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 07:20:35, Andreas Kemnade wrote:
> the charging current uses unsigned int variables, if we step back
> if the current is still low, we would run into negative which
> means setting the target to a huge value.
> Better add checks here.

Do you expect this to happen in practice? Too high current while
charging seems bad, right?

Cc: stable?
								Pavel

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/power/supply/twl4030_charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index b72838663872..c954b7234393 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -421,7 +421,8 @@ static void twl4030_current_worker(struct work_struct=
 *data)
> =20
>  	if (v < USB_MIN_VOLT) {
>  		/* Back up and stop adjusting. */
> -		bci->usb_cur -=3D USB_CUR_STEP;
> +		if (bci->usb_cur >=3D USB_CUR_STEP)
> +			bci->usb_cur -=3D USB_CUR_STEP;
>  		bci->usb_cur_target =3D bci->usb_cur;
>  	} else if (bci->usb_cur >=3D bci->usb_cur_target ||
>  		   bci->usb_cur + USB_CUR_STEP > USB_MAX_CURRENT) {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluxLyoACgkQMOfwapXb+vLUdQCcCw2lUChh9QF8KfmJ8mbNNEDq
JHwAnRlP32MAnHnP4hLLBC0Zrzm5fO4Z
=G8F0
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
