From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] pwm: twl: Reliably disable TWL6030 PWMs
Date: Tue, 12 Jul 2016 16:18:18 +0300
Message-ID: <b41e8c8c-80e4-d8f7-e223-9b40e85a3438@ti.com>
References: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/29/16 21:55, Paul Kocialkowski wrote:
> The current TWL6030 code for the TWL PWM driver does not reliably dis=
able the
> PWM output, as tested with LEDs. The previous commit to that driver i=
ntroduced
> that regression.
>=20
> However, it does make sense to disable the PWM clock after resetting =
the PWM,
> but for some obscure reason, doing it all at once simply doesn't work=
=2E
>=20
> The TWL6030 datasheet mentions that PWMs have to be disabled in two d=
istinct
> steps. However, clearing the clock enable bit in a second step (after=
 issuing a
> reset first) does not work.
>=20
> The only approach that works is the one that was in place before the =
previous
> commit to the driver. It consists in enabling the PWM clock after iss=
uing a
> reset. This is what TI kernel trees and production code seem to be us=
ing.
>=20
> However, adding an extra step to disable the PWM clock seems to work =
reliably,
> despite looking quite odd.

Unfortunately I don't have board to test, but based on the documentatio=
n and
your explanation, this is the correct way.
Thank you for debugging and fixing it!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/pwm/pwm-twl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
> index 04f7672..7a993b0 100644
> --- a/drivers/pwm/pwm-twl.c
> +++ b/drivers/pwm/pwm-twl.c
> @@ -269,6 +269,22 @@ static void twl6030_pwm_disable(struct pwm_chip =
*chip, struct pwm_device *pwm)
>  		goto out;
>  	}
> =20
> +	val |=3D TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXEN);
> +
> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_R=
EG);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
> +		goto out;
> +	}
> +
> +	val &=3D ~TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXEN);
> +
> +	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_R=
EG);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
> +		goto out;
> +	}
> +
>  	twl->twl6030_toggle3 =3D val;
>  out:
>  	mutex_unlock(&twl->mutex);
>=20


--=20
P=E9ter
