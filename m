From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] ARM: mach-omap2: prm44xx: Inroduce cpu_pm notifiers for
 context save/restore
Date: Fri, 18 May 2018 14:10:22 +0530
Message-ID: <1526632822-26049-2-git-send-email-j-keerthy@ti.com>
References: <1526632822-26049-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526632822-26049-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Inroduce cpu_pm notifiers for context save/restore. This will be
needed for am43xx family in case of rtc only mode with ddr in
self-refresh.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 0a4aa90..5478c71 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -30,6 +31,7 @@
 #include "prcm44xx.h"
 #include "prminst44xx.h"
 #include "powerdomain.h"
+#include "pm.h"
 
 /* Static data */
 
@@ -718,6 +720,22 @@ void prm_restore_context(void)
 				 omap4_prcm_irq_setup.pm_ctrl);
 }
 
+static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (enable_off_mode)
+			prm_save_context();
+		break;
+	case CPU_CLUSTER_PM_EXIT:
+		if (enable_off_mode)
+			prm_restore_context();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 /*
  * XXX document
  */
@@ -738,6 +756,7 @@ void prm_restore_context(void)
 
 int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 {
+	static struct notifier_block nb;
 	omap_prm_base_init();
 
 	prm_init_data = data;
@@ -759,6 +778,12 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 		omap4_prcm_irq_setup.mask = AM43XX_PRM_IRQENABLE_MPU_OFFSET;
 	}
 
+	/* Only AM43XX can lose prm context during rtc-ddr suspend */
+	if (soc_is_am43xx()) {
+		nb.notifier_call = cpu_notifier;
+		cpu_pm_register_notifier(&nb);
+	}
+
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-- 
1.9.1
