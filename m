From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: implement bus recovery
Date: Tue, 10 Mar 2015 20:50:04 -0500
Message-ID: <20150311015004.GB21726@saruman.tx.rr.com>
References: <1424369209-26735-1-git-send-email-balbi@ti.com>
 <20150309163917.GI3739@saruman.tx.rr.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150309163917.GI3739-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 11:39:17AM -0500, Felipe Balbi wrote:
> On Thu, Feb 19, 2015 at 12:06:49PM -0600, Felipe Balbi wrote:
> > If either SCL or SDA are stuck low, we need to
> > recover the bus using the procedure described
> > on section 3.1.16 of the I2C specification.
> >=20
> > Note that we're trying to implement the procedure
> > exactly as described by that section. First we
> > check which line is stuck low, then implement
> > one or the other procedure. If SDA recovery procedure
> > fails, we reset our IP in an attempt to make it work.
> >=20
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >=20
> > Tested with AM437x IDK, AM437x SK, BeagleBoneBlack and Beagle X15 with
> > 1000 iterations of i2cdetect on all available buses.
> >=20
> > That said, I couldn't get any device to hold the bus busy so I could
> > see this working. If anybody has any good way of forcing a condition
> > so that we need bus recovery, I'd be glad to look at.
>=20
> ping

any comments here ?? Anybody at all ????

--=20
balbi

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/59LAAoJEIaOsuA1yqREKisQAKl2+ezaBMOT8HcSmMY3+YQB
/pD6jD5YS0BmO0bAawRto1xmghLEty9phHOsg4HktFmpwqJJJ+S+JeqTN0wVJftm
qt44dAhvoPaGx2wppp+Nog0O30eXay7nZhaJ6IcDcOUaX77WAeL+J/+9Etdx+ILK
juNQwYt+gZlnP92tsOreJuGTirY0UOtJaWUh9LnHvBHF0X/SWa04j5L/kDF3OCe4
lFfKLiLbeMQR/Er/iGLrwQe8tMDFuo+h62yUv4mMbIrpsVWoCKnu9eC06hn6Pr85
wczSGipg4vgvY2Y20K00rC0CEhUhrEalt5UKmMJG6zD2D143rMitoQ029UViWi5E
+az5yYI/JyOOsSYAKCT56vBrMu9VDx57n0o9zDFClzWvA11N4jqjo5t18508YcHA
omcNhJz1xMavdQhMMUwEgaxj63MQEzVqBllIngXV9swtHA6bbsqO2u3mRCATp1SW
WPXdCFriMNpNJ03kZED2YQrdDW3A7wp7zvmqg72YSUrpxijNdJs744MLeh/GnQjN
JAlbXiC+NqwAXCZ3zP8BVfFtGNp2ka9Pfpe1TVNu1Z1DQMr/uTEbYaPKI+RdSHqP
2nD8Ra2DGJibofZk2J+np5iHLG0g9VvCYNaE8w3y5xXd6ShnwIVXq6rao1V+jGdN
dzbDFsGQZ8L6sOP5oawx
=SQYu
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
