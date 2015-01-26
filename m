From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Mon, 26 Jan 2015 10:56:40 -0600
Message-ID: <20150126165640.GA10679@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501260142590.5450-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 26, 2015 at 02:04:35AM +0000, Paul Walmsley wrote:
> Hi
>=20
> the references below are from SPRUHL7
>=20
> On Fri, 23 Jan 2015, Felipe Balbi wrote:
>=20
> > Without hwmod data for DebugSS, performance monitors
> > have no chance of running on AM43xx devices.
> >=20
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 ++++++++++++++++++++++=
++++++++
> >  arch/arm/mach-omap2/prcm43xx.h             |  1 +
> >  2 files changed, 41 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_43xx_data.c
> > index 5c6c8410160e..6709704dd5b5 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > @@ -19,6 +19,7 @@
> >  #include "omap_hwmod.h"
> >  #include "omap_hwmod_33xx_43xx_common_data.h"
> >  #include "prcm43xx.h"
> > +#include "prm44xx.h"
> >  #include "omap_hwmod_common_data.h"
> > =20
> > =20
> > @@ -60,6 +61,44 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod =3D {
> >  	.rst_lines_cnt	=3D ARRAY_SIZE(am33xx_wkup_m3_resets),
> >  };
> > =20
> > +/*
> > + * 'debugss' class
> > + * debug and emulation sub system
> > + */
> > +static struct omap_hwmod_opt_clk am43xx_debugss_opt_clks[] =3D {
> > +	{ .role =3D "dbg_sysclk", .clk =3D "dbg_sysclk_ck" },
> > +	{ .role =3D "dbg_clka", .clk =3D "dbg_clka_ck", },
> > +	{ .role =3D "dbg_clkb", .clk =3D "dbg_clkb_ck", },
> > +	{ .role =3D "dbg_clkc", .clk =3D "dbg_clkc_ck", },
> > +};
> > +
> > +static struct omap_hwmod_class am43xx_debugss_hwmod_class =3D {
> > +	.name	=3D "debugss",
> > +};
> > +
> > +/* debugss */
> > +static struct omap_hwmod am43xx_debugss_hwmod =3D {
> > +	.name		=3D "debugss",
> > +	.class		=3D &am43xx_debugss_hwmod_class,
> > +	.clkdm_name	=3D "l3_aon_clkdm",
> > +	.main_clk	=3D "trace_clk_div_ck",
> > +	.prcm =3D {
> > +		.omap4 =3D {
> > +			.clkctrl_offs =3D AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET,
>=20
> According to Table 6-275 "PRCM_CM_WKUP_DBGSS_CLKCTRL Register Field=20
> Descriptions" this should have a=20
>=20
> 			.modulemode   =3D MODULEMODE_SWCTRL,

hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?

> > +		},
> > +	},
> > +	.opt_clks	=3D am43xx_debugss_opt_clks,
> > +	.opt_clks_cnt	=3D ARRAY_SIZE(am43xx_debugss_opt_clks),
> > +};
> > +
> > +/* debugss -> l3_main_2 */
> > +static struct omap_hwmod_ocp_if am43xx_debugss__l3_main =3D {
> > +	.master		=3D &am43xx_debugss_hwmod,
> > +	.slave		=3D &am33xx_l3_main_hwmod,
> > +	.clk		=3D "sys_clkin_ck",
> > +	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
> > +};
> > +
>=20
> According to Table 31-25 "Debug Modules Memory Mapping" there are a few=
=20
> initiator ports on the DEBUGSS that are connected to various slave ports=
=20
> on various chip-wide interconnects: L3_EMU, L4_PER, L4_WAKEUP, L4_CFG. I=
=20
> would suggest starting by adding at least one of them as a struct=20
> omap_hwmod_ocp_if record.  The one attached to L3_EMU would seem like a=
=20
> good one to start with.

I'll have a look.

--=20
balbi

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxnHIAAoJEIaOsuA1yqREN1cP/1ApHef0WlIogWA8DkBDb77q
f1k47sCqynL/a3+T3gS63FDRl1+tClsyMw2RNdfRN/BnLxIPZ83iJaukLy/9zdaK
dQmVLDjUskloWke/5L36RIGlpN/NM+KeLmtJGEPBy++9s0mbWfzwuAVo8JZbvgMS
V4+5I8NBJzgpJsDUf115Jkqqnq6DCf+fRssWZ99nYxyi/vFYtXIUcC2tuYtexZpR
bG/frA/CCDy8CT/9o/6jMfceLNavziPqPrb0GiExQBYLYpJ3lvJEyvo8i0V5QSV0
/fO/i/R84ui3fP6r1hrvAtZq4BT0n+EIT02Kzuxmz/CIc+v6DiPM567SKL4Lz+CM
TrOPd4Cc7v2ZdMfJYO9OAyU+DaFdWxehx/BwOOzytHJxDIBdYddsEmJpKwgKGsII
ZRl48jTtaYfBupZoZ7iXEOv7MEM8VjeSQTzk+JdFJc5Lebw9k7krp2evuqSe0azx
OvLi1lX5nihOW6c1PM+Aw/jsD8wyK5GhFpGv0ujXRYTvtLSiolmtHadeCfS8Z/35
sbKv7D1D6dRfeL0C2P32hSM6Z9vmf2iUlhj2YBY1tSxXuCc+D24hP+Hw4mZLuEqX
3bxnlw2v+3m9OH6eQohxq/O60HqOtXvXmNL10eBdesIjehPzfbJ08q2oCeL0qkt5
Jkhw+eNtwweQZJ5opr9D
=UdhI
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
