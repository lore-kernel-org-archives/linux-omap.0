From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Mon, 2 May 2016 22:12:17 +0200
Message-ID: <20160502201216.GA19211@earth>
References: <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
 <20160429200559.GA16598@earth>
 <20160501085236.GA14243@amd>
 <20160501154855.GA24970@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160501154855.GA24970@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sun, May 01, 2016 at 05:48:56PM +0200, Sebastian Reichel wrote:
> > I see latest series, and it also talks about frequency scaling.
> > But I guess it is not going to fix this issue?
>=20
> No, this is independent of the runtime PM problems. I also worked
> on runtime PM/idling yesterday and pm_runtime_irq_safe is the main
> culprit for breaking it (not the only one, though). It's not yet
> finished though

I will be on vacation for a week starting tomorrow. If you want to
play around with my intermediate SSI PM status, you can try this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=3Drun=
time-pm-fixes

-- Sebastian

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXJ7ScAAoJENju1/PIO/qadf0P/0hQkJoA90n1GtSkE1n4B4Gm
VPMCtOZ3n0tC0t0v6Oc7g6xfAxQ9GBzyl2ubCR1meDztIC6bgvdXsFWI+g6TwUSR
L6Ju7Zmtgy9G7hR6QMtugyUDQFs8Qf94IAyZIKz0G/Zk5kTPtNDF3vCBx/5z+aIq
b6B4n5g/WYTqlk5+pAG1UhBaUqBWgYbUA11x6ObtRpX5/BxBuxkOypD1bv33bAr2
ZgajDOdY9KarTbVxlGygRl+iAM2qh5cSWLCfsbOnrbnRueEMDGdZnl0i5kf4cCPw
e00Og8lbc5CdaCL9tda38CerJpclnv36kGAS4SHgh1D9CpFh4EP4TQu/P4EKomaH
eYiJDKcOxU4BiE9laqs/P9+HGKgFlgZ9QJ8BJT/qFo2sRTD7CpPuJJkGaD7+wcsu
pQchkrSuPQQHfCOwZb8gOWapE6PLuZMvtEVyktac3WLVulObOzFYsMgK2kZ7qCWr
TflyTdSeIEG902fiHQo9N3pKb4VqES3iWWm7uRyIqQq+ZPEiQX7AbASVhaLR+W7D
TVPHOPSg88XYFewqaVEtw929MfAeV0H2w54ailOwe8wrqSK7lPdx3f1sv4Kbv1oI
iwJ839EZHhZVQtR4xVoO7Fbi93KmgXDkOBQakUdaee3tTA4j8vPjx3P9hV9980Sk
jt2orxd3ct+GXqLhCVKY
=xye5
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
