From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.19-rc1 on droid 4: screen not updating
Date: Wed, 29 Aug 2018 00:41:58 +0200
Message-ID: <20180828224158.GA12978@amd>
References: <20180827105121.GA8283@amd>
 <20180828023722.GK7523@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0681707751=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180828023722.GK7523@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: mpartap@gmx.net, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, sre@kernel.org, nekit1000@gmail.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============0681707751==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > With Sebastian's patches, display works on Droid 4 in v4.18.
>=20
> Hmm care to post your v4.18 patches somewhere too for people?
> I'd have to look around for them since I've been using Linux
> next for past few months.

I don't have patches separated at the moment. I pushed the branch to

git@gitolite.kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git

all-v4.18

> Also, do you have v4.19-rc1 versions of your pending audio
> patches somewhere? I'd like to play with voice calls again
> now with my WIP pending n_gsm serdev patches..

I pushed that to all-v4.19 .

> > I had to do some manual merging, and I see kernel messages in
> > v4.19-rc1, but they are frozen -- no updates.
> >=20
> > a) does someone have it working?
>=20
> I have had it working for few weeks since I'm following
> Linux next. I just pushed Sebastian's patches I rebased
> earlier today against v4.19-rc1 to [0][1].

Thanks, will take a look tommorow.

> > b) is there some way I can help to get it working in mainline? Droid 4
> > is not exactly new, and this is painful point that makes it hard to
> > use.
>=20
> Well since Sebastian is busy according to [2], maybe try to update
> Sebastian's mfd-ti-lmu backlight patches so they can get merged?
> Please check with Sebastian, but that would cut down the pending
> pile by quite a few patches.

Ok, let me take a look.

I currently don't have the patches separated, and yes, the audio ones
work, but no, they are not designed right :-(.=20

Best regards,
									Pavel

> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid=
4-pending-v4.19
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git=
/log/?h=3Ddroid4-pending-v4.19
> [2] https://lists.freedesktop.org/archives/dri-devel/2018-August/186226.h=
tml

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluFz7YACgkQMOfwapXb+vJRFwCeOMVjRK3QYSn+0vy/PTAhpSOL
W9MAn3WO+DDpXIpceIy+U0dSpM8d9e+a
=XVDh
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============0681707751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0681707751==--
