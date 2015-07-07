From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
Date: Tue,  7 Jul 2015 20:48:08 +0200
Message-ID: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Ralf Baechle <ralf@linux-mips.org>, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>, Maxime Ripard <maxime.ripard@free-electrons.com>, Tero Kristo <t-kristo@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Clock rates are stored in an unsigned long field, but ->determine_rate(=
)
(which returns a rounded rate from a requested one) returns a long
value (errors are reported using negative error codes), which can lead
to long overflow if the clock rate exceed 2Ghz.

Change ->determine_rate() prototype to return 0 or an error code, and p=
ass
a pointer to a clk_rate_request structure containing the expected targe=
t
rate and the rate constraints imposed by clk users.

The clk_rate_request structure might be extended in the future to conta=
in
other kind of constraints like the rounding policy, the maximum clock
inaccuracy or other things that are not yet supported by the CCF
(power consumption constraints ?).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

CC: Jonathan Corbet <corbet@lwn.net>
CC: Tony Lindgren <tony@atomide.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: "Emilio L=C3=B3pez" <emilio@elopez.com.ar>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Tero Kristo <t-kristo@ti.com>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
CC: Prashant Gaikwad <pgaikwad@nvidia.com>
CC: Stephen Warren <swarren@wwwdotorg.org>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Alexandre Courbot <gnurou@gmail.com>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-omap@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: linux-tegra@vger.kernel.org

---

changes since v4:
- remove useless tests in omap drivers
- remove useless parent assignment in the hi-3620 driver
- fix a compilation error in the clk-mix driver
- fix a compilation error in the alchemy clk driver
- fix a wrong return code in the qcom pll driver

changes since v3:
- modify clk-emc driver to match the new prototype
- fix __clk_round_rate negative error code return
- remove unused variable in clk-hi3620.c
- rebased on 4.2-rc1

Changes since v2:
- drop the ->round_rate() prototype changes
- introduce a clk_rate_request struct to avoid any changes on the proto=
type
  in the future

Changes since v1:
- fix an 'uninitialized variable' bug reported by Heiko
- rebased on clk-next
---
 Documentation/clk.txt               |   8 +-
 arch/arm/mach-omap2/dpll3xxx.c      |  29 +++---
 arch/arm/mach-omap2/dpll44xx.c      |  30 +++---
 arch/mips/alchemy/common/clock.c    |  61 +++++--------
 drivers/clk/at91/clk-programmable.c |  25 ++---
 drivers/clk/at91/clk-usb.c          |  28 +++---
 drivers/clk/bcm/clk-kona.c          |  34 ++++---
 drivers/clk/clk-composite.c         |  48 +++++-----
 drivers/clk/clk.c                   | 176 ++++++++++++++++++++--------=
--------
 drivers/clk/hisilicon/clk-hi3620.c  |  39 ++++----
 drivers/clk/mmp/clk-mix.c           |  20 ++--
 drivers/clk/qcom/clk-pll.c          |  18 ++--
 drivers/clk/qcom/clk-rcg.c          |  44 ++++-----
 drivers/clk/qcom/clk-rcg2.c         |  78 ++++++++--------
 drivers/clk/sunxi/clk-factors.c     |  21 ++---
 drivers/clk/sunxi/clk-sun6i-ar100.c |  21 ++---
 drivers/clk/sunxi/clk-sunxi.c       |  20 ++--
 drivers/clk/tegra/clk-emc.c         |  28 +++---
 include/linux/clk-provider.h        |  49 ++++++----
 include/linux/clk/ti.h              |  16 +---
 20 files changed, 393 insertions(+), 400 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index f463bdc..5c4bc4d 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -71,12 +71,8 @@ the operations defined in clk.h:
 		long		(*round_rate)(struct clk_hw *hw,
 						unsigned long rate,
 						unsigned long *parent_rate);
-		long		(*determine_rate)(struct clk_hw *hw,
-						unsigned long rate,
-						unsigned long min_rate,
-						unsigned long max_rate,
-						unsigned long *best_parent_rate,
-						struct clk_hw **best_parent_clk);
+		int		(*determine_rate)(struct clk_hw *hw,
+						  struct clk_rate_request *req);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw,
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3=
xxx.c
index 44e57ec..8c57ace 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -462,43 +462,38 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw=
)
 /**
  * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
  * @hw: pointer to the clock to determine rate for
- * @rate: target rate for the DPLL
- * @best_parent_rate: pointer for returning best parent rate
- * @best_parent_clk: pointer for returning best parent clock
+ * @req: target rate request
  *
  * Determines which DPLL mode to use for reaching a desired target rat=
e.
  * Checks whether the DPLL shall be in bypass or locked mode, and if
  * locked, calculates the M,N values for the DPLL via round-rate.
- * Returns a positive clock rate with success, negative error value
- * in failure.
+ * Returns a 0 on success, negative error value in failure.
  */
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk)
+int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
 	struct dpll_data *dd;
=20
-	if (!hw || !rate)
+	if (!req->rate)
 		return -EINVAL;
=20
 	dd =3D clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
=20
-	if (__clk_get_rate(dd->clk_bypass) =3D=3D rate &&
+	if (__clk_get_rate(dd->clk_bypass) =3D=3D req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
+		req->best_parent_hw =3D __clk_get_hw(dd->clk_bypass);
 	} else {
-		rate =3D omap2_dpll_round_rate(hw, rate, best_parent_rate);
-		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
+		req->rate =3D omap2_dpll_round_rate(hw, req->rate,
+					  &req->best_parent_rate);
+		req->best_parent_hw =3D __clk_get_hw(dd->clk_ref);
 	}
=20
-	*best_parent_rate =3D rate;
+	req->best_parent_rate =3D req->rate;
=20
-	return rate;
+	return 0;
 }
=20
 /**
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll4=
4xx.c
index f231be0..446a4e0 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -191,42 +191,36 @@ out:
 /**
  * omap4_dpll_regm4xen_determine_rate - determine rate for a DPLL
  * @hw: pointer to the clock to determine rate for
- * @rate: target rate for the DPLL
- * @best_parent_rate: pointer for returning best parent rate
- * @best_parent_clk: pointer for returning best parent clock
+ * @req: target rate request
  *
  * Determines which DPLL mode to use for reaching a desired rate.
  * Checks whether the DPLL shall be in bypass or locked mode, and if
  * locked, calculates the M,N values for the DPLL via round-rate.
- * Returns a positive clock rate with success, negative error value
- * in failure.
+ * Returns 0 on success and a negative error value otherwise.
  */
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned lo=
ng rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
 	struct dpll_data *dd;
=20
-	if (!hw || !rate)
+	if (!req->rate)
 		return -EINVAL;
=20
 	dd =3D clk->dpll_data;
 	if (!dd)
 		return -EINVAL;
=20
-	if (__clk_get_rate(dd->clk_bypass) =3D=3D rate &&
+	if (__clk_get_rate(dd->clk_bypass) =3D=3D req->rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
+		req->best_parent_hw =3D __clk_get_hw(dd->clk_bypass);
 	} else {
-		rate =3D omap4_dpll_regm4xen_round_rate(hw, rate,
-						      best_parent_rate);
-		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
+		req->rate =3D omap4_dpll_regm4xen_round_rate(hw, req->rate,
+						&req->best_parent_rate);
+		req->best_parent_hw =3D __clk_get_hw(dd->clk_ref);
 	}
=20
-	*best_parent_rate =3D rate;
+	req->best_parent_rate =3D req->rate;
=20
-	return rate;
+	return 0;
 }
diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/commo=
n/clock.c
index 6e46abe..0b4cf3e 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -389,10 +389,9 @@ static long alchemy_calc_div(unsigned long rate, u=
nsigned long prate,
 	return div1;
 }
=20
-static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rat=
e,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk,
-					int scale, int maxdiv)
+static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 int scale, int maxdiv)
 {
 	struct clk *pc, *bpc, *free;
 	long tdv, tpr, pr, nr, br, bpr, diff, lastdiff;
@@ -422,14 +421,14 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *=
hw, unsigned long rate,
 		}
=20
 		pr =3D clk_get_rate(pc);
-		if (pr < rate)
+		if (pr < req->rate)
 			continue;
=20
 		/* what can hardware actually provide */
-		tdv =3D alchemy_calc_div(rate, pr, scale, maxdiv, NULL);
+		tdv =3D alchemy_calc_div(req->rate, pr, scale, maxdiv, NULL);
 		nr =3D pr / tdv;
-		diff =3D rate - nr;
-		if (nr > rate)
+		diff =3D req->rate - nr;
+		if (nr > req->rate)
 			continue;
=20
 		if (diff < lastdiff) {
@@ -448,15 +447,16 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *=
hw, unsigned long rate,
 	 */
 	if (lastdiff && free) {
 		for (j =3D (maxdiv =3D=3D 4) ? 1 : scale; j <=3D maxdiv; j +=3D scal=
e) {
-			tpr =3D rate * j;
+			tpr =3D req->rate * j;
 			if (tpr < 0)
 				break;
 			pr =3D clk_round_rate(free, tpr);
=20
-			tdv =3D alchemy_calc_div(rate, pr, scale, maxdiv, NULL);
+			tdv =3D alchemy_calc_div(req->rate, pr, scale, maxdiv,
+					       NULL);
 			nr =3D pr / tdv;
-			diff =3D rate - nr;
-			if (nr > rate)
+			diff =3D req->rate - nr;
+			if (nr > req->rate)
 				continue;
 			if (diff < lastdiff) {
 				lastdiff =3D diff;
@@ -469,9 +469,10 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *h=
w, unsigned long rate,
 		}
 	}
=20
-	*best_parent_rate =3D bpr;
-	*best_parent_clk =3D __clk_get_hw(bpc);
-	return br;
+	req->best_parent_rate =3D bpr;
+	req->best_parent_hw =3D __clk_get_hw(bpc);
+	req->rate =3D br;
+	return 0;
 }
=20
 static int alchemy_clk_fgv1_en(struct clk_hw *hw)
@@ -562,14 +563,10 @@ static unsigned long alchemy_clk_fgv1_recalc(stru=
ct clk_hw *hw,
 	return parent_rate / v;
 }
=20
-static long alchemy_clk_fgv1_detr(struct clk_hw *hw, unsigned long rat=
e,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int alchemy_clk_fgv1_detr(struct clk_hw *hw,
+				 struct clk_rate_request *req)
 {
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, 2, 512);
+	return alchemy_clk_fgcs_detr(hw, req, 2, 512);
 }
=20
 /* Au1000, Au1100, Au15x0, Au12x0 */
@@ -696,11 +693,8 @@ static unsigned long alchemy_clk_fgv2_recalc(struc=
t clk_hw *hw,
 	return t;
 }
=20
-static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rat=
e,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int alchemy_clk_fgv2_detr(struct clk_hw *hw,
+				 struct clk_rate_request *req)
 {
 	struct alchemy_fgcs_clk *c =3D to_fgcs_clk(hw);
 	int scale, maxdiv;
@@ -713,8 +707,7 @@ static long alchemy_clk_fgv2_detr(struct clk_hw *hw=
, unsigned long rate,
 		maxdiv =3D 512;
 	}
=20
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, scale, maxdiv);
+	return alchemy_clk_fgcs_detr(hw, req, scale, maxdiv);
 }
=20
 /* Au1300 larger input mux, no separate disable bit, flexible divider =
*/
@@ -917,17 +910,13 @@ static int alchemy_clk_csrc_setr(struct clk_hw *h=
w, unsigned long rate,
 	return 0;
 }
=20
-static long alchemy_clk_csrc_detr(struct clk_hw *hw, unsigned long rat=
e,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int alchemy_clk_csrc_detr(struct clk_hw *hw,
+				 struct clk_rate_request *req)
 {
 	struct alchemy_fgcs_clk *c =3D to_fgcs_clk(hw);
 	int scale =3D c->dt[2] =3D=3D 3 ? 1 : 2; /* au1300 check */
=20
-	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
-				     best_parent_clk, scale, 4);
+	return alchemy_clk_fgcs_detr(hw, req, scale, 4);
 }
=20
 static struct clk_ops alchemy_clkops_csrc =3D {
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk=
-programmable.c
index 8c86c0f..43dacad 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -54,12 +54,8 @@ static unsigned long clk_programmable_recalc_rate(st=
ruct clk_hw *hw,
 	return parent_rate >> pres;
 }
=20
-static long clk_programmable_determine_rate(struct clk_hw *hw,
-					    unsigned long rate,
-					    unsigned long min_rate,
-					    unsigned long max_rate,
-					    unsigned long *best_parent_rate,
-					    struct clk_hw **best_parent_hw)
+static int clk_programmable_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct clk *parent =3D NULL;
 	long best_rate =3D -EINVAL;
@@ -76,24 +72,29 @@ static long clk_programmable_determine_rate(struct =
clk_hw *hw,
 		parent_rate =3D __clk_get_rate(parent);
 		for (shift =3D 0; shift < PROG_PRES_MASK; shift++) {
 			tmp_rate =3D parent_rate >> shift;
-			if (tmp_rate <=3D rate)
+			if (tmp_rate <=3D req->rate)
 				break;
 		}
=20
-		if (tmp_rate > rate)
+		if (tmp_rate > req->rate)
 			continue;
=20
-		if (best_rate < 0 || (rate - tmp_rate) < (rate - best_rate)) {
+		if (best_rate < 0 ||
+		    (req->rate - tmp_rate) < (req->rate - best_rate)) {
 			best_rate =3D tmp_rate;
-			*best_parent_rate =3D parent_rate;
-			*best_parent_hw =3D __clk_get_hw(parent);
+			req->best_parent_rate =3D parent_rate;
+			req->best_parent_hw =3D __clk_get_hw(parent);
 		}
=20
 		if (!best_rate)
 			break;
 	}
=20
-	return best_rate;
+	if (best_rate < 0)
+		return best_rate;
+
+	req->rate =3D best_rate;
+	return 0;
 }
=20
 static int clk_programmable_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index b0cbd2b..24747df 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -56,12 +56,8 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(=
struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
 }
=20
-static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
-					      unsigned long rate,
-					      unsigned long min_rate,
-					      unsigned long max_rate,
-					      unsigned long *best_parent_rate,
-					      struct clk_hw **best_parent_hw)
+static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
 {
 	struct clk *parent =3D NULL;
 	long best_rate =3D -EINVAL;
@@ -80,23 +76,23 @@ static long at91sam9x5_clk_usb_determine_rate(struc=
t clk_hw *hw,
 		for (div =3D 1; div < SAM9X5_USB_MAX_DIV + 2; div++) {
 			unsigned long tmp_parent_rate;
=20
-			tmp_parent_rate =3D rate * div;
+			tmp_parent_rate =3D req->rate * div;
 			tmp_parent_rate =3D __clk_round_rate(parent,
 							   tmp_parent_rate);
 			tmp_rate =3D DIV_ROUND_CLOSEST(tmp_parent_rate, div);
-			if (tmp_rate < rate)
-				tmp_diff =3D rate - tmp_rate;
+			if (tmp_rate < req->rate)
+				tmp_diff =3D req->rate - tmp_rate;
 			else
-				tmp_diff =3D tmp_rate - rate;
+				tmp_diff =3D tmp_rate - req->rate;
=20
 			if (best_diff < 0 || best_diff > tmp_diff) {
 				best_rate =3D tmp_rate;
 				best_diff =3D tmp_diff;
-				*best_parent_rate =3D tmp_parent_rate;
-				*best_parent_hw =3D __clk_get_hw(parent);
+				req->best_parent_rate =3D tmp_parent_rate;
+				req->best_parent_hw =3D __clk_get_hw(parent);
 			}
=20
-			if (!best_diff || tmp_rate < rate)
+			if (!best_diff || tmp_rate < req->rate)
 				break;
 		}
=20
@@ -104,7 +100,11 @@ static long at91sam9x5_clk_usb_determine_rate(stru=
ct clk_hw *hw,
 			break;
 	}
=20
-	return best_rate;
+	if (best_rate < 0)
+		return best_rate;
+
+	req->rate =3D best_rate;
+	return 0;
 }
=20
 static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 79a9850..d9c039c 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1017,10 +1017,8 @@ static long kona_peri_clk_round_rate(struct clk_=
hw *hw, unsigned long rate,
 				rate ? rate : 1, *parent_rate, NULL);
 }
