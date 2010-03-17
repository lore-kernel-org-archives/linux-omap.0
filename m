From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] arm: Fix mounting root on omaps with CPU_V6 and CPU_V7
Date: Wed, 17 Mar 2010 10:57:31 -0700
Message-ID: <20100317175731.GE2900@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HTLCc13+3hfAZ6SL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62065 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab0CQR4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 13:56:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Here's an updated version of this patch with more details.

Looks like VFPv3 is only available on V7:

http://www.arm.com/products/processors/technologies/vector-floating-point.php

HAS_TLS reg is only on ARM11 starting with r1p0:

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0211k/Babeihid.html

So that explains why it won't work on omap2420 as it's r0p2.

Regards,

Tony

--HTLCc13+3hfAZ6SL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="v6-v7-no-vfpv3-no-tls.patch"

>From adebf62d18a03ed26ec20f95860976f80690e9f1 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 15 Mar 2010 15:25:43 -0700
Subject: [PATCH] arm: Fix mounting root on omaps with CPU_V6 and CPU_V7

To mount root on omap2420, we need to disable VFPv3 and
HAS_TLS_REG.

VFPv3 is only available on CPU_V7. TLS_REG is only available
on ARM11 starting with r1p0 and later. As omap2420 is r0p2,
it does not have TLS_REG.

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
index d97d893..409ae23 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1549,7 +1549,7 @@ config VFP
 config VFPv3
 	bool
 	depends on VFP
-	default y if CPU_V7
+	default y if CPU_V7 && !CPU_V6
 
 config NEON
 	bool "Advanced SIMD (NEON) Extension support"
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c4ed9f9..ff0c829 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -718,11 +718,11 @@ config TLS_REG_EMUL
 config HAS_TLS_REG
 	bool
 	depends on !TLS_REG_EMUL
-	default y if SMP || CPU_32v7
+	default y if (SMP || CPU_32v7) && !ARCH_OMAP2
 	help
 	  This selects support for the CP15 thread register.
-	  It is defined to be available on some ARMv6 processors (including
-	  all SMP capable ARMv6's) or later processors.  User space may
+	  It is defined to be available on some ARMv6 processors (r1p0 and
+	  later, including all SMP capable ARMv6's).  User space may
 	  assume directly accessing that register and always obtain the
 	  expected value only on ARMv7 and above.
 

--HTLCc13+3hfAZ6SL--
