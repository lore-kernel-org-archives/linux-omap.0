From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sat, 24 Sep 2016 02:31:33 +0200
Message-ID: <20160924003133.htaaiphjrm7vy52t@earth>
References: <cover.1474634475.git.hns@goldelico.com>
 <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com>
 <20160923224726.GA4639@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6a6tkmwscmjsvzhb"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160923224726.GA4639@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--6a6tkmwscmjsvzhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 05:47:26PM -0500, Rob Herring wrote:
> On Fri, Sep 23, 2016 at 02:41:09PM +0200, H. Nikolaus Schaller wrote:
> > commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> > introduced common DT bindings for touchscreens [1] and a helper functio=
n to
> > parse the DT.
> >=20
> > commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted =
/ swapped axes")
> > added another helper for parsing axis inversion and swapping
> > and applying them to x and y coordinates.
> >=20
> > Both helpers have been integrated to accommodate any orientation of the
> > touch panel in relation to the LCD.
> >=20
> > A new feature is to introduce scaling the min/max ADC values to the scr=
een
> > size.
> >=20
> > This makes it possible to pre-calibrate the touch so that is (almost)
> > exactly matches the LCD pixel coordinates it is glued onto. This allows=
 to
> > well enough operate the touch before a user space calibration step can
> > improve the precision.
> >=20
> > Finally, calculate_pressure has been renamed to calculate_resistance
> > because that is what it is doing.
>=20
> Seems like you are breaking compatibility with old DTs. I can't tell for=
=20
> sure though.
>=20
> >=20
> > [1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> >=20
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> >  .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
> >  drivers/input/touchscreen/tsc2007.c                | 126 +++++++++++++=
++++----
> >  include/linux/i2c/tsc2007.h                        |   8 ++
> >  3 files changed, 123 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc200=
7.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > index ec365e1..6e9fd55 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >  - ti,x-plate-ohms: X-plate resistance in ohms.
> > =20
> >  Optional properties:
> > +- generic touch screen properties: see touchscreen binding [2].
> >  - gpios: the interrupt gpio the chip is connected to (trough the penir=
q pin).
> >    The penirq pin goes to low when the panel is touched.
> >    (see GPIO binding[1] for more details).
> > @@ -13,17 +14,20 @@ Optional properties:
> >    (see interrupt binding[0]).
> >  - interrupts: (gpio) interrupt to which the chip is connected
> >    (see interrupt binding[0]).
> > -- ti,max-rt: maximum pressure.
> > -- ti,fuzzx: specifies the absolute input fuzz x value.
> > -  If set, it will permit noise in the data up to +- the value given to=
 the fuzz
> > -  parameter, that is used to filter noise from the event stream.
> > -- ti,fuzzy: specifies the absolute input fuzz y value.
> > -- ti,fuzzz: specifies the absolute input fuzz z value.
> > +- ti,max-rt: maximum pressure resistance above which samples are ignor=
ed
> > +  (default: 4095).
> > +- ti,report-resistance: report resistance (no pressure =3D max_rt) ins=
tead
> > +  of pressure (no pressure =3D 0).
> > +- ti,min-x: minimum value reported by X axis ADC (default 0).
> > +- ti,max-x: maximum value reported by X axis ADC (default 4095).
> > +- ti,min-y: minimum value reported by Y axis ADC (default 0).
> > +- ti,max-y: maximum value reported by Y axis ADC (default 4095).
>=20
> Seems like these could be common too. They make more sense than giving x=
=20
> and y sizes in pixel units which really should come from the panel.

The generic touchscreen properties are described "(in pixels)" in
the DT, but they are used in the same way.

So ti,max-[xy] is basically the same as touchscreen-size-[xy],
except, that the generic bindings don't support min-[xy] !=3D 0.

So maybe change the generic bindings like this:

touchscreen-min-x: minimum value reported by X axis ADC (default 0)
touchscreen-max-x: maximum value reported by Y axis ADC
touchscreen-min-y: minimum value reported by Y axis ADC (default 0)
touchscreen-max-y: maximum value reported by Y axis ADC
touchscreen-size-x: deprecated alias for touchscreen-max-x
touchscreen-size-y: deprecated alias for touchscreen-max-y

-- Sebastian

--6a6tkmwscmjsvzhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX5cliAAoJENju1/PIO/qaqrMP/04uFRW5Ph4ytHVxMn1cOw1m
i2NgDvbFwDZmrRFWU67UYeHc4xMwqGrm0icvkiXg+fNohskwFHDgocR0Ii2QXw6X
F35f1Gk2JXlp9HBDBfAWJzj91G/cifCr0g+sn9LXl+215L/24N0N71rEoY2DxW0D
fa1d73mvmYY2rMhKTkwaK5O+hIRrzWUwiSlLiBQm43A4p9NEQasIJMcqKnUVQqNm
KEJinVyRFKZgObIpMI2mpE7MXIA5jO9Tjyb5KSx7RWmue6Wb22UibiBsfauA6WgX
kaW4OQpPcezP/jueJOZxMyoymJAZwtwoJidJUK1SUMzIqtdwkLAJMA0p6Mh0ZSBC
RDQO+TKSITQjlF6m1MVMl0x9ydir6WpahEKoZzfNwvjsUwVqkyXwANDiaJ6TxxJH
2pG9MpChNuUZjVhQmMeFY904v3Pn5nGaJlrbQDqDtAjcqM8+3HIfvepU7xc3tn6O
7q3jdRCpqU4nLeUIi0XA4c507HjFtjMHv+dOx0Q1000g0zVAuzA78oNJiDf1UlNY
k6mMnIfgsEVPfO/QRHEQt+g76shkpnToWLj7deEVIELeV71rKw96/ZQx/XqZQpFM
WJIPpmVxE7KvMMkA38t/g3laGefUgIL2YXG/JJbNnK3sBpcp+rISdYzEaAUThKXQ
C4WkIv/25AtEmEtVKRiM
=W2rx
-----END PGP SIGNATURE-----

--6a6tkmwscmjsvzhb--