=20
-static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned l=
ong rate,
-		unsigned long min_rate,
-		unsigned long max_rate,
-		unsigned long *best_parent_rate, struct clk_hw **best_parent)
+static int kona_peri_clk_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct kona_clk *bcm_clk =3D to_kona_clk(hw);
 	struct clk *clk =3D hw->clk;
@@ -1029,6 +1027,7 @@ static long kona_peri_clk_determine_rate(struct c=
lk_hw *hw, unsigned long rate,
 	unsigned long best_delta;
 	unsigned long best_rate;
 	u32 parent_count;
+	long rate;
 	u32 which;
=20
 	/*
@@ -1037,14 +1036,21 @@ static long kona_peri_clk_determine_rate(struct=
 clk_hw *hw, unsigned long rate,
 	 */
 	WARN_ON_ONCE(bcm_clk->init_data.flags & CLK_SET_RATE_NO_REPARENT);
 	parent_count =3D (u32)bcm_clk->init_data.num_parents;
-	if (parent_count < 2)
-		return kona_peri_clk_round_rate(hw, rate, best_parent_rate);
+	if (parent_count < 2) {
+		rate =3D kona_peri_clk_round_rate(hw, req->rate,
+						&req->best_parent_rate);
+		if (rate < 0)
+			return rate;
+
+		req->rate =3D rate;
+		return 0;
+	}
=20
 	/* Unless we can do better, stick with current parent */
 	current_parent =3D clk_get_parent(clk);
 	parent_rate =3D __clk_get_rate(current_parent);
-	best_rate =3D kona_peri_clk_round_rate(hw, rate, &parent_rate);
-	best_delta =3D abs(best_rate - rate);
+	best_rate =3D kona_peri_clk_round_rate(hw, req->rate, &parent_rate);
+	best_delta =3D abs(best_rate - req->rate);
=20
 	/* Check whether any other parent clock can produce a better result *=
/
 	for (which =3D 0; which < parent_count; which++) {
@@ -1058,17 +1064,19 @@ static long kona_peri_clk_determine_rate(struct=
 clk_hw *hw, unsigned long rate,
=20
 		/* We don't support CLK_SET_RATE_PARENT */
 		parent_rate =3D __clk_get_rate(parent);
-		other_rate =3D kona_peri_clk_round_rate(hw, rate, &parent_rate);
-		delta =3D abs(other_rate - rate);
+		other_rate =3D kona_peri_clk_round_rate(hw, req->rate,
+						      &parent_rate);
+		delta =3D abs(other_rate - req->rate);
 		if (delta < best_delta) {
 			best_delta =3D delta;
 			best_rate =3D other_rate;
-			*best_parent =3D __clk_get_hw(parent);
-			*best_parent_rate =3D parent_rate;
+			req->best_parent_hw =3D __clk_get_hw(parent);
+			req->best_parent_rate =3D parent_rate;
 		}
 	}
=20
-	return best_rate;
+	req->rate =3D best_rate;
+	return 0;
 }
=20
 static int kona_peri_clk_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 616f5ae..9e69f34 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -55,11 +55,8 @@ static unsigned long clk_composite_recalc_rate(struc=
t clk_hw *hw,
 	return rate_ops->recalc_rate(rate_hw, parent_rate);
 }
=20
-static long clk_composite_determine_rate(struct clk_hw *hw, unsigned l=
ong rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_p)
+static int clk_composite_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_composite *composite =3D to_clk_composite(hw);
 	const struct clk_ops *rate_ops =3D composite->rate_ops;
@@ -71,25 +68,28 @@ static long clk_composite_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	long tmp_rate, best_rate =3D 0;
 	unsigned long rate_diff;
 	unsigned long best_rate_diff =3D ULONG_MAX;
+	long rate;
 	int i;
