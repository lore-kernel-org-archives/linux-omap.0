From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
Date: Fri, 8 Jul 2011 12:04:22 +0200
Message-ID: <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.eu ([217.6.246.34]:42549 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab1GHKEd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jul 2011 06:04:33 -0400
In-Reply-To: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>


Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 19d5891..c6a2d43 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -323,6 +323,11 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE
 
+config MACH_PCM049
+	bool "OMAP4 based phyCORE OMAP4"
+	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBS
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b148077..e81b594 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
 					   hsmmc.o \
 					   omap_phy_internal.o
 
+obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
+					   hsmmc.o \
+					   omap_phy_internal.o
+
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
 					   omap_phy_internal.o \
 
-- 
1.7.0.4

