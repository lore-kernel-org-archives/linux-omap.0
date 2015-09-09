From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] ARM: OMAP5: Cleanup options for SoC only build
Date: Wed, 9 Sep 2015 16:18:14 -0500
Message-ID: <1441833494-32450-5-git-send-email-nm@ti.com>
References: <1441833494-32450-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441833494-32450-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

OMAP5 SoC has Cortex-A15 which does not use TWD timer. It uses
ARCH_TIMER instead, clean up unwanted configuration and enable
OMAP_INTERCONNECT and OPP which is necessary for expected functionality
on the SoC.

Reported-by: Carlos Hernandez <ceh@ti.com>
Reported-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 403022a38607..b3a0dff67e3f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,10 +44,11 @@ config SOC_OMAP5
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
-	select HAVE_ARM_TWD if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select ARM_ERRATA_798181 if SMP
+	select OMAP_INTERCONNECT
 	select OMAP_INTERCONNECT_BARRIER
+	select PM_OPP if PM
 
 config SOC_AM33XX
 	bool "TI AM33XX"
-- 
1.7.9.5
