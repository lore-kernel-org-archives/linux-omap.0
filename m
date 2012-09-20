From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 0/5] ARM: augment cache flushing API
Date: Thu, 20 Sep 2012 12:27:55 +0100
Message-ID: <20120920112755.GF4588@e102568-lin.cambridge.arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45847 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab2ITL2F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 07:28:05 -0400
In-Reply-To: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>, kgene.kim@samsung.com, shawn.guo@linaro.org, magnus.damm@gmail.com, rob.herring@calxeda.com

[adding CCs: Kukjin Kim, Shawn Guo, Magnus Damm, Rob Herring]

Pushed out a branch containing the set @

git://linux-arm.org/linux-2.6-lp.git cache-louis

for testing purposes.

Thanks a lot,
Lorenzo

On Tue, Sep 18, 2012 at 05:35:30PM +0100, Lorenzo Pieralisi wrote:
> This patch series provides an update of a previous posting:
> 
> http://www.spinics.net/lists/arm-kernel/msg194946.html
> 
> v2 updates:
>  - Dropped v7 dcache level patch
>  - Refactor the set to make it work on all processors with MULTI_CACHE
>    and !MULTI_CACHE
>  - Factor out label redefinition in v7_flush_dcache_all
>  - Updated some comments
> 
> v7 ARM architecture introduced the concept of cache levels and relative
> control registers to manage them. Cache operations that operate on set/way
> require to define the cache level at which maintenance operations are carried
> out by using coprocessor registers.
> 
> Processors like A7/A15 integrates a unified L2 that is part of the cache
> level hierarchy; this implies that cache operations operating on all levels
> also end up cleaning the L2 unified cache which is a very time consuming
> operation and it is not needed for some power-down operations like single CPU
> shutdown.
> 
> For v7, flush_kern_all() cleans all the cache levels up to the Level of
> Coherency which includes L2 in it. This is suboptimal for code paths that end
> up shutting-down a single processor like CPU hotplug and CPU idle, where only
> per-CPU cache state (ie L1 integrated cache) has to be cleaned and invalidated.
> 
> To fix this performance issue this patchset introduces cache LoUIS (Level of
> Unification Inner Shareable) maintenance operations in the kernel.
> 
> A new cache operations pointer is added to cpu_cache_fns
> 
> void (*flush_kern_cache_louis)(void);
> 
> that allows to clean and invalidate all data cache levels up to the LoUIS and
> invalidate the instruction cache. This new API should provide a sufficiently
> optimized API to be used in generic C code in the kernel for power management
> operations on most v7 systems.
> 
> For architecture versions previous to v7, flush_kern_cache_louis() falls back
> to flush_kern_all() leaving the current behaviour unchanged.
> 
> For A9/A5 processors Level of Unification Inner Shareable and Level of
> Coherency are equivalent hence this patch should not affect current kernel
> behaviour in any way when run on A9/A5 based systems, but should nonetheless
> be thoroughly tested on them.
> 
> Tested on:
>   - OMAP4 (S2R, cpuidle and hotplug)
>   - OMAP5 (out of tree code) (S2R, cpuidle and hotplug)
>   - TC2 big.LITTLE testchip (out of tree code) (cpuidle, on both A7 and A15
>     clusters)
> 
> Lorenzo Pieralisi (4):
>   ARM: mm: implement LoUIS API for cache maintenance ops
>   ARM: mm: rename jump labels in v7_flush_dcache_all function
>   ARM: kernel: update cpu_suspend code to use cache LoUIS operations
>   ARM: kernel: update __cpu_disable to use cache LoUIS maintenance API
> 
> Santosh Shilimkar (1):
>   ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API
> 
>  arch/arm/include/asm/cacheflush.h | 15 ++++++++++++
>  arch/arm/include/asm/glue-cache.h |  1 +
>  arch/arm/kernel/smp.c             |  5 +++-
>  arch/arm/kernel/suspend.c         | 17 +++++++++++++-
>  arch/arm/mm/cache-fa.S            |  3 +++
>  arch/arm/mm/cache-v3.S            |  3 +++
>  arch/arm/mm/cache-v4.S            |  3 +++
>  arch/arm/mm/cache-v4wb.S          |  3 +++
>  arch/arm/mm/cache-v4wt.S          |  3 +++
>  arch/arm/mm/cache-v6.S            |  3 +++
>  arch/arm/mm/cache-v7.S            | 48 ++++++++++++++++++++++++++++++++++-----
>  arch/arm/mm/proc-arm1020.S        |  3 +++
>  arch/arm/mm/proc-arm1020e.S       |  3 +++
>  arch/arm/mm/proc-arm1022.S        |  3 +++
>  arch/arm/mm/proc-arm1026.S        |  3 +++
>  arch/arm/mm/proc-arm920.S         |  3 +++
>  arch/arm/mm/proc-arm922.S         |  3 +++
>  arch/arm/mm/proc-arm925.S         |  3 +++
>  arch/arm/mm/proc-arm926.S         |  3 +++
>  arch/arm/mm/proc-arm940.S         |  3 +++
>  arch/arm/mm/proc-arm946.S         |  3 +++
>  arch/arm/mm/proc-feroceon.S       |  3 +++
>  arch/arm/mm/proc-macros.S         |  1 +
>  arch/arm/mm/proc-mohawk.S         |  3 +++
>  arch/arm/mm/proc-v7.S             |  2 +-
>  arch/arm/mm/proc-xsc3.S           |  3 +++
>  arch/arm/mm/proc-xscale.S         |  3 +++
>  27 files changed, 140 insertions(+), 9 deletions(-)
> 
> -- 
> 1.7.12
> 

