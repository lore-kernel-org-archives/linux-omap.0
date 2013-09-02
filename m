From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 4/6] ARM: OMAP2+: AM43x/AM335x: have reset controller
Date: Mon, 2 Sep 2013 19:50:28 +0530
Message-ID: <54ef6f33272dfe2bbf3596da05579a7305fb0cff.1378129416.git.afzal@ti.com>
References: <cover.1378129416.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1378129416.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

AM43x, AM335x have reset block as part of prcm, let reset driver be
usable with these SoC's.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3eed000..fa28d1d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -72,6 +72,7 @@ config SOC_AM33XX
 	select CPU_V7
 	select MULTI_IRQ_HANDLER
 	select COMMON_CLK
+	select ARCH_HAS_RESET_CONTROLLER
 
 config SOC_AM43XX
 	bool "TI AM43x"
@@ -82,6 +83,7 @@ config SOC_AM43XX
 	select ARM_GIC
 	select COMMON_CLK
 	select MACH_OMAP_GENERIC
+	select ARCH_HAS_RESET_CONTROLLER
 
 config ARCH_OMAP2PLUS
 	bool
-- 
1.8.3.4
