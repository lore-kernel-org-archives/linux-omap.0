From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
 testing
Date: Thu, 2 Sep 2010 19:22:01 -0700
Message-ID: <20100903022201.GI11597@atomide.com>
References: <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
 <20100902174244.GU11597@atomide.com>
 <20100902192659.GW11597@atomide.com>
 <20100903000817.GG11597@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cDtQGJ/EJIRf/Cpq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64771 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0ICCWN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 22:22:13 -0400
Content-Disposition: inline
In-Reply-To: <20100903000817.GG11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100902 17:00]:
> * Tony Lindgren <tony@atomide.com> [100902 12:20]:
> 
> Heh, turns out there's a bit of a bug in the code snippet above :) It should
> be !((mpidr >> 30) & 1) instead, otherwise it always returns 0.

This too can check for value of 2. Also we probably want to do the
CPU type checks too. Updated patch below.

Tony

--cDtQGJ/EJIRf/Cpq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="smp-cpu.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Mon, 30 Aug 2010 14:00:54 -0700
Subject: [PATCH] ARM: Add inline function smp_cpu() for early init testing

Add inline function smp_cpu() for early init checks, and
change build_mem_type_table to use it.

Inline function copied from cpu_is_part_of_mp_system() by
Will Deacon <will.deacon@arm.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 8db3512..50a4f0b 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -39,4 +39,24 @@ static inline int cache_ops_need_broadcast(void)
 #define UP(instr...)	_str(instr)
 #endif
 
+static inline int smp_cpu(void)
+{
+        u32 val;
+
+	val = read_cpuid(CPUID_ID);
+
+	/* Check for ARM CPU */
+	if ((val & 0xff000000) != 0x41000000)
+		return 0;
+
+	/* Check for ARMv6 or 7 */
+	if ((val & 0x00070000) != 0x00070000)
+		return 0;
+
+	/* Check MPIDR */
+        asm ("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+        return (val >> 30) == 2;
+}
+
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..2bfaefd 100644
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
+		if (smp_cpu()) {
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
 

--cDtQGJ/EJIRf/Cpq--
