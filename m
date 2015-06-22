From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/6] ARM: OMAP4+: PRM: Add AM437x specific data
Date: Mon, 22 Jun 2015 11:52:55 +0530
Message-ID: <1434954176-9605-6-git-send-email-j-keerthy@ti.com>
References: <1434954176-9605-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434954176-9605-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: galak@codeaurora.org, t-kristo@ti.com, pawel.moll@arm.com, linux-kernel@vger.kernel.org, paul@pwsan.com, bcousson@baylibre.com, linux-clk@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

The register offsets for some of the PRM Registers are different
hence populating the differing fields.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 20b547a..686bcab 100644
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
@@ -723,6 +724,14 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 
 	omap4_prminst_set_prm_dev_inst(data->device_inst_offset);
 
+	/* Add AM437X specific differences */
+	if (of_device_is_compatible(data->np, "ti,am4-prcm")) {
+		omap4_prcm_irq_setup.nr_irqs = 1;
+		omap4_prcm_irq_setup.pm_ctrl = AM43XX_PRM_IO_PMCTRL_OFFSET;
+		omap4_prcm_irq_setup.ack[0] = AM43XX_PRM_IRQSTATUS_MPU_OFFSET;
+		omap4_prcm_irq_setup.mask[0] = AM43XX_PRM_IRQENABLE_MPU_OFFSET;
+	}
+
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-- 
1.9.1
