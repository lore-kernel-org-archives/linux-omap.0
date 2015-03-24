From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] clk: ti: Implement FAPLL set_rate for the synthesizer
Date: Tue, 24 Mar 2015 09:37:35 -0700
Message-ID: <20150324163734.GY31346@atomide.com>
References: <1427063726-4248-1-git-send-email-tony@atomide.com>
 <1427063726-4248-3-git-send-email-tony@atomide.com>
 <5510143A.8090404@ti.com>
 <20150323155242.GX31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150323155242.GX31346@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150323 08:58]:
> * Tero Kristo <t-kristo@ti.com> [150323 06:25]:
> >=20
> > This code is generating these compile time warnings for me:
> >=20
> >   CC      drivers/clk/ti/fapll.o
> > drivers/clk/ti/fapll.c: In function =E2=80=98ti_fapll_synth_set_rat=
e=E2=80=99:
> > drivers/clk/ti/fapll.c:394:5: warning: =E2=80=98synth_int_div=E2=80=
=99 may be used
> > uninitialized in this function [-Wuninitialized]
> > drivers/clk/ti/fapll.c:373:18: note: =E2=80=98synth_int_div=E2=80=99=
 was declared here
> > drivers/clk/ti/fapll.c:400:23: warning: =E2=80=98synth_frac_div=E2=80=
=99 may be used
> > uninitialized in this function [-Wuninitialized]
> > drivers/clk/ti/fapll.c:373:33: note: =E2=80=98synth_frac_div=E2=80=99=
 was declared here
>=20
> Oops thanks will check. I did move this into a separate function
> to make it more readable, probably happened at that point.

Updated version of this patch below, let me know if you want the
whole set reposted.

Regards,

Tony

8< -------------------
=46rom: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Mar 2015 18:04:20 -0700
Subject: [PATCH] clk: ti: Implement FAPLL set_rate for the synthesizer

We can pretty much get any rate out of the FAPLL because of the fractio=
nal
divider. Let's first try just adjusting the post divider, and if that i=
s
not enough, then reprogram both the fractional divider and the post div=
ider.

Let's also add a define for the fixed SYNTH_PHASE_K instead of using 8.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -12,6 +12,7 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
@@ -47,6 +48,8 @@
 /* Synthesizer frequency register */
 #define SYNTH_LDFREQ		BIT(31)
=20
+#define SYNTH_PHASE_K		8
+#define SYNTH_MAX_INT_DIV	0xf
 #define SYNTH_MAX_DIV_M		0xff
