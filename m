From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: v6: avoid read_cpuid_ext() on ARM1136r0 in
 cache_ops_need_broadcast()
Date: Sun, 28 Jul 2013 19:47:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307281945530.23852@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com>
 <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com> <20130727122221.GB6618@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
 <20130728111038.GA9374@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51689 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab3G1TrQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 15:47:16 -0400
In-Reply-To: <20130728111038.GA9374@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Will

On Sun, 28 Jul 2013, Will Deacon wrote:

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
> 

...

> So we should have returned 0 here without exploding (this just reads a
> .globl initialised in head.S). Are we somehow misidentifying your 1136
> as an SMP core?

You're right - the is_arm1136_r0() logic is completely unnecessary - it's 
just the 'asm volatile' that makes the difference.

- Paul
