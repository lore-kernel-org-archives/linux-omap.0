From: "Sin, David" <davidsin@ti.com>
Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
 implementation
Date: Mon, 2 Aug 2010 09:55:26 -0500
Message-ID: <513FF747EED39B4AADBB4D6C9D9F9F7903D654A44A@dlee02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <1279927348-21750-3-git-send-email-davidsin@ti.com>
 <1279927348-21750-4-git-send-email-davidsin@ti.com>
 <1279927348-21750-5-git-send-email-davidsin@ti.com>
 <20100724080118.GB15064@n2100.arm.linux.org.uk>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D654A3FE@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C641D580@dbde02.ent.ti.com>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D654A430@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C641D58B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34775 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab0HBOzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 10:55:36 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C641D58B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Molnar, Lajos" <molnar@ti.com>, "Voultoury, Pierre" <p-voultoury@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

-----Original Message-----
From: Shilimkar, Santosh 
Sent: Monday, August 02, 2010 9:53 AM
To: Sin, David; Russell King - ARM Linux; Woodruff, Richard
Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav; Molnar, Lajos; Voultoury, Pierre; linux-arm-kernel@lists.infradead.org
Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and implementation



> -----Original Message-----
> From: Sin, David
> Sent: Monday, August 02, 2010 8:20 PM
> To: Shilimkar, Santosh; Russell King - ARM Linux; Woodruff, Richard
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-
> Cohen; Hiremath, Vaibhav; Molnar, Lajos; Voultoury, Pierre; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Monday, August 02, 2010 9:45 AM
> To: Sin, David; Russell King - ARM Linux; Woodruff, Richard
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Kanigeri, Hari; Ohad Ben-
> Cohen; Hiremath, Vaibhav; Molnar, Lajos; Voultoury, Pierre; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
> implementation
> 
< snip>

> > > +	m->pa = page_to_phys(m->pg);
> > > +
> > > +	/* flush the cache entry for each page we allocate. */
> > > +	dmac_flush_range(page_address(m->pg),
> > > +				page_address(m->pg) + PAGE_SIZE);
> > > +	outer_flush_range(m->pa, m->pa + PAGE_SIZE);
> >
> > NAK.  This is an abuse of these interfaces, and is buggy in any case.
> >
> > ARMv6 and ARMv7 CPUs speculatively prefetch memory, which means that
> > there's no guarantee that if you flush the caches for a particular
> > range of virtual space, that it will stay flushed until you decide
> > to read it.  So flushing the caches in some memory allocator can't
> > guarantee that when you eventually get around to using the page that
> > there won't be cache lines associated with it.
> >
> > [dhs] Russell, thanks for reviewing this code.  Do you have any
> interface
> > suggestions that you can share that would make this proper?  Ideally, I
> > would like to get physical pages without associated virtual address, or
> > ones that are non-cached/non-bufferable.
> 
> There is nothing called 'non-bufferable' any more David on ARMv6 and
> ARMv7.
> You can get non-cached memory using "dma_alloc_coherent"
> 
> [dhs] Thanks, Santosh, for the clarification.  I believe
> dma_alloc_coherent is quite limited, right?  We need to be able to cover
> potentially 128MB of physical memory for the TILER.  BTW, does GFP_DMA
> indicate that I don't want cached memory?
> 
It's configurable. By default it's 2 MB pool. GFP_DMA doesn't give you
un-cacheable memory.

[dhs] OK -- I will increase this and try to allocate this way.  Thank you.

