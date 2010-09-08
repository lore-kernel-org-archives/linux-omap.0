From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Check for is_smp for tlb_ops and cache_ops boardcast
Date: Tue, 7 Sep 2010 20:12:14 -0700
Message-ID: <20100908031214.GI22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100906180346.GC20849@atomide.com>
 <20100908030951.GH22507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50985 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab0IHDM1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 23:12:27 -0400
Content-Disposition: inline
In-Reply-To: <20100908030951.GH22507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

This should not be needed when running on UP systems.

Additionally we will also get an undefined instruction on ARM cores
without the extended CPUID registers with CONFIG_SMP_ON_UP.

Also, we can now remove the is_smp() test from mmu.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 7de5aa5..7f4e663 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -7,17 +7,6 @@
 
 #include <asm/cputype.h>
 
-/* all SMP configurations have the extended CPUID registers */
-static inline int tlb_ops_need_broadcast(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
-}
-
-static inline int cache_ops_need_broadcast(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
-}
-
 /*
  * Return true if we are running on a SMP platform
  */
@@ -33,4 +22,21 @@ static inline bool is_smp(void)
 #endif
 }
 
+/* all SMP configurations have the extended CPUID registers */
+static inline int tlb_ops_need_broadcast(void)
+{
+	if (!is_smp())
+		return 0;
+
+	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
+}
+
+static inline int cache_ops_need_broadcast(void)
+{
+	if (!is_smp())
+		return 0;
+
+	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
+}
+
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a789320..34df905 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -800,7 +800,7 @@ static void __init sanity_check_meminfo(void)
 			 * rather difficult.
 			 */
 			reason = "with VIPT aliasing cache";
-		} else if (is_smp() && tlb_ops_need_broadcast()) {
+		} else if (tlb_ops_need_broadcast()) {
 			/*
 			 * kmap_high needs to occasionally flush TLB entries,
 			 * however, if the TLB entries need to be broadcast
