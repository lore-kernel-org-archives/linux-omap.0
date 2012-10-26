From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 10/16] ARM: OMAP: Make omap_device local to mach-omap2
Date: Fri, 26 Oct 2012 20:18:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262016410.11258@utopia.booyaka.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local> <20121004220456.26676.31050.stgit@muffinssi.local> <alpine.DEB.2.00.1210260124360.11251@utopia.booyaka.com> <20121026163900.GC11908@atomide.com> <alpine.DEB.2.00.1210261701060.3301@utopia.booyaka.com>
 <20121026171059.GG11908@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40931 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966367Ab2JZUSt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:18:49 -0400
In-Reply-To: <20121026171059.GG11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, 26 Oct 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [121026 10:03]:
> > On Fri, 26 Oct 2012, Tony Lindgren wrote:
> > 
> > > Can you do a branch on top of omap-for-v3.8/cleanup-headers
> > > with all these fixes that I can pull in?
> > 
> > Yes, will do that today.
> 
> OK thanks!

Just sent the pull request.  Are you planning to rebuild cleanup-prcm also 
when you pull those cleanup-headers fixes in?  Am planning to send another 
PRCM cleanup pull request next week...


- Paul
