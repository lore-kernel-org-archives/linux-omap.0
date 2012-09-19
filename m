From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 1/5] ARM: mm: implement LoUIS API for cache
 maintenance ops
Date: Wed, 19 Sep 2012 13:30:13 +0100
Message-ID: <20120919123002.GA11497@e102568-lin.cambridge.arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.02.1209181411530.28681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45643 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab2ISMaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:30:20 -0400
In-Reply-To: <alpine.LFD.2.02.1209181411530.28681@xanadu.home>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Tue, Sep 18, 2012 at 07:12:52PM +0100, Nicolas Pitre wrote:
> On Tue, 18 Sep 2012, Lorenzo Pieralisi wrote:
> 
> > ARM v7 architecture introduced the concept of cache levels and related
> > control registers. New processors like A7 and A15 embed an L2 unified cache
> > controller that becomes part of the cache level hierarchy. Some operations in
> > the kernel like cpu_suspend and __cpu_disable do not require a flush of the
> > entire cache hierarchy to DRAM but just the cache levels belonging to the
> > Level of Unification Inner Shareable (LoUIS), which in most of ARM v7 systems
> > correspond to L1.
> >
> > The current cache flushing API used in cpu_suspend and __cpu_disable,
> > flush_cache_all(), ends up flushing the whole cache hierarchy since for
> > v7 it cleans and invalidates all cache levels up to Level of Coherency
> > (LoC) which cripples system performance when used in hot paths like hotplug
> > and cpuidle.
> >
> > Therefore a new kernel cache maintenance API must be added to cope with
> > latest ARM system requirements.
> >
> > This patch adds flush_cache_louis() to the ARM kernel cache maintenance API.
> >
> > This function cleans and invalidates all data cache levels up to the
> > Level of Unification Inner Shareable (LoUIS) and invalidates the instruction
> > cache for processors that support it (> v7).
> >
> > This patch also creates an alias of the cache LoUIS function to flush_kern_all
> > for all processor versions prior to v7, so that the current cache flushing
> > behaviour is unchanged for those processors.
> >
> > v7 cache maintenance code implements a cache LoUIS function that cleans and
> > invalidates the D-cache up to LoUIS and invalidates the I-cache, according
> > to the new API.
> >
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Thanks a lot for reviewing the series.

Lorenzo

