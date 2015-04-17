From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
Date: Fri, 17 Apr 2015 09:29:28 +0200
Message-ID: <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Mike Turquette <mturquette@linaro.org>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>, ascha Hauer <kernel@pengutronix.de>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.lin>
List-Id: linux-omap@vger.kernel.org

Clock rates are stored in an unsigned long field, but ->round_rate()
(which returns a rounded rate from a requested one) returns a long
value (errors are reported using negative error codes), which can lead
to long overflow if the clock rate exceed 2Ghz.

Change ->round_rate() prototype to return 0 or an error code, and pass =
the
requested rate as a pointer so that it can be adjusted depending on
hardware capabilities.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
CC: Jonathan Corbet <corbet@lwn.net>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: ascha Hauer <kernel@pengutronix.de>
CC: David Brown <davidb@codeaurora.org>
CC: Daniel Walker <dwalker@fifo99.com>
CC: Bryan Huntsman <bryanh@codeaurora.org>
CC: Tony Lindgren <tony@atomide.com>
CC: Paul Walmsley <paul@pwsan.com>
CC: Liviu Dudau <liviu.dudau@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Sylwester Nawrocki <s.nawrocki@samsung.com>=20
CC: Tomasz Figa <tomasz.figa@gmail.com>
CC: Barry Song <baohua@kernel.org>
CC: Viresh Kumar <viresh.linux@gmail.com>
CC: "Emilio L=C3=B3pez" <emilio@elopez.com.ar>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Peter De Schrijver <pdeschrijver@nvidia.com>
CC: Prashant Gaikwad <pgaikwad@nvidia.com>
CC: Stephen Warren <swarren@wwwdotorg.org>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Alexandre Courbot <gnurou@gmail.com>
CC: Tero Kristo <t-kristo@ti.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Michal Simek <michal.simek@xilinx.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-arm-msm@vger.kernel.org
CC: linux-omap@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: patches@opensource.wolfsonmicro.com
CC: linux-rockchip@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: spear-devel@list.st.com
CC: linux-tegra@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: linux-media@vger.kernel.org
CC: rtc-linux@googlegroups.com

 Documentation/clk.txt                        |  4 +-
 arch/arm/mach-imx/clk-busy.c                 |  2 +-
 arch/arm/mach-imx/clk-cpu.c                  | 12 +++-
 arch/arm/mach-imx/clk-fixup-div.c            |  2 +-
 arch/arm/mach-imx/clk-pfd.c                  | 11 ++--
 arch/arm/mach-imx/clk-pllv2.c                |  8 ++-
 arch/arm/mach-imx/clk-pllv3.c                | 46 +++++++------
 arch/arm/mach-msm/clock-pcom.c               |  4 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 13 ++--
 arch/arm/mach-omap2/clkt_clksel.c            |  6 +-
 arch/arm/mach-omap2/clkt_dpll.c              | 21 +++---
 arch/arm/mach-omap2/clock.h                  |  4 +-
 arch/arm/mach-omap2/dpll3xxx.c               | 27 +++++---
 arch/arm/mach-omap2/dpll44xx.c               | 26 +++++---
 arch/arm/mach-vexpress/spc.c                 | 11 +++-
 arch/mips/alchemy/common/clock.c             | 13 ++--
 drivers/clk/at91/clk-h32mx.c                 | 24 ++++---
 drivers/clk/at91/clk-peripheral.c            | 31 +++++----
 drivers/clk/at91/clk-pll.c                   | 14 ++--
 drivers/clk/at91/clk-plldiv.c                | 22 ++++---
 drivers/clk/at91/clk-smd.c                   | 24 ++++---
 drivers/clk/at91/clk-usb.c                   | 34 ++++++----
 drivers/clk/clk-axi-clkgen.c                 |  5 +-
 drivers/clk/clk-cdce706.c                    | 46 ++++++-------
 drivers/clk/clk-composite.c                  | 23 ++++---
 drivers/clk/clk-divider.c                    | 16 +++--
 drivers/clk/clk-fixed-factor.c               |  7 +-
 drivers/clk/clk-fractional-divider.c         | 16 +++--
 drivers/clk/clk-highbank.c                   | 18 +++---
 drivers/clk/clk-si5351.c                     | 96 ++++++++++++++------=
--------
 drivers/clk/clk-si570.c                      | 14 ++--
 drivers/clk/clk-u300.c                       | 65 ++++++++++---------
 drivers/clk/clk-vt8500.c                     | 27 ++++----
 drivers/clk/clk-wm831x.c                     | 11 ++--
 drivers/clk/clk-xgene.c                      | 11 ++--
 drivers/clk/clk.c                            | 15 +++--
 drivers/clk/mmp/clk-frac.c                   | 14 ++--
 drivers/clk/mvebu/clk-corediv.c              |  7 +-
 drivers/clk/mvebu/clk-cpu.c                  |  9 +--
 drivers/clk/mxs/clk-div.c                    |  4 +-
 drivers/clk/mxs/clk-frac.c                   | 11 ++--
 drivers/clk/mxs/clk-ref.c                    | 11 ++--
 drivers/clk/qcom/clk-regmap-divider.c        |  4 +-
 drivers/clk/rockchip/clk-pll.c               | 13 ++--
 drivers/clk/samsung/clk-pll.c                | 13 ++--
 drivers/clk/shmobile/clk-div6.c              |  7 +-
 drivers/clk/shmobile/clk-rcar-gen2.c         |  9 +--
 drivers/clk/sirf/clk-common.c                | 18 +++---
 drivers/clk/spear/clk-aux-synth.c            | 10 ++-
 drivers/clk/spear/clk-frac-synth.c           | 10 ++-
 drivers/clk/spear/clk-gpt-synth.c            | 10 ++-
 drivers/clk/spear/clk-vco-pll.c              | 20 ++++--
 drivers/clk/st/clk-flexgen.c                 | 11 ++--
 drivers/clk/st/clkgen-fsyn.c                 | 21 +++---
 drivers/clk/st/clkgen-mux.c                  |  2 +-
 drivers/clk/sunxi/clk-factors.c              | 14 ++--
 drivers/clk/tegra/clk-audio-sync.c           |  8 +--
 drivers/clk/tegra/clk-divider.c              | 19 ++++--
 drivers/clk/tegra/clk-periph.c               |  4 +-
 drivers/clk/tegra/clk-pll.c                  | 39 ++++++-----
 drivers/clk/ti/clk-dra7-atl.c                |  9 +--
 drivers/clk/ti/composite.c                   |  4 +-
 drivers/clk/ti/divider.c                     |  9 +--
 drivers/clk/ux500/clk-prcmu.c                | 13 +++-
 drivers/clk/versatile/clk-icst.c             |  9 +--
 drivers/clk/versatile/clk-vexpress-osc.c     | 12 ++--
 drivers/clk/zynq/pll.c                       |  7 +-
 drivers/gpu/drm/imx/imx-tve.c                | 15 +++--
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c     |  7 +-
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_pll.c |  7 +-
 drivers/media/platform/omap3isp/isp.c        |  6 +-
 drivers/rtc/rtc-hym8563.c                    | 14 ++--
 include/linux/clk-provider.h                 |  6 +-
 include/linux/clk/ti.h                       | 12 ++--
 74 files changed, 672 insertions(+), 475 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index 0e4f90a..fca8b7a 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -68,8 +68,8 @@ the operations defined in clk.h:
 		int		(*is_enabled)(struct clk_hw *hw);
 		unsigned long	(*recalc_rate)(struct clk_hw *hw,
 						unsigned long parent_rate);
