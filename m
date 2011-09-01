From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Date: Thu, 1 Sep 2011 23:33:43 +0800
Message-ID: <20110901153342.GB5147@S2100-06.ap.freescale.net>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:14691 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab1IAPY5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 11:24:57 -0400
Content-Disposition: inline
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Thu, Sep 01, 2011 at 01:47:52PM +0100, Russell King - ARM Linux wrote:
> Some systems (such as OMAP) preserve the L2 cache across a suspend/
> resume cycle.  This means they do not perform L2 cache maintanence
> in their suspend finisher function.
> 
> However, the side effect is that the saved CPU state is not readable
> by the resume code because it is sitting in the L2 cache.
> 
> This patch series adds L2 cache cleaning to the generic CPU suspend/
> resume support code, making it possible to use this on systems with
> L2 cache enabled without having to clean/invalidate the entire L2
> cache.
> 
This is also the case on i.MX6Q, which L2 cache is retained during a
suspend/resume cycle.  Currently, I have to call into the following
before calling generic cpu_suspend() to clean/invalidate the entire
L2 cache.

	outer_flush_all();
	outer_disable();

But there is a wired thing on using generic cpu_resume().  I have to
invalidate L1 before calling into cpu_resume() like below.

ENTRY(imx6q_cpu_resume)
        bl      v7_invalidate_l1
        b       cpu_resume
ENDPROC(imx6q_cpu_resume)

ENTRY(imx6q_secondary_startup)
        bl      v7_invalidate_l1
        b       secondary_startup
ENDPROC(imx6q_secondary_startup)

The v7_invalidate_l1() is the function copied from mach-tegra/headsmp.S,
which has to be called before calling secondary_startup to boot
secondary cores (same situation between Tegra and i.MX6Q).

/*
 * Tegra specific entry point for secondary CPUs.
 *   The secondary kernel init calls v7_flush_dcache_all before it enables
 *   the L1; however, the L1 comes out of reset in an undefined state, so
 *   the clean + invalidate performed by v7_flush_dcache_all causes a bunch
 *   of cache lines with uninitialized data and uninitialized tags to get
 *   written out to memory, which does really unpleasant things to the main
 *   processor.  We fix this by performing an invalidate, rather than a
 *   clean + invalidate, before jumping into the kernel.
 */
ENTRY(v7_invalidate_l1)
        mov     r0, #0
        mcr     p15, 2, r0, c0, c0, 0
        mrc     p15, 1, r0, c0, c0, 0

        ldr     r1, =0x7fff
        and     r2, r1, r0, lsr #13

        ldr     r1, =0x3ff

        and     r3, r1, r0, lsr #3  @ NumWays - 1
        add     r2, r2, #1          @ NumSets

        and     r0, r0, #0x7
        add     r0, r0, #4          @ SetShift

        clz     r1, r3              @ WayShift
        add     r4, r3, #1          @ NumWays
1:      sub     r2, r2, #1          @ NumSets--
        mov     r3, r4              @ Temp = NumWays
2:      subs    r3, r3, #1          @ Temp--
        mov     r5, r3, lsl r1
        mov     r6, r2, lsl r0
        orr     r5, r5, r6          @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
        mcr     p15, 0, r5, c7, c6, 2
        bgt     2b
        cmp     r2, #0
        bgt     1b
        dsb
        isb
        mov     pc, lr
ENDPROC(v7_invalidate_l1)
 
Before applying this patch series, I have something like below actually
working.


	outer_flush_all();
	outer_disable();
	imx_set_cpu_jump(0, imx6q_cpu_resume);
	/* Zzz ... */
	cpu_suspend(0, imx6q_suspend_finish);

I expect with you patches applied, I can still have it work with simply
removing those two lines outer cache codes.  But unfortunately, I'm
running into Oops when resuming back.  And I also have Oops with
imx_set_cpu_jump(0, cpu_resume) which means skipping the
v7_invalidate_l1() and calling generic cpu_resume() only.

I know the key point of the whole thing is that we need to invalidate
L1 before either booting secondary cores or resuming the primary core
on i.MX6Q.  But I really need some help to understand why, and the
best solution to that.

-- 
Regards,
Shawn

