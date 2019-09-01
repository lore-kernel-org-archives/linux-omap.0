From: Pavel Machek <pavel@denx.de>
Subject: next-20190830 on Droid 4 was Re: [PATCH 0/4] musb host improvments
 mostly for omap2430 glue
Date: Sun, 1 Sep 2019 21:39:25 +0200
Message-ID: <20190901193925.GA30586@amd>
References: <20190830232058.53414-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830232058.53414-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> So I ended up cleaning up omap2430 glue layer a bit for host mode with the
> various reproducable errors I was seeing docking droid4 to a lapdock. The=
re
> are a few fixes, and then we end up removing all the devctl register tink=
ering
> for omap2430 glue layer.

I thought I'd test this, so I took

commit 6d028043b55e54f48fbdf62ea8ce11a4ad830cac
    Add linux-next specific files for 20190830

Series (and the other two patches you sent around it) applies ok, but
the result does not boot.

Hmm.

I guess I'll need to resurrect the serial port cable.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1sHm0ACgkQMOfwapXb+vIVbQCgsPODxEwwCon5ZeHC4gpSLfq1
aB4An14jJZbgRELk7gz8FZPreGgMAzW+
=paUb
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
