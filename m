From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: PMU: fix runtime PM enable
Date: Wed, 24 Oct 2012 18:23:25 +0100
Message-ID: <20121024172325.GK7339@mudshark.cambridge.arm.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com>
 <20121024093150.GA23775@mudshark.cambridge.arm.com>
 <5087F84B.9070705@ti.com>
 <20121024143204.GF7339@mudshark.cambridge.arm.com>
 <508803DF.7020902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54348 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932816Ab2JXRXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 13:23:37 -0400
Content-Disposition: inline
In-Reply-To: <508803DF.7020902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 24, 2012 at 04:06:07PM +0100, Jon Hunter wrote:
> On 10/24/2012 09:32 AM, Will Deacon wrote:
> > Hmmm, now I start to wonder whether your original idea of having separate
> > callbacks for enable/disable irq and resume/suspend doesn't make more sense.
> > Then the CTI magic can go in the irq management code and be totally separate
> > to the PM stuff.
> > 
> > What do you reckon?
> 
> The resume/suspend calls really replaced the enable/disable irq
> callbacks. That still seems like a good approach given that we need
> runtime PM for OMAP and PMU.

Ok, perhaps splitting it up isn't worth it then. I'm still not convinced
either way.

> > Nah, we should be able to fix this in the platdata, I'd just rather have
> > function pointers instead of state variables in there.
> 
> Well, we could pass a pointer to pm_runtime_enable() function in the
> platdata.

What do other drivers do? Grepping around, I see calls to pm_runtime_enable
made in various drivers and, given that you pass the device in there, what's
the problem with us just calling that unconditionally from perf? I know you
said that will work for OMAP, but I'm trying to understand the effect that
has on PM-aware platforms that don't require this for the PMU (since this
seems to be per-device).

Will
