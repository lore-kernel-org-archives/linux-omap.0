From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/6] OMAP4: clocks: Update the clock tree with 4460
 clock nodes
Date: Fri, 8 Jul 2011 03:52:17 -0700
Message-ID: <20110708105217.GW5783@atomide.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
 <1309573826-10615-2-git-send-email-rnayak@ti.com>
 <1309573826-10615-3-git-send-email-rnayak@ti.com>
 <1309573826-10615-4-git-send-email-rnayak@ti.com>
 <1309573826-10615-5-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1107080044270.24181@utopia.booyaka.com>
 <4E16AD18.7040402@ti.com>
 <alpine.DEB.2.00.1107080134430.24181@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62732 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751604Ab1GHKwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 06:52:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107080134430.24181@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

* Paul Walmsley <paul@pwsan.com> [110708 00:30]:
> On Fri, 8 Jul 2011, Rajendra Nayak wrote:
> 
> > On 7/7/2011 11:49 PM, Paul Walmsley wrote:
> > > On Sat, 2 Jul 2011, Rajendra Nayak wrote:
> > > 
> > > > Add the new clock nodes (bandgap_ts_fclk, div_ts_ck) for omap4460.
> > > > Handle these nodes using the clock flags (CK_*).
> > > > 
> > > > Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> > > > Signed-off-by: Nishanth Menon<nm@ti.com>
> > > > Signed-off-by: Benoit Cousson<b-cousson@ti.com>
> > > > Reviewed-by: Kevin Hilman<khilman@ti.com>
> > > 
> > > Is this data coming from autogenerator scripts that have been checked into
> > > that repository, or have these been hand-edited?
> > 
> > They have been hand edited to create a diff from the 4430 autogen output
> > and 4460 autogen output.
> > 
> > > 
> > > Also, this isn't the complete set of clock changes needed for full 4460
> > > support, right?  I'm thinking of the duty cycle correction changes
> > > described in TRM 3.6.3.7.2 "Tactical Clocking Adjustment".
> > > Are those planned to go into a future patch?
> > 
> > Yes, this series was targeted at providing basic boot support. I was
> > planning to add the DCC changes as part of the next series.
> 
> Okay.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Updated patch below.

Tony


From: Rajendra Nayak <rnayak@ti.com>
Date: Sat, 2 Jul 2011 08:00:24 +0530
Subject: [PATCH] OMAP4: clocks: Update the clock tree with 4460 clock nodes

Add the new clock nodes (bandgap_ts_fclk, div_ts_ck) for omap4460.
Handle these nodes using the clock flags (CK_*).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..639e00e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1486,6 +1486,40 @@ static struct clk dss_dss_clk = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel_rate div3_8to32_rates[] = {
+	{ .div = 8, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 16, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 32, .val = 2, .flags = RATE_IN_44XX },
+	{ .div = 0 },
+};
+
+static const struct clksel div_ts_div[] = {
+	{ .parent = &l4_wkup_clk_mux_ck, .rates = div3_8to32_rates },
+	{ .parent = NULL },
+};
+
+static struct clk div_ts_ck = {
+	.name		= "div_ts_ck",
+	.parent		= &l4_wkup_clk_mux_ck,
+	.clksel		= div_ts_div,
+	.clksel_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_24_25_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk bandgap_ts_fclk = {
+	.name		= "bandgap_ts_fclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+	.enable_bit	= OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &div_ts_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk dss_48mhz_clk = {
 	.name		= "dss_48mhz_clk",
 	.ops		= &clkops_omap2_dflt,
@@ -3110,7 +3144,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
 	CLK(NULL,	"aess_fck",			&aess_fck,	CK_443X),
 	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
+	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
 	CLK(NULL,	"des3des_fck",			&des3des_fck,	CK_443X),
+	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
 	CLK(NULL,	"dmic_fck",			&dmic_fck,	CK_443X),
 	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
@@ -3293,6 +3329,9 @@ int __init omap4xxx_clk_init(void)
 	if (cpu_is_omap44xx()) {
 		cpu_mask = RATE_IN_4430;
 		cpu_clkflg = CK_443X;
+	} else if (cpu_is_omap446x()) {
+		cpu_mask = RATE_IN_4460;
+		cpu_clkflg = CK_446X;
 	}
 
 	clk_init(&omap2_clk_functions);
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index f1899a3..387a963 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -39,6 +39,7 @@ struct omap_clk {
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
 #define CK_TI816X	(1 << 12)
+#define CK_446X		(1 << 13)
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 006e599..21b1beb 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -58,10 +58,12 @@ struct clkops {
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
 #define RATE_IN_TI816X		(1 << 6)
+#define RATE_IN_4460		(1 << 7)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
 #define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
+#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
 
 /* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
 #define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
