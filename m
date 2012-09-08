From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 2/2] OMAP:IOMMU:flush L1 and L2 caches
Date: Sat, 8 Sep 2012 11:17:24 +0100
Message-ID: <20120908101724.GB28448@n2100.arm.linux.org.uk>
References: <CADysL2YwpyuhgzwF6djObZQTpgdHCsLp=K7NsCJth6wAXuFV=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56389 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab2IHKRf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Sep 2012 06:17:35 -0400
Content-Disposition: inline
In-Reply-To: <CADysL2YwpyuhgzwF6djObZQTpgdHCsLp=K7NsCJth6wAXuFV=A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Jul 05, 2012 at 10:50:24AM +0530, Gupta, Ramesh wrote:
>  static void flush_iopgd_range(u32 *first, u32 *last)
>  {
> -	/* FIXME: L2 cache should be taken care of if it exists */
> -	do {
> -		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
> -		    : : "r" (first));
> -		first += L1_CACHE_BYTES / sizeof(*first);
> -	} while (first <= last);
> +	flush_iommu_mem(first, last);
> +	outer_flush_range(virt_to_phys(first), virt_to_phys(last));

I think this would be safer if these operated on an area rather than a
range - which means taking a start plus size.

	phys_addr_t phys = virt_to_phys(start);

	iommu_flush_area(start, size);
	outer_flush_range(phys, phys + size);

is safer than the above if virt_to_phys() is non-linear.

>  		*iopgd = virt_to_phys(iopte) | IOPGD_TABLE;
> -		flush_iopgd_range(iopgd, iopgd);
> +		flush_iopgd_range(iopgd, iopgd + 1);

And operating on a start + size also makes this kind of stuff clearer.