=20
 	if (rate_hw && rate_ops && rate_ops->determine_rate) {
 		__clk_hw_set_clk(rate_hw, hw);
-		return rate_ops->determine_rate(rate_hw, rate, min_rate,
-						max_rate,
-						best_parent_rate,
-						best_parent_p);
+		return rate_ops->determine_rate(rate_hw, req);
 	} else if (rate_hw && rate_ops && rate_ops->round_rate &&
 		   mux_hw && mux_ops && mux_ops->set_parent) {
-		*best_parent_p =3D NULL;
+		req->best_parent_hw =3D NULL;
=20
 		if (__clk_get_flags(hw->clk) & CLK_SET_RATE_NO_REPARENT) {
 			parent =3D clk_get_parent(mux_hw->clk);
-			*best_parent_p =3D __clk_get_hw(parent);
-			*best_parent_rate =3D __clk_get_rate(parent);
+			req->best_parent_hw =3D __clk_get_hw(parent);
+			req->best_parent_rate =3D __clk_get_rate(parent);
=20
-			return rate_ops->round_rate(rate_hw, rate,
-						    best_parent_rate);
+			rate =3D rate_ops->round_rate(rate_hw, req->rate,
+						    &req->best_parent_rate);
+			if (rate < 0)
+				return rate;
+
+			req->rate =3D rate;
+			return 0;
 		}
=20
 		for (i =3D 0; i < __clk_get_num_parents(mux_hw->clk); i++) {
@@ -99,33 +99,33 @@ static long clk_composite_determine_rate(struct clk=
_hw *hw, unsigned long rate,
=20
 			parent_rate =3D __clk_get_rate(parent);
=20
-			tmp_rate =3D rate_ops->round_rate(rate_hw, rate,
+			tmp_rate =3D rate_ops->round_rate(rate_hw, req->rate,
 							&parent_rate);
 			if (tmp_rate < 0)
 				continue;
=20
-			rate_diff =3D abs(rate - tmp_rate);
+			rate_diff =3D abs(req->rate - tmp_rate);
=20
-			if (!rate_diff || !*best_parent_p
+			if (!rate_diff || !req->best_parent_hw
 				       || best_rate_diff > rate_diff) {
-				*best_parent_p =3D __clk_get_hw(parent);
-				*best_parent_rate =3D parent_rate;
+				req->best_parent_hw =3D __clk_get_hw(parent);
+				req->best_parent_rate =3D parent_rate;
 				best_rate_diff =3D rate_diff;
 				best_rate =3D tmp_rate;
 			}
=20
 			if (!rate_diff)
-				return rate;
+				return 0;
 		}
=20
-		return best_rate;
+		req->rate =3D best_rate;
+		return 0;
 	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
 		__clk_hw_set_clk(mux_hw, hw);
-		return mux_ops->determine_rate(mux_hw, rate, min_rate,
-					       max_rate, best_parent_rate,
-					       best_parent_p);
+		return mux_ops->determine_rate(mux_hw, req);
 	} else {
 		pr_err("clk: clk_composite_determine_rate function called, but no mu=
x or rate callback set!\n");
+		req->rate =3D 0;
 		return 0;
 	}
 }
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ddb4b54..c182d8a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -436,28 +436,37 @@ static bool mux_is_better_rate(unsigned long rate=
, unsigned long now,
 	return now <=3D rate && now > best;
 }
=20
-static long
-clk_mux_determine_rate_flags(struct clk_hw *hw, unsigned long rate,
-			     unsigned long min_rate,
-			     unsigned long max_rate,
-			     unsigned long *best_parent_rate,
-			     struct clk_hw **best_parent_p,
+static int
+clk_mux_determine_rate_flags(struct clk_hw *hw, struct clk_rate_reques=
t *req,
 			     unsigned long flags)
 {
 	struct clk_core *core =3D hw->core, *parent, *best_parent =3D NULL;
-	int i, num_parents;
-	unsigned long parent_rate, best =3D 0;
+	int i, num_parents, ret;
+	unsigned long best =3D 0;
+	struct clk_rate_request parent_req =3D *req;
=20
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
 		parent =3D core->parent;
-		if (core->flags & CLK_SET_RATE_PARENT)
-			best =3D __clk_determine_rate(parent ? parent->hw : NULL,
-						    rate, min_rate, max_rate);
-		else if (parent)
+		if (core->flags & CLK_SET_RATE_PARENT) {
+			ret =3D __clk_determine_rate(parent ? parent->hw : NULL,
+						   &parent_req);
+			if (ret)
+				return ret;
+
+			best =3D parent_req.rate;
+			req->best_parent_hw =3D parent->hw;
+			req->best_parent_rate =3D best;
+		} else if (parent) {
 			best =3D clk_core_get_rate_nolock(parent);
-		else
+			req->best_parent_hw =3D parent->hw;
+			req->best_parent_rate =3D best;
+		} else {
 			best =3D clk_core_get_rate_nolock(core);
+			req->best_parent_hw =3D NULL;
+			req->best_parent_rate =3D 0;
+		}
+
 		goto out;
 	}
=20
@@ -467,24 +476,30 @@ clk_mux_determine_rate_flags(struct clk_hw *hw, u=
nsigned long rate,
 		parent =3D clk_core_get_parent_by_index(core, i);
 		if (!parent)
 			continue;
-		if (core->flags & CLK_SET_RATE_PARENT)
-			parent_rate =3D __clk_determine_rate(parent->hw, rate,
-							   min_rate,
-							   max_rate);
-		else
-			parent_rate =3D clk_core_get_rate_nolock(parent);
-		if (mux_is_better_rate(rate, parent_rate, best, flags)) {
+
+		if (core->flags & CLK_SET_RATE_PARENT) {
+			parent_req =3D *req;
+			ret =3D __clk_determine_rate(parent->hw, &parent_req);
+			if (ret)
+				continue;
+		} else {
+			parent_req.rate =3D clk_core_get_rate_nolock(parent);
+		}
+
+		if (mux_is_better_rate(req->rate, parent_req.rate,
+				       best, flags)) {
 			best_parent =3D parent;
-			best =3D parent_rate;
+			best =3D parent_req.rate;
 		}
 	}
=20
 out:
 	if (best_parent)
-		*best_parent_p =3D best_parent->hw;
-	*best_parent_rate =3D best;
+		req->best_parent_hw =3D best_parent->hw;
+	req->best_parent_rate =3D best;
+	req->rate =3D best;
=20
-	return best;
+	return 0;
 }
=20
 struct clk *__clk_lookup(const char *name)
@@ -515,28 +530,17 @@ static void clk_core_get_boundaries(struct clk_co=
re *core,
  * directly as a determine_rate callback (e.g. for a mux), or from a m=
ore
  * complex clock that may combine a mux with other operations.
  */
-long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+int __clk_mux_determine_rate(struct clk_hw *hw,
+			     struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, rate, min_rate, max_rate,
-					    best_parent_rate,
-					    best_parent_p, 0);
+	return clk_mux_determine_rate_flags(hw, req, 0);
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate);
=20
-long __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long=
 rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+int __clk_mux_determine_rate_closest(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, rate, min_rate, max_rate,
-					    best_parent_rate,
-					    best_parent_p,
-					    CLK_MUX_ROUND_CLOSEST);
+	return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
=20
@@ -759,14 +763,11 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
=20
-static unsigned long clk_core_round_rate_nolock(struct clk_core *core,
-						unsigned long rate,
-						unsigned long min_rate,
-						unsigned long max_rate)
+static int clk_core_round_rate_nolock(struct clk_core *core,
+				      struct clk_rate_request *req)
 {
-	unsigned long parent_rate =3D 0;
 	struct clk_core *parent;
-	struct clk_hw *parent_hw;
+	long rate;
=20
 	lockdep_assert_held(&prepare_lock);
=20
@@ -774,21 +775,28 @@ static unsigned long clk_core_round_rate_nolock(s=
truct clk_core *core,
 		return 0;
=20
 	parent =3D core->parent;
-	if (parent)
-		parent_rate =3D parent->rate;
+	if (parent) {
+		req->best_parent_hw =3D parent->hw;
+		req->best_parent_rate =3D parent->rate;
+	} else {
+		req->best_parent_hw =3D NULL;
+		req->best_parent_rate =3D 0;
+	}
=20
 	if (core->ops->determine_rate) {
-		parent_hw =3D parent ? parent->hw : NULL;
-		return core->ops->determine_rate(core->hw, rate,
-						min_rate, max_rate,
-						&parent_rate, &parent_hw);
-	} else if (core->ops->round_rate)
-		return core->ops->round_rate(core->hw, rate, &parent_rate);
-	else if (core->flags & CLK_SET_RATE_PARENT)
-		return clk_core_round_rate_nolock(core->parent, rate, min_rate,
-						  max_rate);
-	else
-		return core->rate;
+		return core->ops->determine_rate(core->hw, req);
+	} else if (core->ops->round_rate) {
+		rate =3D core->ops->round_rate(core->hw, req->rate,
+					     &req->best_parent_rate);
+		if (rate < 0)
+			return rate;
+
+		req->rate =3D rate;
+	} else if (core->flags & CLK_SET_RATE_PARENT) {
+		return clk_core_round_rate_nolock(parent, req);
+	}
+
+	return 0;
 }
=20
 /**
@@ -800,15 +808,12 @@ static unsigned long clk_core_round_rate_nolock(s=
truct clk_core *core,
  *
  * Useful for clk_ops such as .set_rate and .determine_rate.
  */
-unsigned long __clk_determine_rate(struct clk_hw *hw,
-				   unsigned long rate,
-				   unsigned long min_rate,
-				   unsigned long max_rate)
+int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r=
eq)
 {
 	if (!hw)
 		return 0;
=20
-	return clk_core_round_rate_nolock(hw->core, rate, min_rate, max_rate)=
;
+	return clk_core_round_rate_nolock(hw->core, req);
 }
 EXPORT_SYMBOL_GPL(__clk_determine_rate);
=20
@@ -821,15 +826,20 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
  */
 unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	unsigned long min_rate;
-	unsigned long max_rate;
+	struct clk_rate_request req;
+	int ret;
=20
 	if (!clk)
 		return 0;
=20
-	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
+	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
+	req.rate =3D rate;
+
+	ret =3D clk_core_round_rate_nolock(clk->core, &req);
+	if (ret)
+		return 0;
=20
-	return clk_core_round_rate_nolock(clk->core, rate, min_rate, max_rate=
);
+	return req.rate;
 }
 EXPORT_SYMBOL_GPL(__clk_round_rate);
=20
@@ -1249,7 +1259,6 @@ static struct clk_core *clk_calc_new_rates(struct=
 clk_core *core,
 {
 	struct clk_core *top =3D core;
 	struct clk_core *old_parent, *parent;
-	struct clk_hw *parent_hw;
 	unsigned long best_parent_rate =3D 0;
 	unsigned long new_rate;
 	unsigned long min_rate;
@@ -1270,20 +1279,29 @@ static struct clk_core *clk_calc_new_rates(stru=
ct clk_core *core,
=20
 	/* find the closest rate and parent clk/rate */
 	if (core->ops->determine_rate) {
-		parent_hw =3D parent ? parent->hw : NULL;
-		ret =3D core->ops->determine_rate(core->hw, rate,
-					       min_rate,
-					       max_rate,
-					       &best_parent_rate,
-					       &parent_hw);
+		struct clk_rate_request req;
+
+		req.rate =3D rate;
+		req.min_rate =3D min_rate;
+		req.max_rate =3D max_rate;
+		if (parent) {
+			req.best_parent_hw =3D parent->hw;
+			req.best_parent_rate =3D parent->rate;
+		} else {
+			req.best_parent_hw =3D NULL;
+			req.best_parent_rate =3D 0;
+		}
+
+		ret =3D core->ops->determine_rate(core->hw, &req);
 		if (ret < 0)
 			return NULL;
=20
-		new_rate =3D ret;
-		parent =3D parent_hw ? parent_hw->core : NULL;
+		best_parent_rate =3D req.best_parent_rate;
+		new_rate =3D req.rate;
+		parent =3D req.best_parent_hw ? req.best_parent_hw->core : NULL;
 	} else if (core->ops->round_rate) {
 		ret =3D core->ops->round_rate(core->hw, rate,
-					   &best_parent_rate);
+					    &best_parent_rate);
 		if (ret < 0)
 			return NULL;
=20
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon=
/clk-hi3620.c
index 715d34a..a0674ba 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -294,34 +294,29 @@ static unsigned long mmc_clk_recalc_rate(struct c=
lk_hw *hw,
 	}
 }
=20
-static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long ra=
te,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p)
+static int mmc_clk_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct clk_mmc *mclk =3D to_mmc(hw);
-	unsigned long best =3D 0;
=20
-	if ((rate <=3D 13000000) && (mclk->id =3D=3D HI3620_MMC_CIUCLK1)) {
-		rate =3D 13000000;
-		best =3D 26000000;
-	} else if (rate <=3D 26000000) {
-		rate =3D 25000000;
-		best =3D 180000000;
-	} else if (rate <=3D 52000000) {
-		rate =3D 50000000;
-		best =3D 360000000;
-	} else if (rate <=3D 100000000) {
-		rate =3D 100000000;
-		best =3D 720000000;
+	if ((req->rate <=3D 13000000) && (mclk->id =3D=3D HI3620_MMC_CIUCLK1)=
) {
+		req->rate =3D 13000000;
+		req->best_parent_rate =3D 26000000;
+	} else if (req->rate <=3D 26000000) {
+		req->rate =3D 25000000;
+		req->best_parent_rate =3D 180000000;
+	} else if (req->rate <=3D 52000000) {
+		req->rate =3D 50000000;
+		req->best_parent_rate =3D 360000000;
+	} else if (req->rate <=3D 100000000) {
+		req->rate =3D 100000000;
+		req->best_parent_rate =3D 720000000;
 	} else {
 		/* max is 180M */
-		rate =3D 180000000;
-		best =3D 1440000000;
+		req->rate =3D 180000000;
+		req->best_parent_rate =3D 1440000000;
 	}
-	*best_parent_rate =3D best;
-	return rate;
+	return 0;
 }
=20
 static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index de6a873..7a37432 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -201,11 +201,8 @@ error:
 	return ret;
 }
=20
-static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk)
+static int mmp_clk_mix_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct mmp_clk_mix *mix =3D to_clk_mix(hw);
 	struct mmp_clk_mix_clk_table *item;
@@ -221,7 +218,7 @@ static long mmp_clk_mix_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 	parent =3D NULL;
 	mix_rate_best =3D 0;
 	parent_rate_best =3D 0;
-	gap_best =3D rate;
+	gap_best =3D req->rate;
 	parent_best =3D NULL;
=20
 	if (mix->table) {
@@ -233,7 +230,7 @@ static long mmp_clk_mix_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 							item->parent_index);
 			parent_rate =3D __clk_get_rate(parent);
 			mix_rate =3D parent_rate / item->divisor;
-			gap =3D abs(mix_rate - rate);
+			gap =3D abs(mix_rate - req->rate);
 			if (parent_best =3D=3D NULL || gap < gap_best) {
 				parent_best =3D parent;
 				parent_rate_best =3D parent_rate;
@@ -251,7 +248,7 @@ static long mmp_clk_mix_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 			for (j =3D 0; j < div_val_max; j++) {
 				div =3D _get_div(mix, j);
 				mix_rate =3D parent_rate / div;
-				gap =3D abs(mix_rate - rate);
+				gap =3D abs(mix_rate - req->rate);
 				if (parent_best =3D=3D NULL || gap < gap_best) {
 					parent_best =3D parent;
 					parent_rate_best =3D parent_rate;
@@ -265,10 +262,11 @@ static long mmp_clk_mix_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	}
=20
 found:
-	*best_parent_rate =3D parent_rate_best;
-	*best_parent_clk =3D __clk_get_hw(parent_best);
+	req->best_parent_rate =3D parent_rate_best;
+	req->best_parent_hw =3D __clk_get_hw(parent_best);
+	req->rate =3D mix_rate_best;
=20
-	return mix_rate_best;
+	return 0;
 }
=20
 static int mmp_clk_mix_set_rate_and_parent(struct clk_hw *hw,
diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
index 245d506..6017a76 100644
--- a/drivers/clk/qcom/clk-pll.c
+++ b/drivers/clk/qcom/clk-pll.c
@@ -135,19 +135,23 @@ struct pll_freq_tbl *find_freq(const struct pll_f=
req_tbl *f, unsigned long rate)
 	return NULL;
 }
=20
-static long
-clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
-		       unsigned long min_rate, unsigned long max_rate,
-		       unsigned long *p_rate, struct clk_hw **p)
+static int
+clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req=
)
 {
+	struct clk *parent =3D __clk_get_parent(hw->clk);
 	struct clk_pll *pll =3D to_clk_pll(hw);
 	const struct pll_freq_tbl *f;
=20
-	f =3D find_freq(pll->freq_tbl, rate);
+	req->best_parent_hw =3D __clk_get_hw(parent);
+	req->best_parent_rate =3D __clk_get_rate(parent);
+
+	f =3D find_freq(pll->freq_tbl, req->rate);
 	if (!f)
-		return clk_pll_recalc_rate(hw, *p_rate);
+		req->rate =3D clk_pll_recalc_rate(hw, req->best_parent_rate);
+	else
+		req->rate =3D f->freq;
=20
-	return f->freq;
+	return 0;
 }
