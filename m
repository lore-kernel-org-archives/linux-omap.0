From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: Access only available clock bits
Date: Fri, 20 Mar 2009 15:56:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903201556070.4676@utopia.booyaka.com>
References: <4d34a0a70903192015j4ea44b1fn4f7bb045da32d218@mail.gmail.com> <alpine.DEB.2.00.0903201523220.4676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44404 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCTV4x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 17:56:53 -0400
In-Reply-To: <alpine.DEB.2.00.0903201523220.4676@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, kyungmin.park@samsung.com, Tony Lindgren <tony@atomide.com>, bhmin@samsung.com

On Fri, 20 Mar 2009, Paul Walmsley wrote:

> On Fri, 20 Mar 2009, Kim Kyuwon wrote:
> 
> > I found a problem on PM Branch with OMAP3430 ES3.1 Board when enabling
> > OMAP_RESET_CLOCKS feature.
> > In clk_disable_unsed() function, as soon as sad2d_ick is disabled,
> > prcm interrupt is generated and its handler can't exit loop at next
> > statement!
> > 
> > while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));
> 
> We encountered a similar problem a few months ago.  The problem is 
> probably the pad mux settings on the d2d_mstdby and d2d_swakeup pads.  
> These are usually configured by the bootloader.  My recollection is that 
> they should be pulled up, but I don't recall for sure.

On second thought, I believe swakeup should be pulled down and mstdby 
should be pulled up.


- Paul
