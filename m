From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
Date: Tue, 21 Aug 2012 17:09:24 +0300
Message-ID: <20120821140923.GL10347@arwen.pp.htv.fi>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
 <20120821132741.GI10347@arwen.pp.htv.fi>
 <20120821134936.GH7995@opensource.wolfsonmicro.com>
 <20120821135240.GJ10347@arwen.pp.htv.fi>
 <20120821140803.GK7995@opensource.wolfsonmicro.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUjYDmxMtFc8vtOf"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120821140803.GK7995@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fUjYDmxMtFc8vtOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 21, 2012 at 03:08:03PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 04:52:41PM +0300, Felipe Balbi wrote:
>=20
> > Fair enough, we have "quiet", but I'm not sure that's enough argument to
> > allow any simple driver to start poluting dmesg with whatever random
> > messages.
>=20
> I think if the driver is just logging to say "I'm running" that's noise
> and I do push back on that routinely myself; if the driver is providing
> information it's discovered from the running system then that seems much
> more useful and we should have a sensible way of getting that out in a
> place where users are likely to find.

fair enough. But look at the messages which that driver is printing:

+       regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
+
+       regmap_read(smsc->regmap, SMSC_DEV_REV, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
+
+       regmap_read(smsc->regmap, SMSC_VEN_ID_L, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
+
+       regmap_read(smsc->regmap, SMSC_VEN_ID_H, &ret);
+       dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);

You can't possibly understand what that'll print. First of all, VEN_ID_H
and VEN_ID_L should be ORed together. Second, the user will see the same
message four times in a row, with different values, but see that driver
claims that all four values refer to the device id. What this should do,
is at least combine all four messages into a single one of the format:

dev_(dbg|info)(&i2c->dev, "SMSCxxx devid: %02x rev: %02x venid: %02x\n",
	devid, rev, (venid_h << 8) | venid_l);

or something similar.

--=20
balbi

--fUjYDmxMtFc8vtOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM5aTAAoJEIaOsuA1yqREbTEP/326y2iYhQNsIddMJIjzB2VT
0h8cu1J+OzeAWJ84GO4mT0RQyOQu9TjxOUVHyzQ3Mk/XvUQYDxOPySJSq5KR/ys0
qj+WKi1MTKrRdXdBhINYXZTHpTlDT2yDxW0Vu1xionnzsML4H/+0Cfc0Suo/NTBd
74rgJ6z9x6BY7PpMwkfQNQZ/13XcPZJtBmPPdfqOaSuzHQthBPV6B84+t4ShnsXm
QR20HtTuLxw9PHc1fW6hpI6OjE2CpKODo1Qal0/ul03MBeTGae8GkIdu6L8j3uYn
N3MG5QcBQ1/iwn4RKUAMEVVx9gvZOpgm2Yt2zRqCBLACHXN7lSKdRwILgMfUA5xi
MsfIAPB9FtrYpfwNM+Uwn2l292m/F/SEAyKZVXLoUOYWRK21x2xEiIBKn4kWZ8XR
OQXFBX1ppnGn+v4qfhUDpFS/+nCEgWB/zTaDujFCZg6LxyAJEE5etse8qdH4w0mf
U59/efhFw3f7SHRnXxH7tj+ajtzwoB0CM4+wdAeZW6lskQ1NjIcR7iuKovh+f9Oe
5WWyB6mTuP44kDC6nF2rIARzdkt/DFjENOVANvWGsE4G9l43w7cS8MQwK6NYDfeA
cFA2v5XqcmOK/+VL3R4oZfnOKnpuKzOLRWdLTxLjmN5sBEeIkMpKaklLC5XbN1Hv
x1yW2f/IIbluePbB1Upb
=ywZA
-----END PGP SIGNATURE-----

--fUjYDmxMtFc8vtOf--
