From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 05/14] ARM: v6k: Realview EB 11MPCore and PB11MPCore use V6K architecture CPUs
Date: Mon, 17 Jan 2011 19:22:41 +0000
Message-ID: <E1Peuf3-0003SZ-Hf@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51087 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1AQTXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:23:02 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Make Realview EB ARM11MPCore and PB11MPCore select the new V6K CPU
option.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-realview/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index b4575ae..e219459 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -17,7 +17,7 @@ config REALVIEW_EB_A9MP
 config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
-	select CPU_V6
+	select CPU_V6K
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
@@ -33,7 +33,7 @@ config REALVIEW_EB_ARM11MP_REVB
 
 config MACH_REALVIEW_PB11MP
 	bool "Support RealView/PB11MPCore platform"
-	select CPU_V6
+	select CPU_V6K
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
@@ -42,6 +42,7 @@ config MACH_REALVIEW_PB11MP
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
 	  support for PCI-E and Compact Flash.
 
+# ARMv6 CPU without K extensions, but does have the new exclusive ops
 config MACH_REALVIEW_PB1176
 	bool "Support RealView/PB1176 platform"
 	select CPU_V6
-- 
1.6.2.5

