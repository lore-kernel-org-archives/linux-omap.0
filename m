From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/18] OMAP3 : clock data: Update name string for EMAC
 clocks
Date: Wed, 5 May 2010 13:02:23 -0700
Message-ID: <20100505200222.GC29604@atomide.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
 <20100505193308.21568.98880.stgit@baageli.muru.com>
 <20100505194556.GB17678@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64256 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214Ab0EEUCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 16:02:39 -0400
Content-Disposition: inline
In-Reply-To: <20100505194556.GB17678@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Sriramakrishnan <srk@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100505 12:41]:
> On Wed, May 05, 2010 at 12:33:09PM -0700, Tony Lindgren wrote:
> > The emac driver uses generic name for the module and phy
> > clocks. Updated the omap3xxx_clks table to match the names
> > used by the Davinci emac driver.
> 
> Patch doesn't match description.

Sriramakrishnan, can you please update the patch for better
description?

> IMHO "ick" and "fck" are generic names, whereas "emac_clk" and
> "phy_clk" are specific names.
> 
> > -	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
> > -	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
> > +	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> > +	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),

Yeah as Paul pointed out too, there should be a follow-up patch
to fix there clock names in drivers/net/davinci_emac.c, mach-davinci/dm646x.c,
mach-davinci/da850.c, and mach-omap2/clock3xxx_data.c.

That should also be mentioned in the patch description.

Regards,

Tony
