From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] OMAP clock/SDRC patches on v2.6.30-rc5
Date: Tue, 26 May 2009 15:04:31 -0700
Message-ID: <20090526220431.GF11865@atomide.com>
References: <20090512235713.10349.49339.stgit@localhost.localdomain> <alpine.DEB.2.00.0905261025350.17019@utopia.booyaka.com> <20090526163703.GF26713@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0905261050560.17019@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52321 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZEZWEo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 18:04:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0905261050560.17019@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [090526 09:53]:
> On Tue, 26 May 2009, Russell King - ARM Linux wrote:
> 
> > On Tue, May 26, 2009 at 10:29:52AM -0600, Paul Walmsley wrote:
> > > Hello Russell,
> > > 
> > > On Tue, 12 May 2009, Paul Walmsley wrote:
> > > 
> > > > This series contains OMAP clock and SDRAM controller patches against
> > > > v2.6.30-rc5.  If you are happy with these, Tony will merge them into
> > > > his for-next branch for you to pull.
> > > > 
> > > > This series includes the clk_init_one() to clk_preinit() rename that
> > > > we've discussed recently.  Most of the patches prepare for CORE DPLL
> > > > M2 rate changing support.
> > > 
> > > Any comments on these patches?
> > 
> > All look fine to me.
> 
> Great, thanks.

I've pulled these to the omap for-next branch to wait for the merge window.

Tony
