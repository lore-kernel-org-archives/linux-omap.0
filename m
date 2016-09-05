From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: twl: Reliably disable TWL6030 PWMs
Date: Mon, 5 Sep 2016 07:14:46 +0200
Message-ID: <20160905051446.GA3532@ulmo.ba.sec>
References: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459277745-16878-1-git-send-email-contact@paulk.fr>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--d6Gm4EdcadzBjdND
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

Applied, thanks.

Thierry

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzP9EAAoJEN0jrNd/PrOhJZ0P/RknLyUbkHObwQVEmFqTfokE
z6s982doQrscQLej9/hlBMtF/PG5DdDNC736bmEaU6r7RnWcK8/qlaheRql5wE2X
eOMWB0EIS91WzYQrlCSwpv+Sj/1BKFOgka30JsNDGGtsrwA+57RsgKMONqeFg+ST
AljzbqNlVSFqZCBwR9mVL/OAB3rtrTVX86afkVru04AyJBxdXgnRm69mlOFYUh4L
lrVJNUPrmaDUVv8uX7/lBKV33DqEdO2x4d75Z1Wojq9eOiqOLYr/GyRmwJtwynvS
Baqmmfru6L1gMxVn+gB/8h+pcoyzoTDU5OBJGWh7uXgDdFdYr79nX+OYwGB+a4Xx
eWfC+111NW4D2gfUSFKg9MruExt2M9IwjFlga+wqKNk4S/i5a/16Qf6isHbR/+6k
nAcbIA5L3DL//fl1lnawUU/HJjcW0EE3Wchp3x4n1w+OZxgtBEYNxpH5j19WhuLU
GwKC/8AMqOecSemund1C3LaQ9xLxhR1yGrbQme1Jggvi3GwEqItRHEasmzhw0CMi
buXDpHmaeiQ4uLeTi/tdm4ADtLTDrLDQGCyBPA9/bWTy5+BqW+pzgr4pkp65bkyu
6H54iKJY7Y4OfKjKpyXc5MpmY4IcTJERAVa8LqO/rLP1YZTOlOhELpcSbVsvl+Jp
bUBp1ZC8Yoce9dW1FzS8
=ia8M
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
