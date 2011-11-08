From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL v3] ARM: OMAP: Cortex-A9 PERIPHCLK node for 3.2
Date: Tue, 8 Nov 2011 00:53:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111080051471.12394@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com> <alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com> <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com> <20111105005312.GQ31337@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35068 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1KHHxb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 02:53:31 -0500
In-Reply-To: <20111105005312.GQ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, keshava_mgowda@ti.com

On Fri, 4 Nov 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [111010 17:09]:
> > The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> > 
> >   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> > 
> > are available in the git repository at:
> >   git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2
> > 
> > This pull request drops the EHCI/OHCI hwmod data due to some 
> > inconsistencies that were just found in the data.
> > 
> > Santosh Shilimkar (1):
> >       ARM: OMAP4: clock: Add CPU local timer clock node.
> > 
> >  arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> Should this be pulled into fixes for v3.2 -rc cycle?

Santosh would be the right person to ask.  Santosh, is anything broken in 
3.2 if this patch doesn't get merged in -rc?  Or is it just a feature 
which could be added in 3.3?


- Paul
