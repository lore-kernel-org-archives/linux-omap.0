From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v3] ARM: OMAP: Cortex-A9 PERIPHCLK node for 3.2
Date: Fri, 4 Nov 2011 17:53:12 -0700
Message-ID: <20111105005312.GQ31337@atomide.com>
References: <alpine.DEB.2.00.1110101342010.5205@utopia.booyaka.com>
 <alpine.DEB.2.00.1110101415560.5205@utopia.booyaka.com>
 <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24273 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752205Ab1KEAxQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 20:53:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1110101840440.5205@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com, keshava_mgowda@ti.com

* Paul Walmsley <paul@pwsan.com> [111010 17:09]:
> Hi Tony
> 
> The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> 
>   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 clock_hwmod_devel_3.2
> 
> This pull request drops the EHCI/OHCI hwmod data due to some 
> inconsistencies that were just found in the data.
> 
> Santosh Shilimkar (1):
>       ARM: OMAP4: clock: Add CPU local timer clock node.
> 
>  arch/arm/mach-omap2/clock44xx_data.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Should this be pulled into fixes for v3.2 -rc cycle?

Tony
