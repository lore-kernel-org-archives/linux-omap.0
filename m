From: Felipe Balbi <balbi@ti.com>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Wed, 8 Apr 2015 11:35:59 -0500
Message-ID: <20150408163559.GE1738@saruman.tx.rr.com>
References: <5522886D.5050409@ti.com>
 <20150406134541.GE6023@sirena.org.uk>
 <55228FE0.2040702@ti.com>
 <20150406135829.GH4027@n2100.arm.linux.org.uk>
 <20150406150127.GF6023@sirena.org.uk>
 <5522A391.6080503@ti.com>
 <20150406152750.GE11160@saruman.tx.rr.com>
 <5522D442.9090905@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5522D442.9090905@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Maninder Singh <maninder1.s@samsung.com>
Cc: balbi@ti.com, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yogesh Gaur <yn.gaur@samsung.com>, Amit Arora <amit.arora@samsung.com>, Ajeet Yadav <ajeet.y@samsung.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 01:45:22PM -0500, Nishanth Menon wrote:
> On 04/06/2015 10:27 AM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Apr 06, 2015 at 10:17:37AM -0500, Nishanth Menon wrote:
> >> On 04/06/2015 10:01 AM, Mark Brown wrote:
> >>> On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux wr=
ote:
> >>>> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:
> >>>
> >>>>>> at least a description of the problem you're seeing and some attem=
pt at
> >>>
> >>>>> Test was a simple boot test. There seems to be a lockdep reported a=
t the
> >>>>> very least in the log provided (see
> >>>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2=
plus_defconfig/ldp.txt#L488
> >>>>> ).
> >>>
> >>>> I think what Mark is trying to say is to include a fuller descriptio=
n of
> >>>> the problem, and don't expect people to fire up their web browser to=
 get
> >>>> a basic overview of what the problem is.
> >>>
> >>> Yes, indeed.  I hadn't actually opened the links, I might've got round
> >>> to it later on.
> >>>
> >>>> My guess is that the problem _appears_ to be that someone's added a =
call
> >>>> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
> >>>> without considering what this means.
> >>>
> >>>> What it means is that you can't now use usleep_range() from within a=
ny
> >>>> driver probe function - which is absolutely absurd.
> >>>
> >>> I can't think of any regulator side changes which might be relevant in
> >>> that period.  It's possible that there might be something in the MFD I
> >>> guess.
> >>>
> >>
> >> Ran a few tests since my original email..
> >>
> >> 6261b06de565baafa590e58a531a1a5522cea0b6 ("regulator: Defer lookup of
> >> supply to regulator_get") was the only patch that was introduced in
> >> the interval. there seems nothing in mfd either.
> >>
> >> I still have the following in my log.. trying to further down.
> >=20
> > I noticed a similar warning with AM437x SK
> >=20
> posting intermediate debug results:
>=20
> I did a bisect on the merge commits to identify which tree the
> regression got introduced, looks like it is the merge from akpm tree -
> I have not yet looked deeper.
>=20
> b58a6c0b0808 Merge branch 'akpm-current/current'
> ---> FAIL http://paste.ubuntu.org.cn/2540641
>=20
> ef31288bdf44 Merge remote-tracking branch 'livepatching/for-next'
> --> OK -> http://paste.ubuntu.org.cn/2540778

yeah, this works on my SK too. I bisected it further down to one commit.

commit 6dfc11e36ee0 is the first bad commit, but looks like that's not
in linux-next anymore.

--=20
balbi

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVJVjvAAoJEIaOsuA1yqREW98P/2oOnsySuF3EqTWDjQcn7XQ3
zm3NJT9al3CEy4AWAZceGoPqelegWLqVuQTAteTpIiwz4ANlqeD9Rdjt0ezeRNh7
jljLFDLQ9yDg6vKH9HuCAOhnq7g3gYbQ+AXytBhuzE8tHfPo3NuajTAsNAk8mETt
DxwycdvhnMLxPlnpO2xihgaJtjBsOdglluq4Oc+SUQXm39qOZkhjm0hp4N5XrQW1
S+wiNivMank5PKkExT8UVF66ZM6rP363T5hgME74HjiKFvm0gdqQ2QN5xRmCFBLi
PNwmcKp7CDYPq77Wuj2586M4OkfOIte7BDJdIxlHz+nojre5sr+LuflS8G4tPSSA
S5nBpJVAoXNSx1wdmK5BMQNDNWnBtQMwI6fOGRHaUcy4xJoSi9vWCsRj4W3xIClc
S3L8MdfybupdRsp9NgR1HqGnufd63zfkgHj5uvBOkfSOgBLkCVdVK+OW53QF5fs2
8/yGMRkqgd71xKULqlerJbqb4xlrZF31TaEDZiRO0ecbq5W9hQASo5qrx9Gm/0/6
uA6/Tly4ro4s5bRtS6J1MuvZezt8IXyLlh1BuX7IZXnRSE3QvMfd+RyUJYkoUBnQ
jp5y24ukYxP0oyReBV470UsiTChvFAK/OGbMN/VqFb62NOjENLLY7vygEZqCDEta
iTVfo7yNtpVnr+GHvrPT
=scZ+
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
