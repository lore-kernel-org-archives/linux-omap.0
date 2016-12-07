From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3] clk: ti: omap36xx: Work around sprz319 advisory 2.1
Date: Wed, 7 Dec 2016 17:34:02 +0100
Message-ID: <20161207163402.GA26187@localhost.localdomain>
References: <1480713278-6884-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <2239782.MNuANFihMe@avalon>
 <20161205093649.GA31898@localhost.localdomain>
 <3238104.GnrXpa3VZc@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3238104.GnrXpa3VZc@avalon>
Sender: linux-clk-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Richard Watts <rrw@kynesim.co.uk>, Tony Lindgren <tony@atomide.com>, Alexander Kinzer <a.kinzer@plusoptix.de>
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Tue, Dec 06, 2016 at 01:59:56AM +0200, Laurent Pinchart wrote:
> Hi Ladislav,
[snip]
> I've tested both versions with gcc 4.7.3 [1] and 4.8.5 [2]. With 4.7.3 my 
> version is 4 bytes longer, and with 4.8.5 it's 4 bytes shorter. Interestingly 
> enough the "break + test after loop" pattern doesn't make a difference, it's 
> only the intermediate variable that results in changes to the generated code.

Interesting exercise... I hereby present 92 bytes shorter version using
gcc version 5.4.0 (OSELAS.Toolchain-2016.06.0)
I hope it's still easily readable.

> [1] arm-linux-gnueabihf-gcc (crosstool-NG 
> linaro-1.13.1-4.7-2013.02-01-20130221 - Linaro GCC 2013.02) 4.7.3 20130205 
> (prerelease)
> 
> [2] arm-buildroot-linux-uclibcgnueabihf-gcc.br_real (Buildroot 2016.08-dirty) 
> 4.8.5

Best regards,
	ladis

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 88f2ce8..f7772fc 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -838,3 +838,69 @@ int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
 						      index);
 }
+
+/* Apply DM3730 errata sprz319 advisory 2.1. */
+static bool omap3_dpll5_apply_errata(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct omap3_dpll5_settings {
+		unsigned int rate;
+		unsigned short m, n;
+	};
+
+	int i;
+	struct dpll_data *dd;
+	struct clk_hw_omap *clk;
+	const struct omap3_dpll5_settings *p;
+	static const struct omap3_dpll5_settings precomputed[] = {
+		/*
+		 * From DM3730 errata advisory 2.1, table 35 and 36.
+		 * The N value is increased by 1 compared to the tables as the
+		 * errata lists register values while last_rounded_field is the
+		 * real divider value.
+		 */
+		{ 12000000,  80,  0 + 1 },
+		{ 13000000, 443,  5 + 1 },
+		{ 19200000,  50,  0 + 1 },
+		{ 26000000, 443, 11 + 1 },
+		{ 38400000,  25,  0 + 1 }
+	};
+
+	for (i = 0; i< ARRAY_SIZE(precomputed); i++) {
+		p = precomputed + i;
+		if (parent_rate == p->rate) {
+			clk = to_clk_hw_omap(hw);
+			dd = clk->dpll_data;
+			/* Update the M, N and rounded rate values */
+			dd->last_rounded_m = p->m;
+			dd->last_rounded_n = p->n;
+			dd->last_rounded_rate =
+				div_u64((u64)parent_rate * p->m, p->n);
+			omap3_noncore_dpll_program(clk, 0);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * omap3_dpll5_set_rate - set rate for omap3 dpll5
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Set rate for the DPLL5 clock. Apply the sprz319 advisory 2.1 on OMAP36xx if
+ * the DPLL is used for USB host (detected through the requested rate).
+ */
+int omap3_dpll5_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	if (rate == OMAP3_DPLL5_FREQ_FOR_USBHOST * 8) {
+		if (omap3_dpll5_apply_errata(hw, parent_rate))
+			return 0;
+	}
+
+	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
+}
-- 
2.1.4

