From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv6 01/11] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Fri, 26 Aug 2011 03:12:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108260257410.9743@utopia.booyaka.com>
References: <1311611771-15093-1-git-send-email-t-kristo@ti.com> <1311611771-15093-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39751 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1HZJM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Aug 2011 05:12:26 -0400
In-Reply-To: <1311611771-15093-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>

Hello Tero,

a few comments on this patch:

On Mon, 25 Jul 2011, Tero Kristo wrote:

> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.
> 
> arch/arm/mach-omap2/prcm.c implements the chained interrupt mechanism
> itself, with SoC specific support / init structure defined in
> arch/arm/mach-omap2/prm2xxx_3xxx.c and arch/arm/mach-omap2/prm4xxx.c
> respectively. At initialization time, the set of PRCM events is filtered
> against the SoC on which we are running, keeping only the ones that are
> actually useful. All the logic is written to be generic with regard to
> OMAP3/OMAP4, even though OMAP3 has single PRCM event registers and OMAP4
> has two PRCM event registers.

Looking over this patch, it seems that this functionality should be
part of a PRM device driver.  That would allow the separation of the
SoC-specific data from the code, so there wouldn't be a need to embed
the OMAP_PRCM_IRQ data in the driver code.  Rather, that data could go
into the dev_attr data for the PRM hwmod.  That avoids putting
SoC-specific data in driver code, allows the removal of
omap[34]_prcm_irq_setup(), and should also remove the dependency on
omap_chip.

Similarly, OMAP_PRCM_MAX_NR_PENDING_REG and OMAP_PRCM_NR_IRQS should
be defined somewhere SoC-specific.  I'd suggest defining those in the
hwmod dev_attr data.  That way that file won't need to be patched if
those constants need change in the future.  Unfortunately, doing this
in a clean way will probably mean that the variables that are
allocated via these constants will need to be allocated and freed
dynamically.

What I'd suggest is to create a short series that:

1. adds PRM hwmod data for OMAP2430+ platforms

2. adds a basic PRM device driver skeleton in a directory such as
   drivers/power -- (I'm not convinced that this is the right place,
   in the end; but seems like a good place to start)

3. creates the chained interrupt handler in the PRM device driver,
   and removes the old PRCM interrupt handler from pm34xx.c 

...

A few other relatively minor comments:

- Probably omap_prcm_irq_cleanup() shouldn't be called from pm34xx.c,
  since other code outside of pm34xx.c might wish to use the PRCM
  interrupt, even in the (admittedly unlikely) circumstance that some
  of the code in pm34xx.c fails?

- It would be good to document struct omap_prcm_irq via KernelDoc,
  rather than inline comments
  (Documentation/kernel-doc-nano-HOWTO.txt).  It would be ideal if the
  patch's function documentation followed the same standard.


- Paul
