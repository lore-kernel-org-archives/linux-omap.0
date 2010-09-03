From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
 testing
Date: Fri, 3 Sep 2010 17:42:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A8@dbde02.ent.ti.com>
References: <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
 <20100902174244.GU11597@atomide.com> <20100902192659.GW11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34550 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569Ab0ICMMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 08:12:50 -0400
In-Reply-To: <20100902192659.GW11597@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>


> > BTW, so far looks like we should only need this during init to set up
> things.
> 
> Here's this one updated to replace smp_cpu() instead of smp_on_up().
> 


diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 8db3512..82bc488 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -39,4 +39,11 @@ static inline int cache_ops_need_broadcast(void)
 #define UP(instr...)	_str(instr)
 #endif
 
+static inline int smp_cpu(void)
+{
+        u32 mpidr;
+        asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
+        return (mpidr >> 31) ? !(mpidr >> 30) : 0;
+}
+
Will this be called on UP machines ?? if yes, then mpidr register is not
available on those
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

