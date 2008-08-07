From: Catalin Marinas <catalin.marinas@arm.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 07 Aug 2008 17:55:26 +0100
Message-ID: <1218128126.7718.50.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <20080805114920.GC27299@trinity.fluff.org>
	 <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>
	 <1218018018.25235.23.camel@pc1117.cambridge.arm.com>
	 <13B9B4C6EF24D648824FF11BE89671620361F4E50C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:61460 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861AbYHGQ4R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 12:56:17 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361F4E50C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

> On Wed, 2008-08-06 at 07:28 -0500, Woodruff, Richard wrote:
> > > The code need to execute in a non-cached region.
> >
> > I don't think there is any guarantee that dirty cache line won't be
> > evicted to SDRAM even if your code uses uncached memory only. The CPU
> > is
> > allowed to do speculative reads from the normal cached memory and
> > these
> > reads may force a dirty cache line to be written back to memory. You
> > may
> > need to do at least a cache clean operation (invalidate not necessary).
> 
> I hope that is not necessary.

Probably not but need to check internally as well.

> As I indicated the code in question is small assembly dealing with
> hardware registers for clock and power.
> 
> This code at one point did make sure use barriers at entry which
> hopefully stop the ARM from being smart.  Also things like speculative
> access at the AXI were turned off.

You would need a DSB at the beginning to drain the write buffer (among
other things)

> And perhaps you even make my point in 'The CPU is allowed to do
> speculative reads from normal-cached-memory'.
>         !! I don't want some speculative branch prediction to fetch
> from who knows where when I've temporally shut off the memory
> controller !!

If you have a DMB at the end of your code, this ensures that all memory
accesses after the DMB (i.e. accesses to the SDRAM) are visible after
accesses before the barrier (i.e. the enabling of the SDRAM controller).

-- 
Catalin

