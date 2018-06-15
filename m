From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.18-rc0: ohci-platform on n900 oops-es on reboot
Date: Fri, 15 Jun 2018 13:39:19 +0200
Message-ID: <20180615113919.GA28328@amd>
References: <20180614194449.GB17808@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180614194449.GB17808@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, stern@rowland.harvard.edu, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When I enable
>=20
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_OMAP3=3Dy
> CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
>=20
> on n900 (I need it on droid4 and want common config), I get oops when
> attempting to reboot the system. I believe problem is there in v4.17,
> too.
>=20
> I'll try to build it as a module and debug, but if you have better
> idea, let me know...

It oopses in the ohci_shutdown, see the "oopses here" below.

Any ideas?
								Pavel

+       printk(KERN_CRIT "ohci_shutdown... have pointers %lx, %lx\n", hcd, =
ohci);
        ohci_writel(ohci, (u32) ~0, &ohci->regs->intrdisable);
+       printk(KERN_CRIT "ohci_shutdown... disable done\n");
+       udelay(1000);
+       printk(KERN_CRIT "ohci_shutdown... disable done\n");
=20
        /* Software reset, after which the controller goes into SUSPEND */
        ohci_writel(ohci, OHCI_HCR, &ohci->regs->cmdstatus);
+       printk(KERN_CRIT "ohci_shutdown... writel done\n");
        ohci_readl(ohci, &ohci->regs->cmdstatus);       /* flush the writes=
 */
+       /* It oopses here */
+       printk(KERN_CRIT "ohci_shutdown... readl done\n");
        udelay(10);
=20
+       printk(KERN_CRIT "ohci_shutdown... reset done\n");     =20
        ohci_writel(ohci, ohci->fminterval, &ohci->regs->fminterval);
        ohci->rh_state =3D OHCI_RH_HALTED;
+
+       printk(KERN_CRIT "ohci_shutdown... all ok?\n");=20

=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsjpWcACgkQMOfwapXb+vKe4QCfeThIxj9HPavRuH8Pr3SNY79x
BfoAnRTiBtVVOBSR1j5aNy5mEXuTh9Bg
=5JTG
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
