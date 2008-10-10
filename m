From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Fix compiler warnings in smartreflex.c
Date: Fri, 10 Oct 2008 15:54:29 +0300
Message-ID: <20081010125429.GD7503@gandalf.research.nokia.com>
References: <1223642237-9345-1-git-send-email-premi@ti.com> <20081010124407.GC7503@gandalf.research.nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37136 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbYJJMyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 08:54:52 -0400
Content-Disposition: inline
In-Reply-To: <20081010124407.GC7503@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Fri, Oct 10, 2008 at 03:44:07PM +0300, ext Felipe Balbi wrote:
> On Fri, Oct 10, 2008 at 06:07:17PM +0530, ext Sanjeev Premi wrote:
> > Fix these compiler warnings:
> > smartreflex.c:126: warning: initialization makes integer from pointer without a cast
> > smartreflex.c:134: warning: initialization makes integer from pointer without a cast
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/smartreflex.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> > index e54c0fb..8460633 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -123,7 +123,7 @@ static struct omap_sr sr1 = {
> >  	.is_sr_reset		= 1,
> >  	.is_autocomp_active	= 0,
> >  	.clk_length		= 0,
> > -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
> > +	.srbase_addr		= (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
> 
> please don't. Most likely srbase_addr should move to void __iomem *
> 
> Paul, any comments ??

Took a look at it, the following might be a better ?? (compile tested
only)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e54c0fb..084f855 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -43,32 +43,32 @@ struct omap_sr {
 	int		srid;
 	int		is_sr_reset;
 	int		is_autocomp_active;
-	struct clk 	*clk;
-	u32 		clk_length;
-	u32 		req_opp_no;
-	u32 		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
+	struct clk	*clk;
+	u32		clk_length;
+	u32		req_opp_no;
+	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
 	u32		opp5_nvalue;
 	u32		senp_mod, senn_mod;
-	u32		srbase_addr;
-	u32		vpbase_addr;
+	void __iomem	*srbase_addr;
+	void __iomem	*vpbase_addr;
 };
 
 /* Custom clocks to enable SR specific enable/disable functions. */
 struct sr_custom_clk {
-	struct clk 	clk;  /* meta-clock with custom enable/disable calls */
-	struct clk 	*fck; /* actual functional clock */
-	struct omap_sr 	*sr;
+	struct clk	clk;  /* meta-clock with custom enable/disable calls */
+	struct clk	*fck; /* actual functional clock */
+	struct omap_sr	*sr;
 };
 
-#define SR_REGADDR(offs)     (__force void __iomem *)(sr->srbase_addr + offset)
+#define SR_REGADDR(offs)     (sr->srbase_addr + offset)
 
-static inline void sr_write_reg(struct omap_sr *sr, int offset, u32 value)
+static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
 	__raw_writel(value, SR_REGADDR(offset));
 }
 
-static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
-								u32 value)
+static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
+		u32 value)
 {
 	u32 reg_val;
 
@@ -79,7 +79,7 @@ static inline void sr_modify_reg(struct omap_sr *sr, int offset, u32 mask,
 	__raw_writel(reg_val, SR_REGADDR(offset));
 }
 
-static inline u32 sr_read_reg(struct omap_sr *sr, int offset)
+static inline u32 sr_read_reg(struct omap_sr *sr, unsigned offset)
 {
 	return __raw_readl(SR_REGADDR(offset));
 }
@@ -136,7 +136,7 @@ static struct omap_sr sr2 = {
 
 static struct sr_custom_clk sr1_custom_clk = {
 	.clk = {
-			.name 		= "sr1_custom_clk",
+			.name		= "sr1_custom_clk",
 			.enable		= sr_clk_enable,
 			.disable	= sr_clk_disable,
 	},
@@ -145,7 +145,7 @@ static struct sr_custom_clk sr1_custom_clk = {
 
 static struct sr_custom_clk sr2_custom_clk = {
 	.clk = {
-			.name 		= "sr2_custom_clk",
+			.name		= "sr2_custom_clk",
 			.enable		= sr_clk_enable,
 			.disable	= sr_clk_disable,
 	},


> 
> >  };
> >  
> >  static struct omap_sr sr2 = {
> > @@ -131,7 +131,7 @@ static struct omap_sr sr2 = {
> >  	.is_sr_reset		= 1,
> >  	.is_autocomp_active	= 0,
> >  	.clk_length		= 0,
> > -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
> > +	.srbase_addr		= (u32)OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
> >  };
> >  
> >  static struct sr_custom_clk sr1_custom_clk = {
> > -- 
> > 1.5.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
