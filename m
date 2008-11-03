From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] DSPBRIDGE: Ensure write posting when acking
	mailbox irq
Date: Mon, 3 Nov 2008 10:54:07 -0800
Message-ID: <20081103185406.GY28924@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <1225480873-30835-2-git-send-email-tony@atomide.com> <1225480873-30835-3-git-send-email-tony@atomide.com> <1225480873-30835-4-git-send-email-tony@atomide.com> <1225480873-30835-5-git-send-email-tony@atomide.com> <13B9B4C6EF24D648824FF11BE89671620369885CBD@dlee02.ent.ti.com> <20081102221050.GQ28924@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QXO0/MSS4VvK6f+D"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58518 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYKCSyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 13:54:09 -0500
Content-Disposition: inline
In-Reply-To: <20081102221050.GQ28924@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [081102 14:11]:
> * Woodruff, Richard <r-woodruff2@ti.com> [081031 20:44]:
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Friday, October 31, 2008 2:21 PM
> > 
> > > The only way to ensure write posting to L4 bus is to do a read back
> > > of the same register right after the write.
> > >
> > > This seems to be mostly needed in interrupt handlers to avoid
> > > causing spurious interrupts.
> > >
> > > The earlier fix has been to mark the L4 bus as strongly ordered
> > > memory, which solves the problem, but causes performance penalties.
> > 
> > What penalties have you observed?  Can you quantify?
> 
> Not yet, I guess we can run some benchmarks though.
> 
> > From the L4 perspectives DEVICE and SO are similar.  Long back I was told one difference is DEVICE is allowed to do burst transactions of element size where SO was not. This behavior is only really wanted to a FIFO.
> > 
> > Really performance sensitive devices will be using DMA to FIFOs.  SO/DEVICE only applies to the ARM's view of things.  DMA is not affected by ARM memory types.
> 
> You may be right, and if that's the only difference, then SO might be
> even faster as it avoids the extra readbacks.
> 
> > Some kind of barrier or read back is needed for sure when dealing with the main interrupt controller.
> 
> Yeah. I'm worried that these issues could happen with SO too..

And here's the fix copied from the LAK mailing list.

> Regards,
> 
> Tony



--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=apply

Return-Path: <linux+tony=atomide.com@arm.linux.org.uk>
X-Original-To: tony@atomide.com
Delivered-To: tmlind@muru.com
Received: from localhost (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTP id 501906B81
	for <tony@atomide.com>; Mon,  3 Nov 2008 18:20:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at muru.com
Received: from muru.com ([127.0.0.1])
	by localhost (muru.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnXeC0yRM67G for <tony@atomide.com>;
	Mon,  3 Nov 2008 18:20:37 +0000 (UTC)
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk [78.32.30.218])
	by muru.com (Postfix) with ESMTP id 8E3D26B7F
	for <tony@atomide.com>; Mon,  3 Nov 2008 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:Mime-Version:Content-Type:In-Reply-To:
	Sender; bh=E7T+sNNhAMVrmIeJvqIeD2sTnYDVvwn66HW3FXwY+tE=; b=LRToU
	WyC/1QDPYX1Kc53XPddYuWrtGX2Hc4JTuxnsGQhtQJ5BgcTYu+O+rSO+LFOXBpMA
	6NGqRODq5XguA9DAhRmAA3cGyeOZ0S2KgmQa/0cnx0+/O8n/5H4+CYg8dchHe3s4
	Bm0F2mMf4hf/7Z3557TwH+zfnsu57ppmTNWMYg=
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1Kx42M-0005Zg-RF; Mon, 03 Nov 2008 18:20:27 +0000
Received: from linux by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@flint.arm.linux.org.uk>)
	id 1Kx42H-0001pA-No; Mon, 03 Nov 2008 18:20:21 +0000
