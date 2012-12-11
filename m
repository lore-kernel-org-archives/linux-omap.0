From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2 3/5] ARM: kernel: update cpu_suspend code to use
 cache LoUIS operations
Date: Tue, 11 Dec 2012 16:38:43 +0000
Message-ID: <20121211163843.GH16759@mudshark.cambridge.arm.com>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919134658.GA2111@linaro.org>
 <20120920102514.GD4588@e102568-lin.cambridge.arm.com>
 <20120920110439.GB2117@linaro.org>
 <Pine.LNX.4.64.1212111655050.29758@axis700.grange>
 <20121211163313.GG16759@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121211163313.GG16759@mudshark.cambridge.arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Simon Horman <horms@verge.net.au>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Wenzeng Chen <wzch@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 11, 2012 at 04:33:13PM +0000, Will Deacon wrote:
> On Tue, Dec 11, 2012 at 04:07:56PM +0000, Guennadi Liakhovetski wrote:
> > Git bisect identified this patch, in the mainline as
> > 
> > commit dbee0c6fb4c1269b2dfc8b0b7a29907ea7fed560
> > Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Date:   Fri Sep 7 11:06:57 2012 +0530
> > 
> >     ARM: kernel: update cpu_suspend code to use cache LoUIS operations
> > 
> > as the culprit of the broken wake up from STR on mackerel, based on an 
> > sh7372 A8 SoC. .config attached.
> 
> My guess is that because Cortex-A8 does not implement the MP extensions,
> the LoUIS field of the CLIDR reads as zero, and the cache isn't flushed at
> all (I can see an early exit in v7_flush_dcache_louis).
> 
> Lorenzo -- how is this supposed to work for uniprocessor CPUs?

Bah, forgot to ask you if the following patch helps...

Will

--->8

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index cd95664..f58248f 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -44,7 +44,8 @@ ENDPROC(v7_flush_icache_all)
 ENTRY(v7_flush_dcache_louis)
        dmb                                     @ ensure ordering with previous memory accesses
        mrc     p15, 1, r0, c0, c0, 1           @ read clidr, r0 = clidr
-       ands    r3, r0, #0xe00000               @ extract LoUIS from clidr
+       ALT_SMP(ands    r3, r0, #(7 << 21))     @ extract LoUIS from clidr
+       ALT_UP(ands     r3, r0, #(7 << 27))     @ extract LoUU from clidr
        mov     r3, r3, lsr #20                 @ r3 = LoUIS * 2
        moveq   pc, lr                          @ return if level == 0
        mov     r10, #0                         @ r10 (starting level) = 0

