From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 5/8] drivers:input:ads7846(+tsc2046): add new common
 binding names, pre-calibration and flipping
Date: Fri, 13 Nov 2015 23:29:52 +0100
Message-ID: <20151113222952.GB24590@earth>
References: <cover.1447446957.git.hns@goldelico.com>
 <7e66c363a6bacc33a77ca7bd577db24f603c5b1a.1447446957.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7e66c363a6bacc33a77ca7bd577db24f603c5b1a.1447446957.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 13, 2015 at 09:35:56PM +0100, H. Nikolaus Schaller wrote:
> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> introduced common DT bindings for touchscreens [1] and a helper function =
to
> parse the DT.
>=20
> This has been integrated and interpretation of the inversion (flipping)
> properties for the x and y axis has been added to accommodate any
> orientation of the touch in relation to the LCD.
>=20
> By scaling the min/max ADC values to the screen size it is now possible to
> pre-calibrate the touch so that is (almost) exactly matches the LCD it is
> glued onto. This allows to well enough operate the touch before a user
> space calibration can improve the precision.
>=20
> [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/input/ads7846.txt          |  8 ++-
>  drivers/input/touchscreen/ads7846.c                | 72 ++++++++++++++++=
++++--
>  2 files changed, 74 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Docume=
ntation/devicetree/bindings/input/ads7846.txt
> index df8b127..ae56355 100644
> --- a/Documentation/devicetree/bindings/input/ads7846.txt
> +++ b/Documentation/devicetree/bindings/input/ads7846.txt
> @@ -26,12 +26,17 @@ Additional required properties:
> =20
>  Optional properties:
> =20
> +You can optionally specify any of the touchscreen parameters described in
> +
> +	Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> +
> +This allows to scale, invert or swap coordinates and define the fuzz fac=
tors.
> +
>  	ti,vref-delay-usecs		vref supply delay in usecs, 0 for
>  					external vref (u16).
>  	ti,vref-mv			The VREF voltage, in millivolts (u16).
>  	ti,keep-vref-on			set to keep vref on for differential
>  					measurements as well
> -	ti,swap-xy			swap x and y axis

I guess this should be:

ti,swap-xy: deprecated name for touchscreen-swapped-x-y

-- Sebastian

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWRmRdAAoJENju1/PIO/qazM0P/2/cCfeZPQrBcMlN1g0zx1Pd
YLAYu9CKwWAa8aO9ecn11RMm2acm9Yboqd5l5v47+GVnC4gueehMMLhm6ViJklCd
PCstp+gB8BmMnOHEgCeiSUwvzvOhJG/FdtNDayL2TmfZQMFya2xBE1AKlWJqVl47
+N912tLmmbePRazzsTwNslMjQK8UMG1fe84jhFIv0YJCWeT65VnFkrsKXEFAODev
6grtf6giRmHcfvPjBOcB7AzUPfrnm0FDU49YzX6ufHkw1jlUQr4zotOZ9Ry93Hnq
4EUVYwewCf7chtv3pYRFd6+vOcotyoWS5Z/BtkiSxU8ggFN65AloAHFeYfyWwPSR
x/a6yCCWp3ooP+6mhF2Us2c+EFUhdtuJHWrTCrLU5ySOl4eaLdYaXh4KElpLgOFg
FXndGxchpSKXcuRK2ecQlNGVK4FmkeyJe0hBN/R+QlJX/JuoK6JT5j0jOEj2GOOZ
4NIHH2DAvXDiG7hUEzVvckjBnlCxlKhKSZP0/D+NucQ7pCaQSgSG+zFi0yjnFFnB
kDYnMgTNMLP7ce734uQyu+FVilCSOpwYRnbNf9GMK2PKnUzCpVLXbtf/m28esgTr
mbUQjzjVb+TOikRyOnRuEYAs5sS2J0ABt4pOtoykRpiNWjeF5TWgiZFyWYrcixA+
Rmzl08gNcMI2R+x57pIG
=18pb
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
