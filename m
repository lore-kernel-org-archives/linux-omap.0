From: Felipe Balbi <balbi@ti.com>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 6 Apr 2015 10:27:50 -0500
Message-ID: <20150406152750.GE11160@saruman.tx.rr.com>
References: <5522886D.5050409@ti.com>
 <20150406134541.GE6023@sirena.org.uk>
 <55228FE0.2040702@ti.com>
 <20150406135829.GH4027@n2100.arm.linux.org.uk>
 <20150406150127.GF6023@sirena.org.uk>
 <5522A391.6080503@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5522A391.6080503@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 06, 2015 at 10:17:37AM -0500, Nishanth Menon wrote:
> On 04/06/2015 10:01 AM, Mark Brown wrote:
> > On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux wrot=
e:
> >> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:
> >=20
> >>>> at least a description of the problem you're seeing and some attempt=
 at
> >=20
> >>> Test was a simple boot test. There seems to be a lockdep reported at =
the
> >>> very least in the log provided (see
> >>> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2pl=
us_defconfig/ldp.txt#L488
> >>> ).
> >=20
> >> I think what Mark is trying to say is to include a fuller description =
of
> >> the problem, and don't expect people to fire up their web browser to g=
et
> >> a basic overview of what the problem is.
> >=20
> > Yes, indeed.  I hadn't actually opened the links, I might've got round
> > to it later on.
> >=20
> >> My guess is that the problem _appears_ to be that someone's added a ca=
ll
> >> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
> >> without considering what this means.
> >=20
> >> What it means is that you can't now use usleep_range() from within any
> >> driver probe function - which is absolutely absurd.
> >=20
> > I can't think of any regulator side changes which might be relevant in
> > that period.  It's possible that there might be something in the MFD I
> > guess.
> >=20
>=20
> Ran a few tests since my original email..
>=20
> 6261b06de565baafa590e58a531a1a5522cea0b6 ("regulator: Defer lookup of
> supply to regulator_get") was the only patch that was introduced in
> the interval. there seems nothing in mfd either.
>=20
> I still have the following in my log.. trying to further down.

I noticed a similar warning with AM437x SK

--=20
balbi

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVIqX2AAoJEIaOsuA1yqREhVcQAJ4BHB+MkkMMMZ0FfEx1bXlF
OcTL1InW4zJ8dTnvrbsjufre0w986n1vYfG86kPUp/wVu3TBeK0u/UNlGgBAtSpO
ZIWnZiJ+JurD7uWGvmnkJJwtgKQ2neykCZMFg2EzReaKKYv0i4FEdbTQvV6tqsZP
UbcdgcGEZWRtg2GZ6owbxV3+kwZyzmDaSmu9NqQhQLu5fy6W9ubxcCD+4JW3eQdd
gHW+R0+Mr3I2F3XZsdWeWlE5vMfuuu5vdvsrSshiEZ2MpKm9/xPvKapveCMFmaHb
j+8GeXz5YFXAvRTG+Q/zXizFS5dnoiFp1ZNHvOeaFWPwnq+xLqzmOW8uOydV+7T5
OfVqHULZqJVtuQluqvavjkfsLIKeGRDjnoU3a8JCYnUvPgNzbSwPGaJ0o+rl8gOC
pI/6OF0x1XvZE9PWX1ZY++W78U7nLnoOmfwhTfHy/mLrCiJzVv9769DB7uHq7ije
dWPmM9lL41upLm9ZwU4s3FHMm66Ixo3mGITUje7Tr0T08bABlkfYgGXFJjFsQDRR
2Fbod5hZyvrViFmHreYFFUHq/tAtRUSFIxhYzWUWZELej/bgV79NF/Nlnn2BfIhU
LSbROeLHoI3WYh1kOAoR8ek3wivs6w3+5V33WlUkhpPROabfQBS+xSZM6sPPVul0
egsHQn/xuQ4QNNBFxOpS
=XVDT
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
