From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCHv9 01/43] clk: Add support for regmap register read/write
Date: Tue, 5 Nov 2013 22:43:20 +0100
Message-ID: <20131105214320.GC17929@book.gsilab.sittig.org>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-2-git-send-email-t-kristo@ti.com>
 <52726342.6030406@ti.com>
 <52726BD5.3080704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41825 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab3KEVn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Nov 2013 16:43:27 -0500
Content-Disposition: inline
In-Reply-To: <52726BD5.3080704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Thu, Oct 31, 2013 at 16:40 +0200, Tero Kristo wrote:
> 
> On 10/31/2013 04:03 PM, Nishanth Menon wrote:
> >On 10/25/2013 10:56 AM, Tero Kristo wrote:
> >[...]
> >>diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> >>index 7e59253..63ff78c 100644
> >>--- a/include/linux/clk-provider.h
> >>+++ b/include/linux/clk-provider.h
> >
> >[...]
> >>-static inline u32 clk_readl(u32 __iomem *reg)
> >>+static inline u32 clk_readl(u32 __iomem *reg, struct regmap *regmap)
> >>  {
> >>-	return readl(reg);
> >>+	u32 val;
> >>+
> >>+	if (regmap)
> >>+		regmap_read(regmap, (u32)reg, &val);
> >>+	else
> >>+		val = readl(reg);
> >>+	return val;
> >>  }
> >>
> >>-static inline void clk_writel(u32 val, u32 __iomem *reg)
> >>+static inline void clk_writel(u32 val, u32 __iomem *reg, struct regmap *regmap)
> >>  {
> >>-	writel(val, reg);
> >>+	if (regmap)
> >>+		regmap_write(regmap, (u32)reg, val);
> >>+	else
> >>+		writel(val, reg);
> >>  }
> >>
> >>  #endif /* CONFIG_COMMON_CLK */
> >>
> >
> >Might it not be better to introduce regmap variants?
> >static inline void clk_regmap_writel(u32 val, u32 reg, struct regmap
> >*regmap)
> >and corresponding readl? that allows cleaner readability for clk
> >drivers that use regmap and those that dont.
> 
> Well, doing that will introduce a lot of redundant code, as the
> checks for the presence of regmap must be copied all over the place.
> With this patch, all the generic clock drivers support internally
> both regmap or non-regmap register accesses.

Please keep in mind that the "identity" of clk_readl() and
readl() only applies in the current source code (ARM only use of
common CCF primitives), while patches are pending (currently
under review and receiving further improvement) which introduce
several alternative implementations of clk_readl() depending on
the platform.  Making all of them duplicate the "regmap vs direct
register access" branch would be as bad.  Keeping one set of
clk_readl() and clk_writel() routines and adding #ifdefs around
the direct register access would be rather ugly, and I understand
that preprocessor ifdef counts should get reduced instead of
introduced.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
