From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
Date: Fri, 4 May 2012 13:05:47 -0700
Message-ID: <20120504200547.GU5613@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
 <20120503155717.GE5140@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
 <871un1j769.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA1409D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55021 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759570Ab2EDUFu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 16:05:50 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA1409D@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120503 23:04]:
> 
> Tony, seems to be against adding new ARCH_OMAPAM33XX, but which _ARCH_ we need to follow for AM33XX?
> I have to choose between ARCH_OMAP3 or ARCH_OMAP4 and what should I choose 
> here?

I think you're getting confused now :) I'm against ARCH_XXX but I'm OK with
adding SOC_XXX.

We should only need ARCH_OMAP2PLUS + SOC_XXX, there should not be any need
to add new ARCH_XXX under mach-omap2. Whatever we have left for ARCH_OMAP
in mach-omap2 will be eventually converted to SOC_OMAP.
 
> Does it make sense to follow ARCH_OMAPx but not follow cpu_is_omapxxx()?
> OR

No

> Should we create ARCH_AMXXXX, assuming that all AM devices have similar 

No

> memory map layout, interrupt mapping, etc...
> OR
> Should I just add SOC_OMAPAM33XX, wherever required?

Yes, but how about just use SOC_AM33XX? 
 
> Also, there are lot of thing wrapped under ARCH_OMAP3 || ARCH_OMAP4 option, which is required for AM33XX, how should we handle this?
> 
> For example,
> 
> "arch/arm/plat-omap/include/plat/clock.h"
> struct dpll_data {
> #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> 	<dpll related variables>
> #endif
> };
> 
> "arch/arm/mach-omap2/clock.c"
> 
> #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> 
> const struct clkops clkops_omap3_noncore_dpll_ops = {
> };
> const struct clkops clkops_omap3_core_dpll_ops = {
> }

I suggest doing some clean-up patches before adding SOC_AM33XX where
you just convert those to be

#if defined(CONFIG_ARCH_OMAP2PLUS) && !defined(CONFIG_ARCH_OMAP2)

or something similar depending if they already are inside mach-omap2
directory. This will make them future proof for adding new SoCs
without having to patch all over the place.

Regards,

Tony
