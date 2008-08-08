From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Fri, 08 Aug 2008 17:40:06 +0100
Message-ID: <1218213606.12256.74.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
	 <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
	 <20080807073035.GA10255@flint.arm.linux.org.uk>
	 <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
	 <20080807192531.GF5737@flint.arm.linux.org.uk>
	 <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>
	 <20080807212033.GH5737@flint.arm.linux.org.uk>
	 <1218195889.12256.31.camel@pc1117.cambridge.arm.com>
	 <20080808131930.GB8643@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:55129 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758910AbYHHQk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 12:40:29 -0400
In-Reply-To: <20080808131930.GB8643@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Fri, 2008-08-08 at 14:19 +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 08, 2008 at 12:44:49PM +0100, Catalin Marinas wrote:
> > I need to check in ARM when people come from holidays but a simple LDR
> > might not be enough to guarantee that a CPSIE etc. happens after it. You
> > may need to add either an LDR + CMP (or some other usage of the loaded
> > register) or LDR + DSB. I agree that DSB alone is not enough.
> 
> Okay, I give up on this issue.  Weak memory ordering seems to be a
> very very big can of worms.  And then there's this:
> 
> 14:07 < rmk> so we're back to making readl() itself do something with the
>              data... which brings us back to that question about why bother
>              with weak ordering
> 14:10 < willy> you can't have weak ordering for device control registers
> 14:11 < rmk> yes you can, provided they're ordered wrt each other.
> 14:11 < willy> weak ordering works great for SMP or for just covering up latency
> 14:12 < willy> no, you can't.  see writel(); readl(); udelay(1); writel();.
>                You didn't wait for 1 microsecond before accessing the device
>                again.
> 
> Or, to put it another way, it seems that on Linux _all_ devices must
> be strongly ordered or be seen to Linux as being strongly ordered
> (iow, readl and writel and friends _must_ have a barrier.)

Why not put a barrier in udelay? The delay functions are mainly used for
device access.

> TBH, this is becoming soo much of a joke, it's untrue.

For performance in a multi-stage pipeline model, you need weaker
ordering. I'm not a hardware engineer to comment more on this.

> Let's go back to having a strongly ordered memory model.  Please.

On pre-ARMv6, updates to CPSR are guaranteed to take place in program
order with a strongly-ordered memory access. This is still true on
ARMv6/v7 for backward compatibility but the feature is deprecated and it
might not be true for future architecture versions. At some point
barriers might be needed.

-- 
Catalin

