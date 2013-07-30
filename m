From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2] ARM: v6: prevent gcc 4.5 from reordering extended CP15
 reads above is_smp() test
Date: Tue, 30 Jul 2013 11:32:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307301125420.4505@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com> <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com> <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com> <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38851 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3G3LcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 07:32:07 -0400
In-Reply-To: <alpine.DEB.2.02.1307282012280.23852@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Commit 621a0147d5c921f4cc33636ccd0602ad5d7cbfbc ("ARM: 7757/1: mm:
don't flush icache in switch_mm with hardware broadcasting") breaks
the boot on OMAP2430SDP with omap2plus_defconfig.  Tracked to an
undefined instruction abort from the CP15 read in
cache_ops_need_broadcast().  It turns out that gcc 4.5 reorders the
extended CP15 read above the is_smp() test.  This breaks ARM1136 r0
cores, since they don't support several CP15 registers that later ARM
cores do.  ARM1136JF-S TRM section 3.2.1 "Register allocation" has the
details.

So mark the extended CP15 read as clobbering memory, which prevents
the compiler from reordering it before the is_smp() test.  Russell
states that the code generated from this approach is preferable to
marking the inline asm as volatile.  Remove the existing condition
code clobber as it's obsolete, per Nico's post:

    http://www.spinics.net/lists/arm-kernel/msg261208.html

This patch is a collaboration with Will Deacon and Russell King.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
---

Intended for v3.11-rc.

Basic test logs available here:

http://www.pwsan.com/omap/testlogs/bisect_2430sdp_hang_v3.11-rc/20130730045715/

N.B., several boards have problems on v3.11-rc that are unrelated to this 
patch.

 arch/arm/include/asm/cputype.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 8c25dc4..9672e97 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -89,13 +89,18 @@ extern unsigned int processor_id;
 		__val;							\
 	})
 
+/*
+ * The memory clobber prevents gcc 4.5 from reordering the mrc before
+ * any is_smp() tests, which can cause undefined instruction aborts on
+ * ARM1136 r0 due to the missing extended CP15 registers.
+ */
 #define read_cpuid_ext(ext_reg)						\
 	({								\
 		unsigned int __val;					\
 		asm("mrc	p15, 0, %0, c0, " ext_reg		\
 		    : "=r" (__val)					\
 		    :							\
-		    : "cc");						\
+		    : "memory");					\
 		__val;							\
 	})
 
-- 
1.8.3.2

