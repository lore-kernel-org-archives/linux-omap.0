From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: v6: avoid remaining accesses to missing CP15 registers
 on ARM1136 r0
Date: Sun, 28 Jul 2013 05:46:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307280543370.8385@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com> <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280527430.8385@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39725 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3G1FqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 01:46:05 -0400
In-Reply-To: <alpine.DEB.2.02.1307280527430.8385@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Ensure that the remaining callers of read_cpuid_ext can't attempt an
extended CP15 register read on ARMv6.  The only one that appears dodgy
is tlb_ops_need_broadcast().

While here, convert feat_v6_fixup() to use cpu_is_arm1136_r0() to save
a few lines of code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---

Intended for v3.12.  Depends on the patch "ARM: v6: avoid read_cpuid_ext() 
on ARM1136r0 in cache_ops_need_broadcast()".

Tested (along with the parent patch) here:

http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130727224434/README.txt

against stock v3.11-rc2, so several boards aren't booting due to unrelated 
issues.

 arch/arm/include/asm/smp_plat.h | 3 +++
 arch/arm/kernel/setup.c         | 7 +------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 76214cb..ad07564 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -30,6 +30,9 @@ static inline bool is_smp(void)
 #else
 static inline int tlb_ops_need_broadcast(void)
 {
+	if (cpu_is_arm1136_r0())
+		return 0;
+
 	if (!is_smp())
 		return 0;
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 63af9a7..a601843 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -389,16 +389,11 @@ static void __init cpuid_init_hwcaps(void)
 
 static void __init feat_v6_fixup(void)
 {
-	int id = read_cpuid_id();
-
-	if ((id & 0xff0f0000) != 0x41070000)
-		return;
-
 	/*
 	 * HWCAP_TLS is available only on 1136 r1p0 and later,
 	 * see also kuser_get_tls_init.
 	 */
-	if ((((id >> 4) & 0xfff) == 0xb36) && (((id >> 20) & 3) == 0))
+	if (cpu_is_arm1136_r0())
 		elf_hwcap &= ~HWCAP_TLS;
 }
 
-- 
1.8.3.2

