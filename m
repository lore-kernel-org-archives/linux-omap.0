From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Fri, 8 Aug 2008 14:19:30 +0100
Message-ID: <20080808131930.GB8643@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com> <1218016428.25235.11.camel@pc1117.cambridge.arm.com> <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com> <20080807073035.GA10255@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com> <20080807192531.GF5737@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com> <20080807212033.GH5737@flint.arm.linux.org.uk> <1218195889.12256.31.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40163 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYHHNUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 09:20:12 -0400
Content-Disposition: inline
In-Reply-To: <1218195889.12256.31.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Fri, Aug 08, 2008 at 12:44:49PM +0100, Catalin Marinas wrote:
> There are already CPUs with weaker memory ordering model than ARM (e.g.
> Alpha) and they are supported by Linux. Of course, there may be problems
> with drivers since most of them are developed in x86.

There are, and they are _constantly_ complaining about drivers not
having the necessary barriers.

Consider that for a moment - how long has Linux supported had weakly
ordered architectures, and how long does it take to fix ordering
problems... 10 or so years?

> > So, in the case of arch/arm/common/gic.c, we should be reading one of
> > the gic control registers after the writes.  In the case of
> > arch/arm/mach-omap2/irq.c, reading the INTC_REVISION reg after masking
> > should be a sufficient solution.
> 
> I need to check in ARM when people come from holidays but a simple LDR
> might not be enough to guarantee that a CPSIE etc. happens after it. You
> may need to add either an LDR + CMP (or some other usage of the loaded
> register) or LDR + DSB. I agree that DSB alone is not enough.

Okay, I give up on this issue.  Weak memory ordering seems to be a
very very big can of worms.  And then there's this:

14:07 < rmk> so we're back to making readl() itself do something with the
             data... which brings us back to that question about why bother
             with weak ordering
14:10 < willy> you can't have weak ordering for device control registers
14:11 < rmk> yes you can, provided they're ordered wrt each other.
14:11 < willy> weak ordering works great for SMP or for just covering up latency
14:12 < willy> no, you can't.  see writel(); readl(); udelay(1); writel();.
               You didn't wait for 1 microsecond before accessing the device
               again.

Or, to put it another way, it seems that on Linux _all_ devices must
be strongly ordered or be seen to Linux as being strongly ordered
(iow, readl and writel and friends _must_ have a barrier.)

And of course, putting barriers into readl and writel, we might as well
use strongly ordered mappings anyway, because that'll save us a few
bytes of program memory.

TBH, this is becoming soo much of a joke, it's untrue.

Let's go back to having a strongly ordered memory model.  Please.
