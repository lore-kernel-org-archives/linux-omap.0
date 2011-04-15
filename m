From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 17:58:58 +0100
Message-ID: <20110415165857.GH4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA84AAB.60601@gmail.com> <20110415160339.GF4423@n2100.arm.linux.org.uk> <56132A77AB93C141BF06E6B96CA6CFEA1F88D9@039-SN1MPN1-004.039d.mgd.msft.net> <20110415162045.GG4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52094 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922Ab1DOQ7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 12:59:18 -0400
Content-Disposition: inline
In-Reply-To: <20110415162045.GG4423@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nguyen Dinh-R00091 <R00091@freescale.com>
Cc: Kevin Hilman <khilman@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 15, 2011 at 05:20:45PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 04:18:23PM +0000, Nguyen Dinh-R00091 wrote:
> > >Hmm, that's nice - except for one issue.  According to my grep of
> > >arch/arm/ and drivers/, nothing uses iram_alloc().  So, does anything in
> > >the MX stuff use iram_alloc.c, or is it dead code left over from a
> > >previous experiment?
> > 
> > This function will be used for suspend code in the mx5x series. I just
> > got done submitting a series of patches to Sascha for a simple suspend
> > that does not need running code out of IRAM yet. The next set of suspend
> > patches will be using these iram functions.
> 
> Okay, so does iram_alloc() need to return a dma_addr_t or a phys_addr_t ?
> Are you dealing with physical addresses for it or DMA addresses?

And another question: why does iram_alloc() return a void __iomem * for
the virtual address, and the physical address via a pointer argument.
However, iram_free() take an unsigned long for the address.

It seems rather inconsistent that the parameter for free is returned via
a pointer argument.

If I convert this to sram-pool, can we change this to:

static inline void *iram_alloc(size_t size, phys_addr_t *phys_addr)
{
	return sram_pool_alloc(iram_pool, size, phys_addr);
}

static void iram_free(void *addr, size_t size)
{
	sram_pool_free(iram_pool, addr, size);
}

and:

int __init iram_init(unsigned long base, unsigned long size)

becomes:

int __init iram_init(phys_addr_t base, size_t size)

?
