From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 00/09] OMAP PM interface implementation using Sharedresource f/w
Date: Fri, 11 Jul 2008 17:24:59 +0530
Message-ID: <018301c8e34c$f2e9fe20$68bf18ac@ent.ti.com>
References: <030701c8e0ef$42440a20$68bf18ac@ent.ti.com> <20080711115234.GD4401@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:53867 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbYGKLzP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jul 2008 07:55:15 -0400
In-Reply-To: <20080711115234.GD4401@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Peter 'p2' De Schrijver' <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Peter 'p2' De Schrijver [mailto:peter.de-schrijver@nokia.com] 
> Sent: Friday, July 11, 2008 5:23 PM
> To: ext Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 00/09] OMAP PM interface implementation 
> using Sharedresource f/w
> 
> Hi Rajendra,
> 
> > Hi,
> > 
> > The patches which follow implement the API's defined by 
> Paul Walmsley as part of the 
> > OMAP PM Interface on OMAP3430sdp. 
> > Shared resource f/w is used for the underlying implementation.
> > 
> > The following resources are modeled
> > 1) MPU/CORE latency resources
> > 2) Power Domain latency resources (One for each Power domain)
> > 3) OPP/Freq resources (For DVFS)
> > 
> > The below API from the OMAP PM interface is yet to be implemented.
> > void omap_pm_set_min_bus_tput(struct device *dev, struct 
> bus_type *bus,
> >                                     unsigned long r)
> > 
> 
> I tried to apply this to linux-omap, but when compiling I get the
> following error message :
> 
> arch/arm/mach-omap2/clockdomain.c:38:30: error: 
> asm/arch/omap-pm.h: No such file or directory

This file was part of Paul's no-op patch for omap-pm layer.
You should be able to fix this if you apply the no-op patch.

> arch/arm/mach-omap2/clockdomain.c: In function 
> 'omap2_clkdm_clk_enable':
> arch/arm/mach-omap2/clockdomain.c:572: error: implicit 
> declaration of function 'omap_pm_pwrdm_active'
> arch/arm/mach-omap2/clockdomain.c: In function 
> 'omap2_clkdm_clk_disable':
> arch/arm/mach-omap2/clockdomain.c:626: error: implicit 
> declaration of function 'omap_pm_pwrdm_inactive'
> make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Seems there is a file missing from the patchset.
> 
> Thanks,
> 
> Peter.
> 
> -- 
> goa is a state of mind
> 

