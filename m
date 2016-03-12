From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Sat, 12 Mar 2016 13:42:33 +0100
Message-ID: <201603121342.33099@pali>
References: <201507251228.27128@pali> <201601050034.12810@pali> <20160306152339.GA428@earth>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4576805.YoUhivveFn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160306152339.GA428@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

--nextPart4576805.YoUhivveFn
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 06 March 2016 16:23:39 Sebastian Reichel wrote:
> Hi Pali,
>=20
> On Tue, Jan 05, 2016 at 12:34:12AM +0100, Pali Roh=C3=A1r wrote:
> > On Tuesday 04 August 2015 09:02:39 Peter Ujfalusi wrote:
> > > On 08/03/2015 09:48 PM, Jarkko Nikula wrote:
> > > > It is well possible that some regression got introduced to
> > > > TPA6130A2 I2C communication over the years without nobody than
> > > > you now notices. We used to do QA back in Meego N900 days but
> > > > that was pre 3.x kernels.
> > >=20
> > > No major changes has been done to the tpa driver during the past
> > > years... I wanted to do some updates, like moving it to regmap,
> > > but as you said, n900 is the only user (and n9) and I do not
> > > feel comfortable to hack on a device where I do not have serial
> > > console... And I'm using the n900 time to time also.
> > >=20
> > > >> So maybe something similar? Kernel expects that some PM or
> > > >> regulator parts are initialized, but they are only sometimes?
> > > >> Just speculation...
> > > >=20
> > > > I'm thinking the same. I could figure SCL could be stuck low if
> > > > TPA or some other chip connected to the same I2C bus is
> > > > without power and is pulling I2C signals down.
> > >=20
> > > What would happen with the SCL stuck on i2c.2 bus if you remove
> > > the tpa driver from the kernel? If you remove the other drivers
> > > for the devices on i2c.2?
> >=20
> > Hi Peter and Jarkko! Do you have some code samples for testing? Or
> > something else which I can test? This problem is still reproducible
> > on more N900 devices and I would like to see it fixed.
>=20
> I have not seen your error with N900, but while working on N950 I
> noticed similar problems when I added lp5523. I think the lp5523
> reset routine locks up the omap i2c controller, since the lp5523
> will stop responding in the middle of an ongoing communication:
>=20
> static void lp55xx_reset_device(struct lp55xx_chip *chip)
> {
> 	struct lp55xx_device_config *cfg =3D chip->cfg;
> 	u8 addr =3D cfg->reset.addr;
> 	u8 val  =3D cfg->reset.val;
>=20
> 	/* no error checking here because no ACK from the device after reset
> */ lp55xx_write(chip, addr, val);
> }
>=20
> Since tpa6130a2 is on the same i2c bus, it would be affected by
> this. You can check this by just commenting out the call to
> lp55xx_reset_device() in the probe function, since it's not
> needed on N900 (chip reset is done via enable gpio anyways).
>=20
> I'm pretty sure, there were no bus lock problems when I added
> lp5523 to N900 dts, so this having problems with this is probably
> a regression in the omap-i2c driver.
>=20
> -- Sebastian

Hi Sebastian! Commenting calling lp55xx_reset_device function did not=20
helped. Still getting that error.

Tony, Peter, Jarkko: can you reproduce this problem? I'm really stucked=20
here... do not know where is problem or how to fix it. What we know that=20
it happens when rebooting from stock Nokia kernel (2.6.28) to upstream.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4576805.YoUhivveFn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlbkDrkACgkQi/DJPQPkQ1JYKgCgqbxzLOJHeIyx8vj7ByQPYqfR
ESsAoLSlWi5K2Ir6/eSM75ArxV8aDIjb
=Y5FA
-----END PGP SIGNATURE-----

--nextPart4576805.YoUhivveFn--
