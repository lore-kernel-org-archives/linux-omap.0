From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: power/supply: Update TPS65217 properties
Date: Thu, 12 Jan 2017 04:47:04 +0100
Message-ID: <20170112034704.4lgilyic5cj4nrxs@earth>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
 <20161209062833.5768-4-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6a6e5z2na24jt6b"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161209062833.5768-4-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--s6a6e5z2na24jt6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Milo,

On Fri, Dec 09, 2016 at 03:28:32PM +0900, Milo Kim wrote:
> Add interrupt specifiers for USB and AC charger input. Interrupt numbers
> are from the datasheet.
> Fix wrong property for compatible string.
>=20
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/tps65217_charger.txt          | 7 +=
+++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_char=
ger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.t=
xt
> index 98d131a..a11072c 100644
> --- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
> @@ -2,11 +2,16 @@ TPS65217 Charger
> =20
>  Required Properties:
>  -compatible: "ti,tps65217-charger"
> +-interrupts: TPS65217 interrupt numbers for the AC and USB charger input=
 change.
> +             Should be <0> for the USB charger and <1> for the AC adapte=
r.
> +-interrupt-names: Should be "USB" and "AC"
> =20
>  This node is a subnode of the tps65217 PMIC.
> =20
>  Example:
> =20
>  	tps65217-charger {
> -		compatible =3D "ti,tps65090-charger";
> +		compatible =3D "ti,tps65217-charger";
> +		interrupts =3D <0>, <1>;
> +		interrupt-names =3D "USB", "AC";
>  	};

Thanks, I queued this into power-supply's for-next branch.

-- Sebastian

--s6a6e5z2na24jt6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh2/DUACgkQ2O7X88g7
+pqcBRAAnvd9Z8Hpx0wKiHt+qcH+EsAiLrUPDI4Ax5jcMSwgG1zaoP8oxnquFUIo
3SSXTHgBcCZyT1oHjdH41kTVn5N73rInmt2zaaHrpMfz3c19rUQAi0ACSmszRL/o
D9CmKu0yNBC0kPK1xk1IP74VR8rm2ddILs56SN/GhtIp3ztES3AiobkCJW4V3HVB
3WRpA7yzeuHD8pxq9cUPzQ9A4Y1+MzI4pQhcoOaAeoZighXGawn9wfiwT/jWKUP4
3K4alPi26L/SVBMLmTV1RBVnc8ZfTzIjeu8vI5IgIyAecTgEp9u9GgJNlGRWe1Jo
xRG2KuFxjQNQq1/818yXeXl/TYZps/QjyUov5Dx5wY2W26q1YOD9T+uJVXNh5E1T
MzusSOck5DOP0wW2dnfqFcIocI+rkft/fIr7KoeDQS2c4MVRZdrs6Kymw18QtR+p
o4GrohJNhUPoLAa8voEk9EY8i5HG5Vpo9rXdR4M1bw3+3IfxsyJu5+J2A8nunqcU
hCooAIHL8x5lW97fJVf2RcP1MLyl4zqrQV1ZrgeqJvp7ZIhLW2UX6pZ1I4+csmfC
phznoWdKyTQTLGyCIZlnirKM8lHsOhvj6I91l14pKiEJBW6xAG4pKtvtQTHSMSAL
NhTtSW5vPI1LCsqfBArTNS1hxHNKlwJeb2qfHipn4GoosVFmMFw=
=K9zX
-----END PGP SIGNATURE-----

--s6a6e5z2na24jt6b--
