From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/14] ARM: v6k: Dove platforms use V6K architecture CPUs
Date: Mon, 17 Jan 2011 19:23:01 +0000
Message-ID: <E1PeufN-0003Sd-W2@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51101 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab1AQTZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:25:34 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Make Dove platforms select the new V6K CPU option.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-dove/Kconfig |    4 +++-
 arch/arm/mm/Kconfig        |    4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index a4ed390..822439a 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -5,12 +5,14 @@ menu "Marvell Dove Implementations"
 config MACH_DOVE_DB
 	bool "Marvell DB-MV88AP510 Development Board"
 	select I2C_BOARDINFO
+	select CPU_V6K
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell DB-MV88AP510 Development Board.
 
- config MACH_CM_A510
+config MACH_CM_A510
 	bool "CompuLab CM-A510 Board"
+	select CPU_V6K
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  CompuLab CM-A510 Board.
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 559e933..22a3f4a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -390,7 +390,7 @@ config CPU_PJ4
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
+	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_PABRT_V6
@@ -403,7 +403,7 @@ config CPU_V6
 
 # ARMv6k
 config CPU_V6K
-	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
+	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
 	select CPU_32v6
 	select CPU_32v6K if !ARCH_OMAP2
 	select CPU_ABRT_EV6
-- 
1.6.2.5

