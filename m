From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Thu, 18 Oct 2012 16:53:52 +0300
Message-ID: <20121018135352.GC2739@arwen.pp.htv.fi>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
 <20121018103334.GA1449@arwen.pp.htv.fi>
 <1350562684.2143.52.camel@sokoban>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57886 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab2JRN72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 09:59:28 -0400
Content-Disposition: inline
In-Reply-To: <1350562684.2143.52.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>

--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
> > > +static int __init omap4430_phy_power_down(void)
> > > +{
> > > +	void __iomem *ctrl_base;
> > > +
> > > +	if (!cpu_is_omap44xx())
> > > +		return 0;
> > > +
> > > +	ctrl_base =3D ioremap(OMAP443X_SCM_BASE, SZ_1K);
> > > +	if (!ctrl_base) {
> > > +		pr_err("control module ioremap failed\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	/* Power down the phy */
> > > +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> > > +
> > > +	iounmap(ctrl_base);
> > > +
> > > +	return 0;
> > > +}
> > > +early_initcall(omap4430_phy_power_down);
> > > +#endif
> >=20
> > I think you could do it even if the driver is enabled.
>=20
> Actually not at least now, it looks like the driver is not controlling
> this bit at all, so the driver would fail if we do this.

then we can consider that a bug in the driver. Kishon, I thought you had
added SCM address space to PHY driver for this particular reason until
we get SCM driver, wasn't it ??

> > Just to make sure I understand the issue right: is the PHY enabled by
> > default or did bootloader left this enabled ?
>=20
> The reset value for the register is zero (at least according to TRM), so
> it is enabled from boot. Also, I couldn't find any code from the u-boot
> that would touch this bit with a quick look.

ok, so it looks like we must do this anyway, thanks ;-)

--=20
balbi

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgAnwAAoJEIaOsuA1yqREaBYP/RCLsf4/yCsgyCHXH4IJ74DD
8Wl+5xX5BLRmRmzLEY91mTQvFOuMJ87P0ZW7sMFO3fO8A09U7WUypAISS782XKhF
4aqlUJmSWPtSZHZhxiep/Eo6gDZbn8waIthVMR8TM6bNtd8eL/G7Ka2l1NkhgQ0g
rRm1p7RL1/BibBXQbmwVhy7Q0K6O1+E7W6movVCLYpRro/iQEnASgKyWMSNnLUUA
opuokrH+YwKZ3s6sP0sGzGJqhgjIbV07DTBo1KXkUkewp8nSkZMgtYNbPWpScZcz
HLBVBduZqswaIqSyxUgneuouOJ1Ot5Vu2BUxJ4wbUUrDGEbEMHWDjoHF+mVpqjmP
WSSv1zzknrkmg+fy7UL7Wp2HUUV6wPjLLhz30ye+D1u6KCH0/aNhZbnBMGkj49cS
1SqjgcpkjxPakXvfVT7kgc0lRq6P70ABKZ7AoPFktxZOy35fnJQCuelE8epGKNUL
wo5MwZ+8UkqwISWJFvnA+270Y+iEjOjExbD03A4ur7QHMYWnEwD73EW5vR4XT+YY
H6Shhhzbsb0PAmhdY8CCnKJCo3qykozqSfy4d1EomZYw3X8MhwerQzG8vx3AuaG7
hRNEKcyhUsAe7RTkspnf+7f48nAWdLzIUIYK58M1EMzSEoNBAIacrJ67XVl4dNop
/tVNWexYjRbVqs5Mi8pu
=IeE9
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
