From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/8] ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
Date: Thu, 13 Feb 2014 12:45:19 +0200
Message-ID: <52FCA23F.6090003@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com> <1392285846-13199-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DMVvATOWwaUOLhpGm6CvRuetFsaQo5mvF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58519 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaBMKpo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 05:45:44 -0500
In-Reply-To: <1392285846-13199-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

--DMVvATOWwaUOLhpGm6CvRuetFsaQo5mvF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 12:04, Tomi Valkeinen wrote:
> If CLK_SET_RATE_PARENT is set for a clkoutx2 clock, calling
> clk_set_rate() on the clock "skips" the x2 multiplier as there are no
> set_rate and round_rate functions defined for the clkoutx2.
>=20
> This results in getting double the requested clock rates, breaking the
> display on omap3430 based devices.
>=20
> This patch implements set_rate and round_rate for clkoutx2.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c |  2 ++
>  arch/arm/mach-omap2/dpll3xxx.c        | 62 +++++++++++++++++++++++++++=
++++++++
>  include/linux/clk/ti.h                |  4 +++
>  3 files changed, 68 insertions(+)

Argh. This patch 3/8 was an old version, and not valid. It does not work =
for
omap3430. I had earlier posted a proper version, but somehow I managed to=
 get
an old version for this series.

The correct version can be found from

http://mid.gmane.org/1391080640-23370-1-git-send-email-tomi.valkeinen@ti.=
com

and I'll also include it below.

 Tomi

=46rom 0d46054a8b33bc1f7a37bc9b17dd1631b1a06047 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 Jan 2014 13:17:20 +0200
Subject: [PATCH] ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PAREN=
T

If CLK_SET_RATE_PARENT is set for a clkoutx2 clock, calling
clk_set_rate() on the clock "skips" the x2 multiplier as there are no
set_rate and round_rate functions defined for the clkoutx2.

This results in getting double the requested clock rates, breaking the
display on omap3430 based devices. This got broken when
d0f58bd3bba3877fb1af4664c4e33273d36f00e4 and related patches were merged
for v3.14, as omapdss driver now relies more on the clk-framework and
CLK_SET_RATE_PARENT.

This patch implements set_rate and round_rate for clkoutx2.

Tested on OMAP3430, OMAP3630, OMAP4460.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |  2 +
 arch/arm/mach-omap2/dpll3xxx.c        | 92 +++++++++++++++++++++++++++++=
------
 include/linux/clk/ti.h                |  4 ++
 3 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/=
cclock3xxx_data.c
index 3b05aea56d1f..11ed9152e665 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -433,7 +433,9 @@ static const struct clk_ops dpll4_m5x2_ck_ops =3D {
 	.enable		=3D &omap2_dflt_clk_enable,
 	.disable	=3D &omap2_dflt_clk_disable,
 	.is_enabled	=3D &omap2_dflt_clk_is_enabled,
+	.set_rate	=3D &omap3_clkoutx2_set_rate,
 	.recalc_rate	=3D &omap3_clkoutx2_recalc,
+	.round_rate	=3D &omap3_clkoutx2_round_rate,
 };
=20
 static const struct clk_ops dpll4_m5x2_ck_3630_ops =3D {
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xx=
x.c
index 3185ced807c9..3c418ea54bbe 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -623,6 +623,32 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
=20
 /* Clock control for DPLL outputs */
=20
+/* Find the parent DPLL for the given clkoutx2 clock */
+static struct clk_hw_omap *omap3_find_clkoutx2_dpll(struct clk_hw *hw)
+{
+	struct clk_hw_omap *pclk =3D NULL;
+	struct clk *parent;
+
+	/* Walk up the parents of clk, looking for a DPLL */
+	do {
+		do {
+			parent =3D __clk_get_parent(hw->clk);
+			hw =3D __clk_get_hw(parent);
+		} while (hw && (__clk_get_flags(hw->clk) & CLK_IS_BASIC));
+		if (!hw)
+			break;
+		pclk =3D to_clk_hw_omap(hw);
+	} while (pclk && !pclk->dpll_data);
+
+	/* clk does not have a DPLL as a parent?  error in the clock data */
+	if (!pclk) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	return pclk;
+}
+
 /**
  * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock rate=

  * @clk: DPLL output struct clk
@@ -637,27 +663,14 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *=
hw,
 	unsigned long rate;
 	u32 v;
 	struct clk_hw_omap *pclk =3D NULL;
-	struct clk *parent;
=20
 	if (!parent_rate)
 		return 0;
=20
-	/* Walk up the parents of clk, looking for a DPLL */
-	do {
-		do {
-			parent =3D __clk_get_parent(hw->clk);
-			hw =3D __clk_get_hw(parent);
-		} while (hw && (__clk_get_flags(hw->clk) & CLK_IS_BASIC));
-		if (!hw)
-			break;
-		pclk =3D to_clk_hw_omap(hw);
-	} while (pclk && !pclk->dpll_data);
+	pclk =3D omap3_find_clkoutx2_dpll(hw);
=20
-	/* clk does not have a DPLL as a parent?  error in the clock data */
-	if (!pclk) {
-		WARN_ON(1);
+	if (!pclk)
 		return 0;
-	}
=20
 	dd =3D pclk->dpll_data;
=20
@@ -672,6 +685,55 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *h=
w,
 	return rate;
 }
