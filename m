From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2
 cache
Date: Mon, 18 Apr 2011 14:42:46 +0300 (EEST)
Message-ID: <20110418.144246.77604458849535045.Hiroshi.DOYU@nokia.com>
References: <20110414223036.GA7335@n2100.arm.linux.org.uk>
	<201104180929.33569.arnd@arndb.de>
	<20110418110502.GI12272@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110418110502.GI12272@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: arnd@arndb.de, linux@arm.linux.org.uk, fernando.lugo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, grgupta@ti.com, h-kanigeri2@ti.com
List-Id: linux-omap@vger.kernel.org

From: ext Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Mon, 18 Apr 2011 14:05:08 +0300

> * Arnd Bergmann <arnd@arndb.de> [110418 10:26]:
>> On Friday 15 April 2011, Russell King - ARM Linux wrote:
>> > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
>> > > From: Ramesh Gupta <grgupta@ti.com>
>> > > 
>> > > This patch is to flush the iommu page table entries from L1 and L2
>> > > caches using dma_map_single. This also simplifies the implementation
>> > > by removing the functions  flush_iopgd_range/flush_iopte_range.
>> > 
>> > No.  This usage is just wrong.  If you're going to use the DMA API then
>> > unmap it, otherwise the DMA API debugging will go awol.
>> 
>> 
>> It's also completely upside-down: The iommu support should provide interfaces
>> using the dma-mapping API, not use that API to provide a machine specific
>> version of the generic interface.
>> 
>> As far as I can tell, nothing actually uses these drivers, maybe we should just
>> remove them before we get any code in the mainline kernel that depends on it.
> 
> There is drivers/media/video/omap3isp/isp.c. But if we now

Yes, and "dspbridge" has introduced this too, IIRC.

> have a generic replacement for this code we should start using it.

I'm afraid that there's no general IOMMU APIs yet, or already? If
there is, migrating to those general IOMMU API is the way, but still
SoC dependent parts remain, anyway. I guess that more or less general
IOMMU API is composed of common set of client APIs(like IOVMM) and the
registration of H/W dependent functions(like omap iommu), I guess.

> Hiroshi, any comments on that?

This patch is not about (1)general buffer handling between CPU cores
but just about (2)page table entry coherency. (2) is quite same to
what ARM does for its pagetable in cpu_*_set_pte_ext. I think that
using dma api to make pte entry coherent may make sense for general
solution, as Russell suggested.

For (1), I agree that IOVMM layer should be refactored by introducing
dma-mapping API in any case. Any patches are appreciated.
