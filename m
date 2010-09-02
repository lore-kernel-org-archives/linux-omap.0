From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Thu, 2 Sep 2010 09:20:40 -0700
Message-ID: <20100902162039.GM11597@atomide.com>
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
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50578 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab0IBQUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 12:20:40 -0400
Content-Disposition: inline
In-Reply-To: <20100902161659.GJ11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

>From 253e91b76e104dbdf05c5c3eaf9cbf426972c938 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 1 Sep 2010 16:49:13 -0700
Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP

Fix v7wbi_tlb_flags for SMP on UP. Note that we must enable MULTI_TLB
to avoid undefined reference to cpu_tlb error.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/tlbflush.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 1fd0db9..55e1dd9 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -189,20 +189,32 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
+#define v7wbi_tlb_flags_common (TLB_WB | TLB_DCLEAN)
 #define v7wbi_tlb_flags_smp (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
 			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
 #define v7wbi_tlb_flags_up (TLB_WB | TLB_DCLEAN | TLB_BTB | \
 			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SMP_ON_UP
+#define v7wbi_tlb_flags	(v7wbi_tlb_flags_smp | v7wbi_tlb_flags_up)
+#else
 #define v7wbi_tlb_flags	v7wbi_tlb_flags_smp
+#endif
 #else
 #define v7wbi_tlb_flags	v7wbi_tlb_flags_up
 #endif
 
 #ifdef CONFIG_CPU_TLB_V7
 # define v7wbi_possible_flags	v7wbi_tlb_flags
-# define v7wbi_always_flags	v7wbi_tlb_flags
+# ifdef CONFIG_SMP_ON_UP
+#  define v7wbi_always_flags	v7wbi_tlb_flags_common
+#  ifndef MULTI_TLB
+#   define MULTI_TLB 1
+#  endif
+# else
+#  define v7wbi_always_flags	v7wbi_tlb_flags
+# endif
 # ifdef _TLB
 #  define MULTI_TLB 1
 # else
-- 
1.7.1

