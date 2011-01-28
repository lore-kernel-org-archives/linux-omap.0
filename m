From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 11/14] ARM: v6k: use CPU domain feature if we include
 support for arch < ARMv6K
Date: Fri, 28 Jan 2011 15:11:05 +0000
Message-ID: <1296227465.1799.95.camel@e102109-lin.cambridge.arm.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	 <E1Peuh2-0003Sx-5e@rmk-PC.arm.linux.org.uk>
	 <AANLkTimN8Gn5a-k4ai7EhMGpqbj_u4Y8fHvUh_actzd+@mail.gmail.com>
	 <20110127185935.GA1651@n2100.arm.linux.org.uk>
	 <1296207966.1799.10.camel@e102109-lin.cambridge.arm.com>
	 <20110128095953.GA13005@n2100.arm.linux.org.uk>
	 <1296211611.1799.15.camel@e102109-lin.cambridge.arm.com>
	 <20110128110629.GB13005@n2100.arm.linux.org.uk>
	 <1296217518.1799.59.camel@e102109-lin.cambridge.arm.com>
	 <20110128132134.GD13005@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([94.185.240.25]:46215 "HELO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754642Ab1A1PLQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 10:11:16 -0500
In-Reply-To: <20110128132134.GD13005@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 2011-01-28 at 13:21 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 28, 2011 at 12:25:18PM +0000, Catalin Marinas wrote:
> > With your latest patches, do we use the TLS emulation on ARMv7 (UP) if
> > v6 is compiled in? If that's the case, we may have a problem - I talked
> > to the toolchain guys and it looks like code optimised for ARMv7 reads
> > the TLS register directly without going through the kuser helper. So you
> > may have people taking an Ubuntu filesystem (v7 only) and a pre-built
> > OMAP image with TLS emulation even on Cortex-A8 and things won't work as
> > expected.
> 
> You're really making a mountain out of TLS.

Not really, just asking for clarification as I haven't checked all your
patches recently.

> If we have a v6+v6k+v7 kernel, then the way the kernel TLS code is built,
> we will use the TLS register if that's available on the hardware.  If it
> isn't, we will write the TLS value directly to virtual 0xffff0ffc.
> 
> So, a kernel built for v6+v6k+v7, when run on v7, will set the hardware
> TLS register, and your v7 optimized binaries which access the TLS register
> directly will work.  Same for v6k.

Great.

> What we're discussing has nothing at all to do with getting v7 binaries
> running on v6 hardware.  That's just not going to happen.

I wasn't suggesting this. That's not easily possible.

> > On ARMv6 with domains enabled, cpu_v6_set_pte_ext() maps the vectors
> > page as kernel R/W. The cpu_v7_set_pte_ext() could map it as kernel RO
> > and use the TLS register. The only other place where this matters on
> > ARMv7 is early_trap_init() but it's easily fixable on this architecture.
> 
> That's pointless.  There's no "could map the vectors page" - set_pte_ext()
> doesn't know what's the vectors page and what isn't.  It's about how
> set_pte_ext() maps pages which are marked with just L_PTE_USER.

What I meant is that we leave cpu_v6_set_pte_ext as it is (with R/W
kernel access for RO user pages) and always mark such pages kernel RO in
cpu_v7_set_pte_ext. See patch at the end of this email.

> > > 1. SWP emulation requires domain support turned off
> >
> > Not necessarily - it requires RO user pages to be kernel RO (though this
> > feature came with the domains removal patch).
> 
> Yes it does because without domains, we need user pages to be kernel
> read-only, which also makes the vectors page kernel read-only.

But even with domains we can make user pages kernel RO for ARMv7 only.

> The only use which SWP_EMULATE gets us then is detecting userspace
> programs which use the SWP instruction - and that can only happen on
> a V7-only or v6k+v7 targetted kernel.

In some MP hardware configurations, SWP may not ensure atomicity across
all the CPUs. Exclusives would ensure this behaviour.

The patch below allows domains to be enabled on ARMv7 and also use SWP
emulation (tested on VE + A9 with domains enabled):


diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index ee57640..6e0b349 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -758,17 +758,21 @@ static void __init kuser_get_tls_init(unsigned long vectors)
 
 void __init early_trap_init(void)
 {
-#if defined(CONFIG_CPU_USE_DOMAINS)
-	unsigned long vectors = CONFIG_VECTORS_BASE;
-#else
-	unsigned long vectors = (unsigned long)vectors_page;
-#endif
+	unsigned long vectors;
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
 
 	/*
+	 * On ARMv7, user RO pages are mapped as kernel RO.
+	 */
+	if (cpu_architecture() >= 7)
+		vectors = (unsigned long)vectors_page;
+	else
+		vectors = CONFIG_VECTORS_BASE;
+
+	/*
 	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
 	 * into the vector page, mapped at 0xffff0000, and ensure these
 	 * are visible to the instruction stream.
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0c1172b..5f51592 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -146,11 +146,6 @@ ENTRY(cpu_v7_set_pte_ext)
 
 	tst	r1, #L_PTE_USER
 	orrne	r3, r3, #PTE_EXT_AP1
-#ifdef CONFIG_CPU_USE_DOMAINS
-	@ allow kernel read/write access to read-only user pages
-	tstne	r3, #PTE_EXT_APX
-	bicne	r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
-#endif
 
 	tst	r1, #L_PTE_XN
 	orrne	r3, r3, #PTE_EXT_XN



-- 
Catalin


