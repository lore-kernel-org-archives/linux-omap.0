From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/25] OMAPDSS: DT preparation patches v2
Date: Thu, 10 May 2012 10:11:28 +0300
Message-ID: <1336633888.5182.19.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <20120507174657.GF5088@atomide.com> <1336550949.3962.2.camel@deskari>
	 <20120509154543.GK5088@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Sr+lD9w0i49LlGm/nOnW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55629 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755612Ab2EJHLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 03:11:35 -0400
Received: by lahg1 with SMTP id g1so262675lah.2
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 00:11:31 -0700 (PDT)
In-Reply-To: <20120509154543.GK5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-Sr+lD9w0i49LlGm/nOnW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 08:45 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120509 01:12]:
> >=20
> > Below is the pull request for board file related changes. Tested on
> > panda & 4430sdp.
>=20
> Thanks, I've merged that into clenaup-dss branch and will send it
> along with other still pending cleanup branches.
> =20
> > How should I manage my tree related to this... Should I rebase my
> > original DT preparation series on top of this new branch, or can I just
> > ignore the new branch for now, as long as I merge it at some point
> > before sending a pull request to mainline?
>=20
> Yes you need to rebase on this now. And not touch these commits.
>=20
> Otherwise we'll end up with duplicate commits in the mainline tree,
> which is a big no-no. If something shows up that needs fixing in this
> series, it must now be separate patches on top of this series.
>=20
> When doing pull requests we both just have to make note that there's
> a dependency to this branch, and it will find it's way to mainline
> via arm-soc pull request. Or if no conflicts need sorting out, then
> it will just get merged with your pull request.

Hmm, I'm still not totally sure how to proceed. What do you mean with
"make a note"?

I understand that I can't change the commits, but is it ok for me to now
merge the for-l-o-3.5 branch into my master branch (which is my "stable"
branch, for which I'll send a pull request)?

If the same commits are both in my tree and in l-o (or arm-soc), doesn't
it mean that the commits seem to come into Linus's tree from whoever
happens to send their pull request first? Then again, does it matter..

And if there are conflicts in the board files between for-l-o-3.5 and
some other commits, and you or Arnd resolve those for l-o or arm-soc,
what happens when the same, but unresolved, commits come from my pull
request?=20

Sorry if this should be obvious, but I haven't done such merging before
and I'd rather not mess it up =3D).

 Tomi


--=-Sr+lD9w0i49LlGm/nOnW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq2ogAAoJEPo9qoy8lh713UsQAJAu/Wy/0kVBmm53QN4pt6/r
3HvSrMRy1RpA4q38EWTKiv3RsI/nAkt5hdj9+JfUxf+cALkC5lZOJ4oA4kDFDBBW
tCwS5Y334drthLwItCbBKO+Wc2IBFY4TLvDAEUkjL3ksKyWfPEzdIAUjBz3pALFf
BNCg7l+wVbS/COZ/ErnS7fj2+QHH4jxa5m3Bh1G4lJfnUI8fV+kBkIActF1lWf9i
oKfjOJ/v9A2G3BB7633fmY6bfeLzA5GiGOoZAtveKTGujPYdUjDUl/QExuf1BLWw
mtFnPtzqm8jruXcLLzJXxWHTs1wEuE6OP4TSzvcdZIHgR9FBcMDdtq0cwBP56rBN
j0v/c0ZixmmSaJaf9U5heUAOMJnoxlDx90WKAH6w6JiQOAK9uyky5llDVOzL6m8e
l8NnfM7NFQcWnxtFqQ7R1LLLBzuz9Zp+SX2sHzyOJMFQiL1owjzadEBW3o5LtUo/
bvJePjpV6DQ8tfsp6RaNw1d/OqPs4lDmsnw0fmNUURc8kLIuwEZU3HScF+OUoxkI
uAF2EEfb2wKgY988l5OiaAq5omJg5ARH+JwUR1j0yMLVj4CAkmqGgWwbX5MWm1En
rt0nIczHYwbg1/R9ND/C3tW1Cpwyr+rw9HqhsyRh4VFV5qxZu5oiBWxGaOMuWyHX
qWZUoI0PM7UKxc4OLRYh
=5w1p
-----END PGP SIGNATURE-----

--=-Sr+lD9w0i49LlGm/nOnW--