=20
 static int
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index 7b3d626..2bc42bb 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -404,13 +404,11 @@ clk_dyn_rcg_recalc_rate(struct clk_hw *hw, unsign=
ed long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, pre_div);
 }
=20
-static long _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, unsigned long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p_hw,
+static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct fr=
eq_tbl *f,
+		struct clk_rate_request *req,
 		const struct parent_map *parent_map)
 {
-	unsigned long clk_flags;
+	unsigned long clk_flags, rate =3D req->rate;
 	struct clk *p;
 	int index;
=20
@@ -435,25 +433,24 @@ static long _freq_tbl_determine_rate(struct clk_h=
w *hw,
 	} else {
 		rate =3D  __clk_get_rate(p);
 	}
-	*p_hw =3D __clk_get_hw(p);
-	*p_rate =3D rate;
+	req->best_parent_hw =3D __clk_get_hw(p);
+	req->best_parent_rate =3D rate;
+	req->rate =3D f->freq;
=20
-	return f->freq;
+	return 0;
 }
=20
-static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long ra=
te,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p)
+static int clk_rcg_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct clk_rcg *rcg =3D to_clk_rcg(hw);
=20
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, min_rate,
-			max_rate, p_rate, p, rcg->s.parent_map);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req,
+					rcg->s.parent_map);
 }
