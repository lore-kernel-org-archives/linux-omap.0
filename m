From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: v6: prevent gcc from reordering extended CP15
 reads above is_smp() test
Date: Mon, 29 Jul 2013 00:30:11 -0700
Message-ID: <20130729073010.GU7656@atomide.com>
References: <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
 <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com>
 <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
 <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38782 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab3G2HaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 03:30:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

* Paul Walmsley <paul@pwsan.com> [130728 13:23]:
> 
> Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
> don't flush icache in switch_mm with hardware broadcasting") breaks
> the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
> undefined instruction abort from the CP15 read in
> cache_ops_need_broadcast().  It turns out that gcc reorders the
> extended CP15 read above the is_smp() test.  This breaks ARM1136 r0
> cores, since they don't support several CP15 registers that later ARM
> cores do.  ARM1136JF-S TRM section 3.2.1 "Register allocation" has the
> details.
> 
> So, when the kernel is built for ARMv6 cores, mark the extended CP15
> read as clobbering memory, which seems to prevent the compiler from
> reordering it before the is_smp() test.  Russell states that the code
> generated from this approach is preferable to marking the inline asm
> as volatile.
> 
> This patch was developed in collaboration with Will Deacon and Russell
> King.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Sorry to be late to this party, I was offline last week. This
patch fixes the issue for me:

Acked-by: Tony Lindgren <tony@atomide.com>
