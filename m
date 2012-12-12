From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Wed, 12 Dec 2012 17:43:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212121743240.10522@axis700.grange>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919134658.GA2111@linaro.org> <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
 <20120920110439.GB2117@linaro.org> <Pine.LNX.4.64.1212111655050.29758@axis700.grange>
 <20121211163313.GG16759@mudshark.cambridge.arm.com>
 <20121211163843.GH16759@mudshark.cambridge.arm.com> <50C7C16B.7050106@codeaurora.org>
 <20121212103119.GA6195@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20121212103119.GA6195@mudshark.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Will

On Wed, 12 Dec 2012, Will Deacon wrote:

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
> Ha, nice catch. So the original patch ended up with a ridiculously high
> level number and would've flushed L2, hence we will need to retest with the
> fix below...

Had to apply manually, but it worked too.

Thanks
Guennadi

> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> index cd95664..7539ec2 100644
> --- a/arch/arm/mm/cache-v7.S
> +++ b/arch/arm/mm/cache-v7.S
> @@ -44,8 +44,10 @@ ENDPROC(v7_flush_icache_all)
>  ENTRY(v7_flush_dcache_louis)
>         dmb                                     @ ensure ordering with previous memory accesses
>         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
> -       ands    r3, r0, #0xe00000               @ extract LoUIS from clidr
> -       mov     r3, r3, lsr #20                 @ r3 = LoUIS * 2
> +       ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
> +       ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
> +       ALT_SMP(mov     r3, r3, lsr #20)        @ r3 = LoUIS * 2
> +       ALT_UP(mov      r3, r3, lsr #26)        @ r3 = LoUU * 2
>         moveq   pc, lr                          @ return if level == 0
>         mov     r10, #0                         @ r10 (starting level) = 0
>         b       flush_levels                    @ start flushing cache levels
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
