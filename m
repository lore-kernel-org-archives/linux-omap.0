From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Wed, 30 Apr 2014 10:38:53 -0500
Message-ID: <20140430153853.GB23679@saruman.home>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
 <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
 <53172BA9.2050901@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35202 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758922AbaD3Pj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2014 11:39:29 -0400
Content-Disposition: inline
In-Reply-To: <53172BA9.2050901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Andrew Morton <akpm@linux-foundation.org>

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mike/Paul,

(sorry for top-posting)

any comments here, what do we do ? Do we split this patch ? Use v1 ? Use
v2 ?

cheers

On Wed, Mar 05, 2014 at 03:50:33PM +0200, Tomi Valkeinen wrote:
> On 20/02/14 21:30, Paul Walmsley wrote:
> > On Wed, 19 Feb 2014, Paul Walmsley wrote:
> >=20
> >> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
> >>
> >>> This patch adds a simple method of rounding: during the iteration, th=
e=20
> >>> code keeps track of the closest rate match. If no exact match is foun=
d,=20
> >>> the closest is returned.
> >>
> >> So that's one possible rounding policy; maybe it works fine for a disp=
lay=20
> >> interface PLL, at least for some values of "closest rate".  But anothe=
r=20
> >> might be "only allow a selection from a set of pre-determined rates=20
> >> characterized by the silicon validation team".  Or another rounding=20
> >> function might need to select a more distant rate that minimizes jitte=
r,=20
> >> EMI, or power consumption. =20
> >=20
> > Thought about this some more.  Do you only need this for the DSS PLL, o=
r=20
> > do you need it for one of the core OMAP PLLs?
> >=20
> > If the former, then how about modifying your patch to create a separate=
=20
> > round_rate function that's only used for the DSS PLL that implements th=
e=20
> > behavior that you want?
> >=20
> > That would eliminate any risk of impacting other users on the system.  =
And=20
> > would also allow this change to get into the codebase much faster, sinc=
e=20
> > there's no need for clk API changes, etc.
>=20
> How about this one:
>=20
> From f5a78303411e9192899a6a681acac37f09f4cc3b Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Wed, 15 Jan 2014 11:45:07 +0200
> Subject: [PATCH] ARM: OMAP2+: fix dpll round_rate() to actually round
>=20
> omap2_dpll_round_rate() doesn't actually round the given rate, even if
> the name and the description so hints. Instead it only tries to find an
> exact rate match, or if that fails, return ~0 as an error.
>=20
> What this basically means is that the user of the clock needs to know
> what rates the dpll can support, which obviously isn't right.
>=20
> This patch adds a simple method of rounding: during the iteration, the
> code keeps track of the closest rate match. If no exact match is found,
> the closest is returned.
>=20
> However, as it is unclear whether current drivers rely on the current
> behavior, the rounding functionality not enabled by default, but by
> setting DPLL_USE_ROUNDED_RATE for the DPLL.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/clkt_dpll.c | 23 ++++++++++++++++++-----
>  drivers/clk/ti/dpll.c           |  3 +++
>  include/linux/clk/ti.h          |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_d=
pll.c
> index 2649ce445845..fed7538e1eed 100644
> --- a/arch/arm/mach-omap2/clkt_dpll.c
> +++ b/arch/arm/mach-omap2/clkt_dpll.c
> @@ -298,6 +298,8 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigne=
d long target_rate,
>  	struct dpll_data *dd;
>  	unsigned long ref_rate;
>  	const char *clk_name;
> +	unsigned long diff, closest_diff =3D ~0;
> +	bool use_rounding =3D clk->flags & DPLL_USE_ROUNDED_RATE;
> =20
>  	if (!clk || !clk->dpll_data)
>  		return ~0;
> @@ -345,20 +347,31 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsig=
ned long target_rate,
>  		pr_debug("clock: %s: m =3D %d: n =3D %d: new_rate =3D %lu\n",
>  			 clk_name, m, n, new_rate);
> =20
> -		if (target_rate =3D=3D new_rate) {
> +		diff =3D max(target_rate, new_rate) - min(target_rate, new_rate);
> +
> +		if ((use_rounding && diff < closest_diff) ||
> +			(!use_rounding && diff =3D=3D 0)) {
> +			closest_diff =3D diff;
> +
>  			dd->last_rounded_m =3D m;
>  			dd->last_rounded_n =3D n;
> -			dd->last_rounded_rate =3D target_rate;
> -			break;
> +			dd->last_rounded_rate =3D new_rate;
> +
> +			if (diff =3D=3D 0)
> +				break;
>  		}
>  	}
> =20
> -	if (target_rate !=3D new_rate) {
> +	if (closest_diff =3D=3D ~0) {
>  		pr_debug("clock: %s: cannot round to rate %lu\n",
>  			 clk_name, target_rate);
>  		return ~0;
>  	}
> =20
> -	return target_rate;
> +	if (closest_diff > 0)
> +		pr_debug("clock: %s: rounded rate %lu to %lu\n",
> +			 clk_name, target_rate, dd->last_rounded_rate);
> +
> +	return dd->last_rounded_rate;
>  }
> =20
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index 7e498a44f97d..c5858c46b58c 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -265,6 +265,9 @@ static void __init of_ti_dpll_setup(struct device_nod=
e *node,
>  	if (dpll_mode)
>  		dd->modes =3D dpll_mode;
> =20
> +	if (of_property_read_bool(node, "ti,round-rate"))
> +		clk_hw->flags |=3D DPLL_USE_ROUNDED_RATE;
> +
>  	ti_clk_register_dpll(&clk_hw->hw, node);
>  	return;
> =20
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index 092b64168d7f..c9ed8b6b8513 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -155,6 +155,7 @@ struct clk_hw_omap {
>  #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
>  #define CLOCK_CLKOUTX2		(1 << 5)
>  #define MEMMAP_ADDRESSING	(1 << 6)
> +#define DPLL_USE_ROUNDED_RATE	(1 << 7)	/* dpll's round_rate() returns ro=
unded rate */
> =20
>  /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
>  #define DPLL_LOW_POWER_STOP	0x1
> --=20
> 1.8.3.2
>=20
>=20
>=20



--=20
balbi

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYRkNAAoJEIaOsuA1yqREZ50QAIViaVALi8Lq19keeCx3+NSJ
qSdC333B4pb8Vc/gR7OWx4LxrBXBGp6kZDfuAzBou+/NZgjREXYCbNZiLGQ9S15h
OJ2F1YRmwWtXmr5UW5E8UOBv97EKWPS5BsJn/SxnRV+YDvQjh4cOX8fiYvfuSrdL
pllQbgwaJemX1CoaaSMdlJjdQLdCqHlG6Zn7lPTWhTPnpWgPI6mE4OLF3QntIGXi
wYANadkRZaym9viW+3vNmEuHU1xyFxv+of8XnY3RsVkcao+SR754jkL56J2UrFgr
ymqtAUmkoulsiBJhJUaCRlWu9EZ7qH4rMT5nOFjfU+vGdI0oPqgxhD3YeO5N5X9u
jz6Xj38yvVCEsfuIujTJxRPP7GQCSETdLzU5Ytv+3JItTMGpolf6DKg/SMu076gl
eyqgHI3HXE1XjH2a95slmhuXR7enOaWnWHGLEG+B/6k+KGTV2KV82CvMhoPgB1El
oqNB7m2Zwwmhsci5/fhYrpB+cey0JFGRlBauFrNV8LTmYWp/RD/BkD7f4WJ3vwtG
U3jUWxhOjIKNtxf9hG4lwkxhFbtPDAnfO9AycBLMJwkAbnD0yHYZ8yV22dJfwAqo
tltBocHQVnPgkTlIKg+j9extt6vIsiIkWipMvptzSbqqI7DHikd4Wmerm5gIk4QP
cAwaUZ1PnUtJIMk+Dj3W
=w4EQ
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
