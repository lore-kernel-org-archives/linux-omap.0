From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Thu, 2 Sep 2010 16:47:46 -0700
Message-ID: <20100902234746.GF11597@atomide.com>
References: <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902162039.GM11597@atomide.com>
 <20100902162537.GU26319@n2100.arm.linux.org.uk>
 <20100902163453.GR11597@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="V32M1hWVjliPHW+c"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49695 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab0IBXr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 19:47:57 -0400
Content-Disposition: inline
In-Reply-To: <20100902163453.GR11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100902 09:29]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 09:18]:
> > On Thu, Sep 02, 2010 at 09:20:40AM -0700, Tony Lindgren wrote:
> > > >From 253e91b76e104dbdf05c5c3eaf9cbf426972c938 Mon Sep 17 00:00:00 2001
> > > From: Tony Lindgren <tony@atomide.com>
> > > Date: Wed, 1 Sep 2010 16:49:13 -0700
> > > Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
> > > 
> > > Fix v7wbi_tlb_flags for SMP on UP. Note that we must enable MULTI_TLB
> > > to avoid undefined reference to cpu_tlb error.
> > 
> > This isn't required, as it is already covered by my patch.
> 
> Yup, seems to be working without this patch.

Correction, only boots on SMP hardawre. On UP hardware I still
need the following patch.

Left out forcing MULTI_TLB as looks like your patch already
does that.

Also noticed I'm now getting unhandled fault on SMP system
which I was not getting earlier. Will try to track it down.

Tony

--V32M1hWVjliPHW+c
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="tlbflush-fix-smp-on-up-flags.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 1 Sep 2010 16:49:13 -0700
Subject: [PATCH] ARM: Fix v7wbi_tlb_flags for SMP on UP

Fix v7wbi_tlb_flags for SMP on UP. Note that depends on MULTI_TLB
to avoid undefined reference to cpu_tlb error.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 1fd0db9..692e9cf 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -189,20 +189,29 @@
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
+# else
+#  define v7wbi_always_flags	v7wbi_tlb_flags
+# endif
 # ifdef _TLB
 #  define MULTI_TLB 1
 # else

--V32M1hWVjliPHW+c--