=20
+int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	return 0;
+}
+
+long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate)
+{
+	const struct dpll_data *dd;
+	u32 v;
+	struct clk_hw_omap *pclk =3D NULL;
+
+	if (!*prate)
+		return 0;
+
+	pclk =3D omap3_find_clkoutx2_dpll(hw);
+
+	if (!pclk)
+		return 0;
+
+	dd =3D pclk->dpll_data;
+
+	/* TYPE J does not have a clkoutx2 */
+	if (dd->flags & DPLL_J_TYPE) {
+		*prate =3D __clk_round_rate(__clk_get_parent(pclk->hw.clk), rate);
+		return *prate;
+	}
+
+	WARN_ON(!dd->enable_mask);
+
+	v =3D omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
+	v >>=3D __ffs(dd->enable_mask);
+
+	/* If in bypass, the rate is fixed to the bypass rate*/
+	if (v !=3D OMAP3XXX_EN_DPLL_LOCKED)
+		return *prate;
+
+	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
+		unsigned long best_parent;
+
+		best_parent =3D (rate / 2);
+		*prate =3D __clk_round_rate(__clk_get_parent(hw->clk),
+				best_parent);
+	}
+
+	return *prate * 2;
+}
+
 /* OMAP3/4 non-CORE DPLL clkops */
 const struct clk_hw_omap_ops clkhwops_omap3_dpll =3D {
 	.allow_idle	=3D omap3_dpll_allow_idle,
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 092b64168d7f..4a21a872dbbd 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -245,6 +245,10 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsign=
ed long target_rate,
 void omap2_init_clk_clkdm(struct clk_hw *clk);
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
+int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate);
+long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
--=20
1.8.3.2




--DMVvATOWwaUOLhpGm6CvRuetFsaQo5mvF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/KI/AAoJEPo9qoy8lh71YKoP/082DCCTWCg1NOZ5OkfPSvYb
nnxygQGh7Ds/98R+LvOL1c7ln24A9UXiQpAlxOyPEHCckrwVqpPBRvPc3oxi1FjJ
LZKCDku3W6KscvM2skw1/B9SJZjCMroDH26rZVIcy7BjSN0Nk7STPqqatw97h3e1
A5N6RLxBC7k/XgcI8vxYwLYer7G2NpHEN+P/6J36f5F4MHfvQt+SXGPvhFCXO7iu
kwqCm9dJRKDXVw2yTBEfJN98ej+NfiiUFlSWk1tB909icEsoNtsHxIMQ6k1l3D5m
TuLUiz929yi9YckZRizxbGHg57Ce5314jI4omE0K45YhAfsDequTicifxSL0cfS1
uUzUn8A2mvvWDPD4de89euH7XolbATn0sYSKxRSj7Zu47xG8Am9LLrlkoR39JEKy
APaUYOQ62VdApLWsHO1WU2dvSPfC1Zq+LcVDwDVurwZfcWJMt8XsN78JVpTpK7C6
lrae6SB8jnoiVE99LXEXYbu5/kylifgp5wPXnidnUGN0rprt80cJQ/8FOwHj8gsV
xWc7JQ8pm8qkKB74TRrdL1ZX2BjIbQHKUzd6d5HHMOhZTaUJ7+Yr5HJ85Q4q+VFO
8byaPCBZtiLXLBet5lBFcw4ByE10GEoemSkN6t2zzWPDvZWmTALGx3gq7z0/a8oA
eG+wseZHEQYTHC3KDzyR
=PtlH
-----END PGP SIGNATURE-----

--DMVvATOWwaUOLhpGm6CvRuetFsaQo5mvF--
