From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 21:19:12 +0100
Message-ID: <20160325201911.GA25471@earth>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
 <56F562B7.10107@gmail.com>
 <20160325161954.GA5028@sirena.org.uk>
 <56F56C4A.7070502@gmail.com>
 <20160325170558.GB5028@sirena.org.uk>
 <56F573E5.6030408@gmail.com>
 <20160325182017.GE5028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325182017.GE5028@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Fri, Mar 25, 2016 at 06:20:17PM +0000, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 07:22:45PM +0200, Ivaylo Dimitrov wrote:
>=20
> > On Nokia N900 regulators are left in the mode last set by the bootloade=
r or
> > by the stock kernel, depends on whether it is power-on or reboot from s=
tock
> > kernel to mainline. That leads to problem with devices connected to vmm=
c2
> > regulator - when the device is rebooted from stock kernel vmmc2 is left=
 in
> > "sleep" mode (REGULATOR_STATUS_STANDBY in terms of regulator framework)=
 and
> > as noone in mainline kernel switches vmmc2 regulator to normal
> > (REGULATOR_STATUS_NORMAL) mode, devices supplied by it does not get eno=
ugh
> > power to operate normally.
>=20
> Then there is a constraint that the regulators must be in normal mode
> and this needs to be expressed in the machine constraints.

As in adding "regulator-initial-mode =3D <TWL4030_OPMODE_NORMAL>;" to
the regulator's DT node (and providing an of_map_mode method in the
twl-regulator driver)?

-- Sebastian

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW9Z0/AAoJENju1/PIO/qaVjEQAIW8Q5nfIxTtKzTqNAQk/m3i
0dvpO24eN9BaZsm6G9zvbMmON7qxhpwoyTTmu9rz6bDikf8cMn0gi6C3OKYgQt/C
sf6wfgiIgR9WkhuadIcUD8PjDppsAEixwINipVUc1OqK4TUgbyJeT8vByzebkIKU
PZ2ZbxmEBg9JO+F4nmXZw70ExAwaKrugW/HZ/9JW33PTImWeVE1VMbobjdRa1xuN
G/E+nMNyNuq2HRBV42mQykewVNmJpoc2iAtRO81isaoXUQrgbCJJXweekL82e7DT
QEkYWw1L+oLqs19O2ma3O0ZwNeYzQ6n458OED5ZVPv5OfdKNUDGKjVhH/C3XYSEa
Fv8FP3Fiss42uyPLhiZ/7GlJeWRQbopJHUlweiA++1Ko2iBDwh3XWLWyk5FdMOHB
jkbEr35XUk025zHnyXL+RPp4rjWaqtQ0Ty4nr59AYVPb5DihAcC5qHIehrLrBHDR
B8kdXOUJK3eWF1MhtEP5FqjGQwORw0g8gTzCUjD538+38vccdAmr8vqx4/7lvclK
pDWqh7Yq43oOT8OE3dm6Ot3asNdY50sakYQG3SrBTj1PrdT7IzIDi7HMFJGWWbed
DHsiPBwOTsUSL8zWnO8AEfMuYiUDzIcbrG1J/Qzj2dYfDRkCZHSBEEpEdx9X7UDT
Up6JFxKo921g3uJxGqTU
=Ls4t
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