=20
-static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p)
+static int clk_dyn_rcg_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk_dyn_rcg *rcg =3D to_clk_dyn_rcg(hw);
 	u32 reg;
@@ -464,13 +461,11 @@ static long clk_dyn_rcg_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	bank =3D reg_to_bank(rcg, reg);
 	s =3D &rcg->s[bank];
=20
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, min_rate,
-			max_rate, p_rate, p, s->parent_map);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, s->parent_map=
);
 }
=20
-static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned =
long rate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p_hw)
+static int clk_rcg_bypass_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct clk_rcg *rcg =3D to_clk_rcg(hw);
 	const struct freq_tbl *f =3D rcg->freq_tbl;
@@ -478,10 +473,11 @@ static long clk_rcg_bypass_determine_rate(struct =
clk_hw *hw, unsigned long rate,
 	int index =3D qcom_find_src_index(hw, rcg->s.parent_map, f->src);
=20
 	p =3D clk_get_parent_by_index(hw->clk, index);
-	*p_hw =3D __clk_get_hw(p);
-	*p_rate =3D __clk_round_rate(p, rate);
+	req->best_parent_hw =3D __clk_get_hw(p);
+	req->best_parent_rate =3D __clk_round_rate(p, req->rate);
+	req->rate =3D req->best_parent_rate;
=20
-	return *p_rate;
+	return 0;
 }
=20
 static int __clk_rcg_set_rate(struct clk_rcg *rcg, const struct freq_t=
bl *f)
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index b95d17f..aa6c3bd 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -176,11 +176,10 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned =
long parent_rate)
 	return calc_rate(parent_rate, m, n, mode, hid_div);
 }
=20
-static long _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, unsigned long rate,
-		unsigned long *p_rate, struct clk_hw **p_hw)
+static int _freq_tbl_determine_rate(struct clk_hw *hw,
+		const struct freq_tbl *f, struct clk_rate_request *req)
 {
-	unsigned long clk_flags;
+	unsigned long clk_flags, rate =3D req->rate;
 	struct clk *p;
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
 	int index;
@@ -210,19 +209,19 @@ static long _freq_tbl_determine_rate(struct clk_h=
w *hw,
 	} else {
 		rate =3D  __clk_get_rate(p);
 	}
-	*p_hw =3D __clk_get_hw(p);
-	*p_rate =3D rate;
+	req->best_parent_hw =3D __clk_get_hw(p);
+	req->best_parent_rate =3D rate;
+	req->rate =3D f->freq;
=20
-	return f->freq;
+	return 0;
 }
=20
-static long clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long r=
ate,
-		unsigned long min_rate, unsigned long max_rate,
-		unsigned long *p_rate, struct clk_hw **p)
+static int clk_rcg2_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
=20
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, p_rate, p);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req);
 }
=20
 static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_=
tbl *f)
@@ -374,35 +373,34 @@ static int clk_edp_pixel_set_rate_and_parent(stru=
ct clk_hw *hw,
 	return clk_edp_pixel_set_rate(hw, rate, parent_rate);
 }
=20
-static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned l=
ong rate,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *p_rate, struct clk_hw **p)
+static int clk_edp_pixel_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
 	const struct freq_tbl *f =3D rcg->freq_tbl;
 	const struct frac_entry *frac;
 	int delta =3D 100000;
-	s64 src_rate =3D *p_rate;
 	s64 request;
 	u32 mask =3D BIT(rcg->hid_width) - 1;
 	u32 hid_div;
 	int index =3D qcom_find_src_index(hw, rcg->parent_map, f->src);
+	struct clk *p =3D clk_get_parent_by_index(hw->clk, index);
=20
 	/* Force the correct parent */
-	*p =3D __clk_get_hw(clk_get_parent_by_index(hw->clk, index));
+	req->best_parent_hw =3D __clk_get_hw(p);
+	req->best_parent_rate =3D __clk_get_rate(p);
=20
-	if (src_rate =3D=3D 810000000)
+	if (req->best_parent_rate =3D=3D 810000000)
 		frac =3D frac_table_810m;
 	else
 		frac =3D frac_table_675m;
