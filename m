From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
 implementation
Date: Mon, 2 Aug 2010 20:14:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641D580@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <1279927348-21750-3-git-send-email-davidsin@ti.com>
 <1279927348-21750-4-git-send-email-davidsin@ti.com>
 <1279927348-21750-5-git-send-email-davidsin@ti.com>
 <20100724080118.GB15064@n2100.arm.linux.org.uk>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D654A3FE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43795 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab0HBOo6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 10:44:58 -0400
In-Reply-To: <513FF747EED39B4AADBB4D6C9D9F9F7903D654A3FE@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sin, David" <davidsin@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Molnar, Lajos" <molnar@ti.com>, "Voultoury, Pierre" <p-voultoury@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Sin, David
> Sent: Monday, August 02, 2010 8:11 PM
> To: Russell King - ARM Linux; Woodruff, Richard
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-
> Cohen; Hiremath, Vaibhav; Shilimkar, Santosh; Molnar, Lajos; Voultoury,
> Pierre; linux-arm-kernel@lists.infradead.org
> Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, July 24, 2010 3:01 AM
> To: Sin, David
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org;
> Tony Lindgren; Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav;
> Shilimkar, Santosh; Molnar, Lajos
> Subject: Re: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
> On Fri, Jul 23, 2010 at 06:22:24PM -0500, David Sin wrote:
> > +/* allocate and flush a page */
> > +static struct mem *alloc_mem(void)
> > +{
> > +	struct mem *m = kzalloc(sizeof(*m), GFP_KERNEL);
> > +	if (!m)
> > +		return NULL;
> > +
> > +	m->pg = alloc_page(GFP_KERNEL | GFP_DMA);
> > +	if (!m->pg) {
> > +		kfree(m);
> > +		return NULL;
> > +	}
> > +
> > +	m->pa = page_to_phys(m->pg);
> > +
> > +	/* flush the cache entry for each page we allocate. */
> > +	dmac_flush_range(page_address(m->pg),
> > +				page_address(m->pg) + PAGE_SIZE);
> > +	outer_flush_range(m->pa, m->pa + PAGE_SIZE);
> 
> NAK.  This is an abuse of these interfaces, and is buggy in any case.
> 
> ARMv6 and ARMv7 CPUs speculatively prefetch memory, which means that
> there's no guarantee that if you flush the caches for a particular
> range of virtual space, that it will stay flushed until you decide
> to read it.  So flushing the caches in some memory allocator can't
> guarantee that when you eventually get around to using the page that
> there won't be cache lines associated with it.
> 
> [dhs] Russell, thanks for reviewing this code.  Do you have any interface
> suggestions that you can share that would make this proper?  Ideally, I
> would like to get physical pages without associated virtual address, or
> ones that are non-cached/non-bufferable.

There is nothing called 'non-bufferable' any more David on ARMv6 and ARMv7. 
You can get non-cached memory using "dma_alloc_coherent"

Regards,
Santosh
