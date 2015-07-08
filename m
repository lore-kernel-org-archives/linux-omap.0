From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 5/6] ARM: OMAP4+: PRM: Add AM437x specific data
Date: Wed, 8 Jul 2015 11:12:27 +0530
Message-ID: <1436334148-9309-6-git-send-email-j-keerthy@ti.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436334148-9309-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com, paul@pwsan.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The register offsets for some of the PRM Registers are different
hence populating the differing fields.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index f82d89a..311d717 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -18,13 +18,14 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of_irq.h>
-
+#include <linux/of.h>
 
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
 #include "vp.h"
 #include "prm44xx.h"
+#include "prcm43xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prminst44xx.h"
@@ -720,6 +721,14 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 
 	omap4_prminst_set_prm_dev_inst(data->device_inst_offset);
 
+	/* Add AM437X specific differences */
+	if (of_device_is_compatible(data->np, "ti,am4-prcm")) {
+		omap4_prcm_irq_setup.nr_irqs = 1;
+		omap4_prcm_irq_setup.pm_ctrl = AM43XX_PRM_IO_PMCTRL_OFFSET;
+		omap4_prcm_irq_setup.ack = AM43XX_PRM_IRQSTATUS_MPU_OFFSET;
+		omap4_prcm_irq_setup.mask = AM43XX_PRM_IRQENABLE_MPU_OFFSET;
+	}
+
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-- 
1.9.1