=20
 	for (; frac->num; frac++) {
-		request =3D rate;
+		request =3D req->rate;
 		request *=3D frac->den;
 		request =3D div_s64(request, frac->num);
-		if ((src_rate < (request - delta)) ||
-		    (src_rate > (request + delta)))
+		if ((req->best_parent_rate < (request - delta)) ||
+		    (req->best_parent_rate > (request + delta)))
 			continue;
=20
 		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
@@ -410,8 +408,10 @@ static long clk_edp_pixel_determine_rate(struct cl=
k_hw *hw, unsigned long rate,
 		hid_div >>=3D CFG_SRC_DIV_SHIFT;
 		hid_div &=3D mask;
=20
-		return calc_rate(src_rate, frac->num, frac->den, !!frac->den,
-				 hid_div);
+		req->rate =3D calc_rate(req->best_parent_rate,
+				      frac->num, frac->den,
+				      !!frac->den, hid_div);
+		return 0;
 	}
=20
 	return -EINVAL;
@@ -428,9 +428,8 @@ const struct clk_ops clk_edp_pixel_ops =3D {
 };
 EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
=20
-static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long r=
ate,
-			 unsigned long min_rate, unsigned long max_rate,
-			 unsigned long *p_rate, struct clk_hw **p_hw)
+static int clk_byte_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
 	const struct freq_tbl *f =3D rcg->freq_tbl;
@@ -439,17 +438,19 @@ static long clk_byte_determine_rate(struct clk_hw=
 *hw, unsigned long rate,
 	u32 mask =3D BIT(rcg->hid_width) - 1;
 	struct clk *p;
=20
-	if (rate =3D=3D 0)
+	if (req->rate =3D=3D 0)
 		return -EINVAL;
=20
 	p =3D clk_get_parent_by_index(hw->clk, index);
-	*p_hw =3D __clk_get_hw(p);
-	*p_rate =3D parent_rate =3D __clk_round_rate(p, rate);
+	req->best_parent_hw =3D __clk_get_hw(p);
+	req->best_parent_rate =3D parent_rate =3D __clk_round_rate(p, req->ra=
te);
=20
-	div =3D DIV_ROUND_UP((2 * parent_rate), rate) - 1;
+	div =3D DIV_ROUND_UP((2 * parent_rate), req->rate) - 1;
 	div =3D min_t(u32, div, mask);
=20
-	return calc_rate(parent_rate, 0, 0, 0, div);
+	req->rate =3D calc_rate(parent_rate, 0, 0, 0, div);
+
+	return 0;
 }
=20
 static int clk_byte_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -494,10 +495,8 @@ static const struct frac_entry frac_table_pixel[] =
=3D {
 	{ }
 };
=20
-static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long =
rate,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *p_rate, struct clk_hw **p)
+static int clk_pixel_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
 	struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
 	unsigned long request, src_rate;
@@ -507,18 +506,19 @@ static long clk_pixel_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 	int index =3D qcom_find_src_index(hw, rcg->parent_map, f->src);
 	struct clk *parent =3D clk_get_parent_by_index(hw->clk, index);
=20
-	*p =3D __clk_get_hw(parent);
+	req->best_parent_hw =3D __clk_get_hw(parent);
=20
 	for (; frac->num; frac++) {
-		request =3D (rate * frac->den) / frac->num;
+		request =3D (req->rate * frac->den) / frac->num;
=20
 		src_rate =3D __clk_round_rate(parent, request);
 		if ((src_rate < (request - delta)) ||
 			(src_rate > (request + delta)))
 			continue;
=20
-		*p_rate =3D src_rate;
-		return (src_rate * frac->num) / frac->den;
+		req->best_parent_rate =3D src_rate;
+		req->rate =3D (src_rate * frac->num) / frac->den;
+		return 0;
 	}
=20
 	return -EINVAL;
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-fa=
ctors.c
index 8c20190..7a48587 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -79,11 +79,8 @@ static long clk_factors_round_rate(struct clk_hw *hw=
, unsigned long rate,
 	return rate;
 }
=20
-static long clk_factors_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_p)
+static int clk_factors_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct clk *clk =3D hw->clk, *parent, *best_parent =3D NULL;
 	int i, num_parents;
@@ -96,13 +93,14 @@ static long clk_factors_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
-			parent_rate =3D __clk_round_rate(parent, rate);
+			parent_rate =3D __clk_round_rate(parent, req->rate);
 		else
 			parent_rate =3D __clk_get_rate(parent);
=20
-		child_rate =3D clk_factors_round_rate(hw, rate, &parent_rate);
+		child_rate =3D clk_factors_round_rate(hw, req->rate,
+						    &parent_rate);
=20
-		if (child_rate <=3D rate && child_rate > best_child_rate) {
+		if (child_rate <=3D req->rate && child_rate > best_child_rate) {
 			best_parent =3D parent;
 			best =3D parent_rate;
 			best_child_rate =3D child_rate;
@@ -110,10 +108,11 @@ static long clk_factors_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	}
=20
 	if (best_parent)
-		*best_parent_p =3D __clk_get_hw(best_parent);
-	*best_parent_rate =3D best;
+		req->best_parent_hw =3D __clk_get_hw(best_parent);
+	req->best_parent_rate =3D best;
+	req->rate =3D best_child_rate;
=20
-	return best_child_rate;
+	return 0;
 }
=20
 static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/cl=
k-sun6i-ar100.c
index 63cf149..d70c1ea 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -44,17 +44,14 @@ static unsigned long ar100_recalc_rate(struct clk_h=
w *hw,
 	return (parent_rate >> shift) / (div + 1);
 }
