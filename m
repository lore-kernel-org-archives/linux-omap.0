From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: twl: Reliably disable TWL6030 PWMs
Date: Mon, 11 Jul 2016 12:55:16 +0200
Message-ID: <20160711105516.GD5503@ulmo.ba.sec>
References: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, Axel Lin <axel.lin@ingics.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2016 at 08:55:45PM +0200, Paul Kocialkowski wrote:
> The current TWL6030 code for the TWL PWM driver does not reliably disable=
 the
> PWM output, as tested with LEDs. The previous commit to that driver intro=
duced
> that regression.
>=20
> However, it does make sense to disable the PWM clock after resetting the =
PWM,
> but for some obscure reason, doing it all at once simply doesn't work.
>=20
> The TWL6030 datasheet mentions that PWMs have to be disabled in two disti=
nct
> steps. However, clearing the clock enable bit in a second step (after iss=
uing a
> reset first) does not work.
>=20
> The only approach that works is the one that was in place before the prev=
ious
> commit to the driver. It consists in enabling the PWM clock after issuing=
 a
> reset. This is what TI kernel trees and production code seem to be using.
>=20
> However, adding an extra step to disable the PWM clock seems to work reli=
ably,
> despite looking quite odd.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/pwm/pwm-twl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Axel, Peter,

can you guys comment on this?

Thierry

>=20
> diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
> index 04f7672..7a993b0 100644
> --- a/drivers/pwm/pwm-twl.c
> +++ b/drivers/pwm/pwm-twl.c
> @@ -269,6 +269,22 @@ static void twl6030_pwm_disable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  		goto out;
>  	}
> =20
> +	val |=3D TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXEN);
> +
> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
> +		goto out;
> +	}
> +
> +	val &=3D ~TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXEN);
> +
> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
> +		goto out;
> +	}
> +
>  	twl->twl6030_toggle3 =3D val;
>  out:
>  	mutex_unlock(&twl->mutex);
> --=20
> 2.7.4
>=20

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg3sUAAoJEN0jrNd/PrOhnPYP/0CFTAE34Vzw+TtTnC15MAmq
LA/0r1knO95GqM85P9dpQCbch2Lg10R++VplKQZszSmtaMQe2TLPO+JTL6KgFtKw
6upeCGGcrZoPf/IHSSCxGxMajbAObsy8+Vxv1jVjP7Fu9p/U9mouPwggje6mvWBF
HwQxZHpuWb5QghRlrKWKdSAcHCTFgAZX9yDiGqTnlCa6NLY8U7m3iPlOvRqTwrVf
2RAOuioeW/5FqKpkWU31THMLXoQ4mxgFLVd+gKj5GdgXKVBWgZ+tHaw/D5nsWSZ0
aziYTh/hogmTKMrFj1ivK1wTxb+TbNyEPh1b+nIODFQ/VI9AkIyM5BiH7DHBDxOP
i+aZe25H1V72McCTDMkUPTQjFnnSdnXkONcqCR/HDHAVzMUdqAoHiAnwHr+LOinM
UmMenY0lnV1P8AajkdkvwA3CaBVhCsPYKxoBllkpH7IRCfOuutsjdEUdEUlwot7+
ix0imMIXb9Q9+flIX/O12KJk/zso1zxETiJKgtUTGu0i3Al7yz7ySpocKt3mfRh8
drQZde1CF43sUmncls8JI5dOqavXKAJ+3rERmAIb7IyR4q3ejBzsLSBIwEzQMbRm
ukcAS3GMqZqsoOJfTr2nSqHlnsTLnsFRAyyHeLRSymvFZqrJJ4yHD+1o8+TWWW3b
SS+rmT/UHQSCnJx1Jpfl
=AJzq
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
