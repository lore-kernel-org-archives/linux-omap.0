From: Afzal Mohammed <afzal@ti.com>
Subject: [RFC 5/8] ARM: OMAP2+: am43: Kconfig
Date: Mon, 18 Feb 2013 12:00:32 +0530
Message-ID: <5951ba90110b97fb494743e1aedf26aaa92b97a9.1361166003.git.afzal@ti.com>
References: <cover.1361166003.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1361166003.git.afzal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

Add Kconfig option for AM43 family of SoC's, these are ARM Cortex A9
based (SMP configuration with 1 core).

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 49ac3df..683fbaa 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -141,6 +141,17 @@ config SOC_AM33XX
 	select MULTI_IRQ_HANDLER
 	select COMMON_CLK
 
+config SOC_AM43
+	bool "TI AM43"
+	depends on ARCH_OMAP2PLUS
+	default y
+	select CPU_V7
+	select HAVE_SMP
+	select LOCAL_TIMERS if SMP
+	select MULTI_IRQ_HANDLER
+	select ARM_GIC
+	select COMMON_CLK
+
 config OMAP_PACKAGE_ZAF
        bool
 
-- 
1.7.12
