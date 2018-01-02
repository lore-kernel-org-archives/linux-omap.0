From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 09/10] arm: omap: pdata-quirks: Remove unused timer pdata
Date: Tue, 2 Jan 2018 15:39:58 +0530
Message-ID: <1514887799-24605-10-git-send-email-j-keerthy@ti.com>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: ladis@linux-mips.org, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Remove unused timer pdata.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index ad9df86..e7d7fc7 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -24,10 +24,8 @@
 #include <linux/platform_data/hsmmc-omap.h>
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/wkup_m3.h>
-#include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_data/media/ir-rx51.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <clocksource/dmtimer.h>
 
 #include "common.h"
 #include "common-board-devices.h"
@@ -477,33 +475,6 @@ void omap_auxdata_legacy_init(struct device *dev)
 	dev->platform_data = &twl_gpio_auxdata;
 }
 
-/* Dual mode timer PWM callbacks platdata */
-#if IS_ENABLED(CONFIG_OMAP_DM_TIMER)
-static struct pwm_omap_dmtimer_pdata pwm_dmtimer_pdata = {
-	.request_by_node = omap_dm_timer_request_by_node,
-	.request_specific = omap_dm_timer_request_specific,
-	.request = omap_dm_timer_request,
-	.set_source = omap_dm_timer_set_source,
-	.get_irq = omap_dm_timer_get_irq,
-	.set_int_enable = omap_dm_timer_set_int_enable,
-	.set_int_disable = omap_dm_timer_set_int_disable,
-	.free = omap_dm_timer_free,
-	.enable = omap_dm_timer_enable,
-	.disable = omap_dm_timer_disable,
-	.get_fclk = omap_dm_timer_get_fclk,
-	.start = omap_dm_timer_start,
-	.stop = omap_dm_timer_stop,
-	.set_load = omap_dm_timer_set_load,
-	.set_match = omap_dm_timer_set_match,
-	.set_pwm = omap_dm_timer_set_pwm,
-	.set_prescaler = omap_dm_timer_set_prescaler,
-	.read_counter = omap_dm_timer_read_counter,
-	.write_counter = omap_dm_timer_write_counter,
-	.read_status = omap_dm_timer_read_status,
-	.write_status = omap_dm_timer_write_status,
-};
-#endif
-
 static struct ir_rx51_platform_data __maybe_unused rx51_ir_data = {
 	.set_max_mpu_wakeup_lat = omap_pm_set_max_mpu_wakeup_lat,
 };
@@ -572,9 +543,6 @@ static void __init omap3_mcbsp_init(void) {}
 	OF_DEV_AUXDATA("ti,am4372-wkup-m3", 0x44d00000, "44d00000.wkup_m3",
 		       &wkup_m3_data),
 #endif
-#if IS_ENABLED(CONFIG_OMAP_DM_TIMER)
-	OF_DEV_AUXDATA("ti,omap-dmtimer-pwm", 0, NULL, &pwm_dmtimer_pdata),
-#endif
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 	OF_DEV_AUXDATA("ti,omap4-iommu", 0x4a066000, "4a066000.mmu",
 		       &omap4_iommu_pdata),
-- 
1.9.1
