From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Thu, 9 Apr 2015 07:46:54 +1000
Message-ID: <20150409074654.5a3ec836@canb.auug.org.au>
References: <5522886D.5050409@ti.com>
	<20150406134541.GE6023@sirena.org.uk>
	<55228FE0.2040702@ti.com>
	<20150406135829.GH4027@n2100.arm.linux.org.uk>
	<20150406150127.GF6023@sirena.org.uk>
	<5522A391.6080503@ti.com>
	<20150406152750.GE11160@saruman.tx.rr.com>
	<5522D442.9090905@ti.com>
	<20150408163559.GE1738@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LoAKjzQGXfm7Id2PkSAio/x"; protocol="application/pgp-signature"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20150408163559.GE1738@saruman.tx.rr.com>
Sender: linux-next-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Maninder Singh <maninder1.s@samsung.com>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yogesh Gaur <yn.gaur@samsung.com>, Amit Arora <amit.arora@samsung.com>, Ajeet Yadav <ajeet.y@samsung.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/LoAKjzQGXfm7Id2PkSAio/x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

On Wed, 8 Apr 2015 11:35:59 -0500 Felipe Balbi <balbi@ti.com> wrote:
>
> On Mon, Apr 06, 2015 at 01:45:22PM -0500, Nishanth Menon wrote:
> > On 04/06/2015 10:27 AM, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Mon, Apr 06, 2015 at 10:17:37AM -0500, Nishanth Menon wrote:
> > >> On 04/06/2015 10:01 AM, Mark Brown wrote:
> > >>> On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux =
wrote:
> > >>>> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:
> > >>>
> > >>>>>> at least a description of the problem you're seeing and some att=
empt at
> > >>>
> > >>>>> Test was a simple boot test. There seems to be a lockdep reported=
 at the
> > >>>>> very least in the log provided (see
> > >>>>> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/oma=
p2plus_defconfig/ldp.txt#L488
> > >>>>> ).
> > >>>
> > >>>> I think what Mark is trying to say is to include a fuller descript=
ion of
> > >>>> the problem, and don't expect people to fire up their web browser =
to get
> > >>>> a basic overview of what the problem is.
> > >>>
> > >>> Yes, indeed.  I hadn't actually opened the links, I might've got ro=
und
> > >>> to it later on.
> > >>>
> > >>>> My guess is that the problem _appears_ to be that someone's added =
a call
> > >>>> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock=
()
> > >>>> without considering what this means.
> > >>>
> > >>>> What it means is that you can't now use usleep_range() from within=
 any
> > >>>> driver probe function - which is absolutely absurd.
> > >>>
> > >>> I can't think of any regulator side changes which might be relevant=
 in
> > >>> that period.  It's possible that there might be something in the MF=
D I
> > >>> guess.
> > >>>
> > >>
> > >> Ran a few tests since my original email..
> > >>
> > >> 6261b06de565baafa590e58a531a1a5522cea0b6 ("regulator: Defer lookup of
> > >> supply to regulator_get") was the only patch that was introduced in
> > >> the interval. there seems nothing in mfd either.
> > >>
> > >> I still have the following in my log.. trying to further down.
> > >=20
> > > I noticed a similar warning with AM437x SK
> > >=20
> > posting intermediate debug results:
> >=20
> > I did a bisect on the merge commits to identify which tree the
> > regression got introduced, looks like it is the merge from akpm tree -
> > I have not yet looked deeper.
> >=20
> > b58a6c0b0808 Merge branch 'akpm-current/current'
> > ---> FAIL http://paste.ubuntu.org.cn/2540641
> >=20
> > ef31288bdf44 Merge remote-tracking branch 'livepatching/for-next'
> > --> OK -> http://paste.ubuntu.org.cn/2540778
>=20
> yeah, this works on my SK too. I bisected it further down to one commit.
>=20
> commit 6dfc11e36ee0 is the first bad commit, but looks like that's not
> in linux-next anymore.

Please give at least the summary line as well when you refer to
commits.  They get rebase and rewritten which means that their commit
SHA1 changes ...

That commit is "kernel/time/hrtimer.c: restart_syscall: use freezable
blocking call" and, indeed, it was removed from linux-next and Andrew's
tree.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/LoAKjzQGXfm7Id2PkSAio/x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVJaHUAAoJEMDTa8Ir7ZwVzA0P/2WJQ0fOThrO7ZRoLy0SNXqi
V/rtQLUkxfPUV3JKcPMbL0ewxmia2SaY50Ev9i17eC6VilomE/6ZvNK+pabdHjTt
EJYfBkDLTUG+e1NMwYCpXsSljjHCzb2mFZlYM0hKFWpu6PgEL2xZ2W0Mt3v84aNr
dQm+NCPnrRwXSfzjX/WYUCtzqGq3/cxMGcbR4mYa47RPqtLLZ7dAV8L8O/3GNpm8
FUF9nbjqb6s1hXfUT50QtXrPrIosyX4Pfwnm+sjoaErBCFJAHuuawEDkMH+TMmLw
jhICacKpZSnReZiXIBnIG5qhvE9HXYciGuTFm3LE5W3ec3G5U9PRBF0VaEsmzGl+
MVNbNMMTDWVZ3+TtT/g3SOy0LzOPhB7v6X1iw07w4Rxnvl6WOD4VPLvL0NIuyDzk
ukTfusgt/dKtEteXihh8WZ0In0TwN+XRw6+To8pJF9d8ToV2w0nxJYWbzw/qD3vq
X5/q6nm+EXm6FzHYH5ylbpO39QRU/BrxmpUJSBIZAYhIx+Eq05xVPjersvBP3p10
uGPEOEKeDt/NR6DIZWWoA5llbAnFWl5Pk87YiuWp58v74xe0eS5RPRE3ru6xH9vW
DqwLmovZmK9DdU8DaDLY/PWHGGXqOmCDbQq0nsn0DwKG80AA3n92vze/7OZtGVZ5
g1cwLcgB0JFNaYIDQrLK
=p/Gd
-----END PGP SIGNATURE-----

--Sig_/LoAKjzQGXfm7Id2PkSAio/x--
