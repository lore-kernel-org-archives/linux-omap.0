From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: v6: avoid read_cpuid_ext() on ARM1136r0 in
 cache_ops_need_broadcast()
Date: Sun, 28 Jul 2013 05:43:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3G1FnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 01:43:25 -0400
In-Reply-To: <20130727122221.GB6618@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
don't flush icache in switch_mm with hardware broadcasting") breaks
the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
undefined instruction abort from the CP15 read in
cache_ops_need_broadcast().  It turns out that early ARM1136 variants
don't support several CP15 registers that later ARM cores do.
ARM1136JF-S TRM section 3.2.1 "Register allocation" has the details.

So, prevent cache_ops_need_broadcast() from attempting the CP15 read
if the running CPU doesn't provide the register.
cache_ops_need_broadcast() is a hot path function, so focus on
minimizing the execution time impact.  A subsequent patch will take
care of the remaining cases in the current kernel.

Thanks to Will Deacon for helping track this down.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Will Deacon <will.deacon@arm.com>
---

Intended for v3.11-rc.

Tested (along with the followup patch) here:

http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130727224434/README.txt

against stock v3.11-rc2, so several boards aren't booting due to unrelated 
issues.

 arch/arm/include/asm/cputype.h  | 37 ++++++++++++++++++++++++++++++++++++-
 arch/arm/include/asm/smp_plat.h |  4 +++-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 8c25dc4..91ccd77 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -76,6 +76,8 @@
 #define ARM_CPU_XSCALE_ARCH_V2		0x4000
 #define ARM_CPU_XSCALE_ARCH_V3		0x6000
 
+#define ARM_CPU_ARM1136R0		0x4107b360
+
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
@@ -89,10 +91,43 @@ extern unsigned int processor_id;
 		__val;							\
 	})
 
+
+/* Workaround for missing CP15 registers on ARM1136 r0 */
+# if defined(CONFIG_CPU_V6)
+/**
+ * cpu_is_arm1136_r0 - is the kernel running on an ARM1136 r0 core?
+ *
+ * Returns true if the kernel is running on an ARM1136 r0 core, or
+ * false otherwise.  Callers use this to avoid undefined instruction
+ * aborts from CP15 accesses to registers not present on the r0
+ * variant, or to detect whether certain CPU features are available.
+ * ARM1136JF-S TRM section 3.2.1 "Register allocation"
+ */
+static inline bool __attribute_const__ cpu_is_arm1136_r0(void)
+{
+	return ((read_cpuid(CPUID_ID) & 0xfffffff0) == ARM_CPU_ARM1136R0);
+}
+
+/*
+ * The mrc in the read_cpuid_ext macro must not be reordered on ARMv6,
+ * else the compiler may move it before any ARM1136r0 test.
+ */
+# define CPUID_EXT_REORDER	volatile
+# else
+static inline bool __attribute_const__ cpu_is_arm1136_r0(void) { return false; }
+# define CPUID_EXT_REORDER
+# endif
+
+/*
+ * Early ARM1136 variants don't support many CP15 registers provided
+ * on later cores.  Users of read_cpuid_ext must ensure that it won't
+ * be used unless it's known that the running core provides the CP15
+ * register ext_reg.  See cpu_is_arm1136_r0() above.
+ */
 #define read_cpuid_ext(ext_reg)						\
 	({								\
 		unsigned int __val;					\
-		asm("mrc	p15, 0, %0, c0, " ext_reg		\
+		asm CPUID_EXT_REORDER("mrc p15, 0, %0, c0, " ext_reg	\
 		    : "=r" (__val)					\
 		    :							\
 		    : "cc");						\
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 6462a72..76214cb 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -25,7 +25,6 @@ static inline bool is_smp(void)
 #endif
 }
 
-/* all SMP configurations have the extended CPUID registers */
 #ifndef CONFIG_MMU
 #define tlb_ops_need_broadcast()	0
 #else
@@ -43,6 +42,9 @@ static inline int tlb_ops_need_broadcast(void)
 #else
 static inline int cache_ops_need_broadcast(void)
 {
+	if (cpu_is_arm1136_r0())
+		return 0;
+
 	if (!is_smp())
 		return 0;
 
-- 
1.8.3.2