-		long		(*round_rate)(struct clk_hw *hw,
-						unsigned long rate,
+		int		(*round_rate)(struct clk_hw *hw,
+						unsigned long *rate,
 						unsigned long *parent_rate);
 		long		(*determine_rate)(struct clk_hw *hw,
 						unsigned long rate,
diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.=
c
index 4bb1bc4..f8c67e9 100644
--- a/arch/arm/mach-imx/clk-busy.c
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -51,7 +51,7 @@ static unsigned long clk_busy_divider_recalc_rate(str=
uct clk_hw *hw,
 	return busy->div_ops->recalc_rate(&busy->div.hw, parent_rate);
 }
=20
-static long clk_busy_divider_round_rate(struct clk_hw *hw, unsigned lo=
ng rate,
+static int clk_busy_divider_round_rate(struct clk_hw *hw, unsigned lon=
g *rate,
 					unsigned long *prate)
 {
 	struct clk_busy_divider *busy =3D to_clk_busy_divider(hw);
diff --git a/arch/arm/mach-imx/clk-cpu.c b/arch/arm/mach-imx/clk-cpu.c
index aa1c345..f6af2d8 100644
--- a/arch/arm/mach-imx/clk-cpu.c
+++ b/arch/arm/mach-imx/clk-cpu.c
@@ -34,12 +34,18 @@ static unsigned long clk_cpu_recalc_rate(struct clk=
_hw *hw,
 	return clk_get_rate(cpu->div);
 }
=20
-static long clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_cpu_round_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *prate)
 {
 	struct clk_cpu *cpu =3D to_clk_cpu(hw);
+	long ret;
=20
-	return clk_round_rate(cpu->pll, rate);
+	ret =3D clk_round_rate(cpu->pll, *rate);
+	if (ret < 0)
+		return ret;
+
+	*rate =3D ret;
+	return 0;
 }
=20
 static int clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/arch/arm/mach-imx/clk-fixup-div.c b/arch/arm/mach-imx/clk-=
fixup-div.c
index 21db020..c2f4f00 100644
--- a/arch/arm/mach-imx/clk-fixup-div.c
+++ b/arch/arm/mach-imx/clk-fixup-div.c
@@ -48,7 +48,7 @@ static unsigned long clk_fixup_div_recalc_rate(struct=
 clk_hw *hw,
 	return fixup_div->ops->recalc_rate(&fixup_div->divider.hw, parent_rat=
e);
 }
=20
-static long clk_fixup_div_round_rate(struct clk_hw *hw, unsigned long =
rate,
+static int clk_fixup_div_round_rate(struct clk_hw *hw, unsigned long *=
rate,
 			       unsigned long *prate)
 {
 	struct clk_fixup_div *fixup_div =3D to_clk_fixup_div(hw);
diff --git a/arch/arm/mach-imx/clk-pfd.c b/arch/arm/mach-imx/clk-pfd.c
index 0b0f6f6..449fb7a 100644
--- a/arch/arm/mach-imx/clk-pfd.c
+++ b/arch/arm/mach-imx/clk-pfd.c
@@ -68,14 +68,14 @@ static unsigned long clk_pfd_recalc_rate(struct clk=
_hw *hw,
 	return tmp;
 }
=20
-static long clk_pfd_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_pfd_round_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *prate)
 {
 	u64 tmp =3D *prate;
 	u8 frac;
=20
-	tmp =3D tmp * 18 + rate / 2;
-	do_div(tmp, rate);
+	tmp =3D tmp * 18 + *rate / 2;
+	do_div(tmp, *rate);
 	frac =3D tmp;
 	if (frac < 12)
 		frac =3D 12;
@@ -85,7 +85,8 @@ static long clk_pfd_round_rate(struct clk_hw *hw, uns=
igned long rate,
 	tmp *=3D 18;
 	do_div(tmp, frac);
=20
-	return tmp;
+	*rate =3D tmp;
+	return 0;
 }
=20
 static int clk_pfd_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv=
2.c
index 20889d5..6b48bf5 100644
--- a/arch/arm/mach-imx/clk-pllv2.c
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -180,14 +180,16 @@ static int clk_pllv2_set_rate(struct clk_hw *hw, =
unsigned long rate,
 	return 0;
 }
=20
-static long clk_pllv2_round_rate(struct clk_hw *hw, unsigned long rate=
,
+static int clk_pllv2_round_rate(struct clk_hw *hw, unsigned long *rate=
,
 		unsigned long *prate)
 {
 	u32 dp_op, dp_mfd, dp_mfn;
=20
-	__clk_pllv2_set_rate(rate, *prate, &dp_op, &dp_mfd, &dp_mfn);
-	return __clk_pllv2_recalc_rate(*prate, MXC_PLL_DP_CTL_DPDCK0_2_EN,
+	__clk_pllv2_set_rate(*rate, *prate, &dp_op, &dp_mfd, &dp_mfn);
+	*rate =3D __clk_pllv2_recalc_rate(*prate, MXC_PLL_DP_CTL_DPDCK0_2_EN,
 			dp_op, dp_mfd, dp_mfn);
+
+	return 0;
 }
=20
 static int clk_pllv2_prepare(struct clk_hw *hw)
diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv=
3.c
index 641ebc5..4d8f4eb 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -104,13 +104,15 @@ static unsigned long clk_pllv3_recalc_rate(struct=
 clk_hw *hw,
 	return (div =3D=3D 1) ? parent_rate * 22 : parent_rate * 20;
 }
=20
-static long clk_pllv3_round_rate(struct clk_hw *hw, unsigned long rate=
,
-				 unsigned long *prate)
+static int clk_pllv3_round_rate(struct clk_hw *hw, unsigned long *rate=
,
+				unsigned long *prate)
 {
 	unsigned long parent_rate =3D *prate;
=20
-	return (rate >=3D parent_rate * 22) ? parent_rate * 22 :
-					    parent_rate * 20;
+	*rate =3D (*rate >=3D parent_rate * 22) ? parent_rate * 22 :
+					      parent_rate * 20;
+
+	return 0;
 }
=20
 static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -151,21 +153,23 @@ static unsigned long clk_pllv3_sys_recalc_rate(st=
ruct clk_hw *hw,
 	return parent_rate * div / 2;
 }
=20
-static long clk_pllv3_sys_round_rate(struct clk_hw *hw, unsigned long =
rate,
-				     unsigned long *prate)
+static int clk_pllv3_sys_round_rate(struct clk_hw *hw, unsigned long *=
rate,
+				    unsigned long *prate)
 {
 	unsigned long parent_rate =3D *prate;
 	unsigned long min_rate =3D parent_rate * 54 / 2;
 	unsigned long max_rate =3D parent_rate * 108 / 2;
 	u32 div;
=20
-	if (rate > max_rate)
-		rate =3D max_rate;
-	else if (rate < min_rate)
-		rate =3D min_rate;
-	div =3D rate * 2 / parent_rate;
+	if (*rate > max_rate)
+		*rate =3D max_rate;
+	else if (*rate < min_rate)
+		*rate =3D min_rate;
+	div =3D *rate * 2 / parent_rate;
=20
-	return parent_rate * div / 2;
+	*rate =3D parent_rate * div / 2;
+
+	return 0;
 }
=20
 static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rat=
e,
@@ -207,7 +211,7 @@ static unsigned long clk_pllv3_av_recalc_rate(struc=
t clk_hw *hw,
 	return (parent_rate * div) + ((parent_rate / mfd) * mfn);
 }
=20
-static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long r=
ate,
+static int clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long *r=
ate,
 				    unsigned long *prate)
 {
 	unsigned long parent_rate =3D *prate;
@@ -217,18 +221,20 @@ static long clk_pllv3_av_round_rate(struct clk_hw=
 *hw, unsigned long rate,
 	u32 mfn, mfd =3D 1000000;
 	s64 temp64;
=20
-	if (rate > max_rate)
-		rate =3D max_rate;
-	else if (rate < min_rate)
-		rate =3D min_rate;
+	if (*rate > max_rate)
+		*rate =3D max_rate;
+	else if (*rate < min_rate)
+		*rate =3D min_rate;
=20
-	div =3D rate / parent_rate;
-	temp64 =3D (u64) (rate - div * parent_rate);
+	div =3D *rate / parent_rate;
+	temp64 =3D (u64) (*rate - div * parent_rate);
 	temp64 *=3D mfd;
 	do_div(temp64, parent_rate);
 	mfn =3D temp64;
=20
-	return parent_rate * div + parent_rate / mfd * mfn;
+	*rate =3D parent_rate * div + parent_rate / mfd * mfn;
+
+	return 0;
 }
=20
 static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate=
,
diff --git a/arch/arm/mach-msm/clock-pcom.c b/arch/arm/mach-msm/clock-p=
com.c
index f5b69d7..118c288 100644
--- a/arch/arm/mach-msm/clock-pcom.c
+++ b/arch/arm/mach-msm/clock-pcom.c
@@ -109,11 +109,11 @@ static int pc_clk_is_enabled(struct clk_hw *hw)
 		return id;
 }
=20
-static long pc_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int pc_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
 			      unsigned long *p_rate)
 {
 	/* Not really supported; pc_clk_set_rate() does rounding on it's own.=
 */
-	return rate;
+	return 0;
 }
=20
 static struct clk_ops clk_ops_pcom =3D {
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/ma=
ch-omap2/clkt2xxx_virt_prcm_set.c
index 85e0b0c0..2829a6f 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -71,8 +71,8 @@ unsigned long omap2_table_mpu_recalc(struct clk_hw *c=
lk,
  * Some might argue L3-DDR, others ARM, others IVA. This code is simpl=
e and
  * just uses the ARM rates.
  */
-long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate)
+int omap2_round_to_table_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *parent_rate)
 {
 	const struct prcm_config *ptr;
 	long highest_rate;
@@ -88,10 +88,15 @@ long omap2_round_to_table_rate(struct clk_hw *hw, u=
nsigned long rate,
 		highest_rate =3D ptr->mpu_speed;
=20
 		/* Can check only after xtal frequency check */
-		if (ptr->mpu_speed <=3D rate)
+		if (ptr->mpu_speed <=3D *rate)
 			break;
 	}
-	return highest_rate;
+
+	if (highest_rate < 0)
+		return highest_rate;
+
+	*rate =3D highest_rate;
+	return 0;
 }
=20
 /* Sets basic clocks based on the specified rate */
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/cl=
kt_clksel.c
index 7ee2610..b932276 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -385,13 +385,15 @@ unsigned long omap2_clksel_recalc(struct clk_hw *=
hw, unsigned long parent_rate)
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long target_r=
ate,
+int omap2_clksel_round_rate(struct clk_hw *hw, unsigned long *target_r=
ate,
 			unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
 	u32 new_div;
=20
-	return omap2_clksel_round_rate_div(clk, target_rate, &new_div);
+	*target_rate =3D omap2_clksel_round_rate_div(clk, *target_rate,
+						   &new_div);
+	return 0;
 }
=20
 /**
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt=
_dpll.c
index f251a14..7dac6b3 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -280,7 +280,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_oma=
p *clk)
  * (expensive) function again.  Returns ~0 if the target rate cannot
  * be rounded, or the rounded rate upon success.
  */
-long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rat=
e,
+int omap2_dpll_round_rate(struct clk_hw *hw, unsigned long *target_rat=
e,
 		unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
@@ -295,16 +295,16 @@ long omap2_dpll_round_rate(struct clk_hw *hw, uns=
igned long target_rate,
 	const char *clk_name;
=20
 	if (!clk || !clk->dpll_data)
-		return ~0;
+		return -EINVAL;
=20
 	dd =3D clk->dpll_data;
=20
 	ref_rate =3D __clk_get_rate(dd->clk_ref);
 	clk_name =3D __clk_get_name(hw->clk);
 	pr_debug("clock: %s: starting DPLL round_rate, target rate %lu\n",
-		 clk_name, target_rate);
+		 clk_name, *target_rate);
=20
-	scaled_rt_rp =3D target_rate / (ref_rate / DPLL_SCALE_FACTOR);
+	scaled_rt_rp =3D *target_rate / (ref_rate / DPLL_SCALE_FACTOR);
 	scaled_max_m =3D dd->max_multiplier * DPLL_SCALE_FACTOR;
=20
 	dd->last_rounded_rate =3D 0;
@@ -330,7 +330,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsig=
ned long target_rate,
 		if (m > scaled_max_m)
 			break;
=20
-		r =3D _dpll_test_mult(&m, n, &new_rate, target_rate,
+		r =3D _dpll_test_mult(&m, n, &new_rate, *target_rate,
 				    ref_rate);
=20
 		/* m can't be set low enough for this n - try with a larger n */
@@ -338,7 +338,7 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsig=
ned long target_rate,
 			continue;
=20
 		/* skip rates above our target rate */
-		delta =3D target_rate - new_rate;
+		delta =3D *target_rate - new_rate;
 		if (delta < 0)
 			continue;
=20
@@ -357,14 +357,15 @@ long omap2_dpll_round_rate(struct clk_hw *hw, uns=
igned long target_rate,
=20
 	if (prev_min_delta =3D=3D LONG_MAX) {
 		pr_debug("clock: %s: cannot round to rate %lu\n",
-			 clk_name, target_rate);
-		return ~0;
+			 clk_name, *target_rate);
+		return -EINVAL;
 	}
=20
 	dd->last_rounded_m =3D min_delta_m;
 	dd->last_rounded_n =3D min_delta_n;
-	dd->last_rounded_rate =3D target_rate - prev_min_delta;
+	dd->last_rounded_rate =3D *target_rate - prev_min_delta;
=20
-	return dd->last_rounded_rate;
+	*target_rate =3D dd->last_rounded_rate;
+	return 0;
 }
=20
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a56742f..cfe41b7 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -194,8 +194,8 @@ u32 omap2_clksel_round_rate_div(struct clk_hw_omap =
*clk,
 				u32 *new_div);
 u8 omap2_clksel_find_parent_index(struct clk_hw *hw);
 unsigned long omap2_clksel_recalc(struct clk_hw *hw, unsigned long par=
ent_rate);
-long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long target_r=
ate,
-				unsigned long *parent_rate);
+int omap2_clksel_round_rate(struct clk_hw *hw, unsigned long *target_r=
ate,
+			    unsigned long *parent_rate);
 int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate);
 int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3=
xxx.c
index 44e57ec..7a6fb45 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -480,6 +480,7 @@ long omap3_noncore_dpll_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
 	struct dpll_data *dd;
+	int ret;
=20
 	if (!hw || !rate)
 		return -EINVAL;
@@ -492,7 +493,10 @@ long omap3_noncore_dpll_determine_rate(struct clk_=
hw *hw, unsigned long rate,
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
 	} else {
-		rate =3D omap2_dpll_round_rate(hw, rate, best_parent_rate);
+		ret =3D omap2_dpll_round_rate(hw, &rate, best_parent_rate);
+		if (ret)
+			return ret;
+
 		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
 	}
=20
@@ -768,27 +772,33 @@ int omap3_clkoutx2_set_rate(struct clk_hw *hw, un=
signed long rate,
 	return 0;
 }
=20
-long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
+int omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long *prate)
 {
 	const struct dpll_data *dd;
 	u32 v;
 	struct clk_hw_omap *pclk =3D NULL;
=20
-	if (!*prate)
+	if (!*prate) {
+		*rate =3D 0;
 		return 0;
+	}
=20
 	pclk =3D omap3_find_clkoutx2_dpll(hw);
=20
-	if (!pclk)
+	if (!pclk) {
+		*rate =3D 0;
 		return 0;
+	}
=20
 	dd =3D pclk->dpll_data;
=20
 	/* TYPE J does not have a clkoutx2 */
 	if (dd->flags & DPLL_J_TYPE) {
-		*prate =3D __clk_round_rate(__clk_get_parent(pclk->hw.clk), rate);
-		return *prate;
+		*prate =3D __clk_round_rate(__clk_get_parent(pclk->hw.clk),
+					  *rate);
+		*rate =3D *prate;
+		return 0;
 	}
=20
 	WARN_ON(!dd->enable_mask);
@@ -803,12 +813,13 @@ long omap3_clkoutx2_round_rate(struct clk_hw *hw,=
 unsigned long rate,
 	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
 		unsigned long best_parent;
=20
-		best_parent =3D (rate / 2);
+		best_parent =3D (*rate / 2);
 		*prate =3D __clk_round_rate(__clk_get_parent(hw->clk),
 				best_parent);
 	}
=20
-	return *prate * 2;
+	*rate =3D *prate * 2;
+	return 0;
 }
=20
 /* OMAP3/4 non-CORE DPLL clkops */
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll4=
4xx.c
index f231be0..afd3284 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -146,11 +146,12 @@ unsigned long omap4_dpll_regm4xen_recalc(struct c=
lk_hw *hw,
  * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
  * ~0 if an error occurred in omap2_dpll_round_rate().
  */
-long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
-				    unsigned long target_rate,
-				    unsigned long *parent_rate)
+int omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
+				   unsigned long *target_rate,
+				   unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+	unsigned long rate =3D *target_rate;
 	struct dpll_data *dd;
 	long r;
=20
@@ -166,7 +167,7 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *=
hw,
 	 * target rate without using the 4X multiplier.
 	 */
 	r =3D omap2_dpll_round_rate(hw, target_rate, NULL);
-	if (r !=3D ~0)
+	if (!r)
 		goto out;
=20
 	/*
@@ -174,9 +175,9 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *=
hw,
 	 * this time see if using the 4X multiplier can help. Enabling the
 	 * 4X multiplier is equivalent to dividing the target rate by 4.
 	 */
-	r =3D omap2_dpll_round_rate(hw, target_rate / OMAP4430_REGM4XEN_MULT,
-				  NULL);
-	if (r =3D=3D ~0)
+	rate =3D *target_rate / OMAP4430_REGM4XEN_MULT;
+	r =3D omap2_dpll_round_rate(hw, &rate, NULL);
+	if (r)
 		return r;
=20
 	dd->last_rounded_rate *=3D OMAP4430_REGM4XEN_MULT;
@@ -184,8 +185,9 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *=
hw,
=20
 out:
 	omap4_dpll_lpmode_recalc(dd);
+	*target_rate =3D dd->last_rounded_rate;
=20
-	return dd->last_rounded_rate;
+	return 0;
 }
=20
 /**
@@ -209,6 +211,7 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_=
hw *hw, unsigned long rate,
 {
 	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
 	struct dpll_data *dd;
+	int ret;
=20
 	if (!hw || !rate)
 		return -EINVAL;
@@ -221,8 +224,11 @@ long omap4_dpll_regm4xen_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
 		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
 	} else {
-		rate =3D omap4_dpll_regm4xen_round_rate(hw, rate,
-						      best_parent_rate);
+		ret =3D omap4_dpll_regm4xen_round_rate(hw, &rate,
+						     best_parent_rate);
+		if (ret)
+			return ret;
+
 		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
 	}
=20
diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.=
c
index f61158c..774ac3b 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -507,12 +507,19 @@ static unsigned long spc_recalc_rate(struct clk_h=
w *hw,
 	return freq * 1000;
 }
=20
-static long spc_round_rate(struct clk_hw *hw, unsigned long drate,
+static int spc_round_rate(struct clk_hw *hw, unsigned long *drate,
 		unsigned long *parent_rate)
 {
 	struct clk_spc *spc =3D to_clk_spc(hw);
+	long ret;
=20
-	return ve_spc_round_performance(spc->cluster, drate);
+	ret =3D ve_spc_round_performance(spc->cluster, *drate);
+	if (ret < 0)
+		return ret;
+
+	*drate =3D ret;
+
+	return 0;
 }
=20
 static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/commo=
n/clock.c
index 6a98d2c..d697d8f 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -202,24 +202,27 @@ static int alchemy_clk_aux_setr(struct clk_hw *hw=
,
 	return 0;
 }
=20
-static long alchemy_clk_aux_roundr(struct clk_hw *hw,
-					    unsigned long rate,
+static int alchemy_clk_aux_roundr(struct clk_hw *hw,
+					    unsigned long *rate,
 					    unsigned long *parent_rate)
 {
 	struct alchemy_auxpll_clk *a =3D to_auxpll_clk(hw);
 	unsigned long mult;
=20
-	if (!rate || !*parent_rate)
+	if (!*rate || !*parent_rate) {
+		*rate =3D 0;
 		return 0;
+	}
=20
-	mult =3D rate / (*parent_rate);
+	mult =3D *rate / (*parent_rate);
=20
 	if (mult && (mult < 7))
 		mult =3D 7;
 	if (mult > a->maxmult)
 		mult =3D a->maxmult;
=20
-	return (*parent_rate) * mult;
+	*rate =3D (*parent_rate) * mult;
+	return 0;
 }
=20
 static struct clk_ops alchemy_clkops_aux =3D {
diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.=
c
index 152dcb3..e48f31e 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -49,21 +49,25 @@ static unsigned long clk_sama5d4_h32mx_recalc_rate(=
struct clk_hw *hw,
 	return parent_rate;
 }
=20
-static long clk_sama5d4_h32mx_round_rate(struct clk_hw *hw, unsigned l=
ong rate,
-				       unsigned long *parent_rate)
+static int clk_sama5d4_h32mx_round_rate(struct clk_hw *hw,
+					unsigned long *rate,
+					unsigned long *parent_rate)
 {
 	unsigned long div;
=20
-	if (rate > *parent_rate)
-		return *parent_rate;
-	div =3D *parent_rate / 2;
-	if (rate < div)
-		return div;
+	if (*rate > *parent_rate) {
+		*rate =3D *parent_rate;
+		return 0;
+	}
=20
-	if (rate - div < *parent_rate - rate)
-		return div;
+	div =3D *parent_rate / 2;
+	if (*rate < div || (*rate - div) < (*parent_rate - *rate)) {
+		*rate =3D div;
+		return 0;
+	}
=20
-	return *parent_rate;
+	*rate =3D *parent_rate;
+	return 0;
 }
=20
 static int clk_sama5d4_h32mx_set_rate(struct clk_hw *hw, unsigned long=
 rate,
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-p=
eripheral.c
index 597fed4..d990ae0 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -227,9 +227,9 @@ clk_sam9x5_peripheral_recalc_rate(struct clk_hw *hw=
,
 	return parent_rate >> periph->div;
 }
=20
-static long clk_sam9x5_peripheral_round_rate(struct clk_hw *hw,
-					     unsigned long rate,
-					     unsigned long *parent_rate)
+static int clk_sam9x5_peripheral_round_rate(struct clk_hw *hw,
+					    unsigned long *rate,
+					    unsigned long *parent_rate)
 {
 	int shift =3D 0;
 	unsigned long best_rate;
@@ -238,8 +238,10 @@ static long clk_sam9x5_peripheral_round_rate(struc=
t clk_hw *hw,
 	unsigned long cur_diff;
 	struct clk_sam9x5_peripheral *periph =3D to_clk_sam9x5_peripheral(hw)=
;
=20
-	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max)
-		return *parent_rate;
+	if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max) {
+		*rate =3D *parent_rate;
+		return 0;
+	}
=20
 	if (periph->range.max) {
 		for (; shift < PERIPHERAL_MAX_SHIFT; shift++) {
@@ -249,28 +251,31 @@ static long clk_sam9x5_peripheral_round_rate(stru=
ct clk_hw *hw,
 		}
 	}
=20
-	if (rate >=3D cur_rate)
-		return cur_rate;
+	if (*rate >=3D cur_rate) {
+		*rate =3D cur_rate;
+		return 0;
+	}
=20
-	best_diff =3D cur_rate - rate;
+	best_diff =3D cur_rate - *rate;
 	best_rate =3D cur_rate;
 	for (; shift < PERIPHERAL_MAX_SHIFT; shift++) {
 		cur_rate =3D *parent_rate >> shift;
-		if (cur_rate < rate)
-			cur_diff =3D rate - cur_rate;
+		if (cur_rate < *rate)
+			cur_diff =3D *rate - cur_rate;
 		else
-			cur_diff =3D cur_rate - rate;
+			cur_diff =3D cur_rate - *rate;
=20
 		if (cur_diff < best_diff) {
 			best_diff =3D cur_diff;
 			best_rate =3D cur_rate;
 		}
=20
-		if (!best_diff || cur_rate < rate)
+		if (!best_diff || cur_rate < *rate)
 			break;
 	}
=20
-	return best_rate;
+	*rate =3D best_rate;
+	return 0;
 }
=20
 static int clk_sam9x5_peripheral_set_rate(struct clk_hw *hw,
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 6ec79db..e7754eb 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -260,13 +260,19 @@ static long clk_pll_get_best_div_mul(struct clk_p=
ll *pll, unsigned long rate,
 	return bestrate;
 }
=20
-static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *parent_rate)
+static int clk_pll_round_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *parent_rate)
 {
 	struct clk_pll *pll =3D to_clk_pll(hw);
+	long ret;
=20
-	return clk_pll_get_best_div_mul(pll, rate, *parent_rate,
-					NULL, NULL, NULL);
+	ret =3D clk_pll_get_best_div_mul(pll, *rate, *parent_rate,
+				       NULL, NULL, NULL);
+	if (ret < 0)
+		return ret;
+
+	*rate =3D ret;
+	return 0;
 }
=20
 static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldi=
v.c
index ea22656..c267214 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -36,21 +36,23 @@ static unsigned long clk_plldiv_recalc_rate(struct =
clk_hw *hw,
 	return parent_rate;
 }
=20
-static long clk_plldiv_round_rate(struct clk_hw *hw, unsigned long rat=
e,
-					unsigned long *parent_rate)
+static int clk_plldiv_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
+				 unsigned long *parent_rate)
 {
 	unsigned long div;
=20
-	if (rate > *parent_rate)
-		return *parent_rate;
-	div =3D *parent_rate / 2;
-	if (rate < div)
-		return div;
+	if (*rate > *parent_rate) {
+		*rate =3D *parent_rate;
+		return 0;
+	}
=20
-	if (rate - div < *parent_rate - rate)
-		return div;
+	div =3D *parent_rate / 2;
+	if (*rate < div || (*rate - div) < (*parent_rate - *rate))
+		*rate =3D div;
+	else
+		*rate =3D *parent_rate;
=20
-	return *parent_rate;
+	return 0;
 }
=20
 static int clk_plldiv_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 144d47e..cd0f6d2 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -43,26 +43,32 @@ static unsigned long at91sam9x5_clk_smd_recalc_rate=
(struct clk_hw *hw,
 	return parent_rate / (smddiv + 1);
 }
=20
-static long at91sam9x5_clk_smd_round_rate(struct clk_hw *hw, unsigned =
long rate,
-					  unsigned long *parent_rate)
+static int at91sam9x5_clk_smd_round_rate(struct clk_hw *hw,
+					 unsigned long *rate,
+					 unsigned long *parent_rate)
 {
 	unsigned long div;
 	unsigned long bestrate;
 	unsigned long tmp;
=20
-	if (rate >=3D *parent_rate)
-		return *parent_rate;
+	if (*rate >=3D *parent_rate) {
+		*rate =3D *parent_rate;
+		return 0;
+	}
=20
-	div =3D *parent_rate / rate;
-	if (div > SMD_MAX_DIV)
-		return *parent_rate / (SMD_MAX_DIV + 1);
+	div =3D *parent_rate / *rate;
+	if (div > SMD_MAX_DIV) {
+		*rate =3D *parent_rate / (SMD_MAX_DIV + 1);
+		return 0;
+	}
=20
 	bestrate =3D *parent_rate / div;
 	tmp =3D *parent_rate / (div + 1);
-	if (bestrate - rate > rate - tmp)
+	if (bestrate - *rate > *rate - tmp)
 		bestrate =3D tmp;
=20
-	return bestrate;
+	*rate =3D bestrate;
+	return 0;
 }
=20
 static int at91sam9x5_clk_smd_set_parent(struct clk_hw *hw, u8 index)
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index a23ac0c..02599e6 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -56,22 +56,26 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate=
(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
 }
=20
-static long at91sam9x5_clk_usb_round_rate(struct clk_hw *hw, unsigned =
long rate,
-					  unsigned long *parent_rate)
+static int at91sam9x5_clk_usb_round_rate(struct clk_hw *hw,
+					 unsigned long *rate,
+					 unsigned long *parent_rate)
 {
 	unsigned long div;
=20
-	if (!rate)
+	if (!*rate)
 		return -EINVAL;
=20
-	if (rate >=3D *parent_rate)
-		return *parent_rate;
+	if (*rate >=3D *parent_rate) {
+		*rate =3D *parent_rate;
+		return 0;
+	}
=20
-	div =3D DIV_ROUND_CLOSEST(*parent_rate, rate);
+	div =3D DIV_ROUND_CLOSEST(*parent_rate, *rate);
 	if (div > SAM9X5_USB_MAX_DIV + 1)
 		div =3D SAM9X5_USB_MAX_DIV + 1;
=20
-	return DIV_ROUND_CLOSEST(*parent_rate, div);
+	*rate =3D DIV_ROUND_CLOSEST(*parent_rate, div);
+	return 0;
 }
=20
 static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
@@ -235,8 +239,9 @@ static unsigned long at91rm9200_clk_usb_recalc_rate=
(struct clk_hw *hw,
 	return 0;
 }
=20
-static long at91rm9200_clk_usb_round_rate(struct clk_hw *hw, unsigned =
long rate,
-					  unsigned long *parent_rate)
+static int at91rm9200_clk_usb_round_rate(struct clk_hw *hw,
+					 unsigned long *rate,
+					 unsigned long *parent_rate)
 {
 	struct at91rm9200_clk_usb *usb =3D to_at91rm9200_clk_usb(hw);
 	struct clk *parent =3D __clk_get_parent(hw->clk);
@@ -252,13 +257,13 @@ static long at91rm9200_clk_usb_round_rate(struct =
clk_hw *hw, unsigned long rate,
 		if (!usb->divisors[i])
 			continue;
=20
-		tmp_parent_rate =3D rate * usb->divisors[i];
+		tmp_parent_rate =3D *rate * usb->divisors[i];
 		tmp_parent_rate =3D __clk_round_rate(parent, tmp_parent_rate);
 		tmprate =3D DIV_ROUND_CLOSEST(tmp_parent_rate, usb->divisors[i]);
-		if (tmprate < rate)
-			tmpdiff =3D rate - tmprate;
+		if (tmprate < *rate)
+			tmpdiff =3D *rate - tmprate;
 		else
-			tmpdiff =3D tmprate - rate;
+			tmpdiff =3D tmprate - *rate;
=20
 		if (bestdiff < 0 || bestdiff > tmpdiff) {
 			bestrate =3D tmprate;
@@ -270,7 +275,8 @@ static long at91rm9200_clk_usb_round_rate(struct cl=
k_hw *hw, unsigned long rate,
 			break;
 	}
=20
-	return bestrate;
+	*rate =3D bestrate;
+	return 0;
 }
=20
 static int at91rm9200_clk_usb_set_rate(struct clk_hw *hw, unsigned lon=
g rate,
diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.=
c
index e619285..3509d50 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -405,7 +405,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_h=
w,
 	return 0;
 }
=20
-static long axi_clkgen_round_rate(struct clk_hw *hw, unsigned long rat=
e,
+static int axi_clkgen_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
 	unsigned long *parent_rate)
 {
 	unsigned int d, m, dout;
@@ -415,7 +415,8 @@ static long axi_clkgen_round_rate(struct clk_hw *hw=
, unsigned long rate,
 	if (d =3D=3D 0 || dout =3D=3D 0 || m =3D=3D 0)
 		return -EINVAL;
=20
-	return *parent_rate / d * m / dout;
+	*rate =3D *parent_rate / d * m / dout;
+	return 0;
 }
=20
 static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index c386ad2..f110959 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -187,8 +187,8 @@ static unsigned long cdce706_pll_recalc_rate(struct=
 clk_hw *hw,
 	return 0;
 }
=20
-static long cdce706_pll_round_rate(struct clk_hw *hw, unsigned long ra=
te,
-				   unsigned long *parent_rate)
+static int cdce706_pll_round_rate(struct clk_hw *hw, unsigned long *ra=
te,
+				  unsigned long *parent_rate)
 {
 	struct cdce706_hw_data *hwd =3D to_hw_data(hw);
 	unsigned long mul, div;
@@ -196,9 +196,9 @@ static long cdce706_pll_round_rate(struct clk_hw *h=
w, unsigned long rate,
=20
 	dev_dbg(&hwd->dev_data->client->dev,
 		"%s, rate: %lu, parent_rate: %lu\n",
-		__func__, rate, *parent_rate);
+		__func__, *rate, *parent_rate);
=20
-	rational_best_approximation(rate, *parent_rate,
+	rational_best_approximation(*rate, *parent_rate,
 				    CDCE706_PLL_N_MAX, CDCE706_PLL_M_MAX,
 				    &mul, &div);
 	hwd->mul =3D mul;
@@ -210,7 +210,8 @@ static long cdce706_pll_round_rate(struct clk_hw *h=
w, unsigned long rate,
=20
 	res =3D (u64)*parent_rate * hwd->mul;
 	do_div(res, hwd->div);
-	return res;
+	*rate =3D res;
+	return 0;
 }
=20
 static int cdce706_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -292,8 +293,8 @@ static unsigned long cdce706_divider_recalc_rate(st=
ruct clk_hw *hw,
 	return 0;
 }
=20
-static long cdce706_divider_round_rate(struct clk_hw *hw, unsigned lon=
g rate,
-				       unsigned long *parent_rate)
+static int cdce706_divider_round_rate(struct clk_hw *hw, unsigned long=
 *rate,
+				      unsigned long *parent_rate)
 {
 	struct cdce706_hw_data *hwd =3D to_hw_data(hw);
 	struct cdce706_dev_data *cdce =3D hwd->dev_data;
@@ -301,31 +302,31 @@ static long cdce706_divider_round_rate(struct clk=
_hw *hw, unsigned long rate,
=20
 	dev_dbg(&hwd->dev_data->client->dev,
 		"%s, rate: %lu, parent_rate: %lu\n",
-		__func__, rate, *parent_rate);
+		__func__, *rate, *parent_rate);
=20
-	rational_best_approximation(rate, *parent_rate,
+	rational_best_approximation(*rate, *parent_rate,
 				    1, CDCE706_DIVIDER_DIVIDER_MAX,
 				    &mul, &div);
 	if (!mul)
 		div =3D CDCE706_DIVIDER_DIVIDER_MAX;
=20
 	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
-		unsigned long best_diff =3D rate;
+		unsigned long best_diff =3D *rate;
 		unsigned long best_div =3D 0;
 		struct clk *gp_clk =3D cdce->clkin_clk[cdce->clkin[0].parent];
 		unsigned long gp_rate =3D gp_clk ? clk_get_rate(gp_clk) : 0;
=20
-		for (div =3D CDCE706_PLL_FREQ_MIN / rate; best_diff &&
-		     div <=3D CDCE706_PLL_FREQ_MAX / rate; ++div) {
+		for (div =3D CDCE706_PLL_FREQ_MIN / *rate; best_diff &&
+		     div <=3D CDCE706_PLL_FREQ_MAX / *rate; ++div) {
 			unsigned long n, m;
 			unsigned long diff;
 			unsigned long div_rate;
 			u64 div_rate64;
=20
-			if (rate * div < CDCE706_PLL_FREQ_MIN)
+			if (*rate * div < CDCE706_PLL_FREQ_MIN)
 				continue;
=20
-			rational_best_approximation(rate * div, gp_rate,
+			rational_best_approximation(*rate * div, gp_rate,
 						    CDCE706_PLL_N_MAX,
 						    CDCE706_PLL_M_MAX,
 						    &n, &m);
@@ -333,7 +334,7 @@ static long cdce706_divider_round_rate(struct clk_h=
w *hw, unsigned long rate,
 			do_div(div_rate64, m);
 			do_div(div_rate64, div);
 			div_rate =3D div_rate64;
-			diff =3D max(div_rate, rate) - min(div_rate, rate);
+			diff =3D max(div_rate, *rate) - min(div_rate, *rate);
=20
 			if (diff < best_diff) {
 				best_diff =3D diff;
@@ -348,8 +349,8 @@ static long cdce706_divider_round_rate(struct clk_h=
w *hw, unsigned long rate,
=20
 		dev_dbg(&hwd->dev_data->client->dev,
 			"%s, altering parent rate: %lu -> %lu\n",
-			__func__, *parent_rate, rate * div);
-		*parent_rate =3D rate * div;
+			__func__, *parent_rate, *rate * div);
+		*parent_rate =3D *rate * div;
 	}
 	hwd->div =3D div;
=20
@@ -357,7 +358,8 @@ static long cdce706_divider_round_rate(struct clk_h=
w *hw, unsigned long rate,
 		"%s, divider: %d, div: %lu\n",
 		__func__, hwd->idx, div);
=20
-	return *parent_rate / div;
+	*rate =3D *parent_rate / div;
+	return 0;
 }
=20
 static int cdce706_divider_set_rate(struct clk_hw *hw, unsigned long r=
ate,
@@ -425,11 +427,11 @@ static unsigned long cdce706_clkout_recalc_rate(s=
truct clk_hw *hw,
 	return parent_rate;
 }
=20
-static long cdce706_clkout_round_rate(struct clk_hw *hw, unsigned long=
 rate,
-				      unsigned long *parent_rate)
+static int cdce706_clkout_round_rate(struct clk_hw *hw, unsigned long =
*rate,
+				     unsigned long *parent_rate)
 {
-	*parent_rate =3D rate;
-	return rate;
+	*parent_rate =3D *rate;
+	return 0;
 }
=20
 static int cdce706_clkout_set_rate(struct clk_hw *hw, unsigned long ra=
te,
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 956b7e5..f56a71d 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -68,10 +68,10 @@ static long clk_composite_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	struct clk_hw *mux_hw =3D composite->mux_hw;
 	struct clk *parent;
 	unsigned long parent_rate;
-	long tmp_rate, best_rate =3D 0;
+	unsigned long tmp_rate, best_rate =3D 0;
 	unsigned long rate_diff;
 	unsigned long best_rate_diff =3D ULONG_MAX;
-	int i;
+	int ret, i;
=20
 	if (rate_hw && rate_ops && rate_ops->determine_rate) {
 		__clk_hw_set_clk(rate_hw, hw);
@@ -88,8 +88,12 @@ static long clk_composite_determine_rate(struct clk_=
hw *hw, unsigned long rate,
 			*best_parent_p =3D __clk_get_hw(parent);
 			*best_parent_rate =3D __clk_get_rate(parent);
=20
-			return rate_ops->round_rate(rate_hw, rate,
-						    best_parent_rate);
+			ret =3D rate_ops->round_rate(rate_hw, &rate,
+						   best_parent_rate);
+			if (ret)
+				return ret;
+
+			return rate;
 		}
=20
 		for (i =3D 0; i < __clk_get_num_parents(mux_hw->clk); i++) {
@@ -99,9 +103,10 @@ static long clk_composite_determine_rate(struct clk=
_hw *hw, unsigned long rate,
=20
 			parent_rate =3D __clk_get_rate(parent);
=20
-			tmp_rate =3D rate_ops->round_rate(rate_hw, rate,
-							&parent_rate);
-			if (tmp_rate < 0)
+			tmp_rate =3D rate;
+			ret =3D rate_ops->round_rate(rate_hw, &tmp_rate,
+						   &parent_rate);
+			if (ret < 0)
 				continue;
=20
 			rate_diff =3D abs(rate - tmp_rate);
@@ -130,8 +135,8 @@ static long clk_composite_determine_rate(struct clk=
_hw *hw, unsigned long rate,
 	}
 }
=20
-static long clk_composite_round_rate(struct clk_hw *hw, unsigned long =
rate,
-				  unsigned long *prate)
+static int clk_composite_round_rate(struct clk_hw *hw, unsigned long *=
rate,
+				     unsigned long *prate)
 {
 	struct clk_composite *composite =3D to_clk_composite(hw);
 	const struct clk_ops *rate_ops =3D composite->rate_ops;
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 25006a8..f646a0c 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -329,19 +329,20 @@ static int clk_divider_bestdiv(struct clk_hw *hw,=
 unsigned long rate,
 	return bestdiv;
 }
=20
-long divider_round_rate(struct clk_hw *hw, unsigned long rate,
-			unsigned long *prate, const struct clk_div_table *table,
-			u8 width, unsigned long flags)
+int divider_round_rate(struct clk_hw *hw, unsigned long *rate,
+		       unsigned long *prate, const struct clk_div_table *table,
+		       u8 width, unsigned long flags)
 {
 	int div;
=20
-	div =3D clk_divider_bestdiv(hw, rate, prate, table, width, flags);
+	div =3D clk_divider_bestdiv(hw, *rate, prate, table, width, flags);
=20
-	return DIV_ROUND_UP(*prate, div);
+	*rate =3D DIV_ROUND_UP(*prate, div);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(divider_round_rate);
=20
-static long clk_divider_round_rate(struct clk_hw *hw, unsigned long ra=
te,
+static int clk_divider_round_rate(struct clk_hw *hw, unsigned long *ra=
te,
 				unsigned long *prate)
 {
 	struct clk_divider *divider =3D to_clk_divider(hw);
@@ -352,7 +353,8 @@ static long clk_divider_round_rate(struct clk_hw *h=
w, unsigned long rate,
 		bestdiv =3D readl(divider->reg) >> divider->shift;
 		bestdiv &=3D div_mask(divider->width);
 		bestdiv =3D _get_div(divider->table, bestdiv, divider->flags);
-		return DIV_ROUND_UP(*prate, bestdiv);
+		*rate =3D DIV_ROUND_UP(*prate, bestdiv);
+		return 0;
 	}
=20
 	return divider_round_rate(hw, rate, prate, divider->table,
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-fac=
tor.c
index d9e3f67..ff936d0 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -36,7 +36,7 @@ static unsigned long clk_factor_recalc_rate(struct cl=
k_hw *hw,
 	return (unsigned long)rate;
 }
=20
-static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rat=
e,
+static int clk_factor_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
 				unsigned long *prate)
 {
 	struct clk_fixed_factor *fix =3D to_clk_fixed_factor(hw);
@@ -44,12 +44,13 @@ static long clk_factor_round_rate(struct clk_hw *hw=
, unsigned long rate,
 	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
 		unsigned long best_parent;
=20
-		best_parent =3D (rate / fix->mult) * fix->div;
+		best_parent =3D (*rate / fix->mult) * fix->div;
 		*prate =3D __clk_round_rate(__clk_get_parent(hw->clk),
 				best_parent);
 	}
=20
-	return (*prate / fix->div) * fix->mult;
+	*rate =3D (*prate / fix->div) * fix->mult;
+	return 0;
 }
=20
 static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fra=
ctional-divider.c
index 6aa72d9..1f1ba3e 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -45,24 +45,26 @@ static unsigned long clk_fd_recalc_rate(struct clk_=
hw *hw,
 	return ret;
 }
=20
-static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long *prate)
+static int clk_fd_round_rate(struct clk_hw *hw, unsigned long *rate,
+			     unsigned long *prate)
 {
 	struct clk_fractional_divider *fd =3D to_clk_fd(hw);
 	unsigned maxn =3D (fd->nmask >> fd->nshift) + 1;
 	unsigned div;
=20
-	if (!rate || rate >=3D *prate)
-		return *prate;
+	if (!*rate || *rate >=3D *prate) {
+		*rate =3D *prate;
+		return 0;
+	}
=20
-	div =3D gcd(*prate, rate);
+	div =3D gcd(*prate, *rate);
=20
 	while ((*prate / div) > maxn) {
 		div <<=3D 1;
-		rate <<=3D 1;
+		*rate <<=3D 1;
 	}
=20
-	return rate;
+	return 0;
 }
=20
 static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 2e7e9d9..f26d1b0 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -142,15 +142,16 @@ static void clk_pll_calc(unsigned long rate, unsi=
gned long ref_freq,
 	*pdivf =3D divf;
 }
=20
-static long clk_pll_round_rate(struct clk_hw *hwclk, unsigned long rat=
e,
-			       unsigned long *parent_rate)
+static int clk_pll_round_rate(struct clk_hw *hwclk, unsigned long *rat=
e,
+			      unsigned long *parent_rate)
 {
 	u32 divq, divf;
 	unsigned long ref_freq =3D *parent_rate;
=20
-	clk_pll_calc(rate, ref_freq, &divq, &divf);
+	clk_pll_calc(*rate, ref_freq, &divq, &divf);
=20
-	return (ref_freq * (divf + 1)) / (1 << divq);
+	*rate =3D (ref_freq * (divf + 1)) / (1 << divq);
+	return 0;
 }
=20
 static int clk_pll_set_rate(struct clk_hw *hwclk, unsigned long rate,
@@ -239,16 +240,17 @@ static unsigned long clk_periclk_recalc_rate(stru=
ct clk_hw *hwclk,
 	return parent_rate / div;
 }
=20
-static long clk_periclk_round_rate(struct clk_hw *hwclk, unsigned long=
 rate,
-				   unsigned long *parent_rate)
+static int clk_periclk_round_rate(struct clk_hw *hwclk, unsigned long =
*rate,
+				  unsigned long *parent_rate)
 {
 	u32 div;
=20
-	div =3D *parent_rate / rate;
+	div =3D *parent_rate / *rate;
 	div++;
 	div &=3D ~0x1;
=20
-	return *parent_rate / div;
+	*rate =3D *parent_rate / div;
+	return 0;
 }
=20
 static int clk_periclk_set_rate(struct clk_hw *hwclk, unsigned long ra=
te,
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 3b2a66f..8fad555 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -446,30 +446,30 @@ static unsigned long si5351_pll_recalc_rate(struc=
t clk_hw *hw,
 	return (unsigned long)rate;
 }
=20
-static long si5351_pll_round_rate(struct clk_hw *hw, unsigned long rat=
e,
-				  unsigned long *parent_rate)
+static int si5351_pll_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
+				 unsigned long *parent_rate)
 {
 	struct si5351_hw_data *hwdata =3D
 		container_of(hw, struct si5351_hw_data, hw);
 	unsigned long rfrac, denom, a, b, c;
 	unsigned long long lltmp;
=20
-	if (rate < SI5351_PLL_VCO_MIN)
-		rate =3D SI5351_PLL_VCO_MIN;
-	if (rate > SI5351_PLL_VCO_MAX)
-		rate =3D SI5351_PLL_VCO_MAX;
+	if (*rate < SI5351_PLL_VCO_MIN)
+		*rate =3D SI5351_PLL_VCO_MIN;
+	if (*rate > SI5351_PLL_VCO_MAX)
+		*rate =3D SI5351_PLL_VCO_MAX;
=20
 	/* determine integer part of feedback equation */
-	a =3D rate / *parent_rate;
+	a =3D *rate / *parent_rate;
=20
 	if (a < SI5351_PLL_A_MIN)
-		rate =3D *parent_rate * SI5351_PLL_A_MIN;
+		*rate =3D *parent_rate * SI5351_PLL_A_MIN;
 	if (a > SI5351_PLL_A_MAX)
-		rate =3D *parent_rate * SI5351_PLL_A_MAX;
+		*rate =3D *parent_rate * SI5351_PLL_A_MAX;
=20
 	/* find best approximation for b/c =3D fVCO mod fIN */
 	denom =3D 1000 * 1000;
-	lltmp =3D rate % (*parent_rate);
+	lltmp =3D *rate % (*parent_rate);
 	lltmp *=3D denom;
 	do_div(lltmp, *parent_rate);
 	rfrac =3D (unsigned long)lltmp;
@@ -492,15 +492,15 @@ static long si5351_pll_round_rate(struct clk_hw *=
hw, unsigned long rate,
 	lltmp *=3D b;
 	do_div(lltmp, c);
=20
-	rate  =3D (unsigned long)lltmp;
-	rate +=3D *parent_rate * a;
+	*rate  =3D (unsigned long)lltmp;
+	*rate +=3D *parent_rate * a;
=20
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: a =3D %lu, b =3D %lu, c =3D %lu, parent_rate =3D %lu, rate=
 =3D %lu\n",
 		__func__, __clk_get_name(hwdata->hw.clk), a, b, c,
-		*parent_rate, rate);
+		*parent_rate, *rate);
=20
-	return rate;
+	return 0;
 }