=20
-static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate=
,
-				 unsigned long min_rate,
-				 unsigned long max_rate,
-				 unsigned long *best_parent_rate,
-				 struct clk_hw **best_parent_clk)
+static int ar100_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
 {
 	int nparents =3D __clk_get_num_parents(hw->clk);
 	long best_rate =3D -EINVAL;
 	int i;
=20
-	*best_parent_clk =3D NULL;
+	req->best_parent_hw =3D NULL;
=20
 	for (i =3D 0; i < nparents; i++) {
 		unsigned long parent_rate;
@@ -65,7 +62,7 @@ static long ar100_determine_rate(struct clk_hw *hw, u=
nsigned long rate,
=20
 		parent =3D clk_get_parent_by_index(hw->clk, i);
 		parent_rate =3D __clk_get_rate(parent);
-		div =3D DIV_ROUND_UP(parent_rate, rate);
+		div =3D DIV_ROUND_UP(parent_rate, req->rate);
=20
 		/*
 		 * The AR100 clk contains 2 divisors:
@@ -101,14 +98,16 @@ static long ar100_determine_rate(struct clk_hw *hw=
, unsigned long rate,
 			continue;
=20
 		tmp_rate =3D (parent_rate >> shift) / div;
-		if (!*best_parent_clk || tmp_rate > best_rate) {
-			*best_parent_clk =3D __clk_get_hw(parent);
-			*best_parent_rate =3D parent_rate;
+		if (!req->best_parent_hw || tmp_rate > best_rate) {
+			req->best_parent_hw =3D __clk_get_hw(parent);
+			req->best_parent_rate =3D parent_rate;
 			best_rate =3D tmp_rate;
 		}
 	}
=20
-	return best_rate;
+	req->rate =3D best_rate;
+
+	return 0;
 }
=20
 static int ar100_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunx=
i.c
index 9a82f17..d0f72a1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -118,11 +118,8 @@ static long sun6i_ahb1_clk_round(unsigned long rat=
e, u8 *divp, u8 *pre_divp,
 	return (parent_rate / calcm) >> calcp;
 }
=20
-static long sun6i_ahb1_clk_determine_rate(struct clk_hw *hw, unsigned =
long rate,
-					  unsigned long min_rate,
-					  unsigned long max_rate,
-					  unsigned long *best_parent_rate,
-					  struct clk_hw **best_parent_clk)
+static int sun6i_ahb1_clk_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
 {
 	struct clk *clk =3D hw->clk, *parent, *best_parent =3D NULL;
 	int i, num_parents;
@@ -135,14 +132,14 @@ static long sun6i_ahb1_clk_determine_rate(struct =
clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (__clk_get_flags(clk) & CLK_SET_RATE_PARENT)
-			parent_rate =3D __clk_round_rate(parent, rate);
+			parent_rate =3D __clk_round_rate(parent, req->rate);
 		else
 			parent_rate =3D __clk_get_rate(parent);
=20
-		child_rate =3D sun6i_ahb1_clk_round(rate, NULL, NULL, i,
+		child_rate =3D sun6i_ahb1_clk_round(req->rate, NULL, NULL, i,
 						  parent_rate);
=20
-		if (child_rate <=3D rate && child_rate > best_child_rate) {
+		if (child_rate <=3D req->rate && child_rate > best_child_rate) {
 			best_parent =3D parent;
 			best =3D parent_rate;
 			best_child_rate =3D child_rate;
@@ -150,10 +147,11 @@ static long sun6i_ahb1_clk_determine_rate(struct =
clk_hw *hw, unsigned long rate,
 	}
=20
 	if (best_parent)
-		*best_parent_clk =3D __clk_get_hw(best_parent);
-	*best_parent_rate =3D best;
+		req->best_parent_hw =3D __clk_get_hw(best_parent);
+	req->best_parent_rate =3D best;
+	req->rate =3D best_child_rate;
=20
-	return best_child_rate;
+	return 0;
 }
=20
 static int sun6i_ahb1_clk_set_rate(struct clk_hw *hw, unsigned long ra=
te,
diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 7649685..08ae518 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -116,11 +116,7 @@ static unsigned long emc_recalc_rate(struct clk_hw=
 *hw,
  * safer since things have EMC rate floors. Also don't touch parent_ra=
te
  * since we don't want the CCF to play with our parent clocks.
  */
-static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long min_rate,
-			       unsigned long max_rate,
-			       unsigned long *best_parent_rate,
-			       struct clk_hw **best_parent_hw)
+static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_reque=
st *req)
 {
 	struct tegra_clk_emc *tegra;
 	u8 ram_code =3D tegra_read_ram_code();
@@ -135,22 +131,28 @@ static long emc_determine_rate(struct clk_hw *hw,=
 unsigned long rate,
=20
 		timing =3D tegra->timings + i;
=20
-		if (timing->rate > max_rate) {
+		if (timing->rate > req->max_rate) {
 			i =3D min(i, 1);
-			return tegra->timings[i - 1].rate;
+			req->rate =3D tegra->timings[i - 1].rate;
+			return 0;
 		}
=20
-		if (timing->rate < min_rate)
+		if (timing->rate < req->min_rate)
 			continue;
=20
-		if (timing->rate >=3D rate)
-			return timing->rate;
+		if (timing->rate >=3D req->rate) {
+			req->rate =3D timing->rate;
+			return 0;
+		}
 	}
=20
-	if (timing)
-		return timing->rate;
+	if (timing) {
+		req->rate =3D timing->rate;
+		return 0;
+	}
=20
-	return __clk_get_rate(hw->clk);
+	req->rate =3D __clk_get_rate(hw->clk);
+	return 0;
 }
=20
 static u8 emc_get_parent(struct clk_hw *hw)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.=
h
index 78842f4..14998f0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -38,6 +38,28 @@ struct clk_core;
 struct dentry;
=20
 /**
+ * struct clk_rate_request - Structure encoding the clk constraints th=
at
+ * a clock user might require.
+ *
+ * @rate:		Requested clock rate. This field will be adjusted by
+ *			clock drivers according to hardware capabilities.
+ * @min_rate:		Minimum rate imposed by clk users.
+ * @max_rate:		Maximum rate a imposed by clk users.
+ * @best_parent_rate:	The best parent rate a parent can provide to ful=
fill the
+ *			requested constraints.
+ * @best_parent_hw:	The most appropriate parent clock that fulfills th=
e
+ *			requested constraints.
+ *
+ */
+struct clk_rate_request {
+	unsigned long rate;
+	unsigned long min_rate;
+	unsigned long max_rate;
+	unsigned long best_parent_rate;
+	struct clk_hw *best_parent_hw;
+};
+
+/**
  * struct clk_ops -  Callback operations for hardware clocks; these ar=
e to
  * be provided by the clock implementation, and will be called by driv=
ers
  * through the clk_* api.
@@ -176,12 +198,8 @@ struct clk_ops {
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate);
-	long		(*determine_rate)(struct clk_hw *hw,
-					  unsigned long rate,
-					  unsigned long min_rate,
-					  unsigned long max_rate,
-					  unsigned long *best_parent_rate,
-					  struct clk_hw **best_parent_hw);
+	int		(*determine_rate)(struct clk_hw *hw,
+					  struct clk_rate_request *req);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
@@ -578,20 +596,11 @@ unsigned long __clk_get_flags(struct clk *clk);
 bool __clk_is_prepared(struct clk *clk);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
-long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p);
-unsigned long __clk_determine_rate(struct clk_hw *core,
-				   unsigned long rate,
-				   unsigned long min_rate,
-				   unsigned long max_rate);
-long __clk_mux_determine_rate_closest(struct clk_hw *hw, unsigned long=
 rate,
-			      unsigned long min_rate,
-			      unsigned long max_rate,
-			      unsigned long *best_parent_rate,
-			      struct clk_hw **best_parent_p);
+int __clk_mux_determine_rate(struct clk_hw *hw,
+			     struct clk_rate_request *req);
+int __clk_determine_rate(struct clk_hw *core, struct clk_rate_request =
*req);
+int __clk_mux_determine_rate_closest(struct clk_hw *hw,
+				     struct clk_rate_request *req);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
=20
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw =
*src)
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 79b76e1..448b4f8 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -269,23 +269,15 @@ int omap3_noncore_dpll_set_rate_and_parent(struct=
 clk_hw *hw,
 					   unsigned long rate,
 					   unsigned long parent_rate,
 					   u8 index);
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
-				       unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk);
+int omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 				    unsigned long target_rate,
 				    unsigned long *parent_rate);
-long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
-					unsigned long rate,
-					unsigned long min_rate,
-					unsigned long max_rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_clk);
+int omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long paren=
t_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rat=
e,
--=20
1.9.1
