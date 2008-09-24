From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 11:00:00 +0300
Message-ID: <20080924075959.GF5222@atomide.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com> <20080924.065137.142952786.Hiroshi.DOYU@nokia.com> <dfeb90390809240005xadef43dhb78c8ae214baab64@mail.gmail.com> <20080924071201.GE5222@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56019 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYIXIAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 04:00:07 -0400
Content-Disposition: inline
In-Reply-To: <20080924071201.GE5222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Walmsley <paul@booyaka.com>, linux-omap@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080924 10:12]:
> * Arun KS <arunks@mistralsolutions.com> [080924 10:05]:
> > On Wed, Sep 24, 2008 at 9:21 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > > Hi,
> > >
> > > How about introducing a new typedef in order to accommodate the
> > > different size of enable_regs without ifdefs?
> > >
> > > I think that this is apparently the case categorized into (a) in
> > > 'CodyingStyle'.
> > 
> > I am not sure which is the right way to do. Is this what you meant?
> 
> No, let's not do this. It should be void __iomem * for sure. Most of
> the omap1 clock registers looks just fine for void __iomem *, let's
> figure out which registers are broken.

I've pushed a fix for this. Turns out I missed some conversions to
void __iomem * while merging code from arm-devel branch. Fix also
attached.

Can you please check that it works for you now?

Tony

--TB36FDmn/VVEgNH/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap1-clock-fix.patch"

>From 3fa3f8c8f56d0013b3802319c601581d73882ff4 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 24 Sep 2008 10:56:18 +0300
Subject: [PATCH] Fix booting of omap1

This got broken because of mismerge from arm-devel.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index f26ad8c..24552b2 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -31,7 +31,7 @@ struct clksel {
 };
 
 struct dpll_data {
-	u16			mult_div1_reg;
+	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
 	u16			last_rounded_m;
@@ -41,18 +41,18 @@ struct dpll_data {
 	u16			max_multiplier;
 	u8			max_divider;
 	u32			max_tolerance;
-	u16			idlest_reg;
+	void __iomem		*idlest_reg;
 	u32			idlest_mask;
 	struct clk		*bypass_clk;
 #  if defined(CONFIG_ARCH_OMAP3)
 	u32			freqsel_mask;
 	u8			modes;
-	u16			control_reg;
+	void __iomem		*control_reg;
 	u32			enable_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
-	u16			autoidle_reg;
+	void __iomem		*autoidle_reg;
 	u32			autoidle_mask;
 #  endif
 };
@@ -67,7 +67,7 @@ struct clk {
 	struct clk		*parent;
 	unsigned long		rate;
 	__u32			flags;
-	u16			enable_reg;
+	void __iomem		*enable_reg;
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			idlest_bit;
@@ -79,7 +79,7 @@ struct clk {
 	void			(*disable)(struct clk *);
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	u8			fixed_div;
-	u16			clksel_reg;
+	void __iomem		*clksel_reg;
 	u32			clksel_mask;
 	const struct clksel	*clksel;
 	struct dpll_data	*dpll_data;

--TB36FDmn/VVEgNH/--
