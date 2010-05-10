From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/18] OMAP3 : clock data: Update name string for EMAC
 clocks
Date: Mon, 10 May 2010 13:17:17 -0700
Message-ID: <20100510201717.GF16460@atomide.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
 <20100505193308.21568.98880.stgit@baageli.muru.com>
 <20100505194556.GB17678@n2100.arm.linux.org.uk>
 <20100505200222.GC29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50967 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535Ab0EJURp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 16:17:45 -0400
Content-Disposition: inline
In-Reply-To: <20100505200222.GC29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Sriramakrishnan <srk@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100505 12:59]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100505 12:41]:
> > On Wed, May 05, 2010 at 12:33:09PM -0700, Tony Lindgren wrote:
> > > The emac driver uses generic name for the module and phy
> > > clocks. Updated the omap3xxx_clks table to match the names
> > > used by the Davinci emac driver.
> > 
> > Patch doesn't match description.
> 
> Sriramakrishnan, can you please update the patch for better
> description?

Never mind, running out of time waiting. Updated patch below.
 
> > IMHO "ick" and "fck" are generic names, whereas "emac_clk" and
> > "phy_clk" are specific names.
> > 
> > > -	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
> > > -	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
> > > +	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> > > +	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
> 
> Yeah as Paul pointed out too, there should be a follow-up patch
> to fix there clock names in drivers/net/davinci_emac.c, mach-davinci/dm646x.c,
> mach-davinci/da850.c, and mach-omap2/clock3xxx_data.c.
> 
> That should also be mentioned in the patch description.

Added a note for that too.

Tony

--vkogqOf2sHV7VnPd
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="board-omap3-emac-naming.patch"

>From eba164add86ebeb389f636ffca8ab691956cfe01 Mon Sep 17 00:00:00 2001
From: Sriram <srk@ti.com>
Date: Thu, 11 Mar 2010 15:13:41 +0000
Subject: [PATCH] OMAP3 : clock data: Update name string for EMAC clocks

The emac driver currently uses Davinci clock names for the module and phy
clocks. Updated the omap3xxx_clks table to match the names
used by the Davinci emac driver.

Note that eventually the EMAC clocks should be renamed to be generic.

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
[tony@atomide.com: updated patch description to match the patch]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 9cba556..6905eb7 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3472,8 +3472,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
 	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
-	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
-	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
+	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
+	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
 	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
 	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
 	CLK("musb_hdrc",	"ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),

--vkogqOf2sHV7VnPd--
