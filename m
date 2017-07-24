From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv4 1/3] dt-bindings: input: add pwm-vibrator
Date: Mon, 24 Jul 2017 21:20:17 +0200
Message-ID: <20170724192017.GE32425@amd>
References: <20170714100151.31234-1-sebastian.reichel@collabora.co.uk>
 <20170714100151.31234-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170714100151.31234-2-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-07-14 12:01:49, Sebastian Reichel wrote:
> Add DT binding document for PWM controlled vibrator devices.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

> index 000000000000..09145d18491d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> @@ -0,0 +1,66 @@
> +* PWM vibrator device tree bindings
> +
> +Registers a PWM device as vibrator. It is expected, that the vibrator's
> +strength increases based on the duty cycle of the enable PWM channel
> +(100% duty cycle meaning strongest vibration, 0% meaning no vibration).
> +
> +The binding supports an optional direction PWM channel, that can be
> +driven at fixed duty cycle. If available this is can be used to increase
> +the vibration effect of some devices.

Actually what "direction" does would be nice to explain, because I
don't know. Does it make the motor turn the other way around?

> +Required properties:
> +- compatible: should contain "pwm-vibrator"

should->Should.

> +- pwm-names: Should contain "enable" and optionally "direction"
> +- pwms: Should contain a PWM handle for each entry in pwm-names
> +
> +Optional properties:
> +- vcc-supply: Phandle for the regulator supplying power
> +- direction-duty-cycle-ns: Duty cycle of the direction PWM channel in
> +                           nanoseconds, defaults to 50% of the channel's
> +			   period.

Is nanoseconds right unit here? It drives a motor...

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAll2SHEACgkQMOfwapXb+vL6eQCgnQ/nkXsG/SRMySTB9qHW4rWu
wz8An1IVCctTyOwSxPrUvtsT+MdeqlYa
=0UQO
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
