From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init
 testing
Date: Thu, 2 Sep 2010 09:18:47 -0700
Message-ID: <20100902161846.GK11597@atomide.com>
References: <20100817141210.GJ12184@atomide.com>
 <20100817154035.GD20325@n2100.arm.linux.org.uk>
 <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64304 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab0IBQSs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 12:18:48 -0400
Content-Disposition: inline
In-Reply-To: <20100902161659.GJ11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

>From 7044c13594c3023da6095f8d432eda260bc3207f Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 30 Aug 2010 14:00:54 -0700
Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing

Add inline function smp_on_up() for early init checks, and
change build_mem_type_table to use it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/smp_plat.h |   16 ++++++++++++++++
 arch/arm/mm/mmu.c               |   20 +++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 8db3512..5ef4114 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
 #define UP(instr...)	_str(instr)
 #endif
 
+static inline int smp_on_up(void)
+{
+#ifdef CONFIG_SMP_ON_UP
+	int smp_on_up;
+
+	asm(							\
+		SMP(mov	%0, #0)					\
+		UP(mov	%0, #1)					\
+		: "=r" (smp_on_up));
+
+	return smp_on_up;
+#else
+	return 0;
+#endif
+}
+
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..f320901 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -430,15 +430,17 @@ static void __init build_mem_type_table(void)
 		/*
 		 * Mark memory with the "shared" attribute for SMP systems
 		 */
-		user_pgprot |= L_PTE_SHARED;
-		kern_pgprot |= L_PTE_SHARED;
-		vecs_pgprot |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		if (!smp_on_up()) {
+			user_pgprot |= L_PTE_SHARED;
+			kern_pgprot |= L_PTE_SHARED;
+			vecs_pgprot |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		}
 #endif
 	}
 
-- 
1.7.1

