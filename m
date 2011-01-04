From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/5] omap2plus: voltage: Trivial warning fix 'no return statement'
Date: Tue,  4 Jan 2011 23:56:14 +0530
Message-ID: <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38327 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab1ADS0k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 13:26:40 -0500
In-Reply-To: <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Fix below build warnings

 CC      arch/arm/mach-omap2/common.o
  CC      arch/arm/mach-omap2/gpio.o
In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
                 from arch/arm/mach-omap2/gpio.c:25:
arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_register_pmic':
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return statement in function returning non-void
  CC      arch/arm/mach-omap2/dma.o
In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
                 from arch/arm/mach-omap2/dma.c:32:
arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_register_pmic':
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return statement in function returning non-void
  CC      arch/arm/mach-omap2/wd_timer.o
In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
                 from arch/arm/mach-omap2/wd_timer.c:15:
arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_register_pmic':
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return statement in function returning non-void
  CC      arch/arm/mach-omap2/prm44xx.o
  CC      arch/arm/mach-omap2/omap_hwmod.o
In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
                 from arch/arm/mach-omap2/omap_hwmod.c:145:
arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_register_pmic':
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return statement in function returning non-void
  CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
In file included from arch/arm/plat-omap/include/plat/omap_hwmod.h:38,
                 from arch/arm/mach-omap2/omap_hwmod_common_data.c:20:
arch/arm/plat-omap/include/plat/voltage.h: In function 'omap_voltage_register_pmic':
arch/arm/plat-omap/include/plat/voltage.h:137: warning: no return statement in function returning non-void

The error is reported when omap2plus_defconfig built with CONFIG_PM disabled

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 0ff1233..710f4ea 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -134,7 +134,10 @@ void omap_change_voltscale_method(struct voltagedomain *voltdm,
 int omap_voltage_late_init(void);
 #else
 static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-		struct omap_volt_pmic_info *pmic_info) {}
+		struct omap_volt_pmic_info *pmic_info)
+{
+	return 0;
+}
 static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method) {}
 static inline int omap_voltage_late_init(void)
-- 
1.6.0.4

