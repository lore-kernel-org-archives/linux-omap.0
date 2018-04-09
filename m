From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 09/10] dt-bindings: mfd: ti-lmu: update for backlight
Date: Mon, 9 Apr 2018 23:24:18 +0200
Message-ID: <20180409212418.mc4yjau4hjdbdqbm@earth.universe>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-10-sebastian.reichel@collabora.co.uk>
 <20180409210638.hugfap4ega3bwgou@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4qhglwb5ohir5hrp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409210638.hugfap4ega3bwgou@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--4qhglwb5ohir5hrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 09, 2018 at 04:06:38PM -0500, Rob Herring wrote:
> On Fri, Mar 30, 2018 at 07:24:13PM +0200, Sebastian Reichel wrote:
> > Update binding to integrate the backlight feature directly into
> > the main node, as suggested by Rob Herring.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  Documentation/devicetree/bindings/mfd/ti-lmu.txt | 119 ++++++++++++---=
--------
> >  1 file changed, 60 insertions(+), 59 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documen=
tation/devicetree/bindings/mfd/ti-lmu.txt
> > index c885cf89b8ce..b3433e95dfa5 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> > +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> > @@ -28,10 +28,9 @@ Required properties:
> > =20
> >  Optional property:
> >    - enable-gpios: A GPIO specifier for hardware enable pin.
> > -
> > -Required node:
> > -  - backlight: All LMU devices have backlight child nodes.
> > -               For the properties, please refer to [1].
> > +  - pwm-names: Should be either "lmu-backlight" or unset
> > +  - pwm: This should be a PWM specifier following ../pwm/pwm.txt and m=
ust
> > +         only be specified, if the backlight should be used in PWM mod=
e.
> > =20
> >  Optional nodes:
> >    - fault-monitor: Hardware fault monitoring driver for LM3633 and LM3=
697.
> > @@ -42,8 +41,31 @@ Optional nodes:
> >    - leds: LED properties for LM3633. Please refer to [2].
> >    - regulators: Regulator properties for LM3631 and LM3632.
> >                  Please refer to [3].
> > +  - bank0, bank1, bank2: This contains the backlight configuration
> > +                         for each backlight control bank.
> > +
> > +Required properties in the bank subnodes:
> > +  - label: A string describing the backlight. Should contain "keyboard"
> > +           for a keyboard backlight and "lcd" for LCD panel backlights.
> > +  - ti,led-sources: A list of channels, that should be driven. Each ch=
annel
> > +                    should only be driven by one bank.
> > +
> > +Optional properties in the bank subnodes:
> > +  - default-brightness-level: Backlight initial brightness value.
> > +                              Type is <u32>. It is set as soon as back=
light
> > +			      device is created.
> > +			      0 ~ 2047 =3D LM3631, LM3632, LM3633, LM3695 and
> > +					 LM3697
> > +			      0 ~ 255  =3D LM3532
> > +  - ti,ramp-up-ms, ti,ramp-down-ms: Light dimming effect properties.
> > +				    Type is <u32>. Unit is millisecond.
> > +					0 ~ 65 ms    =3D LM3532
> > +					0 ~ 4000 ms  =3D LM3631
> > +					0 ~ 16000 ms =3D LM3633 and LM3697
> > +  - pwm-period: PWM period. Only valid in PWM brightness mode.
> > +                Type is <u32>. If this property is missing, then contr=
ol
> > +		mode is set to I2C by default.
> > =20
> > -[1] ../leds/backlight/ti-lmu-backlight.txt
> >  [2] ../leds/leds-lm3633.txt
> >  [3] ../regulator/lm363x-regulator.txt
> > =20
> > @@ -53,14 +75,11 @@ lm3532@38 {
> > =20
> >  	enable-gpios =3D <&pioC 2 GPIO_ACTIVE_HIGH>;
> > =20
> > -	backlight {
> > -		compatible =3D "ti,lm3532-backlight";
> > -
> > -		lcd {
> > -			led-sources =3D <0 1 2>;
> > -			ramp-up-msec =3D <30>;
> > -			ramp-down-msec =3D <0>;
> > -		};
> > +	bank0 {
> > +		label =3D "lcd";
> > +		led-sources =3D <0 1 2>;
> > +		ramp-up-msec =3D <30>;
> > +		ramp-down-msec =3D <0>;
>=20
> Looks like it was already wrong, but these are missing the vendor=20
> prefixes.

Oops. I will add the vendor prefix.

>=20
> >  	};
> >  };
> > =20
> > @@ -105,13 +124,10 @@ lm3631@29 {
>=20
> Are so many examples really needed? Examples aren't supposed to=20
> enumerate all possible options...

I will remove a few in the next version.

-- Sebastian

--4qhglwb5ohir5hrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrL2fwACgkQ2O7X88g7
+pqipA/8CzzOPLEkxt1n41yjFNMYPxh15gjiyxiy75x4MR/Vy3MLFR6KY6JEqeVY
+JV6wwX1LAW8YsqK9t0hL8xS++2L2TU1+caBSdL8eaZbS5YHV/a+5WFy+67Cz06N
xiJxAf0GtQSZLN+1cyquFYpWLEONdio4/j1Cd6hQ/AjR8wXoGLbjX+P0bVlISbY0
801L3oNoPrLNbu9BRZD13M3LTgzaF8kqFCMaFik8cGJ/yf8wdwgJbQFVzm4wC5B3
QnDJYwmHlukeBH0Qmr9u83pW192bbhXIaIajETAozXprtfvV2PhSeYyLsvEZjZ8y
qxZ9Rb2szMPzBCiV0+QgiaxPypWqB4JY0y0kD99oWYYCOvRiJYEIBv8LyTM44Q47
UwXWYYvUM4M2lzMQo6rYrFwyUE35WqgpuCWHBSzVqus3xSsLriJ1jR0ZDGDERYj7
rN9EuqizGzStxxQaF+8Yjt2k0b8nS6gpONq8gL2Kyje0SGds6B41GUuRWxXybVBr
MquTfpkBYJbhzYdn8UVIJFItW/fbpHzNEnaqq/JWlmDnsNOMfQTpdhpbANcaVAda
fZLxNOQTx7EgrNj6m5jQEfqNbizhPSLfc/88hZbEzpy5rgLbncI1WZj0XyKsN0Pd
TjPdrjHnRDa3VHypHuLMCZXv+Mb4lpat6mf0aMb47xTvDvCinjw=
=kR+z
-----END PGP SIGNATURE-----

--4qhglwb5ohir5hrp--
