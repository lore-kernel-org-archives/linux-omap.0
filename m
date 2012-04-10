From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/19] I2C updates
Date: Tue, 10 Apr 2012 14:41:54 +0300
Message-ID: <20120410114153.GR20616@arwen.pp.htv.fi>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
 <CANfBPZ92EEAqrFC2gnULAXwQKhWdAuNntHz0QVXuUR3Wr=nSGQ@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkilVOb9qhI0mB+X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:56527 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653Ab2DJLmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 07:42:47 -0400
Received: by lagz14 with SMTP id z14so5434422lag.14
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 04:42:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANfBPZ92EEAqrFC2gnULAXwQKhWdAuNntHz0QVXuUR3Wr=nSGQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org


--YkilVOb9qhI0mB+X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 05:01:37PM +0530, S, Venkatraman wrote:
> On Tue, Apr 10, 2012 at 4:26 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wro=
te:
> > The patch series does the following
> >
> > - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> > - I2C register restore only if context if the context is lost
> > - Bus busy recovery mechanism.
> > - the reset is not done in init.
> >
> > v2 changes
> > -Adds a patch to use devm_* functions
> > -Also checks the return type of the get_sync and in case
> > =A0of errors prevents register access.
> > - In case of i2c remove register access was done without any
> > =A0get_sync fix the same.
> > - Adds a pdata function pointer to do context save restore
> >
> > v3 changes
> > - Split the omap_i2c_isr to increase readability
> > - Adds the restore flag patch for OMAP4 to the series
> > - Make the i2c use SET_RUNTIME_PM_OPS
> > v4 changes
> > - Folds a patch from Tasslehoff to prevent any merge conflicts.
> > - Prevents the XDUF flag to be set if the underflow condition is not me=
t.
> >
> > v5 changes
> > - Add consistency in the subject naming.
> >
> > v6 changes
> > - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
> > =A0use the unique id instead as the section number in the recent errata
> > =A0docs has changed.
> >
> >
> > [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
> >
> > Tested on omap4sdp and omap3sdp.
> >
> >
> > The following changes since commit 258f742635360175564e9470eb060ff4d4b9=
84e7:
> >
> > =A0modpost: Fix modpost license checking of vmlinux.o (2012-04-09 20:52=
:56 -0700)
> >
> > are available in the git repository at:
> > =A0git@gitorious.org:linus-tree/linus-tree.git i2c_omap-next
>=20
> Minor nit:
> You might want to indicate a git:// link instead of an ssh URL ?

indeed, for those who haven't noticed git now has separate url and
pushurl for every remote. Meaning you can pull and push with different
urls. This solves this issue.

--=20
balbi

--YkilVOb9qhI0mB+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJPhByBAAoJEIaOsuA1yqREBSIP+KMZvtFTGd+iRfb/Lg93lQXH
lijOH4NTHV82AARqOvsb3GMFof5AClXRqXzdv6YvF00Mvsrie7+T79f1FU3A/uMD
22bS7pSgScv2Z817Fs8jrinLupLo4gFoZyPHC6sn7pFfIdWTbgXlhIwlc2Y7tO7e
cBxVVmpgkgp95pnKKcCAoJlKfwSWApURDbWIzawNA5iG/lpzYBkl/FgYbeURTf7H
FlHuYQCFuY3/dmrRIW+a3519/2zZLCXbW1afl4w7Mp8uLHYNYR3YEIfLRV9JXjcY
o3hnlm+4Yc6Clq9dI0404LhCqpZOxFiq9lKgBF0qcyeVQAy4iRc9XUaLMOfo8Tpn
fRIwpyLOfFZihfD+xvNqntOKkRjHJPCYwhW/Sjnf/3JCnmS31oLEXoVAG4A41eyO
DamQMXl8Mdb7z3ihz8TZxglUGbdTZu5lNYZ6R4+K+fi6Tejja1dCUX3GF5I1PmpP
i0Ypq6goSuQGa+ZBbYJ3AsZp/WNXttYhatRdvVZRfDwhKqhTYpJDDT40yjaZ3Gt9
h/JS/Pc973ggEN19JqgrswGell6eGHa69qj1AgvGc2SD6VORQtMBrR9LBVr7kkrS
gUy1k1u5khISuturOaJTLwUXGVaWBwePhvWavWdlp4BrXSV1LArJO01aUojmjDUk
R2a5JVCth3Ax+vlXvcs=
=k8VK
-----END PGP SIGNATURE-----

--YkilVOb9qhI0mB+X--
