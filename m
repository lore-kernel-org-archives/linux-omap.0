From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 2/2] Documentation: dt: Document TSC2005 DT binding
Date: Mon, 9 Dec 2013 19:24:10 +0100
Message-ID: <20131209182409.GA7626@earth.universe>
References: <1386284979-9680-1-git-send-email-sre@debian.org>
 <1386284979-9680-3-git-send-email-sre@debian.org>
 <20131209174638.GC12527@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131209174638.GC12527@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 09:46:38AM -0800, Tony Lindgren wrote:
> > +Optional properties:
> > + - ti,fuzz-x		      : integer, X noise value of the touchscreen
> > +				(defaults to 4)
> > + - ti,fuzz-y		      : integer, Y noise value of the touchscreen
> > +				(defaults to 8)
> > + - ti,fuzz-pressure	      : integer, pressure noise value of the touch=
screen
> > +				(defaults to 2)
> > + - ti,max-x		      : integer, maximum reported x value
> > +				(defaults to 4096)
> > + - ti,max-y		      : integer, maximum reported y value
> > +				(defaults to 4096)
> > + - ti,max-pressure	      : integer, maximum reported pressure
> > +				(defaults to 4096)
> > + - ti,x-plate-resistance      : integer, resistance of the touchscreen=
's X plates
> > +				in ohm (defaults to 280)
> > + - ti,esd-recovery-timeout-ms : integer, if the touchscreen does not r=
espond after
> > +				the configured time (in milli seconds), the driver
> > +				will reset it. This is disabled by default.
>=20
> Instead of adding these optional ti,* properties you can set them in the
> driver directly in the of_match table based on the compatible flag. Then
> you can pass compatible flag like ti,tsc2005-nokia-n900, or the name of
> the LCD panel. Most likely these depend on the LCD panel selected.

I could certainly do this, but it would move the board specific data
=66rom the boardcode into the driver. That looks contra-productive to
me. Is there a good reason to do it this way?

-- Sebastian

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSpgrJAAoJENju1/PIO/qapvsQAI7qV3JzrBekXuf88/1YRqxz
bICnIQPP552wly+wEceIX5xm11RaTuOe8jNsZqZRNyxm0Sjfpd1dPxHkDdwSgiLq
qgK+MC6jliaFmmStoBX6//cE2t6Hl21rYrnBfLFTcdP0sxIFlIzYeq7mdLEBKtgq
PftysW2UMB+VZyM0sHnTt2xKztQpiAFaZDZROeI7Xe7mrzKKwN+JLVFGY6zW1fF7
k4+Ra0hLfTnQpIQgkJBKCOKZh3Imjom4NjPRxcVcPb8HdlFe02+kRVp0V3mNUYay
E8X8rW77cXRwGwqRXNSk4BJ1HPY3/g/q5wDNIaoSS9elgiSbv2K+NFPGnf7ug4yF
Ir+YTa7cCv846zP5UJw8ksPPtOfCkSUQKYEUXVxBphjqMsdey2n6iaETwoxzOJkx
HdK9caKzpoZSW0fDO8ZjR/5JaP35q+tFIST3GmxCO7bBtLfVHv6U1gDIJ8tvYXmI
FPzcDcUrKvPbcydySCuMH4U4OQrp1pEG+K+18W2xQe05JiPb2RlF3vbcqjxFMiJq
B1gaPZagmAv0DruGekd13zcNbuaYsp1dOuYmVDZftUiVnf6smSif7PtN3lP3c4pM
hMD3q2g4Z3dKx3n/f4RCQlclsUVMqwWKuViz6Nm20603OfcRBPaUHZ4aYPJTlGgQ
WN0DKYg64STqw+HRCMRT
=grQi
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
