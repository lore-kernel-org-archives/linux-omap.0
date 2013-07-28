From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: v6: prevent gcc from reordering extended CP15 reads
 above is_smp() test
Date: Sun, 28 Jul 2013 20:16:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com> <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51751 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab3G1UQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Jul 2013 16:16:30 -0400
In-Reply-To: <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
don't flush icache in switch_mm with hardware broadcasting") breaks
the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
undefined instruction abort from the CP15 read in
cache_ops_need_broadcast().  It turns out that gcc reorders the
extended CP15 read above the is_smp() test.  This breaks ARM1136 r0
cores, since they don't support several CP15 registers that later ARM
cores do.  ARM1136JF-S TRM section 3.2.1 "Register allocation" has the
details.

So, when the kernel is built for ARMv6 cores, mark the extended CP15
read as clobbering memory, which seems to prevent the compiler from
reordering it before the is_smp() test.  Russell states that the code
generated from this approach is preferable to marking the inline asm
as volatile.

This patch was developed in collaboration with Will Deacon and Russell
King.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---

Thought I'd respin this to have a discussion strawman.  It boots cleanly 
on 2430SDP.

[ Updated "ARM: v6: avoid read_cpuid_ext() on ARM1136r0 in 
cache_ops_need_broadcast()" to drop the unnecessary ARM1136 r0 test, to 
switch to a memory clobber per rmk's suggestion, and to update the commit 
message. ]

Intended for v3.11-rc.


 arch/arm/include/asm/cputype.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 8c25dc4..f428eb0 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -89,13 +89,25 @@ extern unsigned int processor_id;
 		__val;							\
 	})
 
+
+# if defined(CONFIG_CPU_V6)
+/*
+ * The mrc in the read_cpuid_ext macro must not be reordered on ARMv6,
+ * else the compiler may move it before an is_smp() test, causing
+ * undefined instruction aborts on ARM1136 r0.
+ */
+# define CPUID_EXT_REORDER	"cc", "memory"
+# else
+# define CPUID_EXT_REORDER	"cc"
+# endif
+
 #define read_cpuid_ext(ext_reg)						\
 	({								\
 		unsigned int __val;					\
 		asm("mrc	p15, 0, %0, c0, " ext_reg		\
 		    : "=r" (__val)					\
 		    :							\
-		    : "cc");						\
+		    : CPUID_EXT_REORDER);				\
 		__val;							\
 	})
 
-- 
1.8.3.2

