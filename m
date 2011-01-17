From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 12/14] ARM: v6k: do not disable CPU_32v6K based on platform selection
Date: Mon, 17 Jan 2011 19:25:04 +0000
Message-ID: <E1PeuhM-0003T1-Js@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51099 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1AQTZP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:25:15 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

CPU_32v6K controls whether we use the ARMv6K extension instructions in
the kernel, and in some places whether we use SMP-safe code sequences
(eg, bitops.)

MX3 prevents the selection of this option to ensure that it is not
enabled for their CPU, which is ARMv6 only.  Now that we've split the
CPU_V6 option, V6K support won't be offered for MX3 anymore.

OMAP prevents the selection of this option in an attempt to produce a
kernel which runs on architectures from ARMv6 to ARMv7 MPCore.  We now
achieve this in a different way (see the previous patches).

As such, we no longer need to offer this as a configuration option to
the user.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 29215f5..ca1238b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -405,7 +405,7 @@ config CPU_V6
 config CPU_V6K
 	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
 	select CPU_32v6
-	select CPU_32v6K if !ARCH_OMAP2
+	select CPU_32v6K
 	select CPU_ABRT_EV6
 	select CPU_PABRT_V6
 	select CPU_CACHE_V6
@@ -418,7 +418,7 @@ config CPU_V6K
 # ARMv7
 config CPU_V7
 	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
-	select CPU_32v6K if !ARCH_OMAP2
+	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
 	select CPU_PABRT_V7
@@ -461,15 +461,7 @@ config CPU_32v6
 	select CPU_USE_DOMAINS if CPU_V6 && MMU
 
 config CPU_32v6K
-	bool "Support ARM V6K processor extensions" if !SMP
-	depends on CPU_V6 || CPU_V6K || CPU_V7
-	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
-	help
-	  Say Y here if your ARMv6 processor supports the 'K' extension.
-	  This enables the kernel to use some instructions not present
-	  on previous processors, and as such a kernel build with this
-	  enabled will not boot on processors with do not support these
-	  instructions.
+	bool
 
 config CPU_32v7
 	bool
-- 
1.6.2.5

