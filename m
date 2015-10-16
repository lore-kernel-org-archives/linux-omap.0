From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode timers
Date: Fri, 16 Oct 2015 10:58:37 -0500
Message-ID: <87h9lqls9e.fsf@saruman.tx.rr.com>
References: <5620ED34.6000906@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5620ED34.6000906@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Neil Armstrong <narmstrong@baylibre.com> writes:
> Adds support for using a OMAP dual-mode timer with PWM capability
> as a Linux PWM device. The driver controls the timer by using the
> dmtimer API.
>
> Add a platform_data structure for each pwm-omap-dmtimer nodes containing
> the dmtimers functions in order to get driver not rely on platform
> specific functions.
>
> Cc: Grant Erickson <marathon96@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++=
++++++
>  include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtime=
r.txt
>  create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
>  create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt b=
/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
> new file mode 100644
> index 0000000..7f27606
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
> @@ -0,0 +1,18 @@
> +* OMAP PWM for dual-mode timers
> +
> +Required properties:
> +- compatible: Shall contain "ti,omap-dmtimer-pwm".
> +- ti,timers: phandle to PWM capable OMAP timer. See arm/omap/timer.txt f=
or info
> +  about these timers.
> +- #pwm-cells: Should be 3. See pwm.txt in this directory for a descripti=
on of
> +  the cells format.
> +
> +Optiomal properties:
> +- ti,prescaler: Should be a value between 0 and 7, see the timers datash=
eet
> +
> +Example:
> +	pwm: omap-pwm {
> +		compatible =3D "ti,omap-pwm";
> +		ti,timers =3D <&timer9>;
> +		#pwm-cells =3D <3>;
> +	};

I wonder how far are you from a generic pwm-of-timer.c. This looks
pretty close to that. You already have a pdata function pointers for
pretty much everything, all you need to do is pass a timer phandle and,
as long as the functions pointers are implemented, it should work.

You might want to get rid of pdata altogether at some point, this should
work as migration path.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWIR6vAAoJEIaOsuA1yqREsqcP/285m9FDRTuAT7Ps4NwY/fIG
iQikjuMjVxaGfg3Bs8XHoaRAuRbkyIABb2sDN5hOsKdW2CEG6YGO2PTK3SuWnV8B
/cFBRQJFCoEPy5EiuxvQScUPLZdWP9XisbSZFh+nbSeZzfFf19XkXU6CzSkSQhjl
PMGMsg1dqRnL0bhmY2T0HeefloPsYlXbOAXs/esRr/u7NRPDqjL1ObvbeJ9UQugZ
/B5DbONYe+UZUvDkdcrH+bKYo9SlopPISy2KdK34og3xnHmJHJH8gW4DceIeQ4mh
f2Ojsm3sBRlMpg3EiH5SxDyLFnqZtdRZebIsrYVXd/bmJJF6ikPELafZHpS3XthG
kTgunjFgcvHm3840lFHJqTZ9erR/zvjnMXCQJPnOvbprJ5sHeOvQmEh72KxUY2MQ
n10pv4nNhvg9fbTVfPaQS9EoZA+ABRfpJtNDLRiIuGYUJml5qnRYvRAv6bj99I8U
6wHEZXe+r+5oa0icDLPJxPyXyJmJMsCw/zbaCQZJiww+wqfk2+04Fuj/pWue3ZIc
VAmsEJtlqexoFhgOWBt2dtUT769DFpZ2vyj1hKG0NGZGm7mJyJg3OyBjl5XRKPW/
Ij/y4K8dTCE4qm8SIRnHVKQsjKVL0y1AVF6EsC+NifOn8zvelswRyP2xNmvBLXvO
SVoDsxozbR3MiGGnHUOa
=GBzy
-----END PGP SIGNATURE-----
--=-=-=--
