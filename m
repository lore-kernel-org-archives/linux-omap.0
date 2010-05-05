From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 12/18] OMAP3 : clock data: Update name string for EMAC
	clocks
Date: Wed, 5 May 2010 20:45:56 +0100
Message-ID: <20100505194556.GB17678@n2100.arm.linux.org.uk>
References: <20100505192957.21568.19569.stgit@baageli.muru.com> <20100505193308.21568.98880.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40787 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab0EETqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:46:16 -0400
Content-Disposition: inline
In-Reply-To: <20100505193308.21568.98880.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Sriramakrishnan <srk@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Wed, May 05, 2010 at 12:33:09PM -0700, Tony Lindgren wrote:
> The emac driver uses generic name for the module and phy
> clocks. Updated the omap3xxx_clks table to match the names
> used by the Davinci emac driver.

Patch doesn't match description.  IMHO "ick" and "fck" are generic names,
whereas "emac_clk" and "phy_clk" are specific names.

> -	CLK("davinci_emac",	"ick",		&emac_ick,	CK_AM35XX),
> -	CLK("davinci_emac",	"fck",		&emac_fck,	CK_AM35XX),
> +	CLK("davinci_emac",	"emac_clk",	&emac_ick,	CK_AM35XX),
> +	CLK("davinci_emac",	"phy_clk",	&emac_fck,	CK_AM35XX),
