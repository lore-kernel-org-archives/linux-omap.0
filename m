From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
Date: Mon, 2 Jan 2017 23:48:30 +0100
Message-ID: <20170102224830.GB6817@amd>
References: <20161229231411.GA6865@amd>
 <20170102181058.GF9325@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170102181058.GF9325@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I forgot I had v4.10-rc1 running, and now I got warning on all the
> > consoles (hand-copied).
> >=20
> >=20
> > Unhandled fault: external abort on non-linefetch (0x1028) at
> > 0xfa0ab060
> > ...
> > Comm: kworker/0:0 Not tainted.
> > Workqueue: events musb_irq_work
> > ...
> > PC is at musb_default_readb().
> > ...
>=20
> This means the clocks are not enabled at that point.
>=20
> > WARNING: CPU: 0 ... at drivers/bus/omap_l3_smx.c:166
> > omap3_l3_app_irq+0xcc/...
> > Tainted: GDW.
>=20
> If you comment out postcore_initcall_sync(omap3_l3_init);
> in drivers/bus/omap_l3_smx.c you'll see the proper stack
> trace instead of the l3 interrupt trace. The system will
> hang at that point most likely.
>=20
> > I do have patches to allow nfsroot over usb. But they worked ok in
> > v4.9... Does anyone see it, too?
>=20
> Hmm not much has changed since v4.9. Are you sure you
> had v4.9 or some earlier v4.9-rc version?

I believe v4.9 works.

But... this may be tricky to reproduce. It happened once so
far... after I reconnected N900 to computer when it was running for a
while. I do have USB cable with power meter on it, thus "flakey". Lets
see if it reappears...
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhq2L4ACgkQMOfwapXb+vIX5gCeJdME2bP+Bp+uni1r1jpgpWjs
oFQAn2SGiJShyDmfVcCLo6UF/8XLDVJM
=FwpE
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
