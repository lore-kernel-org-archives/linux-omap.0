From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] ARM: OMAP2/3: Change omapfb to use clkdev for
	dispc and rfbi
Date: Thu, 14 May 2009 13:28:06 -0700
Message-ID: <20090514202805.GQ5593@atomide.com>
References: <20090514174100.12080.9736.stgit@localhost> <20090514174959.12080.64417.stgit@localhost> <20090514210312.9fa02bb3.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="va4/JQ6j8/8uipEp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61687 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530AbZENU2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 16:28:20 -0400
Content-Disposition: inline
In-Reply-To: <20090514210312.9fa02bb3.krzysztof.h1@poczta.fm>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Krzysztof Helt <krzysztof.h1@poczta.fm> [090514 11:57]:
> On Thu, 14 May 2009 10:49:59 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > This makes the framebuffer work on omap3.
> > 
> > Also fix the clk_get usage for checkpatch.pl
> > "ERROR: do not use assignment in if condition".
> > 
> > Cc: Imre Deak <imre.deak@nokia.com>
> > Cc: linux-fbdev-devel@lists.sourceforge.net
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thanks for looking. Here's v2 of the patch with one line fixed below.

> > --- a/drivers/video/omap/dispc.c
> > +++ b/drivers/video/omap/dispc.c
> > @@ -880,23 +880,25 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
> >  
> >  static int get_dss_clocks(void)
> >  {
> > -	if (IS_ERR((dispc.dss_ick = clk_get(dispc.fbdev->dev, "dss_ick")))) {
> > -		dev_err(dispc.fbdev->dev, "can't get dss_ick\n");
> > +	dispc.dss_ick = clk_get(dispc.fbdev->dev, "ick");
> > +	if (IS_ERR(dispc.dss_ick)) {
> > +		dev_err(dispc.fbdev->dev, "can't get ick\n");
> >  		return PTR_ERR(dispc.dss_ick);
> >  	}
> >  
> > -	if (IS_ERR((dispc.dss1_fck = clk_get(dispc.fbdev->dev, "dss1_fck")))) {
> > +	dispc.dss1_fck = clk_get(dispc.fbdev->dev, "dss1_fck");
> > +	if (IS_ERR(dispc.dss1_fck)) {
> >  		dev_err(dispc.fbdev->dev, "can't get dss1_fck\n");
> >  		clk_put(dispc.dss_ick);
> >  		return PTR_ERR(dispc.dss1_fck);
> >  	}
> >  
> > -	if (IS_ERR((dispc.dss_54m_fck =
> > -				clk_get(dispc.fbdev->dev, "dss_54m_fck")))) {
> > -		dev_err(dispc.fbdev->dev, "can't get dss_54m_fck\n");
> > +	dispc.dss_54m_fck = clk_get(dispc.fbdev->dev, "tv_fck");
> > +	if (IS_ERR(dispc.dss_54m_fck)) {
> > +		dev_err(dispc.fbdev->dev, "can't get tv_fck\n");
> >  		clk_put(dispc.dss_ick);
> >  		clk_put(dispc.dss1_fck);
> > -		return PTR_ERR(dispc.dss_54m_fck);
> > +
> >  	}

The return PTR_ERR(dispc.dss_54m_fck) should not be left out.

Regards,

Tony

--va4/JQ6j8/8uipEp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="dispc-clkdev-v2.patch"

commit 27db33cfadd3c47c9499def6e71aaf5d2fd51e60
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue May 12 11:20:03 2009 -0700

    ARM: OMAP2/3: Change omapfb to use clkdev for dispc and rfbi, v2
    
    This makes the framebuffer work on omap3.
    
    Also fix the clk_get usage for checkpatch.pl
    "ERROR: do not use assignment in if condition".
    
    Cc: Imre Deak <imre.deak@nokia.com>
    Cc: linux-fbdev-devel@lists.sourceforge.net
    Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index ff9b4c0..e4cef33 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -103,10 +103,10 @@ static struct omap_clk omap24xx_clks[] = {
 	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
 	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
 	/* DSS domain clocks */
-	CLK(NULL,	"dss_ick",	&dss_ick,	CK_243X | CK_242X),
-	CLK(NULL,	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
-	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_243X | CK_242X),
+	CLK("omapfb",	"ick",		&dss_ick,	CK_243X | CK_242X),
+	CLK("omapfb",	"dss1_fck",	&dss1_fck,	CK_243X | CK_242X),
+	CLK("omapfb",	"dss2_fck",	&dss2_fck,	CK_243X | CK_242X),
+	CLK("omapfb",	"tv_fck",	&dss_54m_fck,	CK_243X | CK_242X),
 	/* L3 domain clocks */
 	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
 	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index a057539..ba05aa4 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -197,11 +197,11 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
 	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
 	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
-	CLK(NULL,	"dss1_alwon_fck", &dss1_alwon_fck, CK_343X),
-	CLK(NULL,	"dss_tv_fck",	&dss_tv_fck,	CK_343X),
-	CLK(NULL,	"dss_96m_fck",	&dss_96m_fck,	CK_343X),
-	CLK(NULL,	"dss2_alwon_fck", &dss2_alwon_fck, CK_343X),
-	CLK(NULL,	"dss_ick",	&dss_ick,	CK_343X),
+	CLK("omapfb",	"dss1_fck",	&dss1_alwon_fck, CK_343X),
+	CLK("omapfb",	"tv_fck",	&dss_tv_fck,	CK_343X),
+	CLK("omapfb",	"video_fck",	&dss_96m_fck,	CK_343X),
+	CLK("omapfb",	"dss2_fck",	&dss2_alwon_fck, CK_343X),
+	CLK("omapfb",	"ick",		&dss_ick,	CK_343X),
 	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index dfb72f5..148cbcc 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -880,20 +880,22 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *dev)
 
 static int get_dss_clocks(void)
 {
-	if (IS_ERR((dispc.dss_ick = clk_get(dispc.fbdev->dev, "dss_ick")))) {
-		dev_err(dispc.fbdev->dev, "can't get dss_ick\n");
+	dispc.dss_ick = clk_get(dispc.fbdev->dev, "ick");
+	if (IS_ERR(dispc.dss_ick)) {
+		dev_err(dispc.fbdev->dev, "can't get ick\n");
 		return PTR_ERR(dispc.dss_ick);
 	}
 
-	if (IS_ERR((dispc.dss1_fck = clk_get(dispc.fbdev->dev, "dss1_fck")))) {
+	dispc.dss1_fck = clk_get(dispc.fbdev->dev, "dss1_fck");
+	if (IS_ERR(dispc.dss1_fck)) {
 		dev_err(dispc.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(dispc.dss_ick);
 		return PTR_ERR(dispc.dss1_fck);
 	}
 
-	if (IS_ERR((dispc.dss_54m_fck =
-				clk_get(dispc.fbdev->dev, "dss_54m_fck")))) {
-		dev_err(dispc.fbdev->dev, "can't get dss_54m_fck\n");
+	dispc.dss_54m_fck = clk_get(dispc.fbdev->dev, "tv_fck");
+	if (IS_ERR(dispc.dss_54m_fck)) {
+		dev_err(dispc.fbdev->dev, "can't get tv_fck\n");
 		clk_put(dispc.dss_ick);
 		clk_put(dispc.dss1_fck);
 		return PTR_ERR(dispc.dss_54m_fck);
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index a13c8dc..9332d6c 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -83,12 +83,14 @@ static inline u32 rfbi_read_reg(int idx)
 
 static int rfbi_get_clocks(void)
 {
-	if (IS_ERR((rfbi.dss_ick = clk_get(rfbi.fbdev->dev, "dss_ick")))) {
-		dev_err(rfbi.fbdev->dev, "can't get dss_ick\n");
+	rfbi.dss_ick = clk_get(rfbi.fbdev->dev, "ick");
+	if (IS_ERR(rfbi.dss_ick)) {
+		dev_err(rfbi.fbdev->dev, "can't get ick\n");
 		return PTR_ERR(rfbi.dss_ick);
 	}
 
-	if (IS_ERR((rfbi.dss1_fck = clk_get(rfbi.fbdev->dev, "dss1_fck")))) {
+	rfbi.dss1_fck = clk_get(rfbi.fbdev->dev, "dss1_fck");
+	if (IS_ERR(rfbi.dss1_fck)) {
 		dev_err(rfbi.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(rfbi.dss_ick);
 		return PTR_ERR(rfbi.dss1_fck);

--va4/JQ6j8/8uipEp--
