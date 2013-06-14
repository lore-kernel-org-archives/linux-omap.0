From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: OMAP5: Fix omap5 standalone build break
Date: Fri, 14 Jun 2013 14:41:46 +0530
Message-ID: <1371201107-20929-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41005 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024Ab3FNJMa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jun 2013 05:12:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Building omap5 standalone results in the below errors..

arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enable'
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_core_count'

Fix this by adding the missing select for HAVE_ARM_SCU for SOC_OMAP5

Reported-by: Pekon Gupta <pekon@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..81690a2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,6 +109,7 @@ config SOC_OMAP5
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
+	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
-- 
1.7.9.5

