From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] omap: Fix 44xx compile
Date: Thu, 24 Sep 2009 16:35:29 -0700
Message-ID: <20090924233529.6065.34357.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49363 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZIXXf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:35:26 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Looks like these patches were not tested that well..

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/cm4xxx.c |   17 ++---------------
 arch/arm/mach-omap2/io.c     |    4 ++--
 arch/arm/mach-omap2/serial.c |    2 +-
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/cm4xxx.c b/arch/arm/mach-omap2/cm4xxx.c
index e4ebd6d..4af76bb 100644
--- a/arch/arm/mach-omap2/cm4xxx.c
+++ b/arch/arm/mach-omap2/cm4xxx.c
@@ -22,7 +22,6 @@
 #include <asm/atomic.h>
 
 #include "cm.h"
-#include "cm-regbits-4xxx.h"
 
 /* XXX move this to cm.h */
 /* MAX_MODULE_READY_TIME: max milliseconds for module to leave idle */
@@ -50,19 +49,7 @@
  */
 int omap4_cm_wait_idlest_ready(u32 prcm_mod, u8 prcm_dev_offs)
 {
-	int i = 0;
-	u8 cm_id;
-	u16 prcm_mod_offs;
-	u32 mask = OMAP4_PRCM_CM_CLKCTRL_IDLEST_MASK;
-
-	cm_id = prcm_mod >> OMAP4_PRCM_MOD_CM_ID_SHIFT;
-	prcm_mod_offs = prcm_mod & OMAP4_PRCM_MOD_OFFS_MASK;
-
-	while (((omap4_cm_read_mod_reg(cm_id, prcm_mod_offs, prcm_dev_offs,
-				       OMAP4_CM_CLKCTRL_DREG) & mask) != 0) &&
-	       (i++ < MAX_MODULE_READY_TIME))
-		udelay(1);
-
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+	/* FIXME: Add clock manager related code */
+	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 7574b6f..e3a3bad 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -294,10 +294,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	else if (cpu_is_omap34xx())
 		hwmods = omap34xx_hwmods;
 
-	omap_hwmod_init(hwmods);
-	omap2_mux_init();
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
+	omap_hwmod_init(hwmods);
+	omap2_mux_init();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index faada9f..ae21868 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -579,7 +579,7 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
 	{
 		.pdev = {
 			.name			= "serial8250",
-			.id			= 3
+			.id			= 3,
 			.dev			= {
 				.platform_data	= serial_platform_data3,
 			},

