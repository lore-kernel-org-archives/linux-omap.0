From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv4] media: i2c/adp1653: devicetree support for adp1653
Date: Fri, 3 Apr 2015 16:22:56 +0200
Message-ID: <20150403142256.GA13595@earth>
References: <20150402143846.GA11687@amd>
 <20150402203417.GA6336@amd>
 <CABxcv=nfg_D9HvXUd4PBFJ5a1XST=PCDEZCjkTtbu_u7cc1+ug@mail.gmail.com>
 <20150403082129.GA10671@amd>
 <CABxcv=mVdw7QkUWSqa1=VRJD+mHCU3dP09SBxVERs1NWUBeWiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABxcv=mVdw7QkUWSqa1=VRJD+mHCU3dP09SBxVERs1NWUBeWiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, sakari.ailus@iki.fi, m.chehab@samsung.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 03, 2015 at 10:49:12AM +0200, Javier Martinez Canillas wrote:
> >> The convention nowadays is to not use unnamed DT properties for GPIOs
> >> but instead use a prefix that explains what those GPIOs are used for.
> >> So something like "power-gpios" or "power-gpio" (if there is only one
> >> GPIO) will be more suitable. Please take a look to
> >> Documentation/gpio/board.txt for more details.
> >
> > Ok. Actually, reading docs below, "power-gpio" will not work, and it
> > needs to be "power-gpios", right?
> >
>=20
> No, the documentation is not updated. People used <function>-gpio so
> at the end it was added as another supported suffix, see commit:
> dd34c37aa3e8 ("gpio: of: Allow -gpio suffix for property names").
>=20
> But I guess it doesn't matter if -gpio or -gpios is used.

I suggest to use enable-gpio(s), since the pin is called "enable" in
the datasheet.

-- Sebastian

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVHqI9AAoJENju1/PIO/qalVMQAIDWCNYtcN335qxzf1IYiwY7
jWvD03JZ1uKYPHvGl9MvBBHN1KzUPV+d/hCJ7q0PMDk5bcyIl3q2lROKbCKD6aZX
fK0VZTpu9aKcid+nUGkAvSNlwhUywjXOTAgkGZwgxmaQQIkf3YE68mIfa6Y6wRNR
x7FvP8kgjkx6VgbdzS8EXgystaYVUeYoDVBkawj2ztRrpkOyoFravKQBdrTyLn/0
qATNGTiRyv1jjXT0jB0aorJo5EwQ/Xl/9csTQRCqrBnQtmFQ1EP9tOzbXzK19cYU
xqIkyYx8bO2DKHPE5HjAZnEitt/Gdzc7pbyIV8gDdgY8lU7OT0LPC/CzdK1OOA30
gssIWChugj/NGd73wALOZHT2i2LxBBdkKIQlLX0fB5ojZJ1AAVZw8AnfyC9leaZ5
TAYS6YtfWLBiol8eQwNu8wKNGh5AwaxYZ5TFStCpNmV0XAiGtQ5xog9Oab2Ao0fU
j/8FDfvmaz8WTncuxq0nH7qhhqL+ytjj5N39mhHAxPS0lsfhBnfIfLOwWHGOc9xf
C/Ob5sXdu/RqXrI4+NL0jQ+jPn8jtc2Gsv/2lrJLl0fSpnPouM+qvujGAEGSU0gM
ldbMw68qYy3kE1qc47vS13XsUfDWndDgDOG48Tv1WdsaRY27GpjZTtYjCUJ22j8S
xGSNSBIAu7T75d1WDeRl
=MRdo
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
