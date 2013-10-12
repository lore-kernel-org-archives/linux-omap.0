From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 06/11] ARM: OMAP2+: PM: AM43x powerdomain data
Date: Sat, 12 Oct 2013 15:45:54 +0530
Message-ID: <26fe34cbff3f6429426ae533300622bc4ca37140.1381569236.git.afzal@ti.com>
References: <cover.1381569236.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34458 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186Ab3JLKQX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Oct 2013 06:16:23 -0400
In-Reply-To: <cover.1381569236.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Ambresh K <ambresh@ti.com>

From: Ambresh K <ambresh@ti.com>

Add the data file to describe all power domains in AM43x SoC.
OMAP4 powerdomain operations is being reused here.

Signed-off-by: Ambresh K <ambresh@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/powerdomain.h           |   1 +
 arch/arm/mach-omap2/powerdomains43xx_data.c | 136 ++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index baf3d8b..da5a59a 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -257,6 +257,7 @@ extern void am33xx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
 extern void omap54xx_powerdomains_init(void);
 extern void dra7xx_powerdomains_init(void);
+void am43xx_powerdomains_init(void);
 
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
diff --git a/arch/arm/mach-omap2/powerdomains43xx_data.c b/arch/arm/mach-omap2/powerdomains43xx_data.c
new file mode 100644
index 0000000..95fee54
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains43xx_data.c
@@ -0,0 +1,136 @@
+/*
+ * AM43xx Power domains framework
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include "powerdomain.h"
+
+#include "prcm-common.h"
+#include "prcm44xx.h"
+#include "prcm43xx.h"
+
+static struct powerdomain gfx_43xx_pwrdm = {
+	.name		  = "gfx_pwrdm",
+	.voltdm		  = { .name = "core" },
+	.prcm_offs	  = AM43XX_PRM_GFX_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_OFF_ON,
+	.banks		  = 1,
+	.pwrsts_mem_on	= {
+		[0] = PWRSTS_ON,	/* gfx_mem */
+	},
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+};
+
+static struct powerdomain mpu_43xx_pwrdm = {
+	.name		  = "mpu_pwrdm",
+	.voltdm		  = { .name = "mpu" },
+	.prcm_offs	  = AM43XX_PRM_MPU_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.banks		  = 3,
+	.pwrsts_mem_ret	= {
+		[0] = PWRSTS_OFF_RET,	/* mpu_l1 */
+		[1] = PWRSTS_OFF_RET,	/* mpu_l2 */
+		[2] = PWRSTS_OFF_RET,	/* mpu_ram */
+	},
+	.pwrsts_mem_on	= {
+		[0] = PWRSTS_ON,	/* mpu_l1 */
+		[1] = PWRSTS_ON,	/* mpu_l2 */
+		[2] = PWRSTS_ON,	/* mpu_ram */
+	},
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+};
+
+static struct powerdomain rtc_43xx_pwrdm = {
+	.name		  = "rtc_pwrdm",
+	.voltdm		  = { .name = "rtc" },
+	.prcm_offs	  = AM43XX_PRM_RTC_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_ON,
+};
+
+static struct powerdomain wkup_43xx_pwrdm = {
+	.name		  = "wkup_pwrdm",
+	.voltdm		  = { .name = "core" },
+	.prcm_offs	  = AM43XX_PRM_WKUP_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_ON,
+	.banks		  = 1,
+	.pwrsts_mem_on	= {
+		[0] = PWRSTS_ON,	/* debugss_mem */
+	},
+};
+
+static struct powerdomain tamper_43xx_pwrdm = {
+	.name		  = "tamper_pwrdm",
+	.voltdm		  = { .name = "tamper" },
+	.prcm_offs	  = AM43XX_PRM_TAMPER_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_ON,
+};
+
+static struct powerdomain cefuse_43xx_pwrdm = {
+	.name		  = "cefuse_pwrdm",
+	.voltdm		  = { .name = "core" },
+	.prcm_offs	  = AM43XX_PRM_CEFUSE_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_OFF_ON,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+};
+
+static struct powerdomain per_43xx_pwrdm = {
+	.name		  = "per_pwrdm",
+	.voltdm		  = { .name = "core" },
+	.prcm_offs	  = AM43XX_PRM_PER_INST,
+	.prcm_partition	  = AM43XX_PRM_PARTITION,
+	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.banks		  = 4,
+	.pwrsts_mem_ret	= {
+		[0] = PWRSTS_OFF_RET,	/* icss_mem */
+		[1] = PWRSTS_OFF_RET,	/* per_mem */
+		[2] = PWRSTS_OFF_RET,	/* ram1_mem */
+		[3] = PWRSTS_OFF_RET,	/* ram2_mem */
+	},
+	.pwrsts_mem_on	= {
+		[0] = PWRSTS_ON,	/* icss_mem */
+		[1] = PWRSTS_ON,	/* per_mem */
+		[2] = PWRSTS_ON,	/* ram1_mem */
+		[3] = PWRSTS_ON,	/* ram2_mem */
+	},
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+};
+
+static struct powerdomain *powerdomains_am43xx[] __initdata = {
+	&gfx_43xx_pwrdm,
+	&mpu_43xx_pwrdm,
+	&rtc_43xx_pwrdm,
+	&wkup_43xx_pwrdm,
+	&tamper_43xx_pwrdm,
+	&cefuse_43xx_pwrdm,
+	&per_43xx_pwrdm,
+	NULL
+};
+
+static int am43xx_check_vcvp(void)
+{
+	return 0;
+}
+
+void __init am43xx_powerdomains_init(void)
+{
+	omap4_pwrdm_operations.pwrdm_has_voltdm = am43xx_check_vcvp;
+	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_am43xx);
+	pwrdm_complete_init();
+}
-- 
1.8.3.4

