From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: v6: avoid read_cpuid_ext() on ARM1136r0 in
	cache_ops_need_broadcast()
Date: Sun, 28 Jul 2013 12:52:20 +0100
Message-ID: <20130728115220.GE21614@n2100.arm.linux.org.uk>
References: <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com> <20130727122221.GB6618@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com> <20130728111038.GA9374@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38981 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3G1Lwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 07:52:40 -0400
Content-Disposition: inline
In-Reply-To: <20130728111038.GA9374@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Jul 28, 2013 at 12:10:38PM +0100, Will Deacon wrote:
> Hi Paul,
> 
> Cheers for sticking with this!
> 
> On Sun, Jul 28, 2013 at 06:43:24AM +0100, Paul Walmsley wrote:
> > 
> > Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
> > don't flush icache in switch_mm with hardware broadcasting") breaks
> > the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
> > undefined instruction abort from the CP15 read in
> > cache_ops_need_broadcast().  It turns out that early ARM1136 variants
> > don't support several CP15 registers that later ARM cores do.
> > ARM1136JF-S TRM section 3.2.1 "Register allocation" has the details.
> 
> Intriguing... I wouldn't expect a cp15 read to be emitted for 1136, since
> the SMP_ON_UP magic should have caused is_smp() to return false.

The compiler seems to be doing something quite odd with schedule():

00000540 <__schedule>:
 558:   ee103ff1        mrc     15, 0, r3, cr0, cr1, {7}
 560:   e1a03623        lsr     r3, r3, #12
 564:   e203300f        and     r3, r3, #15
 570:   e50b3080        str     r3, [fp, #-128] ; 0x80
...
 6e8:   e59f3428        ldr     r3, [pc, #1064] ; b18 <__schedule+0x5d8>
 6f0:   e5933000        ldr     r3, [r3]
 6f4:   e3530000        cmp     r3, #0
 6f8:   1a000027        bne     79c <__schedule+0x25c>
 6fc:   e2851f65        add     r1, r5, #404    ; 0x194
 700:   ebfffffe        bl      0 <_test_and_set_bit>
                        700: R_ARM_CALL _test_and_set_bit
...
 79c:   e51b1080        ldr     r1, [fp, #-128] ; 0x80
 7a0:   e3510000        cmp     r1, #0
 7a4:   1affffd4        bne     6fc <__schedule+0x1bc>
                        b18: R_ARM_ABS32        smp_on_up

Yes - that's right, it's reading from the mcr at the very start of
__schedule and storing it on the stack for just one test later on.  The
act of storing it on the stack and reading it back of is likely a lot
more expensive than reading it from CP15 in the first place!

We don't want to make the asm() itself volatile, because that means the
asm() statement can't be optimised away.

Adding a memory clobber to that asm seems to place it more appropriately,
but again, that's not particularly desirable.

Another solution would be to make both tlb_ops_need_broadcast and
cache_ops_need_broadcast both be a flag test, but that introduces a
memory load in all those paths no matter if we're running on SMP_ON_UP
or not.