=20
 struct fapll_data {
@@ -204,7 +207,7 @@ static unsigned long ti_fapll_synth_recalc_rate(str=
uct clk_hw *hw,
 	/*
 	 * Synth frequency integer and fractional divider.
 	 * Note that the phase output K is 8, so the result needs
-	 * to be multiplied by 8.
+	 * to be multiplied by SYNTH_PHASE_K.
 	 */
 	if (synth->freq) {
 		u32 v, synth_int_div, synth_frac_div, synth_div_freq;
@@ -215,7 +218,7 @@ static unsigned long ti_fapll_synth_recalc_rate(str=
uct clk_hw *hw,
 		synth_div_freq =3D (synth_int_div * 10000000) + synth_frac_div;
 		rate *=3D 10000000;
 		do_div(rate, synth_div_freq);
-		rate *=3D 8;
+		rate *=3D SYNTH_PHASE_K;
 	}
=20
 	/* Synth post-divider M */
@@ -224,11 +227,138 @@ static unsigned long ti_fapll_synth_recalc_rate(=
struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(rate, synth_div_m);
 }
=20
+static unsigned long ti_fapll_synth_get_frac_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct fapll_synth *synth =3D to_synth(hw);
+	unsigned long current_rate, frac_rate;
+	u32 post_div_m;
+
+	current_rate =3D ti_fapll_synth_recalc_rate(hw, parent_rate);
+	post_div_m =3D readl_relaxed(synth->div) & SYNTH_MAX_DIV_M;
+	frac_rate =3D current_rate * post_div_m;
+
+	return frac_rate;
+}
+
+static u32 ti_fapll_synth_set_frac_rate(struct fapll_synth *synth,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	u32 post_div_m, synth_int_div =3D 0, synth_frac_div =3D 0, v;
+
+	post_div_m =3D DIV_ROUND_UP_ULL((u64)parent_rate * SYNTH_PHASE_K, rat=
e);
+	post_div_m =3D post_div_m / SYNTH_MAX_INT_DIV;
+	if (post_div_m > SYNTH_MAX_DIV_M)
+		return -EINVAL;
+	if (!post_div_m)
+		post_div_m =3D 1;
+
+	for (; post_div_m < SYNTH_MAX_DIV_M; post_div_m++) {
+		synth_int_div =3D DIV_ROUND_UP_ULL((u64)parent_rate *
+						 SYNTH_PHASE_K *
+						 10000000,
+						 rate * post_div_m);
+		synth_frac_div =3D synth_int_div % 10000000;
+		synth_int_div /=3D 10000000;
+
+		if (synth_int_div <=3D SYNTH_MAX_INT_DIV)
+			break;
+	}
+
+	if (synth_int_div > SYNTH_MAX_INT_DIV)
+		return -EINVAL;
+
+	v =3D readl_relaxed(synth->freq);
+	v &=3D ~0x1fffffff;
+	v |=3D (synth_int_div & SYNTH_MAX_INT_DIV) << 24;
+	v |=3D (synth_frac_div & 0xffffff);
+	v |=3D SYNTH_LDFREQ;
+	writel_relaxed(v, synth->freq);
+
+	return post_div_m;
+}
+
+static long ti_fapll_synth_round_rate(struct clk_hw *hw, unsigned long=
 rate,
+				      unsigned long *parent_rate)
+{
+	struct fapll_synth *synth =3D to_synth(hw);
+	struct fapll_data *fd =3D synth->fd;
+	unsigned long r;
+
+	if (ti_fapll_clock_is_bypass(fd) || !synth->div || !rate)
+		return -EINVAL;
+
+	/* Only post divider m available with no fractional divider? */
+	if (!synth->freq) {
+		unsigned long frac_rate;
+		u32 synth_post_div_m;
+
+		frac_rate =3D ti_fapll_synth_get_frac_rate(hw, *parent_rate);
+		synth_post_div_m =3D DIV_ROUND_UP(frac_rate, rate);
+		r =3D DIV_ROUND_UP(frac_rate, synth_post_div_m);
+		goto out;
+	}
+
+	r =3D *parent_rate * SYNTH_PHASE_K;
+	if (rate > r)
+		goto out;
+
+	r =3D DIV_ROUND_UP_ULL(r, SYNTH_MAX_INT_DIV * SYNTH_MAX_DIV_M);
+	if (rate < r)
+		goto out;
+
+	r =3D rate;
+out:
+	return r;
+}
+
+static int ti_fapll_synth_set_rate(struct clk_hw *hw, unsigned long ra=
te,
+				   unsigned long parent_rate)
+{
+	struct fapll_synth *synth =3D to_synth(hw);
+	struct fapll_data *fd =3D synth->fd;
+	unsigned long frac_rate, post_rate =3D 0;
+	u32 post_div_m =3D 0, v;
+
+	if (ti_fapll_clock_is_bypass(fd) || !synth->div || !rate)
+		return -EINVAL;
+
+	/* Produce the rate with just post divider M? */
+	frac_rate =3D ti_fapll_synth_get_frac_rate(hw, parent_rate);
+	if (frac_rate < rate) {
+		if (!synth->freq)
+			return -EINVAL;
+	} else {
+		post_div_m =3D DIV_ROUND_UP(frac_rate, rate);
+		if (post_div_m && (post_div_m <=3D SYNTH_MAX_DIV_M))
+			post_rate =3D DIV_ROUND_UP(frac_rate, post_div_m);
+		if (!synth->freq && !post_rate)
+			return -EINVAL;
+	}
+
+	/* Need to recalculate the fractional divider? */
+	if ((post_rate !=3D rate) && synth->freq)
+		post_div_m =3D ti_fapll_synth_set_frac_rate(synth,
+							  rate,
+							  parent_rate);
+
+	v =3D readl_relaxed(synth->div);
+	v &=3D ~SYNTH_MAX_DIV_M;
+	v |=3D post_div_m;
+	v |=3D SYNTH_LDMDIV1;
+	writel_relaxed(v, synth->div);
+
+	return 0;
+}
+
 static struct clk_ops ti_fapll_synt_ops =3D {
 	.enable =3D ti_fapll_synth_enable,
 	.disable =3D ti_fapll_synth_disable,
 	.is_enabled =3D ti_fapll_synth_is_enabled,
 	.recalc_rate =3D ti_fapll_synth_recalc_rate,
+	.round_rate =3D ti_fapll_synth_round_rate,
+	.set_rate =3D ti_fapll_synth_set_rate,
 };
=20
 static struct clk * __init ti_fapll_synth_setup(struct fapll_data *fd,
