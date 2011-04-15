From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 20:31:52 +0200
Message-ID: <20110415183152.GA10539@game.jcrosoft.org>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 30.mail-out.ovh.net ([213.186.62.213]:50905 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752161Ab1DOSk0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 14:40:26 -0400
Content-Disposition: inline
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 14:06 Fri 15 Apr     , Russell King - ARM Linux wrote:
> This is work in progress.
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> Unfortunately, we end up with code growth through doing this, but that
> will become a win when we have another SoC using this (which I know
> there's at least one in the pipeline).
> 
> One of the considerations here is that we can easily convert sram-pool.c
> to hook into device tree stuff, which can tell the sram allocator:
> 	- physical address of sram
> 	- size of sram
> 	- allocation granularity
> and then we just need to ensure that it is appropriately mapped.
> 
> This uses the physical address, and unlike Davinci's dma address usage,
> it always wants to have the physical address, and will always return
> the corresponding physical address when passed that pointer.
> 
> OMAP could probably do with some more work to make the omapfb and other
> allocations use the sram allocator, rather than hooking in before the
> sram allocator is initialized - and then further cleanups so that we
> have an initialization function which just does
> 
> sram_create(phys, size)
> 	virt = map sram(phys, size)
> 	create sram pool(virt, phys, size, min_alloc_order)
> 
> Another question is whether we should allow multiple SRAM pools or not -
> this code does allow multiple pools, but so far we only have one pool
> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
> it if they want to partition the SRAM, or have peripheral-local SRAMs.
> 
> Lastly, uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Hi,

	I also work on it for at91

	and already have some patch in the mm for this

	[PATCH] genalloc: add support to specify the physical address

	so now you can do this

	as I do on at91 will send the patch after

static struct map_desc at91sam9g20_sram_desc[] __initdata = {
	{
		.virtual	= AT91_IO_VIRT_BASE - AT91SAM9G20_SRAM_SIZE,
		.pfn		= __phys_to_pfn(AT91SAM9G20_SRAM_BASE),
		.length		= AT91SAM9G20_SRAM_SIZE,
		.type		= MT_DEVICE,
	}
};

	sram_pool = gen_pool_create(2, -1);

	gen_pool_add_virt(sram_pool, io_desc->virtual __pfn_to_phys(io_desc->pfn),
			io_desc->length, -1)

	and to get the physical address

	phys = gen_pool_virt_to_phys(sram_pool, virt);

Best Resgards,
J.
