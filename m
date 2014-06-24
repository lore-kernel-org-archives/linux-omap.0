From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: create dsp device only on OMAP3 SoCs
Date: Tue, 24 Jun 2014 00:24:27 -0500
Message-ID: <1403587467-59876-4-git-send-email-s-anna@ti.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55501 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbaFXFZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 01:25:20 -0400
In-Reply-To: <1403587467-59876-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The DSP platform device for TI DSP/Bridge is currently
created unconditionally whenever CONFIG_TIDSPBRIDGE is
enabled. This device should only be created on OMAP34xx/
OMAP36xx SoCs, and not for other OMAP3 derived SoCs or when
booting multi-arch images on other SoCs. So, add a check for
the SoC family both before creating the device and allocating
the carveout memory for the device.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/dsp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index b8208b4..f7492df 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -29,6 +29,7 @@
 #ifdef CONFIG_TIDSPBRIDGE_DVFS
 #include "omap-pm.h"
 #endif
+#include "soc.h"
 
 #include <linux/platform_data/dsp-omap.h>
 
@@ -59,6 +60,9 @@ void __init omap_dsp_reserve_sdram_memblock(void)
 	phys_addr_t size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
 	phys_addr_t paddr;
 
+	if (!cpu_is_omap34xx())
+		return;
+
 	if (!size)
 		return;
 
@@ -83,6 +87,9 @@ static int __init omap_dsp_init(void)
 	int err = -ENOMEM;
 	struct omap_dsp_platform_data *pdata = &omap_dsp_pdata;
 
+	if (!cpu_is_omap34xx())
+		return 0;
+
 	pdata->phys_mempool_base = omap_dsp_get_mempool_base();
 
 	if (pdata->phys_mempool_base) {
@@ -115,6 +122,9 @@ module_init(omap_dsp_init);
 
 static void __exit omap_dsp_exit(void)
 {
+	if (!cpu_is_omap34xx())
+		return;
+
 	platform_device_unregister(omap_dsp_pdev);
 }
 module_exit(omap_dsp_exit);
-- 
2.0.0

