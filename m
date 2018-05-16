From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/4] omap2: powerdomain: Inroduce cpu_pm notifiers for context
 save/restore
Date: Wed, 16 May 2018 20:47:01 +0530
Message-ID: <1526483821-25585-5-git-send-email-j-keerthy@ti.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
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

Inroduce cpu_pm notifiers for context save/restore. This is
needed for am43xx family during rtc only mode with ddr in
self-refresh.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index b97b308..1a0f69c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -14,6 +14,7 @@
  */
 #undef DEBUG
 
+#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/list.h>
@@ -39,6 +40,9 @@
 
 #define PWRDM_TRACE_STATES_FLAG	(1<<31)
 
+void pwrdms_save_context(void);
+void pwrdms_restore_context(void);
+
 enum {
 	PWRDM_STATE_NOW = 0,
 	PWRDM_STATE_PREV,
@@ -333,6 +337,22 @@ int pwrdm_register_pwrdms(struct powerdomain **ps)
 	return 0;
 }
 
+static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (enable_off_mode)
+			pwrdms_save_context();
+		break;
+	case CPU_CLUSTER_PM_EXIT:
+		if (enable_off_mode)
+			pwrdms_restore_context();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 /**
  * pwrdm_complete_init - set up the powerdomain layer
  *
@@ -347,6 +367,7 @@ int pwrdm_register_pwrdms(struct powerdomain **ps)
 int pwrdm_complete_init(void)
 {
 	struct powerdomain *temp_p;
+	static struct notifier_block nb;
 
 	if (list_empty(&pwrdm_list))
 		return -EACCES;
@@ -354,6 +375,12 @@ int pwrdm_complete_init(void)
 	list_for_each_entry(temp_p, &pwrdm_list, node)
 		pwrdm_set_next_pwrst(temp_p, PWRDM_POWER_ON);
 
+	/* Only AM43XX can lose pwrdm context during rtc-ddr suspend */
+	if (soc_is_am43xx()) {
+		nb.notifier_call = cpu_notifier;
+		cpu_pm_register_notifier(&nb);
+	}
+
 	return 0;
 }
 
-- 
1.9.1
