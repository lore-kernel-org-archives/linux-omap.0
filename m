From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Sat, 27 Jul 2013 04:10:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58673 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab3G0EK6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Jul 2013 00:10:58 -0400
In-Reply-To: <20130724142059.GJ11072@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Tonight I put on a Jon Hopkins album, in recollection of my UK ARM Linux 
colleagues perhaps, and started testing, and eventually wound up with this 
one:

commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc
Author: Will Deacon <will.deacon@arm.com>
Date:   Wed Jun 12 12:25:56 2013 +0100

    ARM: 7757/1: mm: don't flush icache in switch_mm with hardware broadcasting
    
    When scheduling an mm on a CPU where it hasn't previously been used, we
    flush the icache on that CPU so that any code loaded previously on
    a different core can be safely executed.
    
    For cores with hardware broadcasting of cache maintenance operations,
    this is clearly unnecessary, since the inner-shareable invalidation in
    __sync_icache_dcache will affect all CPUs.
    
    This patch conditionalises the icache flush in switch_mm based on
    cache_ops_need_broadcast().
    
    Acked-by: Catalin Marinas <catalin.marinas@arm.com>
    Reported-by: Albin Tonnerre <albin.tonnerre@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

...

v3.11-rc2 boots with it reverted.  What also works is v3.11-rc2 with the 
below patch applied.

Would be pleased to boot-test anything you'd care to send my way, as long 
as you can tolerate response latency jitter.


- Paul

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index b5792b7..8dfb295 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -112,7 +112,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 * so check for possible thread migration and invalidate the I-cache
 	 * if we're new to this CPU.
 	 */
-	if (cache_ops_need_broadcast() &&
+	if (1 &&
 	    !cpumask_empty(mm_cpumask(next)) &&
 	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
 		__flush_icache_all();


