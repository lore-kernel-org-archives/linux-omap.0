From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/16] ARM: OMAP: Make omap_device local to mach-omap2
Date: Fri, 26 Oct 2012 13:37:41 -0700
Message-ID: <20121026203741.GT11908@atomide.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220456.26676.31050.stgit@muffinssi.local>
 <alpine.DEB.2.00.1210260124360.11251@utopia.booyaka.com>
 <20121026163900.GC11908@atomide.com>
 <alpine.DEB.2.00.1210261701060.3301@utopia.booyaka.com>
 <20121026171059.GG11908@atomide.com>
 <alpine.DEB.2.00.1210262016410.11258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55044 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422673Ab2JZUhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:37:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210262016410.11258@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [121026 13:20]:
> On Fri, 26 Oct 2012, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [121026 10:03]:
> > > On Fri, 26 Oct 2012, Tony Lindgren wrote:
> > > 
> > > > Can you do a branch on top of omap-for-v3.8/cleanup-headers
> > > > with all these fixes that I can pull in?
> > > 
> > > Yes, will do that today.
> > 
> > OK thanks!
> 
> Just sent the pull request.  Are you planning to rebuild cleanup-prcm also 
> when you pull those cleanup-headers fixes in?  Am planning to send another 
> PRCM cleanup pull request next week...

I've merged omap-for-v3.8/cleanup-headers into omap-for-v3.8/cleanup-prcm
too now, so you should be able to use commit 7fc54fd3 as the base for
further PRCM changes.

Regards,

Tony
