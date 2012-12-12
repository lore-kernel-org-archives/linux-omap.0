From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Wed, 12 Dec 2012 13:36:50 +0000
Message-ID: <20121212133650.GJ6195@mudshark.cambridge.arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919134658.GA2111@linaro.org>
 <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
 <20120920110439.GB2117@linaro.org>
 <Pine.LNX.4.64.1212111655050.29758@axis700.grange>
 <20121211163313.GG16759@mudshark.cambridge.arm.com>
 <20121211163843.GH16759@mudshark.cambridge.arm.com>
 <50C7C16B.7050106@codeaurora.org>
 <20121212103338.GB23022@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121212103338.GB23022@e102568-lin.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 12, 2012 at 10:33:38AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 11, 2012 at 11:27:39PM +0000, Stephen Boyd wrote:
> > On 12/11/12 08:38, Will Deacon wrote:
> > > diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> > > index cd95664..f58248f 100644
> > > --- a/arch/arm/mm/cache-v7.S
> > > +++ b/arch/arm/mm/cache-v7.S
> > > @@ -44,7 +44,8 @@ ENDPROC(v7_flush_icache_all)
> > >  ENTRY(v7_flush_dcache_louis)
> > >         dmb                                     @ ensure ordering with previous memory accesses
> > >         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
> > > -       ands    r3, r0, #0xe00000               @ extract LoUIS from clidr
> > > +       ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
> > > +       ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
> > >         mov     r3, r3, lsr #20                 @ r3 = LoUIS * 2
> > 
> > You need to fix this mov as well, right?
> 
> And after doing that I think the suspend finisher will still have
> to call flush_cache_all() since LoUU == 1 on A8, L2 is not cleaned
> and that's probably what we want if it can be retained.

At some point we probably want to describe the level of flushing required in
the device tree as a property of the CPU node (or something similar). That
would allow us to have *one* function for flushing,
e.g. cpu_suspend_flush_cache which flushes to the appropriate level. Then
we could remove the louis flush from the CPU suspend code and instead make
it the finisher's responsibility to call our flushing function when it's
done, which helps to avoid over/under-flushing the cache.

In the meantime, fixing louis as we've suggested should work.

Back to the case in hand.... Lorenzo just pointed out to me that the
finished in question (sh7372_do_idle_sysc) calls v7_flush_dcache_all, so
the louis stuff should be irrelevant. The problem may actually be that the
finisher disables the L2 cache prior to cleaning/invalidating it, which is
the opposite order to that described by the A8 TRM.

Guennadi -- can you try moving the kernel_flush call before the L2 disable
in sh7372_do_idle_sysc please?

Will
