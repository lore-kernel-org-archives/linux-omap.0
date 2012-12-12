From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Wed, 12 Dec 2012 10:33:38 +0000
Message-ID: <20121212103338.GB23022@e102568-lin.cambridge.arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919134658.GA2111@linaro.org>
 <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
 <20120920110439.GB2117@linaro.org>
 <Pine.LNX.4.64.1212111655050.29758@axis700.grange>
 <20121211163313.GG16759@mudshark.cambridge.arm.com>
 <20121211163843.GH16759@mudshark.cambridge.arm.com>
 <50C7C16B.7050106@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <50C7C16B.7050106@codeaurora.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 11, 2012 at 11:27:39PM +0000, Stephen Boyd wrote:
> On 12/11/12 08:38, Will Deacon wrote:
> > diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
> > index cd95664..f58248f 100644
> > --- a/arch/arm/mm/cache-v7.S
> > +++ b/arch/arm/mm/cache-v7.S
> > @@ -44,7 +44,8 @@ ENDPROC(v7_flush_icache_all)
> >  ENTRY(v7_flush_dcache_louis)
> >         dmb                                     @ ensure ordering with previous memory accesses
> >         mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
> > -       ands    r3, r0, #0xe00000               @ extract LoUIS from clidr
> > +       ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
> > +       ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
> >         mov     r3, r3, lsr #20                 @ r3 = LoUIS * 2
> 
> You need to fix this mov as well, right?

And after doing that I think the suspend finisher will still have
to call flush_cache_all() since LoUU == 1 on A8, L2 is not cleaned
and that's probably what we want if it can be retained.

What about this (compile tested) ?

Lorenzo

--->8

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index cd95664..036f80f 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -44,8 +44,9 @@ ENDPROC(v7_flush_icache_all)
 ENTRY(v7_flush_dcache_louis)
 	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
-	ands	r3, r0, #0xe00000		@ extract LoUIS from clidr
-	mov	r3, r3, lsr #20			@ r3 = LoUIS * 2
+	ALT_SMP(lsr	r3, r0, #20)		@ r3 = clidr[31:20]
+	ALT_UP(lsr	r3, r0, #26)		@ r3 = clidr[31:26]
+	ands	r3, r3, #0xe			@ r3 = LoUIS/LoUU * 2
 	moveq	pc, lr				@ return if level == 0
 	mov	r10, #0				@ r10 (starting level) = 0
 	b	flush_levels			@ start flushing cache levels

