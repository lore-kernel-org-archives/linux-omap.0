From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 4/8] TILER-DMM: TILER Memory Manager interface and
	implementation
Date: Sat, 24 Jul 2010 09:01:18 +0100
Message-ID: <20100724080118.GB15064@n2100.arm.linux.org.uk>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com> <1279927348-21750-2-git-send-email-davidsin@ti.com> <1279927348-21750-3-git-send-email-davidsin@ti.com> <1279927348-21750-4-git-send-email-davidsin@ti.com> <1279927348-21750-5-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54463 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab0GXIB3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 04:01:29 -0400
Content-Disposition: inline
In-Reply-To: <1279927348-21750-5-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lajos Molnar <molnar@ti.com>

On Fri, Jul 23, 2010 at 06:22:24PM -0500, David Sin wrote:
> +/* allocate and flush a page */
> +static struct mem *alloc_mem(void)
> +{
> +	struct mem *m = kzalloc(sizeof(*m), GFP_KERNEL);
> +	if (!m)
> +		return NULL;
> +
> +	m->pg = alloc_page(GFP_KERNEL | GFP_DMA);
> +	if (!m->pg) {
> +		kfree(m);
> +		return NULL;
> +	}
> +
> +	m->pa = page_to_phys(m->pg);
> +
> +	/* flush the cache entry for each page we allocate. */
> +	dmac_flush_range(page_address(m->pg),
> +				page_address(m->pg) + PAGE_SIZE);
> +	outer_flush_range(m->pa, m->pa + PAGE_SIZE);

NAK.  This is an abuse of these interfaces, and is buggy in any case.

ARMv6 and ARMv7 CPUs speculatively prefetch memory, which means that
there's no guarantee that if you flush the caches for a particular
range of virtual space, that it will stay flushed until you decide
to read it.  So flushing the caches in some memory allocator can't
guarantee that when you eventually get around to using the page that
there won't be cache lines associated with it.
