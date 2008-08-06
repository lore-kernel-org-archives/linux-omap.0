From: Catalin Marinas <catalin.marinas@arm.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Wed, 06 Aug 2008 11:20:18 +0100
Message-ID: <1218018018.25235.23.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <20080805114920.GC27299@trinity.fluff.org>
	 <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:39476 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753131AbYHFKVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 06:21:11 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Tue, 2008-08-05 at 07:15 -0500, Woodruff, Richard wrote:
> > Is the controller allowed to write dirty cache lines out at any time
> > it
> > likes? Surely a better fix is to drain the cache of the changes before
> > changing the clock for the SDRAM?
> 
> - Previously the SRAM was marked as cached.  _Execution_ using that
> attribute will generate line fetches to SRAM.  This will cause
> displacement write-outs of resident DDR lines.  Similarly,
> _load/store_ sequences in that code have the same effect.  This cast
> outs dead lock the CPU and it can't fetch to progress.
[...]
> * Flushing the entire L1 & L2 cache frequently is very expensive and
> better not done if you don't have.  Also, it is not sufficient for the
> context-restore path which needs to NOT live in DDR.
> 
> The code need to execute in a non-cached region.

I don't think there is any guarantee that dirty cache line won't be
evicted to SDRAM even if your code uses uncached memory only. The CPU is
allowed to do speculative reads from the normal cached memory and these
reads may force a dirty cache line to be written back to memory. You may
need to do at least a cache clean operation (invalidate not necessary).

-- 
Catalin

