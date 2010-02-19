From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and CPU_V7
Date: Thu, 18 Feb 2010 16:27:48 -0800
Message-ID: <20100219002748.GB21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56481 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0BSA07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 19:26:59 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

Here's one more patch for booting CPU_V6 and CPU_V7 omaps
with the same kernel binary. This is needed to boot to
user space, earlier I was just checking for "Mounted root".

Now I'm wondering if some of these should be done as

default y if CPU_V7 && !CPU_32v6K

or 

default y if CPU_V7 && !CPU_V6

instead to make them more generic? This is, after the
earlier patch selecting CPU_32v6K if !ARCH_OMAP2.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 18 Feb 2010 13:22:58 -0800
Subject: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and CPU_V7

To mount root, we need to disable VFPv3, HAS_TLS_REG, and
set ARM_L1_CACHE_SHIFT=5.

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

The ARM_L1_CACHE_SHIFT most likely will cause issues
too if not set to 5.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 554cb9c..89dba0b 100644
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
index 4c2e90d..800f0ce 100644
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
@@ -779,5 +779,5 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
+	default 6 if (ARCH_OMAP3 || ARCH_S5PC1XX) && !ARCH_OMAP2
 	default 5