Date: Mon, 3 Nov 2008 18:20:20 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.arm.linux.org.uk
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [CFT] ALL ARM PLATFORMS AND ARM CPUS: Fix ARMv7 memory typing (was: Current omap hsmmc patch pile)
Message-ID: <20081103182019.GC16696@flint.arm.linux.org.uk>
References: <20081031163102.GE13227@atomide.com> <20081102205506.GL28924@atomide.com> <20081103113643.GA12544@flint.arm.linux.org.uk> <20081103114922.GA12622@flint.arm.linux.org.uk> <20081103133031.GA26993@flint.arm.linux.org.uk> <1225720473.18781.38.camel@pc1117.cambridge.arm.com> <20081103135955.GC12544@flint.arm.linux.org.uk> <1225723480.18781.65.camel@pc1117.cambridge.arm.com> <20081103150810.GD12544@flint.arm.linux.org.uk> <20081103164628.GU28924@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081103164628.GU28924@atomide.com>
User-Agent: Mutt/1.4.2.1i
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-Label: [-TML-]

[LAK added]

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081103 07:09]:
> Solving ARMv7 seems to be fairly simple, at the expense of making
> build_mem_types_table() slightly more complex.  If that was the only
> problem, then I wouldn't be mentioning the idea of dropping the
> patchset.

Well, this is the fix for ARMv7 (and a few others).  In making these
changes, I went back to DDI0100I (ARMv6 ARM), DDI0406A (ARMv7 ARM)
and the Marvell Xscale3 documentation.

I rather wish that this patch was smaller, but that would mean making
build_mem_types_table() even harder to read, which would be a mistake
given its complexity.

I noticed that coherent Xscale3 was setting the shared PTE bit for
kernel memory mappings - we never map kernel memory using PTEs, so
that's been killed.

This solves the issue Tony reported with the UART for me on the OMAP3
LDP platform.  I haven't yet tested this on anything else - and it does
need testing on other CPUs.  The most important thing to do is to
manually check the bit combinations - which is why this patch will dump
them out.  That dumping will of course be removed in the final version.

I do not expect the issues which mkp has reported to be affected by
this patch.

Nevertheless, can as many people as possible test this please.

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 7aad784..568020b 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -42,6 +42,10 @@
 #define CR_U	(1 << 22)	/* Unaligned access operation		*/
 #define CR_XP	(1 << 23)	/* Extended page tables			*/
 #define CR_VE	(1 << 24)	/* Vectored interrupts			*/
+#define CR_EE	(1 << 25)	/* Exception (Big) Endian		*/
+#define CR_TRE	(1 << 28)	/* TEX remap enable			*/
+#define CR_AFE	(1 << 29)	/* Access flag enable			*/
+#define CR_TE	(1 << 30)	/* Thumb exception enable		*/
 
 /*
  * This is used to ensure the compiler did actually allocate the register we
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8ba7540..96b9531 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -180,20 +180,20 @@ void adjust_cr(unsigned long mask, unsigned long set)
 #endif
 
 #define PROT_PTE_DEVICE		L_PTE_PRESENT|L_PTE_YOUNG|L_PTE_DIRTY|L_PTE_WRITE
-#define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_XN|PMD_SECT_AP_WRITE
+#define PROT_SECT_DEVICE	PMD_TYPE_SECT|PMD_SECT_AP_WRITE
 
 static struct mem_type mem_types[] = {
 	[MT_DEVICE] = {		  /* Strongly ordered / ARMv6 shared device */
 		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_SHARED |
 				  L_PTE_SHARED,
 		.prot_l1	= PMD_TYPE_TABLE,
