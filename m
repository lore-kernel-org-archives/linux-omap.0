From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 6/6] ARM: OMAP2+: Don't force select OMAP_GPMC
Date: Thu,  9 Jun 2016 12:02:57 -0500
Message-ID: <1465491777-20033-7-git-send-email-fcooper@ti.com>
References: <1465491777-20033-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465491777-20033-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, boris.brezillon@free-electrons.com, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP_GPMC requires CONFIG_MEMORY to be enabled. However, by forcing
OMAP_GPMC to be selected dependencies are ignored. This is a problem
since it means OMAP_GPMC is always enabled even when it shouldn't be.

By avoiding this force selection it insures that OMAP_GPMC is only
enabled when its dependencies are met.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0517f0c..dcbb4bd 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -95,7 +95,6 @@ config ARCH_OMAP2PLUS
 	select MEMORY
 	select MFD_SYSCON
 	select OMAP_DM_TIMER
-	select OMAP_GPMC
 	select PINCTRL
 	select SOC_BUS
 	select OMAP_IRQCHIP
-- 
2.7.0
