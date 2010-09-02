From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/6] ARM: Add inline function smp_on_up() for early init
 testing
Date: Thu, 2 Sep 2010 10:15:02 -0700
Message-ID: <20100902171502.GS11597@atomide.com>
References: <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49852 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0IBRPM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 13:15:12 -0400
Content-Disposition: inline
In-Reply-To: <20100902170830.GW26319@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
> On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
> > >From 7044c13594c3023da6095f8d432eda260bc3207f Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 30 Aug 2010 14:00:54 -0700
> > Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init testing
> > 
> > Add inline function smp_on_up() for early init checks, and
> > change build_mem_type_table to use it.
> 
> Isn't something missing from this - such as a C-mode definition of
> SMP() and UP() ?

Oops, here's the missing patch.

Tony
>From e52db459dba0088fcff66904069630a24a811db8 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 1 Sep 2010 15:02:50 -0700
Subject: [PATCH] ARM: Add SMP and UP macros for inline assembly

We can't use the macros in asm/assembler.h in C inline functions.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 55974d2..340795c 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -154,6 +154,10 @@
 	.long	9999b,9001f;			\
 	.popsection
 
+/*
+ * SMP and UP defines for assembly code. See also asm/smp_plat.h
+ * for the SMP and UP defines for inline code.
+ */
 #ifdef CONFIG_SMP
 #define SMP(instr...)						\
 9998:	instr
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..8db3512 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -18,4 +18,25 @@ static inline int cache_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 
+/*
+ * SMP and UP defines for inline functions. See also asm/assembler.h
+ * for the SMP and UP defines for assembly code.
+ */
+#ifdef CONFIG_SMP
+#define _str(s...)	#s
+#define _9998(s...)	_str(9998:	s\n)
+
+#define SMP(instr...)						\
+	_9998(instr)
+
+#define UP(instr...)						\
+	_str(.pushsection ".smpalt.init", "a"\n)		\
+	_str(.word	9998b\n)				\
+	_str(instr\n)						\
+	_str(.popsection\n)
+#else
+#define SMP(instr...)
+#define UP(instr...)	_str(instr)
+#endif
+
 #endif
