From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] dt-bindings: Nokia N9 audio support
Date: Mon, 29 Jan 2018 22:19:51 +0100
Message-ID: <20180129211636.GA3873@amd>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
 <20180108222054.GA17452@amd>
 <20180110085315.GA17841@amd>
 <20180119201546.v4ua72kejql3w2ro@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119201546.v4ua72kejql3w2ro@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> > @@ -0,0 +1,36 @@
> > +Texas Instruments - wl1273 radio/bluetooth module
>=20
> bluetooth chips have a binding location: bindings/net/bluetooth.
>=20
> And we already have a WL1273 binding. Plus there's the one for the Nokia=
=20
> BT which I think can be TI chips with a different firmware and protocol.=
=20
> Is this related?

Ok, let me investigate wl1273 (and postpone it, audio is critical, FM
radio -- not so much).

> > index 0000000..230b1eb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> > @@ -0,0 +1,32 @@
> > +* Nokia N9/N950 audio setup
> > +
> > +Required properties:
> > +- compatible: "nokia,n9-audio"
> > +
> > +- nokia,twl4030-cpu-dai: phandle for the McBSP node connected to TWL40=
30
> > +- nokia,tlv320dac33-cpu-dai: phandle for the McBSP node connected to T=
LV320DAC33
> > +- nokia,wl1273-cpu-dai: phandle for the McBSP node connected to WL1273
> > +
> > +- nokia,twl4030-codec: phandle for the TWL4030 codec
> > +- nokia,tlv320dac33-codec: phandle for the TLV320DAC33 codec
> > +- nokia,wl1273-codec: phandle for the WL1273 codec
>=20
> Both dais and codecs should just be lists with a defined order.
>=20
> > +- nokia,headphone-amplifier: phandle for the TPA6130A2 node
>=20
> The simple card or graph card binding don't work? At least follow them=20
> to the extent that they do work.=20

Yep, that quite big changes for the driver... Thanks for pointers. I'm
not sure what features simple card / graph card miss.=20

> > +Texas Instruments - tlv320dac33 Codec module
> > +
> > +The tlv320dac33 serial control bus communicates through I2C protocols.
> > +
> > +Required properties:
> > +
> > +- compatible - "ti,tlv320dac33"
> > +- reg - I2C slave address
> > +
> > +Optional properties:
> > +
> > +- power-gpio - gpio pin to power the device
>=20
> power-gpios.
>=20
> Active high or low?

Ok, this one can be fixed easily, and I guess tlv320dac33 driver might
be useful for someone else, so I'll try to merge it first.

Thanks for review,

> > +	ti,burst-bclkdiv =3D /bits/ 8 <3>;

Oh and I'll make this plain int. No need to play with bits.

Best regards
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpvj/cACgkQMOfwapXb+vL71QCfWTUei7Rlo4oRoJ6WsQKtqWJu
LuEAoKh6PnhMaCz/ktCcA96xpEWgdoxD
=Jm+k
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
