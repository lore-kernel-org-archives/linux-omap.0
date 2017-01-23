From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
Date: Tue, 24 Jan 2017 00:22:49 +0100
Message-ID: <20170123232249.GA11641@amd>
References: <20161229231411.GA6865@amd>
 <20170102181058.GF9325@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8363832313984305729=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170102181058.GF9325@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============8363832313984305729==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Pavel Machek <pavel@ucw.cz> [161229 15:14]:
> > Hi!
> >=20
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

It happened again in -rc5. I have full dmesg this time.

I started new thread with "

Subject: v4.9 to v4.10 regression: oops when USB cable is plugged in.

". It does no longer look completely scary.
=20
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliGkEkACgkQMOfwapXb+vI6VwCeIlZul4K19Iv81c1+AteBkeZE
wmcAoKTqglW0mJhcU7HnPNRnOsVWKKQo
=mqrI
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--


--===============8363832313984305729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8363832313984305729==--
