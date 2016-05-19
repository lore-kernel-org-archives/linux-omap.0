From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: OMAP2: Enable Errata 430973 for OMAP3
Date: Thu, 19 May 2016 18:20:17 -0500
Message-ID: <1463700017-18527-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony <tony@atomide.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable Erratum 430973 similar to commit 5c86c5339c56 ("ARM:
omap2plus_defconfig: Enable ARM erratum 430973 for omap3") - Since
multiple defconfigs can exist from various points of view (multi_v7,
omap2plus etc.. it is always better to enable the erratum from the
Kconfig selection point of view so that downstream kernels dont have
to rediscover this all over again.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Note: If this approach is fine, we should probably search and fixup
errata enablement we have done directly in omap2plus_defconfig.

 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 415a0bd0cda6..e0c796060fa2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP3
 	select PM_OPP if PM
 	select PM if CPU_IDLE
 	select SOC_HAS_OMAP2_SDRC
+	select ARM_ERRATA_430973
 
 config ARCH_OMAP4
 	bool "TI OMAP4"
-- 
2.8.0
