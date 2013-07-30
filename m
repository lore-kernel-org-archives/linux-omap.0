From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] ARM: v6: prevent gcc 4.5 from reordering extended
 CP15 reads above is_smp() test
Date: Tue, 30 Jul 2013 16:04:32 +0100
Message-ID: <20130730150432.GR11527@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com>
 <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com>
 <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
 <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
 <alpine.DEB.2.02.1307301125420.4505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63231 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751725Ab3G3PFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 11:05:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307301125420.4505@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 30, 2013 at 12:32:06PM +0100, Paul Walmsley wrote:
> 
> Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
> don't flush icache in switch_mm with hardware broadcasting") breaks
> the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
> undefined instruction abort from the CP15 read in
> cache_ops_need_broadcast().  It turns out that gcc 4.5 reorders the
> extended CP15 read above the is_smp() test.  This breaks ARM1136 r0
> cores, since they don't support several CP15 registers that later ARM
> cores do.  ARM1136JF-S TRM section 3.2.1 "Register allocation" has the
> details.
> 
> So mark the extended CP15 read as clobbering memory, which prevents
> the compiler from reordering it before the is_smp() test.  Russell
> states that the code generated from this approach is preferable to
> marking the inline asm as volatile.  Remove the existing condition
> code clobber as it's obsolete, per Nico's post:
> 
>     http://www.spinics.net/lists/arm-kernel/msg261208.html
> 
> This patch is a collaboration with Will Deacon and Russell King.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will