=20
 static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -639,8 +639,8 @@ static unsigned long si5351_msynth_recalc_rate(stru=
ct clk_hw *hw,
 	return (unsigned long)rate;
 }
=20
-static long si5351_msynth_round_rate(struct clk_hw *hw, unsigned long =
rate,
-				     unsigned long *parent_rate)
+static int si5351_msynth_round_rate(struct clk_hw *hw, unsigned long *=
rate,
+				    unsigned long *parent_rate)
 {
 	struct si5351_hw_data *hwdata =3D
 		container_of(hw, struct si5351_hw_data, hw);
@@ -649,17 +649,17 @@ static long si5351_msynth_round_rate(struct clk_h=
w *hw, unsigned long rate,
 	int divby4;
=20
 	/* multisync6-7 can only handle freqencies < 150MHz */
-	if (hwdata->num >=3D 6 && rate > SI5351_MULTISYNTH67_MAX_FREQ)
-		rate =3D SI5351_MULTISYNTH67_MAX_FREQ;
+	if (hwdata->num >=3D 6 && *rate > SI5351_MULTISYNTH67_MAX_FREQ)
+		*rate =3D SI5351_MULTISYNTH67_MAX_FREQ;
=20
 	/* multisync frequency is 1MHz .. 160MHz */
-	if (rate > SI5351_MULTISYNTH_MAX_FREQ)
-		rate =3D SI5351_MULTISYNTH_MAX_FREQ;
-	if (rate < SI5351_MULTISYNTH_MIN_FREQ)
-		rate =3D SI5351_MULTISYNTH_MIN_FREQ;
+	if (*rate > SI5351_MULTISYNTH_MAX_FREQ)
+		*rate =3D SI5351_MULTISYNTH_MAX_FREQ;
+	if (*rate < SI5351_MULTISYNTH_MIN_FREQ)
+		*rate =3D SI5351_MULTISYNTH_MIN_FREQ;
=20
 	divby4 =3D 0;
-	if (rate > SI5351_MULTISYNTH_DIVBY4_FREQ)
+	if (*rate > SI5351_MULTISYNTH_DIVBY4_FREQ)
 		divby4 =3D 1;
=20
 	/* multisync can set pll */
@@ -670,7 +670,7 @@ static long si5351_msynth_round_rate(struct clk_hw =
*hw, unsigned long rate,
 		 */
 		if (divby4 =3D=3D 0) {
 			lltmp =3D SI5351_PLL_VCO_MAX;
-			do_div(lltmp, rate);
+			do_div(lltmp, *rate);
 			a =3D (unsigned long)lltmp;
 		} else
 			a =3D 4;
@@ -678,18 +678,18 @@ static long si5351_msynth_round_rate(struct clk_h=
w *hw, unsigned long rate,
 		b =3D 0;
 		c =3D 1;
=20
-		*parent_rate =3D a * rate;
+		*parent_rate =3D a * *rate;
 	} else {
 		unsigned long rfrac, denom;
=20
 		/* disable divby4 */
 		if (divby4) {
-			rate =3D SI5351_MULTISYNTH_DIVBY4_FREQ;
+			*rate =3D SI5351_MULTISYNTH_DIVBY4_FREQ;
 			divby4 =3D 0;
 		}
=20
 		/* determine integer part of divider equation */
-		a =3D *parent_rate / rate;
+		a =3D *parent_rate / *rate;
 		if (a < SI5351_MULTISYNTH_A_MIN)
 			a =3D SI5351_MULTISYNTH_A_MIN;
 		if (hwdata->num >=3D 6 && a > SI5351_MULTISYNTH67_A_MAX)
@@ -699,9 +699,9 @@ static long si5351_msynth_round_rate(struct clk_hw =
*hw, unsigned long rate,
=20
 		/* find best approximation for b/c =3D fVCO mod fOUT */
 		denom =3D 1000 * 1000;
-		lltmp =3D (*parent_rate) % rate;
+		lltmp =3D (*parent_rate) % *rate;
 		lltmp *=3D denom;
-		do_div(lltmp, rate);
+		do_div(lltmp, *rate);
 		rfrac =3D (unsigned long)lltmp;
=20
 		b =3D 0;
@@ -716,7 +716,7 @@ static long si5351_msynth_round_rate(struct clk_hw =
*hw, unsigned long rate,
 	lltmp  =3D *parent_rate;
 	lltmp *=3D c;
 	do_div(lltmp, a * c + b);
-	rate  =3D (unsigned long)lltmp;
+	*rate  =3D (unsigned long)lltmp;
=20
 	/* calculate parameters */
 	if (divby4) {
@@ -734,9 +734,9 @@ static long si5351_msynth_round_rate(struct clk_hw =
*hw, unsigned long rate,
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: a =3D %lu, b =3D %lu, c =3D %lu, divby4 =3D %d, parent_rat=
e =3D %lu, rate =3D %lu\n",
 		__func__, __clk_get_name(hwdata->hw.clk), a, b, c, divby4,
-		*parent_rate, rate);
+		*parent_rate, *rate);
=20
-	return rate;
+	return 0;
 }
=20
 static int si5351_msynth_set_rate(struct clk_hw *hw, unsigned long rat=
e,
@@ -983,57 +983,57 @@ static unsigned long si5351_clkout_recalc_rate(st=
ruct clk_hw *hw,
 	return parent_rate >> rdiv;
 }
=20
-static long si5351_clkout_round_rate(struct clk_hw *hw, unsigned long =
rate,
-				     unsigned long *parent_rate)
+static int si5351_clkout_round_rate(struct clk_hw *hw, unsigned long *=
rate,
+				    unsigned long *parent_rate)
 {
 	struct si5351_hw_data *hwdata =3D
 		container_of(hw, struct si5351_hw_data, hw);
 	unsigned char rdiv;
=20
 	/* clkout6/7 can only handle output freqencies < 150MHz */
-	if (hwdata->num >=3D 6 && rate > SI5351_CLKOUT67_MAX_FREQ)
-		rate =3D SI5351_CLKOUT67_MAX_FREQ;
+	if (hwdata->num >=3D 6 && *rate > SI5351_CLKOUT67_MAX_FREQ)
+		*rate =3D SI5351_CLKOUT67_MAX_FREQ;
=20
 	/* clkout freqency is 8kHz - 160MHz */
-	if (rate > SI5351_CLKOUT_MAX_FREQ)
-		rate =3D SI5351_CLKOUT_MAX_FREQ;
-	if (rate < SI5351_CLKOUT_MIN_FREQ)
-		rate =3D SI5351_CLKOUT_MIN_FREQ;
+	if (*rate > SI5351_CLKOUT_MAX_FREQ)
+		*rate =3D SI5351_CLKOUT_MAX_FREQ;
+	if (*rate < SI5351_CLKOUT_MIN_FREQ)
+		*rate =3D SI5351_CLKOUT_MIN_FREQ;
=20
 	/* request frequency if multisync master */
 	if (__clk_get_flags(hwdata->hw.clk) & CLK_SET_RATE_PARENT) {
 		/* use r divider for frequencies below 1MHz */
 		rdiv =3D SI5351_OUTPUT_CLK_DIV_1;
-		while (rate < SI5351_MULTISYNTH_MIN_FREQ &&
+		while (*rate < SI5351_MULTISYNTH_MIN_FREQ &&
 		       rdiv < SI5351_OUTPUT_CLK_DIV_128) {
 			rdiv +=3D 1;
-			rate *=3D 2;
+			*rate *=3D 2;
 		}
-		*parent_rate =3D rate;
+		*parent_rate =3D *rate;
 	} else {
 		unsigned long new_rate, new_err, err;
=20
 		/* round to closed rdiv */
 		rdiv =3D SI5351_OUTPUT_CLK_DIV_1;
 		new_rate =3D *parent_rate;
-		err =3D abs(new_rate - rate);
+		err =3D abs(new_rate - *rate);
 		do {
 			new_rate >>=3D 1;
-			new_err =3D abs(new_rate - rate);
+			new_err =3D abs(new_rate - *rate);
 			if (new_err > err || rdiv =3D=3D SI5351_OUTPUT_CLK_DIV_128)
 				break;
 			rdiv++;
 			err =3D new_err;
 		} while (1);
 	}
-	rate =3D *parent_rate >> rdiv;
+	*rate =3D *parent_rate >> rdiv;
=20
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: rdiv =3D %u, parent_rate =3D %lu, rate =3D %lu\n",
 		__func__, __clk_get_name(hwdata->hw.clk), (1 << rdiv),
-		*parent_rate, rate);
+		*parent_rate, *rate);
=20
-	return rate;
+	return 0;
 }
=20
 static int si5351_clkout_set_rate(struct clk_hw *hw, unsigned long rat=
e,
diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index fc167b3..0680863 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -245,7 +245,7 @@ static unsigned long si570_recalc_rate(struct clk_h=
w *hw,
 	return rate;
 }
=20
-static long si570_round_rate(struct clk_hw *hw, unsigned long rate,
+static int si570_round_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long *parent_rate)
 {
 	int err;
@@ -253,26 +253,26 @@ static long si570_round_rate(struct clk_hw *hw, u=
nsigned long rate,
 	unsigned int n1, hs_div;
 	struct clk_si570 *data =3D to_clk_si570(hw);
=20
-	if (!rate)
+	if (!*rate)
 		return 0;
=20
-	if (div64_u64(abs(rate - data->frequency) * 10000LL,
+	if (div64_u64(abs(*rate - data->frequency) * 10000LL,
 				data->frequency) < 35) {
-		rfreq =3D div64_u64((data->rfreq * rate) +
+		rfreq =3D div64_u64((data->rfreq * *rate) +
 				div64_u64(data->frequency, 2), data->frequency);
 		n1 =3D data->n1;
 		hs_div =3D data->hs_div;
=20
 	} else {
-		err =3D si570_calc_divs(rate, data, &rfreq, &n1, &hs_div);
+		err =3D si570_calc_divs(*rate, data, &rfreq, &n1, &hs_div);
 		if (err) {
 			dev_err(&data->i2c_client->dev,
 					"unable to round rate\n");
-			return 0;
+			*rate =3D 0;
 		}
 	}
=20
-	return rate;
+	return 0;
 }
=20
 /**
diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
index 406bfc1..5e3163b 100644
--- a/drivers/clk/clk-u300.c
+++ b/drivers/clk/clk-u300.c
@@ -628,22 +628,27 @@ syscon_clk_recalc_rate(struct clk_hw *hw,
 	}
 }
=20
-static long
-syscon_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int
+syscon_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
 		      unsigned long *prate)
 {
 	struct clk_syscon *sclk =3D to_syscon(hw);
=20
-	if (sclk->clk_val !=3D U300_SYSCON_SBCER_CPU_CLK_EN)
-		return *prate;
+	if (sclk->clk_val !=3D U300_SYSCON_SBCER_CPU_CLK_EN) {
+		*rate =3D *prate;
+		return 0;
+	}
 	/* We really only support setting the rate of the CPU clock */
-	if (rate <=3D 13000000)
-		return 13000000;
-	if (rate <=3D 52000000)
-		return 52000000;
-	if (rate <=3D 104000000)
-		return 104000000;
-	return 208000000;
+	if (*rate <=3D 13000000)
+		*rate =3D 13000000;
+	else if (*rate <=3D 52000000)
+		*rate =3D 52000000;
+	else if (*rate <=3D 104000000)
+		*rate =3D 104000000;
+	else
+		*rate =3D 208000000;
+
+	return 0;
 }
=20
 static int syscon_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1037,26 +1042,28 @@ mclk_clk_recalc_rate(struct clk_hw *hw,
 	return parent_rate;
 }
=20
-static long
-mclk_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int
+mclk_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
 		    unsigned long *prate)
 {
-	if (rate <=3D 18900000)
-		return 18900000;
-	if (rate <=3D 20800000)
-		return 20800000;
-	if (rate <=3D 23100000)
-		return 23100000;
-	if (rate <=3D 26000000)
-		return 26000000;
-	if (rate <=3D 29700000)
-		return 29700000;
-	if (rate <=3D 34700000)
-		return 34700000;
-	if (rate <=3D 41600000)
-		return 41600000;
-	/* Highest rate */
-	return 52000000;
+	if (*rate <=3D 18900000)
+		*rate =3D 18900000;
+	else if (*rate <=3D 20800000)
+		*rate =3D 20800000;
+	else if (*rate <=3D 23100000)
+		*rate =3D 23100000;
+	else if (*rate <=3D 26000000)
+		*rate =3D 26000000;
+	else if (*rate <=3D 29700000)
+		*rate =3D 29700000;
+	else if (*rate <=3D 34700000)
+		*rate =3D 34700000;
+	else if (*rate <=3D 41600000)
+		*rate =3D 41600000;
+	else
+		*rate =3D 52000000;
+
+	return 0;
 }
=20
 static int mclk_clk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 37e9288..221eec3 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -137,19 +137,19 @@ static unsigned long vt8500_dclk_recalc_rate(stru=
ct clk_hw *hw,
 	return parent_rate / div;
 }
=20
-static long vt8500_dclk_round_rate(struct clk_hw *hw, unsigned long ra=
te,
+static int vt8500_dclk_round_rate(struct clk_hw *hw, unsigned long *ra=
te,
 				unsigned long *prate)
 {
 	struct clk_device *cdev =3D to_clk_device(hw);
 	u32 divisor;
=20
-	if (rate =3D=3D 0)
+	if (*rate =3D=3D 0)
 		return 0;
=20
-	divisor =3D *prate / rate;
+	divisor =3D *prate / *rate;
=20
 	/* If prate / rate would be decimal, incr the divisor */
-	if (rate * divisor < *prate)
+	if (*rate * divisor < *prate)
 		divisor++;
=20
 	/*
@@ -160,7 +160,8 @@ static long vt8500_dclk_round_rate(struct clk_hw *h=
w, unsigned long rate,
 		divisor =3D 64 * ((divisor / 64) + 1);
 	}
=20
-	return *prate / divisor;
+	*rate =3D *prate / divisor;
+	return 0;
 }
=20
 static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -579,8 +580,8 @@ static int vtwm_pll_set_rate(struct clk_hw *hw, uns=
igned long rate,
 	return 0;
 }
=20
-static long vtwm_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int vtwm_pll_round_rate(struct clk_hw *hw, unsigned long *rate,
+			       unsigned long *prate)
 {
 	struct clk_pll *pll =3D to_clk_pll(hw);
 	u32 filter, mul, div1, div2;
@@ -588,26 +589,28 @@ static long vtwm_pll_round_rate(struct clk_hw *hw=
, unsigned long rate,
=20
 	switch (pll->type) {
 	case PLL_TYPE_VT8500:
-		vt8500_find_pll_bits(rate, *prate, &mul, &div1);
+		vt8500_find_pll_bits(*rate, *prate, &mul, &div1);
 		round_rate =3D VT8500_BITS_TO_FREQ(*prate, mul, div1);
 		break;
 	case PLL_TYPE_WM8650:
-		wm8650_find_pll_bits(rate, *prate, &mul, &div1, &div2);
+		wm8650_find_pll_bits(*rate, *prate, &mul, &div1, &div2);
 		round_rate =3D WM8650_BITS_TO_FREQ(*prate, mul, div1, div2);
 		break;
 	case PLL_TYPE_WM8750:
-		wm8750_find_pll_bits(rate, *prate, &filter, &mul, &div1, &div2);
+		wm8750_find_pll_bits(*rate, *prate, &filter, &mul, &div1,
+				     &div2);
 		round_rate =3D WM8750_BITS_TO_FREQ(*prate, mul, div1, div2);
 		break;
 	case PLL_TYPE_WM8850:
-		wm8850_find_pll_bits(rate, *prate, &mul, &div1, &div2);
+		wm8850_find_pll_bits(*rate, *prate, &mul, &div1, &div2);
 		round_rate =3D WM8850_BITS_TO_FREQ(*prate, mul, div1, div2);
 		break;
 	default:
 		round_rate =3D 0;
 	}
=20
-	return round_rate;
+	*rate =3D round_rate;
+	return 0;
 }
=20
 static unsigned long vtwm_pll_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index ef67719..23db1b5 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -142,18 +142,19 @@ static unsigned long wm831x_fll_recalc_rate(struc=
t clk_hw *hw,
 	return 0;
 }
=20
-static long wm831x_fll_round_rate(struct clk_hw *hw, unsigned long rat=
e,
-				  unsigned long *unused)
+static int wm831x_fll_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
+				 unsigned long *unused)
 {
 	int best =3D 0;
 	int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(wm831x_fll_auto_rates); i++)
-		if (abs(wm831x_fll_auto_rates[i] - rate) <
-		    abs(wm831x_fll_auto_rates[best] - rate))
+		if (abs(wm831x_fll_auto_rates[i] - *rate) <
+		    abs(wm831x_fll_auto_rates[best] - *rate))
 			best =3D i;
=20
-	return wm831x_fll_auto_rates[best];
+	*rate =3D wm831x_fll_auto_rates[best];
+	return 0;
 }
=20
 static int wm831x_fll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index dd8a62d..27460e3 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -367,7 +367,7 @@ static int xgene_clk_set_rate(struct clk_hw *hw, un=
signed long rate,
 	return parent_rate / divider_save;
 }
=20
-static long xgene_clk_round_rate(struct clk_hw *hw, unsigned long rate=
,
+static int xgene_clk_round_rate(struct clk_hw *hw, unsigned long *rate=
,
 				unsigned long *prate)
 {
 	struct xgene_clk *pclk =3D to_xgene_clk(hw);
@@ -376,14 +376,15 @@ static long xgene_clk_round_rate(struct clk_hw *h=
w, unsigned long rate,
=20
 	if (pclk->param.divider_reg) {
 		/* Let's compute the divider */
-		if (rate > parent_rate)
-			rate =3D parent_rate;
-		divider =3D parent_rate / rate;   /* Rounded down */
+		if (*rate > parent_rate)
+			*rate =3D parent_rate;
+		divider =3D parent_rate / *rate;   /* Rounded down */
 	} else {
 		divider =3D 1;
 	}
=20
-	return parent_rate / divider;
+	*rate =3D parent_rate / divider;
+	return 0;
 }
=20
 const struct clk_ops xgene_clk_ops =3D {
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fa5a00e..1462ddc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1146,9 +1146,12 @@ static unsigned long clk_core_round_rate_nolock(=
struct clk_core *clk,
 		return clk->ops->determine_rate(clk->hw, rate,
 						min_rate, max_rate,
 						&parent_rate, &parent_hw);
-	} else if (clk->ops->round_rate)
-		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
-	else if (clk->flags & CLK_SET_RATE_PARENT)
+	} else if (clk->ops->round_rate) {
+		if (clk->ops->round_rate(clk->hw, &rate, &parent_rate))
+			return 0;
+
+		return rate;
+	} else if (clk->flags & CLK_SET_RATE_PARENT)
 		return clk_core_round_rate_nolock(clk->parent, rate, min_rate,
 						  max_rate);
 	else
@@ -1640,8 +1643,10 @@ static struct clk_core *clk_calc_new_rates(struc=
t clk_core *clk,
 						    &parent_hw);
 		parent =3D parent_hw ? parent_hw->core : NULL;
 	} else if (clk->ops->round_rate) {
-		new_rate =3D clk->ops->round_rate(clk->hw, rate,
-						&best_parent_rate);
+		if (clk->ops->round_rate(clk->hw, &new_rate,
+					 &best_parent_rate))
+			return NULL;
+
 		if (new_rate < min_rate || new_rate > max_rate)
 			return NULL;
 	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {
diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 584a992..6652983 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -24,7 +24,7 @@
=20
 #define to_clk_factor(hw) container_of(hw, struct mmp_clk_factor, hw)
=20
-static long clk_factor_round_rate(struct clk_hw *hw, unsigned long dra=
te,
+static int clk_factor_round_rate(struct clk_hw *hw, unsigned long *dra=
te,
 		unsigned long *prate)
 {
 	struct mmp_clk_factor *factor =3D to_clk_factor(hw);
@@ -35,17 +35,19 @@ static long clk_factor_round_rate(struct clk_hw *hw=
, unsigned long drate,
 		prev_rate =3D rate;
 		rate =3D (((*prate / 10000) * factor->ftbl[i].den) /
 			(factor->ftbl[i].num * factor->masks->factor)) * 10000;
-		if (rate > drate)
+		if (rate > *drate)
 			break;
 	}
 	if ((i =3D=3D 0) || (i =3D=3D factor->ftbl_cnt)) {
-		return rate;
+		*drate =3D rate;
 	} else {
-		if ((drate - prev_rate) > (rate - drate))
-			return rate;
+		if ((*drate - prev_rate) > (rate - *drate))
+			*drate =3D rate;
 		else
-			return prev_rate;
+			*drate =3D prev_rate;
 	}
+
+	return 0;
 }
=20
 static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-co=
rediv.c
index d1e5863..c5aee2f 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -132,19 +132,20 @@ static unsigned long clk_corediv_recalc_rate(stru=
ct clk_hw *hwclk,
 	return parent_rate / div;
 }
=20
-static long clk_corediv_round_rate(struct clk_hw *hwclk, unsigned long=
 rate,
+static int clk_corediv_round_rate(struct clk_hw *hwclk, unsigned long =
*rate,
 			       unsigned long *parent_rate)
 {
 	/* Valid ratio are 1:4, 1:5, 1:6 and 1:8 */
 	u32 div;
=20
-	div =3D *parent_rate / rate;
+	div =3D *parent_rate / *rate;
 	if (div < 4)
 		div =3D 4;
 	else if (div > 6)
 		div =3D 8;
=20
-	return *parent_rate / div;
+	*rate =3D *parent_rate / div;
+	return 0;
 }
=20
 static int clk_corediv_set_rate(struct clk_hw *hwclk, unsigned long ra=
te,
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 3821a88..0279b50 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -57,19 +57,20 @@ static unsigned long clk_cpu_recalc_rate(struct clk=
_hw *hwclk,
 	return parent_rate / div;
 }
=20
-static long clk_cpu_round_rate(struct clk_hw *hwclk, unsigned long rat=
e,
-			       unsigned long *parent_rate)
+static int clk_cpu_round_rate(struct clk_hw *hwclk, unsigned long *rat=
e,
+			      unsigned long *parent_rate)
 {
 	/* Valid ratio are 1:1, 1:2 and 1:3 */
 	u32 div;
=20
-	div =3D *parent_rate / rate;
+	div =3D *parent_rate / *rate;
 	if (div =3D=3D 0)
 		div =3D 1;
 	else if (div > 3)
 		div =3D 3;
=20
-	return *parent_rate / div;
+	*rate =3D *parent_rate / div;
+	return 0;
 }
=20
 static int clk_cpu_off_set_rate(struct clk_hw *hwclk, unsigned long ra=
te,
diff --git a/drivers/clk/mxs/clk-div.c b/drivers/clk/mxs/clk-div.c
index 90e1da9..3677e51 100644
--- a/drivers/clk/mxs/clk-div.c
+++ b/drivers/clk/mxs/clk-div.c
@@ -47,8 +47,8 @@ static unsigned long clk_div_recalc_rate(struct clk_h=
w *hw,
 	return div->ops->recalc_rate(&div->divider.hw, parent_rate);
 }
=20
-static long clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_div_round_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *prate)
 {
 	struct clk_div *div =3D to_clk_div(hw);
=20
diff --git a/drivers/clk/mxs/clk-frac.c b/drivers/clk/mxs/clk-frac.c
index e6aa6b5..86fc3bb 100644
--- a/drivers/clk/mxs/clk-frac.c
+++ b/drivers/clk/mxs/clk-frac.c
@@ -49,18 +49,18 @@ static unsigned long clk_frac_recalc_rate(struct cl=
k_hw *hw,
 	return (parent_rate >> frac->width) * div;
 }
=20
-static long clk_frac_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int clk_frac_round_rate(struct clk_hw *hw, unsigned long *rate,
+			       unsigned long *prate)
 {
 	struct clk_frac *frac =3D to_clk_frac(hw);
 	unsigned long parent_rate =3D *prate;
 	u32 div;
 	u64 tmp;
=20
-	if (rate > parent_rate)
+	if (*rate > parent_rate)
 		return -EINVAL;
=20
-	tmp =3D rate;
+	tmp =3D *rate;
 	tmp <<=3D frac->width;
 	do_div(tmp, parent_rate);
 	div =3D tmp;
@@ -68,7 +68,8 @@ static long clk_frac_round_rate(struct clk_hw *hw, un=
signed long rate,
 	if (!div)
 		return -EINVAL;
=20
-	return (parent_rate >> frac->width) * div;
+	*rate =3D (parent_rate >> frac->width) * div;
+	return 0;
 }
=20
 static int clk_frac_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
index 4adeed6..e0d6529 100644
--- a/drivers/clk/mxs/clk-ref.c
+++ b/drivers/clk/mxs/clk-ref.c
@@ -64,15 +64,15 @@ static unsigned long clk_ref_recalc_rate(struct clk=
_hw *hw,
 	return tmp;
 }
=20
-static long clk_ref_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_ref_round_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *prate)
 {
 	unsigned long parent_rate =3D *prate;
 	u64 tmp =3D parent_rate;
 	u8 frac;
=20
-	tmp =3D tmp * 18 + rate / 2;
-	do_div(tmp, rate);
+	tmp =3D tmp * 18 + *rate / 2;
+	do_div(tmp, *rate);
 	frac =3D tmp;
=20
 	if (frac < 18)
@@ -83,8 +83,9 @@ static long clk_ref_round_rate(struct clk_hw *hw, uns=
igned long rate,
 	tmp =3D parent_rate;
 	tmp *=3D 18;
 	do_div(tmp, frac);
+	*rate =3D tmp;
=20
-	return tmp;
+	return 0;
 }
=20
 static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/c=
lk-regmap-divider.c
index 5348491..1720da4 100644
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -23,8 +23,8 @@ static inline struct clk_regmap_div *to_clk_regmap_di=
v(struct clk_hw *hw)
 	return container_of(to_clk_regmap(hw), struct clk_regmap_div, clkr);
 }
=20
-static long div_round_rate(struct clk_hw *hw, unsigned long rate,
-			   unsigned long *prate)
+static int div_round_rate(struct clk_hw *hw, unsigned long *rate,
+			  unsigned long *prate)
 {
 	struct clk_regmap_div *divider =3D to_clk_regmap_div(hw);
=20
diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-=
pll.c
index f8d3baf..bd408ef 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -63,8 +63,8 @@ static const struct rockchip_pll_rate_table *rockchip=
_get_pll_settings(
 	return NULL;
 }
=20
-static long rockchip_pll_round_rate(struct clk_hw *hw,
-			    unsigned long drate, unsigned long *prate)
+static int rockchip_pll_round_rate(struct clk_hw *hw,
+			    unsigned long *drate, unsigned long *prate)
 {
 	struct rockchip_clk_pll *pll =3D to_rockchip_clk_pll(hw);
 	const struct rockchip_pll_rate_table *rate_table =3D pll->rate_table;
@@ -72,12 +72,15 @@ static long rockchip_pll_round_rate(struct clk_hw *=
hw,
=20
 	/* Assumming rate_table is in descending order */
 	for (i =3D 0; i < pll->rate_count; i++) {
-		if (drate >=3D rate_table[i].rate)
-			return rate_table[i].rate;
+		if (*drate >=3D rate_table[i].rate) {
+			*drate =3D rate_table[i].rate;
+			return 0;
+		}
 	}
=20
 	/* return minimum supported value */
-	return rate_table[i - 1].rate;
+	*drate =3D rate_table[i - 1].rate;
+	return 0;
 }
=20
 /*
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pl=
l.c
index 9d70e5c..0128de2 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -42,8 +42,8 @@ static const struct samsung_pll_rate_table *samsung_g=
et_pll_settings(
 	return NULL;
 }
=20
-static long samsung_pll_round_rate(struct clk_hw *hw,
-			unsigned long drate, unsigned long *prate)
+static int samsung_pll_round_rate(struct clk_hw *hw,
+			unsigned long *drate, unsigned long *prate)
 {
 	struct samsung_clk_pll *pll =3D to_clk_pll(hw);
 	const struct samsung_pll_rate_table *rate_table =3D pll->rate_table;
@@ -51,12 +51,15 @@ static long samsung_pll_round_rate(struct clk_hw *h=
w,
=20
 	/* Assumming rate_table is in descending order */
 	for (i =3D 0; i < pll->rate_count; i++) {
-		if (drate >=3D rate_table[i].rate)
-			return rate_table[i].rate;
+		if (*drate >=3D rate_table[i].rate) {
+			*drate =3D rate_table[i].rate;
+			return 0;
+		}
 	}
=20
 	/* return minimum supported value */
-	return rate_table[i - 1].rate;
+	*drate =3D rate_table[i - 1].rate;
+	return 0;
 }
=20
 /*
diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk=
-div6.c
index 036a692..d31ae3d 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -97,12 +97,13 @@ static unsigned int cpg_div6_clock_calc_div(unsigne=
d long rate,
 	return clamp_t(unsigned int, div, 1, 64);
 }
=20
-static long cpg_div6_clock_round_rate(struct clk_hw *hw, unsigned long=
 rate,
+static int cpg_div6_clock_round_rate(struct clk_hw *hw, unsigned long =
*rate,
 				      unsigned long *parent_rate)
 {
-	unsigned int div =3D cpg_div6_clock_calc_div(rate, *parent_rate);
+	unsigned int div =3D cpg_div6_clock_calc_div(*rate, *parent_rate);
=20
-	return *parent_rate / div;
+	*rate =3D *parent_rate / div;
+	return 0;
 }
=20
 static int cpg_div6_clock_set_rate(struct clk_hw *hw, unsigned long ra=
te,
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobil=
e/clk-rcar-gen2.c
index acfb6d7..57581a9 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -68,8 +68,8 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk=
_hw *hw,
 	return div_u64((u64)parent_rate * mult, 32);
 }
=20
-static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate=
,
-				 unsigned long *parent_rate)
+static int cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long *rate=
,
+				unsigned long *parent_rate)
 {
 	unsigned long prate  =3D *parent_rate;
 	unsigned int mult;
@@ -77,10 +77,11 @@ static long cpg_z_clk_round_rate(struct clk_hw *hw,=
 unsigned long rate,
 	if (!prate)
 		prate =3D 1;
=20
-	mult =3D div_u64((u64)rate * 32, prate);
+	mult =3D div_u64((u64)*rate * 32, prate);
 	mult =3D clamp(mult, 1U, 32U);
=20
-	return *parent_rate / 32 * mult;
+	*rate =3D *parent_rate / 32 * mult;
+	return 0;
 }
=20
 static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-commo=
n.c
index 37af51c..68a7889 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -91,7 +91,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_h=
w *hw,
 	}
 }
=20
-static long pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int pll_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
 	unsigned long *parent_rate)
 {
 	unsigned long fin, nf, nr, od;
@@ -101,9 +101,9 @@ static long pll_clk_round_rate(struct clk_hw *hw, u=
nsigned long rate,
 	 * fout =3D fin * nf / (nr * od);
 	 * set od =3D 1, nr =3D fin/MHz, so fout =3D nf * MHz
 	 */
-	rate =3D rate - rate % MHZ;
+	*rate =3D *rate - *rate % MHZ;
=20
-	nf =3D rate / MHZ;
+	nf =3D *rate / MHZ;
 	if (nf > BIT(13))
 		nf =3D BIT(13);
 	if (nf < 1)
@@ -119,7 +119,8 @@ static long pll_clk_round_rate(struct clk_hw *hw, u=
nsigned long rate,
 	dividend =3D (u64)fin * nf;
 	do_div(dividend, nr * od);
=20
-	return (long)dividend;
+	*rate =3D dividend;
+	return 0;
 }
=20
 static int pll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -158,7 +159,7 @@ static int pll_clk_set_rate(struct clk_hw *hw, unsi=
gned long rate,
 	return 0;
 }
=20
-static long cpu_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int cpu_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
 	unsigned long *parent_rate)
 {
 	/*
@@ -347,7 +348,7 @@ static unsigned long dmn_clk_recalc_rate(struct clk=
_hw *hw,
 	}
 }
=20
-static long dmn_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int dmn_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
 	unsigned long *parent_rate)
 {
 	unsigned long fin;
@@ -355,7 +356,7 @@ static long dmn_clk_round_rate(struct clk_hw *hw, u=
nsigned long rate,
 	unsigned bits =3D (strcmp(hw->init->name, "mem") =3D=3D 0) ? 3 : 4;
=20
 	fin =3D *parent_rate;
-	ratio =3D fin / rate;
+	ratio =3D fin / *rate;
=20
 	if (ratio < 2)
 		ratio =3D 2;
@@ -365,7 +366,8 @@ static long dmn_clk_round_rate(struct clk_hw *hw, u=
nsigned long rate,
 	wait =3D (ratio >> 1) - 1;
 	hold =3D ratio - wait - 2;
=20
-	return fin / (wait + hold + 2);
+	*rate =3D fin / (wait + hold + 2);
+	return 0;
 }
=20
 static int dmn_clk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-=
aux-synth.c
index bdfb442..1a93f6a 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -52,14 +52,20 @@ static unsigned long aux_calc_rate(struct clk_hw *h=
w, unsigned long prate,
 			(rtbl[index].yscale * eq)) * 10000;
 }
=20
-static long clk_aux_round_rate(struct clk_hw *hw, unsigned long drate,
+static int clk_aux_round_rate(struct clk_hw *hw, unsigned long *drate,
 		unsigned long *prate)
 {
 	struct clk_aux *aux =3D to_clk_aux(hw);
 	int unused;
+	long ret;
=20
-	return clk_round_rate_index(hw, drate, *prate, aux_calc_rate,
+	ret =3D clk_round_rate_index(hw, *drate, *prate, aux_calc_rate,
 			aux->rtbl_cnt, &unused);
+	if (ret < 0)
+		return ret;
+
+	*drate =3D ret;
+	return 0;
 }
=20
 static unsigned long clk_aux_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk=
-frac-synth.c
index dffd4ce..d4098c8 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -55,14 +55,20 @@ static unsigned long frac_calc_rate(struct clk_hw *=
hw, unsigned long prate,
 	return prate;
 }
=20
-static long clk_frac_round_rate(struct clk_hw *hw, unsigned long drate=
,
+static int clk_frac_round_rate(struct clk_hw *hw, unsigned long *drate=
,
 		unsigned long *prate)
 {
 	struct clk_frac *frac =3D to_clk_frac(hw);
 	int unused;
+	long ret;
=20
-	return clk_round_rate_index(hw, drate, *prate, frac_calc_rate,
+	ret =3D clk_round_rate_index(hw, *drate, *prate, frac_calc_rate,
 			frac->rtbl_cnt, &unused);
+	if (ret < 0)
+		return ret;
+
+	*drate =3D ret;
+	return 0;
 }
=20
 static unsigned long clk_frac_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-=
gpt-synth.c
index 1afc18c..ea3328b 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -42,14 +42,20 @@ static unsigned long gpt_calc_rate(struct clk_hw *h=
w, unsigned long prate,
 	return prate;
 }
=20
-static long clk_gpt_round_rate(struct clk_hw *hw, unsigned long drate,
+static int clk_gpt_round_rate(struct clk_hw *hw, unsigned long *drate,
 		unsigned long *prate)
 {
 	struct clk_gpt *gpt =3D to_clk_gpt(hw);
 	int unused;
+	long ret;
=20
-	return clk_round_rate_index(hw, drate, *prate, gpt_calc_rate,
+	ret =3D clk_round_rate_index(hw, *drate, *prate, gpt_calc_rate,
 			gpt->rtbl_cnt, &unused);
+	if (ret < 0)
+		return ret;
+
+	*drate =3D ret;
+	return 0;
 }
=20
 static unsigned long clk_gpt_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vc=
o-pll.c
index 1b9b65b..08b1411 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -113,12 +113,18 @@ static long clk_pll_round_rate_index(struct clk_h=
w *hw, unsigned long drate,
 	return rate;
 }
=20
-static long clk_pll_round_rate(struct clk_hw *hw, unsigned long drate,
+static int clk_pll_round_rate(struct clk_hw *hw, unsigned long *drate,
 				unsigned long *prate)
 {
 	int unused;
+	long ret;
=20
-	return clk_pll_round_rate_index(hw, drate, prate, &unused);
+	ret =3D clk_pll_round_rate_index(hw, *drate, prate, &unused);
+	if (ret < 0)
+		return ret;
+
+	*drate =3D ret;
+	return 0;
 }
=20
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hw, unsigned l=
ong
@@ -179,14 +185,20 @@ static inline unsigned long vco_calc_rate(struct =
clk_hw *hw,
 	return pll_calc_rate(vco->rtbl, prate, index, NULL);
 }
=20
-static long clk_vco_round_rate(struct clk_hw *hw, unsigned long drate,
+static int clk_vco_round_rate(struct clk_hw *hw, unsigned long *drate,
 		unsigned long *prate)
 {
 	struct clk_vco *vco =3D to_clk_vco(hw);
 	int unused;
+	long ret;
=20
-	return clk_round_rate_index(hw, drate, *prate, vco_calc_rate,
+	ret =3D clk_round_rate_index(hw, *drate, *prate, vco_calc_rate,
 			vco->rtbl_cnt, &unused);
+	if (ret < 0)
+		return ret;
+
+	*drate =3D ret;
+	return 0;
 }
=20
 static unsigned long clk_vco_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.=
c
index bf12a25..d04278b 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -100,20 +100,21 @@ clk_best_div(unsigned long parent_rate, unsigned =
long rate)
 	return parent_rate / rate + ((rate > (2*(parent_rate % rate))) ? 0 : =
1);
 }
=20
-static long flexgen_round_rate(struct clk_hw *hw, unsigned long rate,
+static int flexgen_round_rate(struct clk_hw *hw, unsigned long *rate,
 				   unsigned long *prate)
 {
 	unsigned long div;
=20
 	/* Round div according to exact prate and wished rate */
-	div =3D clk_best_div(*prate, rate);
+	div =3D clk_best_div(*prate, *rate);
=20
 	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
-		*prate =3D rate * div;
-		return rate;
+		*prate =3D *rate * div;
+		return 0;
 	}
=20
-	return *prate / div;
+	*rate =3D *prate / div;
+	return 0;
 }
=20
 unsigned long flexgen_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.=
c
index af94ed8..7c70049 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -548,21 +548,22 @@ int clk_fs660c32_vco_get_params(unsigned long inp=
ut,
 	return 0;
 }
=20
-static long quadfs_pll_fs660c32_round_rate(struct clk_hw *hw, unsigned=
 long rate
-		, unsigned long *prate)
+static int quadfs_pll_fs660c32_round_rate(struct clk_hw *hw,
+					  unsigned long *rate,
+					  unsigned long *prate)
 {
 	struct stm_fs params;
=20
-	if (!clk_fs660c32_vco_get_params(*prate, rate, &params))
-		clk_fs660c32_vco_get_rate(*prate, &params, &rate);
+	if (!clk_fs660c32_vco_get_params(*prate, *rate, &params))
+		clk_fs660c32_vco_get_rate(*prate, &params, rate);
=20
 	pr_debug("%s: %s new rate %ld [sdiv=3D0x%x,md=3D0x%x,pe=3D0x%x,nsdiv3=
=3D%u]\n",
 		 __func__, __clk_get_name(hw->clk),
-		 rate, (unsigned int)params.sdiv,
+		 *rate, (unsigned int)params.sdiv,
 		 (unsigned int)params.mdiv,
 		 (unsigned int)params.pe, (unsigned int)params.nsdiv);
=20
-	return rate;
+	return 0;
 }
=20
 static int quadfs_pll_fs660c32_set_rate(struct clk_hw *hw, unsigned lo=
ng rate,
@@ -953,19 +954,19 @@ static unsigned long quadfs_recalc_rate(struct cl=
k_hw *hw,
 	return rate;
 }
=20
-static long quadfs_round_rate(struct clk_hw *hw, unsigned long rate,
+static int quadfs_round_rate(struct clk_hw *hw, unsigned long *rate,
 				     unsigned long *prate)
 {
 	struct stm_fs params;
=20
-	rate =3D quadfs_find_best_rate(hw, rate, *prate, &params);
+	*rate =3D quadfs_find_best_rate(hw, *rate, *prate, &params);
=20
 	pr_debug("%s: %s new rate %ld [sdiv=3D0x%x,md=3D0x%x,pe=3D0x%x,nsdiv3=
=3D%u]\n",
 		 __func__, __clk_get_name(hw->clk),
-		 rate, (unsigned int)params.sdiv, (unsigned int)params.mdiv,
+		 *rate, (unsigned int)params.sdiv, (unsigned int)params.mdiv,
 			 (unsigned int)params.pe, (unsigned int)params.nsdiv);
=20
-	return rate;
+	return 0;
 }
=20
=20
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 9a15ec3..2bbcb7b 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -190,7 +190,7 @@ static int clkgena_divmux_set_rate(struct clk_hw *h=
w, unsigned long rate,
 	return clk_divider_ops.set_rate(div_hw, rate, parent_rate);
 }
=20
-static long clkgena_divmux_round_rate(struct clk_hw *hw, unsigned long=
 rate,
+static int clkgena_divmux_round_rate(struct clk_hw *hw, unsigned long =
*rate,
 				   unsigned long *prate)
 {
 	struct clkgena_divmux *genamux =3D to_clkgena_divmux(hw);
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-fa=
ctors.c
index 8c20190..5865300 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -69,14 +69,17 @@ static unsigned long clk_factors_recalc_rate(struct=
 clk_hw *hw,
 	return rate;
 }
=20
-static long clk_factors_round_rate(struct clk_hw *hw, unsigned long ra=
te,
-				   unsigned long *parent_rate)
+static int clk_factors_round_rate(struct clk_hw *hw, unsigned long *ra=
te,
+				  unsigned long *parent_rate)
 {
 	struct clk_factors *factors =3D to_clk_factors(hw);
-	factors->get_factors((u32 *)&rate, (u32)*parent_rate,
+	u32 tmp_rate =3D *rate;
+
+	factors->get_factors(&tmp_rate, (u32)*parent_rate,
 			     NULL, NULL, NULL, NULL);
=20
-	return rate;
+	*rate =3D tmp_rate;
+	return 0;
 }
=20
 static long clk_factors_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
@@ -100,7 +103,8 @@ static long clk_factors_determine_rate(struct clk_h=
w *hw, unsigned long rate,
 		else
 			parent_rate =3D __clk_get_rate(parent);
=20
-		child_rate =3D clk_factors_round_rate(hw, rate, &parent_rate);
+		child_rate =3D rate;
+		clk_factors_round_rate(hw, &child_rate, &parent_rate);
=20
 		if (child_rate <=3D rate && child_rate > best_child_rate) {
 			best_parent =3D parent;
diff --git a/drivers/clk/tegra/clk-audio-sync.c b/drivers/clk/tegra/clk=
-audio-sync.c
index c0f7843..0224256 100644
--- a/drivers/clk/tegra/clk-audio-sync.c
+++ b/drivers/clk/tegra/clk-audio-sync.c
@@ -28,15 +28,15 @@ static unsigned long clk_sync_source_recalc_rate(st=
ruct clk_hw *hw,
 	return sync->rate;
 }
=20
-static long clk_sync_source_round_rate(struct clk_hw *hw, unsigned lon=
g rate,
-				       unsigned long *prate)
+static int clk_sync_source_round_rate(struct clk_hw *hw, unsigned long=
 *rate,
+				      unsigned long *prate)
 {
 	struct tegra_clk_sync_source *sync =3D to_clk_sync_source(hw);
=20
-	if (rate > sync->max_rate)
+	if (*rate > sync->max_rate)
 		return -EINVAL;
 	else
-		return rate;
+		return 0;
 }
=20
 static int clk_sync_source_set_rate(struct clk_hw *hw, unsigned long r=
ate,
diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-di=
vider.c
index 59a5714..9e5ca82 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -85,23 +85,28 @@ static unsigned long clk_frac_div_recalc_rate(struc=
t clk_hw *hw,
 	return rate;
 }
=20
-static long clk_frac_div_round_rate(struct clk_hw *hw, unsigned long r=
ate,
+static int clk_frac_div_round_rate(struct clk_hw *hw, unsigned long *r=
ate,
 				   unsigned long *prate)
 {
 	struct tegra_clk_frac_div *divider =3D to_clk_frac_div(hw);
 	int div, mul;
 	unsigned long output_rate =3D *prate;
=20
-	if (!rate)
-		return output_rate;
+	if (!*rate) {
+		*rate =3D output_rate;
+		return 0;
+	}
=20
-	div =3D get_div(divider, rate, output_rate);
-	if (div < 0)
-		return *prate;
+	div =3D get_div(divider, *rate, output_rate);
+	if (div < 0) {
+		*rate =3D *prate;
+		return 0;
+	}
=20
 	mul =3D get_mul(divider);
=20
-	return DIV_ROUND_UP(output_rate * mul, div + mul);
+	*rate =3D DIV_ROUND_UP(output_rate * mul, div + mul);
+	return 0;
 }
=20
 static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate=
,
diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-per=
iph.c
index d84ae49..5a262f5 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -56,8 +56,8 @@ static unsigned long clk_periph_recalc_rate(struct cl=
k_hw *hw,
 	return div_ops->recalc_rate(div_hw, parent_rate);
 }
=20
-static long clk_periph_round_rate(struct clk_hw *hw, unsigned long rat=
e,
-				  unsigned long *prate)
+static int clk_periph_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
+				 unsigned long *prate)
 {
 	struct tegra_clk_periph *periph =3D to_clk_periph(hw);
 	const struct clk_ops *div_ops =3D periph->div_ops;
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index bfef9ab..a73bdb3 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -623,24 +623,29 @@ static int clk_pll_set_rate(struct clk_hw *hw, un=
signed long rate,
 	return ret;
 }
=20
-static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+static int clk_pll_round_rate(struct clk_hw *hw, unsigned long *rate,
 			unsigned long *prate)
 {
 	struct tegra_clk_pll *pll =3D to_clk_pll(hw);
 	struct tegra_clk_pll_freq_table cfg;
=20
-	if (pll->params->flags & TEGRA_PLL_FIXED)
-		return pll->params->fixed_rate;
+	if (pll->params->flags & TEGRA_PLL_FIXED) {
+		*rate =3D pll->params->fixed_rate;
+		return 0;
+	}
=20
 	/* PLLM is used for memory; we do not change rate */
-	if (pll->params->flags & TEGRA_PLLM)
-		return __clk_get_rate(hw->clk);
+	if (pll->params->flags & TEGRA_PLLM) {
+		*rate =3D __clk_get_rate(hw->clk);
+		return 0;
+	}
=20
-	if (_get_table_rate(hw, &cfg, rate, *prate) &&
-	    _calc_rate(hw, &cfg, rate, *prate))
+	if (_get_table_rate(hw, &cfg, *rate, *prate) &&
+	    _calc_rate(hw, &cfg, *rate, *prate))
 		return -EINVAL;
=20
-	return cfg.output_rate;
+	*rate =3D cfg.output_rate;
+	return 0;
 }
=20
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
@@ -1001,25 +1006,28 @@ static int clk_pllxc_set_rate(struct clk_hw *hw=
, unsigned long rate,
 	return ret;
 }
=20
-static long clk_pll_ramp_round_rate(struct clk_hw *hw, unsigned long r=
ate,
+static int clk_pll_ramp_round_rate(struct clk_hw *hw, unsigned long *r=
ate,
 				unsigned long *prate)
 {
 	struct tegra_clk_pll_freq_table cfg;
 	int ret =3D 0, p_div;
 	u64 output_rate =3D *prate;
=20
-	ret =3D _pll_ramp_calc_pll(hw, &cfg, rate, *prate);
+	ret =3D _pll_ramp_calc_pll(hw, &cfg, *rate, *prate);
 	if (ret < 0)
 		return ret;
=20
 	p_div =3D _hw_to_p_div(hw, cfg.p);
-	if (p_div < 0)
-		return p_div;
+	if (p_div < 0) {
+		*rate =3D p_div;
+		return 0;
+	}
=20
 	output_rate *=3D cfg.n;
 	do_div(output_rate, cfg.m * p_div);
=20
-	return output_rate;
+	*rate =3D output_rate;
+	return 0;
 }
=20
 static int clk_pllm_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1272,12 +1280,13 @@ static unsigned long clk_pllre_recalc_rate(stru=
ct clk_hw *hw,
 	return rate;
 }
=20
-static long clk_pllre_round_rate(struct clk_hw *hw, unsigned long rate=
,
+static int clk_pllre_round_rate(struct clk_hw *hw, unsigned long *rate=
,
 				 unsigned long *prate)
 {
 	struct tegra_clk_pll *pll =3D to_clk_pll(hw);
=20
-	return _pllre_calc_rate(pll, NULL, rate, *prate);
+	*rate =3D _pllre_calc_rate(pll, NULL, *rate, *prate);
+	return 0;
 }
=20
 static int clk_plle_tegra114_enable(struct clk_hw *hw)
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-at=
l.c
index 59bb4b3..cdf1d17 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -124,16 +124,17 @@ static unsigned long atl_clk_recalc_rate(struct c=
lk_hw *hw,
 	return parent_rate / cdesc->divider;
 }
=20
-static long atl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *parent_rate)
+static int atl_clk_round_rate(struct clk_hw *hw, unsigned long *rate,
+			      unsigned long *parent_rate)
 {
 	unsigned divider;
=20
-	divider =3D (*parent_rate + rate / 2) / rate;
+	divider =3D (*parent_rate + *rate / 2) / *rate;
 	if (divider > DRA7_ATL_DIVIDER_MASK + 1)
 		divider =3D DRA7_ATL_DIVIDER_MASK + 1;
=20
-	return *parent_rate / divider;
+	*rate =3D *parent_rate / divider;
+	return 0;
 }
=20
 static int atl_clk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 3654f61..eddad41 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -36,8 +36,8 @@ static unsigned long ti_composite_recalc_rate(struct =
clk_hw *hw,
 	return ti_clk_divider_ops.recalc_rate(hw, parent_rate);
 }
=20
-static long ti_composite_round_rate(struct clk_hw *hw, unsigned long r=
ate,
-				    unsigned long *prate)
+static int ti_composite_round_rate(struct clk_hw *hw, unsigned long *r=
ate,
+				   unsigned long *prate)
 {
 	return -EINVAL;
 }
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index ff5f117..6044251 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -200,13 +200,14 @@ static int ti_clk_divider_bestdiv(struct clk_hw *=
hw, unsigned long rate,
 	return bestdiv;
 }
=20
-static long ti_clk_divider_round_rate(struct clk_hw *hw, unsigned long=
 rate,
-				      unsigned long *prate)
+static int ti_clk_divider_round_rate(struct clk_hw *hw, unsigned long =
*rate,
+				     unsigned long *prate)
 {
 	int div;
-	div =3D ti_clk_divider_bestdiv(hw, rate, prate);
+	div =3D ti_clk_divider_bestdiv(hw, *rate, prate);
=20
-	return DIV_ROUND_UP(*prate, div);
+	*rate =3D DIV_ROUND_UP(*prate, div);
+	return 0;
 }
=20
 static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long ra=
te,
diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcm=
u.c
index bf63c96..1e1aa2d 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -80,11 +80,18 @@ static unsigned long clk_prcmu_recalc_rate(struct c=
lk_hw *hw,
 	return prcmu_clock_rate(clk->cg_sel);
 }
=20
-static long clk_prcmu_round_rate(struct clk_hw *hw, unsigned long rate=
,
-				 unsigned long *parent_rate)
+static int clk_prcmu_round_rate(struct clk_hw *hw, unsigned long *rate=
,
+				unsigned long *parent_rate)
 {
 	struct clk_prcmu *clk =3D to_clk_prcmu(hw);
-	return prcmu_round_clock_rate(clk->cg_sel, rate);
+	long ret;
+
+	ret =3D prcmu_round_clock_rate(clk->cg_sel, *rate);
+	if (ret < 0)
+		return ret;
+
+	*rate =3D ret;
+	return 0;
 }
=20
 static int clk_prcmu_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/c=
lk-icst.c
index bc96f10..6404e61 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -91,14 +91,15 @@ static unsigned long icst_recalc_rate(struct clk_hw=
 *hw,
 	return icst->rate;
 }
=20
-static long icst_round_rate(struct clk_hw *hw, unsigned long rate,
-			    unsigned long *prate)
+static int icst_round_rate(struct clk_hw *hw, unsigned long *rate,
+			   unsigned long *prate)
 {
 	struct clk_icst *icst =3D to_icst(hw);
 	struct icst_vco vco;
=20
-	vco =3D icst_hz_to_vco(icst->params, rate);
-	return icst_hz(icst->params, vco);
+	vco =3D icst_hz_to_vco(icst->params, *rate);
+	*rate =3D icst_hz(icst->params, vco);
+	return 0;
 }
=20
 static int icst_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/ver=
satile/clk-vexpress-osc.c
index 765f1e0..b507758 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -39,18 +39,18 @@ static unsigned long vexpress_osc_recalc_rate(struc=
t clk_hw *hw,
 	return rate;
 }
=20
-static long vexpress_osc_round_rate(struct clk_hw *hw, unsigned long r=
ate,
+static int vexpress_osc_round_rate(struct clk_hw *hw, unsigned long *r=
ate,
 		unsigned long *parent_rate)
 {
 	struct vexpress_osc *osc =3D to_vexpress_osc(hw);
=20
-	if (WARN_ON(osc->rate_min && rate < osc->rate_min))
-		rate =3D osc->rate_min;
+	if (WARN_ON(osc->rate_min && *rate < osc->rate_min))
+		*rate =3D osc->rate_min;
=20
-	if (WARN_ON(osc->rate_max && rate > osc->rate_max))
-		rate =3D osc->rate_max;
+	if (WARN_ON(osc->rate_max && *rate > osc->rate_max))
+		*rate =3D osc->rate_max;
=20
-	return rate;
+	return 0;
 }
=20
 static int vexpress_osc_set_rate(struct clk_hw *hw, unsigned long rate=
,
diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index 00d72fb..b62d298 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -60,18 +60,19 @@ struct zynq_pll {
  * @prate:	Clock frequency of parent clock
  * Returns frequency closest to @rate the hardware can generate.
  */
-static long zynq_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+static int zynq_pll_round_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long *prate)
 {
 	u32 fbdiv;
=20
-	fbdiv =3D DIV_ROUND_CLOSEST(rate, *prate);
+	fbdiv =3D DIV_ROUND_CLOSEST(*rate, *prate);
 	if (fbdiv < PLL_FBDIV_MIN)
 		fbdiv =3D PLL_FBDIV_MIN;
 	else if (fbdiv > PLL_FBDIV_MAX)
 		fbdiv =3D PLL_FBDIV_MAX;
=20
-	return *prate * fbdiv;
+	*rate =3D *prate * fbdiv;
+	return 0;
 }
=20
 /**
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tv=
e.c
index 4216e47..0695428 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -423,17 +423,20 @@ static unsigned long clk_tve_di_recalc_rate(struc=
t clk_hw *hw,
 	return 0;
 }
=20
-static long clk_tve_di_round_rate(struct clk_hw *hw, unsigned long rat=
e,
-				  unsigned long *prate)
+static int clk_tve_di_round_rate(struct clk_hw *hw, unsigned long *rat=
e,
+				 unsigned long *prate)
 {
 	unsigned long div;
=20
-	div =3D *prate / rate;
+	div =3D *prate / *rate;
 	if (div >=3D 4)
-		return *prate / 4;
+		*rate =3D *prate / 4;
 	else if (div >=3D 2)
-		return *prate / 2;
-	return *prate;
+		*rate =3D *prate / 2;
+	else
+		*rate =3D *prate;
+
+	return 0;
 }
=20
 static int clk_tve_di_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c b/drivers/gpu/drm=
/msm/hdmi/hdmi_phy_8960.c
index eeed006..97cdcb4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c
@@ -336,11 +336,12 @@ static unsigned long hdmi_pll_recalc_rate(struct =
clk_hw *hw,
 	return phy_8960->pixclk;
 }
=20
-static long hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+static int hdmi_pll_round_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long *parent_rate)
 {
-	const struct pll_rate *pll_rate =3D find_rate(rate);
-	return pll_rate->rate;
+	const struct pll_rate *pll_rate =3D find_rate(*rate);
+	*rate =3D pll_rate->rate;
+	return 0;
 }
=20
 static int hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_pll.c b/drivers/gpu=
/drm/msm/mdp/mdp4/mdp4_lvds_pll.c
index ce42459..c89b109 100644
--- a/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_pll.c
+++ b/drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_pll.c
@@ -109,11 +109,12 @@ static unsigned long mpd4_lvds_pll_recalc_rate(st=
ruct clk_hw *hw,
 	return lvds_pll->pixclk;
 }
=20
-static long mpd4_lvds_pll_round_rate(struct clk_hw *hw, unsigned long =
rate,
+static int mpd4_lvds_pll_round_rate(struct clk_hw *hw, unsigned long *=
rate,
 		unsigned long *parent_rate)
 {
-	const struct pll_rate *pll_rate =3D find_rate(rate);
-	return pll_rate->rate;
+	const struct pll_rate *pll_rate =3D find_rate(*rate);
+	*rate =3D pll_rate->rate;
+	return 0;
 }
=20
 static int mpd4_lvds_pll_set_rate(struct clk_hw *hw, unsigned long rat=
e,
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/plat=
form/omap3isp/isp.c
index deca809..4d5ba85 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -231,11 +231,11 @@ static u32 isp_xclk_calc_divider(unsigned long *r=
ate, unsigned long parent_rate)
 	return divider;
 }
=20
-static long isp_xclk_round_rate(struct clk_hw *hw, unsigned long rate,
+static int isp_xclk_round_rate(struct clk_hw *hw, unsigned long *rate,
 				unsigned long *parent_rate)
 {
-	isp_xclk_calc_divider(&rate, *parent_rate);
-	return rate;
+	isp_xclk_calc_divider(rate, *parent_rate);
+	return 0;
 }
=20
 static int isp_xclk_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index b936bb4..5e6f5a5 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -316,15 +316,19 @@ static unsigned long hym8563_clkout_recalc_rate(s=
truct clk_hw *hw,
 	return clkout_rates[ret];
 }
=20
-static long hym8563_clkout_round_rate(struct clk_hw *hw, unsigned long=
 rate,
-				      unsigned long *prate)
+static int hym8563_clkout_round_rate(struct clk_hw *hw, unsigned long =
*rate,
+				     unsigned long *prate)
 {
 	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(clkout_rates); i++)
-		if (clkout_rates[i] <=3D rate)
-			return clkout_rates[i];
+	for (i =3D 0; i < ARRAY_SIZE(clkout_rates); i++) {
+		if (clkout_rates[i] <=3D *rate) {
+			*rate =3D clkout_rates[i];
+			return 0;
+		}
+	}
=20
+	*rate =3D 0;
 	return 0;
 }
=20
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.=
h
index 5591ea7..1213b0b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -173,8 +173,8 @@ struct clk_ops {
 	void		(*disable_unused)(struct clk_hw *hw);
 	unsigned long	(*recalc_rate)(struct clk_hw *hw,
 					unsigned long parent_rate);
-	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
-					unsigned long *parent_rate);
+	int		(*round_rate)(struct clk_hw *hw, unsigned long *rate,
+				      unsigned long *parent_rate);
 	long		(*determine_rate)(struct clk_hw *hw,
 					  unsigned long rate,
 					  unsigned long min_rate,
@@ -365,7 +365,7 @@ extern const struct clk_ops clk_divider_ops;
 unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long par=
ent_rate,
 		unsigned int val, const struct clk_div_table *table,
 		unsigned long flags);
-long divider_round_rate(struct clk_hw *hw, unsigned long rate,
+int divider_round_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long *prate, const struct clk_div_table *table,
 		u8 width, unsigned long flags);
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6784400..3b2406c 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -277,9 +277,9 @@ long omap3_noncore_dpll_determine_rate(struct clk_h=
w *hw,
 				       struct clk_hw **best_parent_clk);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
-long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
-				    unsigned long target_rate,
-				    unsigned long *parent_rate);
+int omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
+				   unsigned long *target_rate,
+				   unsigned long *parent_rate);
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 					unsigned long rate,
 					unsigned long min_rate,
@@ -288,14 +288,14 @@ long omap4_dpll_regm4xen_determine_rate(struct cl=
k_hw *hw,
 					struct clk_hw **best_parent_clk);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long paren=
t_rate);
-long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rat=
e,
-			   unsigned long *parent_rate);
+int omap2_dpll_round_rate(struct clk_hw *hw, unsigned long *target_rat=
e,
+			  unsigned long *parent_rate);
 void omap2_init_clk_clkdm(struct clk_hw *clk);
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
 int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long parent_rate);
-long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
+int omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long *rate,
 		unsigned long *prate);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
--=20
1.9.1
