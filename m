From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
Date: Fri, 13 Jan 2012 08:44:59 -0800
Message-ID: <20120113164459.GI15299@atomide.com>
References: <20120112184256.GA2287@atomide.com>
 <alpine.LFD.2.02.1201121441580.2722@xanadu.home>
 <alpine.LFD.2.02.1201121447270.2722@xanadu.home>
 <20120112195951.GB2287@atomide.com>
 <20120113140520.GE16726@n2100.arm.linux.org.uk>
 <20120113150421.GF16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53554 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512Ab2AMQpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 11:45:11 -0500
Content-Disposition: inline
In-Reply-To: <20120113150421.GF16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120113 06:31]:
> On Fri, Jan 13, 2012 at 02:05:20PM +0000, Russell King - ARM Linux wrote:
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > ARM: Add arm_memblock_steal() to allocate memory away from the kernel
> > 
> > Several platforms are now using the memblock_alloc+memblock_free+
> > memblock_remove trick to obtain memory which won't be mapped in the
> > kernel's page tables.  Most platforms do this (correctly) in the
> > ->reserve callback.  However, OMAP has started to call these functions
> > outside of this callback, and this is extremely unsafe - memory will
> > not be unmapped, and could well be given out after memblock is no
> > longer responsible for its management.
> > 
> > So, provide arm_memblock_steal() to perform this function, and ensure
> > that it panic()s if it is used inappropriately.  Convert everyone
> > over, including OMAP.
> > 
> > As a result, OMAP will panic on boot with this change.  OMAP needs to
> > be fixed, or 137d105d50 (ARM: OMAP4: Fix errata i688 with MPU
> > interconnect barriers.) reverted until such time it can be fixed
> > correctly.
> 
> Santosh points out that this is only used if the errata i688 option is
> enabled, so I've added to this patch to make this config option depend
> on BROKEN, marked it as such, and commited the result to my fixes branch.
> 
> I'll be planning to push this to Linus sometime on Monday.

Sounds good to me.

Thanks,

Tony
