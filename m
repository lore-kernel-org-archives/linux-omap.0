From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 4/6] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Thu, 13 Sep 2012 15:18:57 +0100
Message-ID: <20120913141857.GC20420@e102568-lin.cambridge.arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347531651-28218-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20120913125347.GD2470@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57530 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab2IMOTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 10:19:03 -0400
In-Reply-To: <20120913125347.GD2470@linaro.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 13, 2012 at 01:53:48PM +0100, Dave Martin wrote:
> On Thu, Sep 13, 2012 at 11:20:49AM +0100, Lorenzo Pieralisi wrote:
> > In processors like A15/A7 L2 cache is unified and integrated within the
> > processor cache hierarchy, so that it is not considered an outer cache
> > anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
> > all cache levels up to Level of Coherency (LoC) that includes
> > the L2 unified cache.
> > 
> > When a single CPU is suspended (CPU idle) a complete L2 clean is not
> > required, so generic cpu_suspend code must clean the data cache using the
> > newly introduced cache LoUIS function.
> > 
> > The context and stack pointer (context pointer) are cleaned to main memory
> > using cache area functions that operate on MVA and guarantee that the data
> > is written back to main memory (perform cache cleaning up to the Point of
> > Coherency - PoC) so that the processor can fetch the context when the MMU
> > is off in the cpu_resume code path.
> > 
> > outer_cache management remains unchanged.
> 
> LoUIS matches the power domain affected by turning a single CPU off
> on most (all?) current v7 SoCs where this matters, but only by coincidence.
> There is no guarantee of that.
> 
> The _louis() API is useful, because this is exactly what you need to to
> I-/D-/TLB synchronisation in an SMP OS.  Using it as preparation for
> powering a CPU off feels like misuse, at least in theory.
> 
> For powerdown, we would logically need a separate function,
> flush_cache_cpu() or something, whose job is precisely to flush those
> levels which will be affected by the powerdown if that single CPU.

Yes, you are right, we discussed this at length and I think that
cleaning to LoUIS is a good trade-off for now. Detecting what cache levels are
affected by the power down in question implies linking caches to power
domains in some sensible (and ARM generic) way, let's not go that far for now.

Thanks,
Lorenzo

