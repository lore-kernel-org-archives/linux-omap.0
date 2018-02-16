From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Fri, 16 Feb 2018 15:12:37 +0100
Message-ID: <20180216141237.rd75sbix7bopi7zu@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uyih4se4bmnl7bld"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180216134448.GI5886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--uyih4se4bmnl7bld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 16, 2018 at 01:44:48PM +0000, Mark Brown wrote:
> On Fri, Feb 16, 2018 at 02:25:38PM +0100, Sebastian Reichel wrote:
> > On Fri, Feb 16, 2018 at 11:30:08AM +0000, Mark Brown wrote:
>=20
> > > Why are we adding a separate DT node with no content for this?  This =
is
> > > a single chip, we already know that the CODEC part is there from the =
DT
> > > telling us that the chip is there and what we decide is part of the
> > > CODEC is going to depend on what the OS running on the system is doin=
g.
>=20
> > While it looks empty in the DT binding file, it's actually not empty
> > once some standard properties are added to support audio-graph-card.
>=20
> This tells me you're missing something in the binding defining the
> DAIs and...

Well it is described by the following document:

Documentation/devicetree/bindings/sound/audio-graph-card.txt

Previous revision of the codec also worked perfectly fine
with the simple card binding, which does the DAI stuff
differently:

Documentation/devicetree/bindings/sound/simple-card.txt

A quick check of the other codecs suggested, that none of them
descibes the graph based binding style. AFAIUI they could be
used with it, though. So if you have a suggestion for a better
binding document I can adopt this in the next version.

> > A real world example looks like this:
>=20
> > &cpcap {
> >     audio-codec {
> >         compatible =3D "motorola,cpcap-audio-codec";
> >         #sound-dai-cells =3D <1>;
>=20
> ...that still doesn't require a compatible here.

I agree, that it's not required. Also the node is not required.
Everything could be dumped into the main node. Many things are
not required, but they make implementations easier and help in
regards to DT readability and consistency. Having the compatible
means, that all sub-functions _can_ be handled equally by the
operating system. Not having the compatible means you _always_
need special handling for the audio codec. This basically makes
the codec node different for the simple purpose of "because it is
not strictly required". If we have a compatible node, other
operating systems can still decide to ignore it, right?

-- Sebastian

--uyih4se4bmnl7bld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG5tIACgkQ2O7X88g7
+prEZg/+Ifk7bp+ccQ3mD97OqKP8xZAjxemJ0PTgQttwYPd68AUV2M3XkLfxDWRb
lWMhhxP2plciikgTS4ehDUFUG37fabNf+VpKPsu753NJDgcD+JNETf+h/grZfj4b
SYBcFc/oLOTb+KdyNk+nXMYsPlFQ9yDXAB9axLO+Hs52WV4w6wnFCUSiw+XYJMX3
ZzhkNzBjdnr8eL37t72eg1N5/+u33yiw8fJb2+Hz+Qa6nvRiq8ksDHFXG714RJiM
Xv6Ss/iskWqRMAvr/1hVNfyCF0DB0kYeY2fb7bI2h6QiSKwAQBc41/XCHZSoh2ZX
gIiED5k4tjcx3rhas3NSPaEZeCeJzGtqTOVDJAoGwwpMsUV9o5vB/bojNe3T9ggQ
C3uX/I7UmjVrXX2N6gubo12q3JKM3SCD/EhH+pJ3oMj0ToTYuRkIyO2gLVjfllYU
rjvlqT+u661k2jr68KNbjuUgKMlaEkHNmeQipPDDyo2xdr0nOnzyb0642nx8/OvJ
wWS/gp/0epzJZWgSV4sd6P1BUeiplTz68WXtqw4nzQ6qAT+ePTEWXFqz7GyoRgQE
hB6Rxu1n0Ur+KfsHnO2Z2UJJxXt3RD5pQIVD79XQqOubDb+Y4qtW+BceunaZ6RY2
Dv0f//cIWhvKN0lRZRBge2z2V6VOFT3/MEexX0LnfnuuhR8D4Qs=
=r5ow
-----END PGP SIGNATURE-----

--uyih4se4bmnl7bld--
