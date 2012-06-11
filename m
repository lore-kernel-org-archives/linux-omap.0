From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv10 00/11] I2C fixes
Date: Mon, 11 Jun 2012 18:00:34 +0200
Message-ID: <20120611160034.GA3887@pengutronix.de>
References: <1338288983-15026-1-git-send-email-shubhrajyoti@ti.com>
 <87obp4x8gs.fsf@ti.com>
 <CAM=Q2ctZmOFdroUw5qywwGU_4ResB9RKqag4-+qh3nHeKHWzKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57104 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab2FKQAi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 12:00:38 -0400
Content-Disposition: inline
In-Reply-To: <CAM=Q2ctZmOFdroUw5qywwGU_4ResB9RKqag4-+qh3nHeKHWzKQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Kevin Hilman <khilman@ti.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2012 at 11:10:47AM +0530, Shubhrajyoti Datta wrote:
> On Fri, Jun 1, 2012 at 4:29 AM, Kevin Hilman <khilman@ti.com> wrote:
> > Shubhrajyoti D <shubhrajyoti@ti.com> writes:
> >
> >> The patch series does the following
> >>
> >> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> >> - In case of i2c remove register access was done without any
> >> =A0get_sync fix the same.
> >> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> >> - Prevents the XDUF flag to be set if the underflow condition is not m=
et.
> >> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
> >> =A0use the unique id instead as the section number in the recent errata
> >> =A0docs has changed.
> >>
> >> v9:
> >> Fix the comments from Wolfram Sang
> >>
> >> v10:
> >> Add a patch from Neil to the series.
> >> Fix kevin comments
> >> update the patches with comments.
> >
> > Shubhrajyoti, thanks for the updates.
> >
> > Wolfgang, with these updates and testing a bit better described, I'm OK
> > with you merging it. =A0Merging it now will give it plenty of time to
> > bake in linux-next and get more test exposure.
>=20
> Agree,
> These are only fixes can it be considered for rc3?

"Baking in linux-next" and "considering rc3" don't match; baking needs
time, rc3 is soon. I've put the patches now into my -next branch for
more exposure. I am still uncertain if they should be in 3.5 already;
there seem to be worhty fixes in there, but they do depend on stuff
which don't really qualify as bugfixes...

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/WFiEACgkQD27XaX1/VRsMfwCeJvMrV0gKFZBR+YJAGC7gaCp6
0+gAniO9hsTUEn1B426S8JBbpaVUTwDW
=gApb
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
