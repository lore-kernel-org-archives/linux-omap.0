From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and
 CPU_V7
Date: Fri, 19 Feb 2010 10:03:32 -0800
Message-ID: <20100219180331.GC21755@atomide.com>
References: <20100219002748.GB21755@atomide.com>
 <20100219083556.GB19649@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Md/poaVZ8hnGTzuv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64279 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab0BSSCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 13:02:54 -0500
Content-Disposition: inline
In-Reply-To: <20100219083556.GB19649@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100219 00:33]:
> On Thu, Feb 18, 2010 at 04:27:48PM -0800, Tony Lindgren wrote:
> > @@ -779,5 +779,5 @@ config CACHE_XSC3L2
> >  
> >  config ARM_L1_CACHE_SHIFT
> >  	int
> > -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> > +	default 6 if (ARCH_OMAP3 || ARCH_S5PC1XX) && !ARCH_OMAP2
> >  	default 5
> 
> This one is definitely wrong.  Setting the L1 cache line size larger
> than it actually is should be safe; setting it smaller is definitely
> unsafe.

OK dropped that part, updated patch below. Maybe the VFPv3
code can be fixed to boot on earlier hardware too.

So I guess ARM_L1_CACHE_SHIFT should be only used for alignment, and
not for for cache operations?

If so, then what have in arch/arm/plat-omap/iommu.c seems buggy:

static void flush_iopgd_range(u32 *first, u32 *last)
{
	/* FIXME: L2 cache should be taken care of if it exists */
	do {
		asm("mcr	p15, 0, %0, c7, c10, 1 @ flush_pgd"
		    : : "r" (first));
		first += L1_CACHE_BYTES / sizeof(*first);
	} while (first <= last);
}

It seems that this code should use the real cache line size instead to
avoid every other line not to flush if ARM_L1_CACHE_SHIFT is set larger
than it is.

Regards,

Tony

--Md/poaVZ8hnGTzuv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="v6-v7-mount-root-v2.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 18 Feb 2010 16:28:26 -0800
Subject: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and CPU_V7

To mount root, we need to disable VFPv3 and HAS_TLS_REG.

Otherwise we'll get something like this for CPUv3:

Freeing init memory: 184K
Internal error: Oops - undefined instruction: 0 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc8-07824-gf2e1d91-dirty #36)
PC is at no_old_VFP_process+0x8/0x3c
LR is at __und_usr_unknown+0x0/0x14
...

Or the system just hangs if HAS_TLS_REG is set.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 184a6bd..7b93898 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1498,7 +1498,7 @@ config VFP
 config VFPv3
 	bool
 	depends on VFP
-	default y if CPU_V7
+	default y if CPU_V7 && !ARCH_OMAP2
 
 config NEON
 	bool "Advanced SIMD (NEON) Extension support"
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 4c2e90d..65f5ebd 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -718,7 +718,7 @@ config TLS_REG_EMUL
 config HAS_TLS_REG
 	bool
 	depends on !TLS_REG_EMUL
-	default y if SMP || CPU_32v7
+	default y if (SMP || CPU_32v7) && !ARCH_OMAP2
 	help
 	  This selects support for the CP15 thread register.
 	  It is defined to be available on some ARMv6 processors (including

--Md/poaVZ8hnGTzuv--
