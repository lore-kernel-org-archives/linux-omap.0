From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and
	CPU_V7
Date: Fri, 19 Feb 2010 19:25:17 +0000
Message-ID: <20100219192517.GA8515@n2100.arm.linux.org.uk>
References: <20100219002748.GB21755@atomide.com> <20100219083556.GB19649@n2100.arm.linux.org.uk> <20100219180331.GC21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46582 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab0BSTZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 14:25:27 -0500
Content-Disposition: inline
In-Reply-To: <20100219180331.GC21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 19, 2010 at 10:03:32AM -0800, Tony Lindgren wrote:
> If so, then what have in arch/arm/plat-omap/iommu.c seems buggy:
> 
> static void flush_iopgd_range(u32 *first, u32 *last)
> {
> 	/* FIXME: L2 cache should be taken care of if it exists */
> 	do {
> 		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
> 		    : : "r" (first));
> 		first += L1_CACHE_BYTES / sizeof(*first);
> 	} while (first <= last);
> }
> 
> It seems that this code should use the real cache line size instead to
> avoid every other line not to flush if ARM_L1_CACHE_SHIFT is set larger
> than it is.

Yes.