-		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_UNCACHED,
+		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_S,
 		.domain		= DOMAIN_IO,
 	},
 	[MT_DEVICE_NONSHARED] = { /* ARMv6 non-shared device */
 		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_NONSHARED,
 		.prot_l1	= PMD_TYPE_TABLE,
-		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_TEX(2),
+		.prot_sect	= PROT_SECT_DEVICE,
 		.domain		= DOMAIN_IO,
 	},
 	[MT_DEVICE_CACHED] = {	  /* ioremap_cached */
@@ -205,7 +205,7 @@ static struct mem_type mem_types[] = {
 	[MT_DEVICE_WC] = {	/* ioremap_wc */
 		.prot_pte	= PROT_PTE_DEVICE | L_PTE_MT_DEV_WC,
 		.prot_l1	= PMD_TYPE_TABLE,
-		.prot_sect	= PROT_SECT_DEVICE | PMD_SECT_BUFFERABLE,
+		.prot_sect	= PROT_SECT_DEVICE,
 		.domain		= DOMAIN_IO,
 	},
 	[MT_CACHECLEAN] = {
@@ -273,22 +273,23 @@ static void __init build_mem_type_table(void)
 #endif
 
 	/*
-	 * On non-Xscale3 ARMv5-and-older systems, use CB=01
-	 * (Uncached/Buffered) for ioremap_wc() mappings.  On XScale3
-	 * and ARMv6+, use TEXCB=00100 mappings (Inner/Outer Uncacheable
-	 * in xsc3 parlance, Uncached Normal in ARMv6 parlance).
+	 * Strip out features not present on earlier architectures.
+	 * Pre-ARMv5 CPUs don't have TEX bits.  Pre-ARMv6 CPUs or those
+	 * without extended page tables don't have the 'Shared' bit.
 	 */
-	if (cpu_is_xsc3() || cpu_arch >= CPU_ARCH_ARMv6) {
-		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_TEX(1);
-		mem_types[MT_DEVICE_WC].prot_sect &= ~PMD_SECT_BUFFERABLE;
-	}
+	if (cpu_arch < CPU_ARCH_ARMv5)
+		for (i = 0; i < ARRAY_SIZE(mem_types); i++)
+			mem_types[i].prot_sect &= ~PMD_SECT_TEX(7);
+	if (cpu_arch < CPU_ARCH_ARMv6 || !(cr & CR_XP))
+		for (i = 0; i < ARRAY_SIZE(mem_types); i++)
+			mem_types[i].prot_sect &= ~PMD_SECT_S;
 
 	/*
-	 * ARMv5 and lower, bit 4 must be set for page tables.
-	 * (was: cache "update-able on write" bit on ARM610)
-	 * However, Xscale cores require this bit to be cleared.
+	 * ARMv5 and lower, bit 4 must be set for page tables (was: cache
+	 * "update-able on write" bit on ARM610).  However, Xscale and
+	 * Xscale3 require this bit to be cleared.
 	 */
-	if (cpu_is_xscale()) {
+	if (cpu_is_xscale() || cpu_is_xsc3()) {
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 			mem_types[i].prot_sect &= ~PMD_BIT4;
 			mem_types[i].prot_l1 &= ~PMD_BIT4;
@@ -302,6 +303,54 @@ static void __init build_mem_type_table(void)
 		}
 	}
 
+	/*
+	 * Mark the device areas according to the CPU/architecture.
+	 */
+	if (cpu_is_xsc3() || (cpu_arch >= CPU_ARCH_ARMv6 && (cr & CR_XP))) {
+		if (!cpu_is_xsc3()) {
+			/*
+			 * Mark device regions on ARMv6+ as execute-never
+			 * to prevent speculative instruction fetches.
+			 */
+			mem_types[MT_DEVICE].prot_sect |= PMD_SECT_XN;
+			mem_types[MT_DEVICE_NONSHARED].prot_sect |= PMD_SECT_XN;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_XN;
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_XN;
+		}
+		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
+			/*
+			 * For ARMv7 with TEX remapping,
+			 * - shared device is SXCB=1100
+			 * - nonshared device is SXCB=0100
+			 * - write combine device mem is SXCB=0001
+			 * (Uncached Normal memory)
+			 */
+			mem_types[MT_DEVICE].prot_sect |= PMD_SECT_TEX(1);
+			mem_types[MT_DEVICE_NONSHARED].prot_sect |= PMD_SECT_TEX(1);
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_BUFFERABLE;
+		} else {
+			/*
+			 * For Xscale3, ARMv6 and ARMv7 without TEX remapping,
+			 * - shared device is TEXCB=00001
+			 * - nonshared device is TEXCB=01000
+			 * - write combine device mem is TEXCB=00100
+			 * (Inner/Outer Uncacheable in xsc3 parlance, Uncached
+			 * Normal in ARMv6 parlance).
+			 */
+			mem_types[MT_DEVICE].prot_sect |= PMD_SECT_BUFFERED;
+			mem_types[MT_DEVICE_NONSHARED].prot_sect |= PMD_SECT_TEX(2);
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_TEX(1);
+		}
+	} else {
+		/*
+		 * On others, write combining is "Uncached/Buffered"
+		 */
+		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_BUFFERABLE;
+	}
+
+	/*
+	 * Now deal with the memory-type mappings
+	 */
 	cp = &cache_policies[cachepolicy];
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
 
@@ -317,12 +366,8 @@ static void __init build_mem_type_table(void)
 	 * Enable CPU-specific coherency if supported.
 	 * (Only available on XSC3 at the moment.)
 	 */
-	if (arch_is_coherent()) {
-		if (cpu_is_xsc3()) {
-			mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-			mem_types[MT_MEMORY].prot_pte |= L_PTE_SHARED;
-		}
-	}
+	if (arch_is_coherent() && cpu_is_xsc3())
+		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
 
 	/*
 	 * ARMv6 and above have extended page tables.
@@ -336,11 +381,6 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 
-		/*
-		 * Mark the device area as "shared device"
-		 */
-		mem_types[MT_DEVICE].prot_sect |= PMD_SECT_BUFFERED;
-
 #ifdef CONFIG_SMP
 		/*
 		 * Mark memory with the "shared" attribute for SMP systems
@@ -360,9 +400,6 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_LOW_VECTORS].prot_pte |= vecs_pgprot;
 	mem_types[MT_HIGH_VECTORS].prot_pte |= vecs_pgprot;
 
-	if (cpu_arch < CPU_ARCH_ARMv5)
-		mem_types[MT_MINICLEAN].prot_sect &= ~PMD_SECT_TEX(1);
-
 	pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
 	pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
 				 L_PTE_DIRTY | L_PTE_WRITE |
@@ -387,6 +424,22 @@ static void __init build_mem_type_table(void)
 
 	for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 		struct mem_type *t = &mem_types[i];
+		const char *s;
+#define T(n)	if (i == (n)) s = #n;
+		s = "???";
+		T(MT_DEVICE);
+		T(MT_DEVICE_NONSHARED);
+		T(MT_DEVICE_CACHED);
+		T(MT_DEVICE_WC);
+		T(MT_CACHECLEAN);
+		T(MT_MINICLEAN);
+		T(MT_LOW_VECTORS);
+		T(MT_HIGH_VECTORS);
+		T(MT_MEMORY);
+		T(MT_ROM);
+		printk(KERN_INFO "%-19s: DOM=%#3x S=%#010x L1=%#010x P=%#010x\n",
+			s, t->domain, t->prot_sect, t->prot_l1, t->prot_pte);
+
 		if (t->prot_l1)
 			t->prot_l1 |= PMD_DOMAIN(t->domain);
 		if (t->prot_sect)
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 07f82db..f1d158f 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -192,11 +192,11 @@ __v7_setup:
 	mov	pc, lr				@ return to head.S:__ret
 ENDPROC(__v7_setup)
 
-	/*
-	 *         V X F   I D LR
-	 * .... ...E PUI. .T.T 4RVI ZFRS BLDP WCAM
-	 * rrrr rrrx xxx0 0101 xxxx xxxx x111 xxxx < forced
-	 *         0 110       0011 1.00 .111 1101 < we want
+	/*   AT
+	 *  TFR   EV X F   I D LR
+	 * .EEE ..EE PUI. .T.T 4RVI ZFRS BLDP WCAM
+	 * rxxx rrxx xxx0 0101 xxxx xxxx x111 xxxx < forced
+	 *    1    0 110       0011 1.00 .111 1101 < we want
 	 */
 	.type	v7_crval, #object
 v7_crval:

--QXO0/MSS4VvK6f+D--
