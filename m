From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv9 8/8] ARM: OMAP4: USB: power down MUSB PHY if not used
Date: Thu, 18 Oct 2012 17:41:44 +0300
Message-ID: <20121018144144.GF2739@arwen.pp.htv.fi>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-9-git-send-email-t-kristo@ti.com>
 <20121018103334.GA1449@arwen.pp.htv.fi>
 <1350562684.2143.52.camel@sokoban>
 <20121018135352.GC2739@arwen.pp.htv.fi>
 <1350571199.2143.53.camel@sokoban>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56822 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab2JROrT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 10:47:19 -0400
Content-Disposition: inline
In-Reply-To: <1350571199.2143.53.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>

--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2012 at 05:39:59PM +0300, Tero Kristo wrote:
> On Thu, 2012-10-18 at 16:53 +0300, Felipe Balbi wrote:
> > hi,
> >=20
> > On Thu, Oct 18, 2012 at 03:18:04PM +0300, Tero Kristo wrote:
> > > > > +static int __init omap4430_phy_power_down(void)
> > > > > +{
> > > > > +	void __iomem *ctrl_base;
> > > > > +
> > > > > +	if (!cpu_is_omap44xx())
> > > > > +		return 0;
> > > > > +
> > > > > +	ctrl_base =3D ioremap(OMAP443X_SCM_BASE, SZ_1K);
> > > > > +	if (!ctrl_base) {
> > > > > +		pr_err("control module ioremap failed\n");
> > > > > +		return -ENOMEM;
> > > > > +	}
> > > > > +
> > > > > +	/* Power down the phy */
> > > > > +	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
> > > > > +
> > > > > +	iounmap(ctrl_base);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +early_initcall(omap4430_phy_power_down);
> > > > > +#endif
> > > >=20
> > > > I think you could do it even if the driver is enabled.
> > >=20
> > > Actually not at least now, it looks like the driver is not controlling
> > > this bit at all, so the driver would fail if we do this.
> >=20
> > then we can consider that a bug in the driver. Kishon, I thought you had
> > added SCM address space to PHY driver for this particular reason until
> > we get SCM driver, wasn't it ??
>=20
> Yes, I would say its a bug in the driver. However we need this disable
> mechanism for the case where we don't have the driver also (which is the
> default config for omap.)

sure, of course. But I'd like to see it unconditionally done, meaning
that there needs to be a counterpart in the driver to make sure you can
run this unconditionally during early phases of boot up ;-)

--=20
balbi

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQgBUoAAoJEIaOsuA1yqRE3wwP/0R5HPX0hRieFJ4EiyQH6+V3
2MgI7401DJim0FrBF1niZiWdL4Gk8rOi9lozJqnYf5z5Sra98hsgo1E96/6SyITd
pu6rxoBQNq+5YGNfIa5AwDJaeSUSMp9LdvLWT8qrUfwdAtSVdEzvdFPdph/eRBwd
fyN4RnbO/bO9ZxlJdHN3oqySYOakc84SPIHHF9VATtsLNbILzreV7YZUjJOUzTFr
WLtvIwo79trnm+in8Qd6ssP4gY5MERZxHr3tSu8/x4VThtrOpWJWrvw9phLnqTFj
XnDohxH5hScMSAuOrhzhYaKBSmDtz+FLpwYSx2g1FCoh1r1KzBugsSffpSOA41fR
LwwcNfXvuZHVXponoxFZGjwc07pAssDY7PLkK8AKzgbuopw2VgAl9cSKloRZd0Vc
ynkhFOdvC2yyM7Jx2N/K9nPBHcBJ31w0FYd7a3K+2zC7YN4ybM0B7SxGOXdTomfo
3FJ0Od0nClsRYLZal4d5GWHY3524XrBE93feuG+c+K4mCsIoSvgAx/0sh+tbEY9M
rEqsxNi4kUVn6VM0cvOvsSL453nwTjE7g8W2vldD7HtOFQzmzVi2/3X7DQScoRUQ
BAIAgFfEzP2XB4ysfw2WDZSCcRdg22/WmJubZ+ng2Ia/VRnqf+67x04YKuYNrPkh
+5Bw8PYS2rJFtMkKGxkI
=iSpB
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
