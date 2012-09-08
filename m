From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 1/2] ARM: new cache maintenance api for iommu
Date: Sat, 8 Sep 2012 11:14:20 +0100
Message-ID: <20120908101420.GA28448@n2100.arm.linux.org.uk>
References: <CADysL2bGP_FKW4dnxM4zbziOPfrbAemRazZYd_mS9i++bZGcqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56383 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab2IHKOf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Sep 2012 06:14:35 -0400
Content-Disposition: inline
In-Reply-To: <CADysL2bGP_FKW4dnxM4zbziOPfrbAemRazZYd_mS9i++bZGcqQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Jul 05, 2012 at 10:50:17AM +0530, Gupta, Ramesh wrote:
> + *	flush_iommu_mem(start, end)
> + *
> + *		Clean and invalidate the specified virtual address range.
> + *		This is	to support the non coherent iommu drivers.
> + *		The iommu driver need to call this api with the page
> + *		table memory address range to ensure the data held in
> + *		the cache is visible to the slave processor MMU.
> + *		- start  - virtual start address
> + *		- end    - virtual end address

I think:
	iommu_flush_range(start, end)
or
	iommu_flush_area(start, size)
		Perform CPU specific cache operations are required to
		ensure that the IOMMU page table mappings covering the
		specified block of memory are visiable to the IOMMU.

Notice that it's defined by purpose, not by implementation.  Also notice
the distinction between _range taking two addresses, and _area taking
a start plus size.

Also notice that it is defined just for IOMMU page tables, not for general
data for other processors.

Note that iommu_flush_area is safer if your virt_to_phys() are non-linear.
