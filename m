From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 27 Jan 2015 10:01:43 -0600
Message-ID: <20150127160143.GH14623@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
 <20150126165640.GA10679@saruman.tx.rr.com>
 <20150126194933.GG6660@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44422 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbbA0QCP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 11:02:15 -0500
Content-Disposition: inline
In-Reply-To: <20150126194933.GG6660@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> Hi,
>=20
> On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > > the references below are from SPRUHL7
> > >=20
> > > On Fri, 23 Jan 2015, Felipe Balbi wrote:
> > >=20
> > > > Without hwmod data for DebugSS, performance monitors
> > > > have no chance of running on AM43xx devices.
> > > >=20
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 ++++++++++++++++++=
++++++++++++
> > > >  arch/arm/mach-omap2/prcm43xx.h             |  1 +
> > > >  2 files changed, 41 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/=
mach-omap2/omap_hwmod_43xx_data.c
> > > > index 5c6c8410160e..6709704dd5b5 100644
> > > > --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > > > +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include "omap_hwmod.h"
> > > >  #include "omap_hwmod_33xx_43xx_common_data.h"
> > > >  #include "prcm43xx.h"
> > > > +#include "prm44xx.h"
> > > >  #include "omap_hwmod_common_data.h"
> > > > =20
> > > > =20
> > > > @@ -60,6 +61,44 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod =
=3D {
> > > >  	.rst_lines_cnt	=3D ARRAY_SIZE(am33xx_wkup_m3_resets),
> > > >  };
> > > > =20
> > > > +/*
> > > > + * 'debugss' class
> > > > + * debug and emulation sub system
> > > > + */
> > > > +static struct omap_hwmod_opt_clk am43xx_debugss_opt_clks[] =3D {
> > > > +	{ .role =3D "dbg_sysclk", .clk =3D "dbg_sysclk_ck" },
> > > > +	{ .role =3D "dbg_clka", .clk =3D "dbg_clka_ck", },
> > > > +	{ .role =3D "dbg_clkb", .clk =3D "dbg_clkb_ck", },
> > > > +	{ .role =3D "dbg_clkc", .clk =3D "dbg_clkc_ck", },
> > > > +};
> > > > +
> > > > +static struct omap_hwmod_class am43xx_debugss_hwmod_class =3D {
> > > > +	.name	=3D "debugss",
> > > > +};
> > > > +
> > > > +/* debugss */
> > > > +static struct omap_hwmod am43xx_debugss_hwmod =3D {
> > > > +	.name		=3D "debugss",
> > > > +	.class		=3D &am43xx_debugss_hwmod_class,
> > > > +	.clkdm_name	=3D "l3_aon_clkdm",
> > > > +	.main_clk	=3D "trace_clk_div_ck",
> > > > +	.prcm =3D {
> > > > +		.omap4 =3D {
> > > > +			.clkctrl_offs =3D AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET,
> > >=20
> > > According to Table 6-275 "PRCM_CM_WKUP_DBGSS_CLKCTRL Register Field=
=20
> > > Descriptions" this should have a=20
> > >=20
> > > 			.modulemode   =3D MODULEMODE_SWCTRL,
> >=20
> > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?
>=20
> gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> read as 0x 12510f00 which would translate into:
>=20
> - module disabled
> - all opt clocks are on
> - module is transitioning
> - module in standby
> - clkA as TPIU and STM trace clock
> - all dividers set to 2

just fyi, checking with HW folks, this might be a new bug, unless
debugss needs something special.

--=20
balbi

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUx7ZnAAoJEIaOsuA1yqREy58P/07F6GxEmgFcLT1+RfA21u5z
Z9/LNNerNP79pJWStyuJc1N1++h4cimpKXr3AJoJvJoEXniWMhdoqzNSDB3XDfFw
/ycMn7aeuPnxx1x0atBm5K8t+AW1qmTNDFFMljuPprw7w85tjJAc9VOUSm+piZHf
CU4mHuFZafQyZKV09jwz+NITLwMRIVk4pZqmFUKkzn7KMZz4sOzq2TcS4su0GVOw
PSIjhM/q9xPZX6Lz8vEPUxqw9+0jj3EV+Go+RFWAsEZPJ9bf6Q2r09tClmj2gooC
qxsuREHNS6IBGqq51ZMvcg3TbVok4GcQ3K2XhQJGwEHanxW/gYkd5nLe0R0jiqxE
4vCxhvmq79IVdzK7RDT2+IAmkA9e9oZfyzL5hl/dujHnfgVP6jYN1TQOEjkYHrqW
ESAxMcTrYcNHWbYicVsLdU7V7ZYGAa0zyyDkNR3im9/ZZoflseL0OnKzXy8IrBqt
s1f7Mzle86qmKIaA5QAryxiy0sgEvqSwwEC+tUwgs9x7guriOfEnZzgqJhtDTe3H
kU+85hxSygPecBeCXFrPvbXQIrQAZmSZ0m5KKSaKZmeDZ0GRXj+5zp4G+GWvXR3q
c+8AiE0AZY2Z81myFgf2u+Bh9P86Zsk6YyzlacbEckfFEZK+bxRvO5y7Z2egL2KQ
ICORiXc+vKQ5//muc5Tb
=mit0
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--
