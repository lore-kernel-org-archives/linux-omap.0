From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH RESEND] twl4030_charger: fix charging current
 out-of-bounds
Date: Thu, 20 Sep 2018 02:20:52 +0200
Message-ID: <20180920002052.xex3xdrvzkb7wf7k@earth.universe>
References: <20180917052035.12234-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tavpoct2v7do34bb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917052035.12234-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--tavpoct2v7do34bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 07:20:35AM +0200, Andreas Kemnade wrote:
> the charging current uses unsigned int variables, if we step back
> if the current is still low, we would run into negative which
> means setting the target to a huge value.
> Better add checks here.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Thanks, queued.

-- Sebastian

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
> --=20
> 2.11.0
>=20

--tavpoct2v7do34bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui5+QACgkQ2O7X88g7
+pqu/w/+PuOEdsIBjlmz1T5XE3MmdQj/ox9PMIqczw1TcK2QH4ccBJGs0EHWKGFX
CdGiFkWx/bH+cNkEAO+yMPOp11qUSDu/fp+riwpfwQQuhvfxvQ31Fj408FYvUlgk
8z4XJ0VglpKSRnSt8CL1VAkpknPu/jenyUau4IFa/0kpOZwS5IGQ+HYypaeGAbF+
aOW5vQBQ5r5slbd243loDup4ObpWMHn/oyzjpPFmNDn612QP3lGaPm3K3s9GsGZe
Yklha8aUlZb9J7MIpIAv5ELeKaIUmF0BfWW77WKwxV8vFwG22aeSu5VIEIVU1+ft
FisOtKR4gwD0D0ZA2O5Ij1N5XLUOj+tJjfroCa4ic1rXVyBkc9dqVr8y6dvOamJT
xF6qupvRj0AR2cCxjLEj/fVT+ajaw6HG3zy7018n4Kc3n/rjAwaYmSfGJZXHN6M5
jL/E9F3q42E6tgBB6YbCWHk2gAg4hr/DzFvm8teXaBpaVFArOxSF8N6HXxDgqIbr
mKI6ZRMGm290iZpp5/6a9VGZSvtCMUNkJZ5vD45nfvHFTFRRKB319EMSvJiYHQTK
Osq2CwZg1Et3x/C7GF3pugr23NmD/OtcNRUwSJ5Au5+QEgv9lcm4Rw8dpwuCtope
pSm5tkcwiSugnNMkUhlPyh6cK2e3GQieqs+ijp0BPGoxLmGPTVc=
=Wo7z
-----END PGP SIGNATURE-----

--tavpoct2v7do34bb--
