From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Wed, 5 Mar 2014 15:50:33 +0200
Message-ID: <53172BA9.2050901@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com> <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com> <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="npdK7aE9Olc3Lmqtx2hasq8CoOCpI6BC4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbaCENvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Mar 2014 08:51:03 -0500
In-Reply-To: <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

--npdK7aE9Olc3Lmqtx2hasq8CoOCpI6BC4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/02/14 21:30, Paul Walmsley wrote:
> On Wed, 19 Feb 2014, Paul Walmsley wrote:
>=20
>> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
>>
>>> This patch adds a simple method of rounding: during the iteration, th=
e=20
>>> code keeps track of the closest rate match. If no exact match is foun=
d,=20
>>> the closest is returned.
>>
>> So that's one possible rounding policy; maybe it works fine for a disp=
lay=20
>> interface PLL, at least for some values of "closest rate".  But anothe=
r=20
>> might be "only allow a selection from a set of pre-determined rates=20
>> characterized by the silicon validation team".  Or another rounding=20
>> function might need to select a more distant rate that minimizes jitte=
r,=20
>> EMI, or power consumption. =20
>=20
> Thought about this some more.  Do you only need this for the DSS PLL, o=
r=20
> do you need it for one of the core OMAP PLLs?
>=20
> If the former, then how about modifying your patch to create a separate=
=20
> round_rate function that's only used for the DSS PLL that implements th=
e=20
> behavior that you want?
>=20
> That would eliminate any risk of impacting other users on the system.  =
And=20
> would also allow this change to get into the codebase much faster, sinc=
e=20
> there's no need for clk API changes, etc.

How about this one:

=46rom f5a78303411e9192899a6a681acac37f09f4cc3b Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 15 Jan 2014 11:45:07 +0200
Subject: [PATCH] ARM: OMAP2+: fix dpll round_rate() to actually round

omap2_dpll_round_rate() doesn't actually round the given rate, even if
the name and the description so hints. Instead it only tries to find an
exact rate match, or if that fails, return ~0 as an error.

What this basically means is that the user of the clock needs to know
what rates the dpll can support, which obviously isn't right.

This patch adds a simple method of rounding: during the iteration, the
code keeps track of the closest rate match. If no exact match is found,
the closest is returned.

However, as it is unclear whether current drivers rely on the current
behavior, the rounding functionality not enabled by default, but by
setting DPLL_USE_ROUNDED_RATE for the DPLL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c | 23 ++++++++++++++++++-----
 drivers/clk/ti/dpll.c           |  3 +++
 include/linux/clk/ti.h          |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_d=
pll.c
index 2649ce445845..fed7538e1eed 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -298,6 +298,8 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigne=
d long target_rate,
 	struct dpll_data *dd;
 	unsigned long ref_rate;
 	const char *clk_name;
+	unsigned long diff, closest_diff =3D ~0;
+	bool use_rounding =3D clk->flags & DPLL_USE_ROUNDED_RATE;
=20
 	if (!clk || !clk->dpll_data)
 		return ~0;
@@ -345,20 +347,31 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsig=
ned long target_rate,
 		pr_debug("clock: %s: m =3D %d: n =3D %d: new_rate =3D %lu\n",
 			 clk_name, m, n, new_rate);
=20
-		if (target_rate =3D=3D new_rate) {
+		diff =3D max(target_rate, new_rate) - min(target_rate, new_rate);
+
+		if ((use_rounding && diff < closest_diff) ||
+			(!use_rounding && diff =3D=3D 0)) {
+			closest_diff =3D diff;
+
 			dd->last_rounded_m =3D m;
 			dd->last_rounded_n =3D n;
-			dd->last_rounded_rate =3D target_rate;
-			break;
+			dd->last_rounded_rate =3D new_rate;
+
+			if (diff =3D=3D 0)
+				break;
 		}
 	}
=20
-	if (target_rate !=3D new_rate) {
+	if (closest_diff =3D=3D ~0) {
 		pr_debug("clock: %s: cannot round to rate %lu\n",
 			 clk_name, target_rate);
 		return ~0;
 	}
=20
-	return target_rate;
+	if (closest_diff > 0)
+		pr_debug("clock: %s: rounded rate %lu to %lu\n",
+			 clk_name, target_rate, dd->last_rounded_rate);
+
+	return dd->last_rounded_rate;
 }
=20
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 7e498a44f97d..c5858c46b58c 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -265,6 +265,9 @@ static void __init of_ti_dpll_setup(struct device_nod=
e *node,
 	if (dpll_mode)
 		dd->modes =3D dpll_mode;
=20
+	if (of_property_read_bool(node, "ti,round-rate"))
+		clk_hw->flags |=3D DPLL_USE_ROUNDED_RATE;
+
 	ti_clk_register_dpll(&clk_hw->hw, node);
 	return;
=20
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 092b64168d7f..c9ed8b6b8513 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -155,6 +155,7 @@ struct clk_hw_omap {
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
 #define MEMMAP_ADDRESSING	(1 << 6)
+#define DPLL_USE_ROUNDED_RATE	(1 << 7)	/* dpll's round_rate() returns ro=
unded rate */
=20
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL *=
/
 #define DPLL_LOW_POWER_STOP	0x1
--=20
1.8.3.2




--npdK7aE9Olc3Lmqtx2hasq8CoOCpI6BC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFyupAAoJEPo9qoy8lh71UWcQAKW9Y9j+EERQt9W1L1MfUhkR
MpZoo/Cv12hRnlsdhrVYFpN9Mym2LhE8UD/tiologfDx5eZulK7cB8pWrksPl6bP
swY3ctv99e8uGyjV8qYoIisqNG3yAR4QVUTgO6SVbZN7YpEoiHQ2LvpxyMcvpi6/
sGNh8cVGJ8nj1dKlleG6+1KnFzBO7CyUvIFmOrpxqXtF303f+lTPIetb8im2N2G0
sX7ynq3O8A3f4jva7sehXJ9l3Y8DCnitARES1QMrSjysdi61jNG89NCLgIGCpAUk
/4UEsD+50jX30W8vcEHpfy1acx1gvLTwVr7H7sLbmydCf45lnN+CcxTVP1WD5taH
ormlQ/uD5ttQ/++HP381HgCUHXl5TPBM3quzYdo7/bsTC97r/iCcgfJ1myGEXc3M
ect3tZKq1r/1qhTyLnrJAp4jkpbG/cp/t2+1bTLOxTjb/5vjIz+p118kaBnnivJP
PjOwLuoI2xG/VYJ7Tth5eIcz43/4Rlg4QwImdJIeFHiXzLsWqF8O7aGelP69O73K
S73nlv7zkMIz4ihm7ktIEmVioukpwszAXHeEUyE5fVcjPG17EW8CQJQCCKtcKySY
3NAY9ftl4fwgn2Qv9SYm8hae1lNjtojeUsS16wbFJ5kyIUrgBZ+X9tT3CIoPOI8d
J6B3DHJ3sy84wuMrtvTE
=9aif
-----END PGP SIGNATURE-----

--npdK7aE9Olc3Lmqtx2hasq8CoOCpI6BC4--
