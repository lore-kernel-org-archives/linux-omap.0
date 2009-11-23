From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address
 instead of user's
Date: Mon, 23 Nov 2009 09:30:40 +0200 (EET)
Message-ID: <20091123.093040.226795873.Hiroshi.DOYU@nokia.com>
References: <20091113.121212.189727725.Hiroshi.DOYU@nokia.com>
	<20091117.084108.193702761.Hiroshi.DOYU@nokia.com>
	<20091121191724.GA29167@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59993 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbZKWHav (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 02:30:51 -0500
In-Reply-To: <20091121191724.GA29167@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, omar.ramirez@ti.com, ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, nm@ti.com, Miguel.Verdu@nokia.com, bshah@ti.com, imre.deak@nokia.com

Hi Russell,

From: ext Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
Date: Sat, 21 Nov 2009 20:17:25 +0100

> On Tue, Nov 17, 2009 at 08:41:08AM +0200, Hiroshi DOYU wrote:
> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
> > Date: Fri, 13 Nov 2009 12:12:12 +0200 (EET)
> > 
> > > From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
> > > Subject: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
> > > Date: Fri, 6 Nov 2009 13:34:21 +0100
> > > 
> > > > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > > > 
> > > > Based on the discussion:
> > > >   http://www.spinics.net/lists/arm-kernel/msg72810.html
> > > > 
> > > > HACK: export "follow_page()" for dspbridge cache operation
> > > > 
> > > > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > > > ---
> > 
> > Now there's no need for homebrewed cache function because we use
> > kernel address and can pass "virt_addr_valid()" check in
> > "dma_cache_maint()".
> 
> Note that with the advent of ARMv7/Cortex A9, dma_cache_maint() is going
> away - and probably will be gone during the next merge window.  There is
> no directly equivalent replacement for it - it is being replaced by two
> sets of functions, one to be called prior to DMA and another to be called
> after DMA has completed.
> 
> In the longer run, it is likely that the 'dmac_*_range' and 'outer_*_range'
> will probably also be going away, to be replaced by two new per-cpu methods
> along the lines of the above.
> 
> I think this may throw a spanner in the works for this patch, but it's
> necessary to make Cortex A9 work.

Thank you for updating the status of cache operations.

I don't think that none of my patch in this thread can be a generic
solution at all, but they are just a hack for VIPT non-aliasing until
a generic solution comes. We need to fix some kernel crash at
v7_dma_*_range() just right now. Anyway, I am looking forward to your
new DMA APIs.
