From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] omap3: give off mode enable a more prominent place
Date: Sat,  2 Feb 2019 06:58:27 +0100
Message-ID: <20190202055827.12956-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@armlinux.org.uk, khilman@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Enabling off mode was only reachable deeply hidden
in the debugfs. As powersaving is an important feature,
move the option out of its shady place.
The debugfs file can still be used to override the default.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/Kconfig    | 8 ++++++++
 arch/arm/mach-omap2/pm-debug.c | 4 ++++
 arch/arm/mach-omap2/pm.h       | 4 ++++
 arch/arm/mach-omap2/pm34xx.c   | 7 ++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5e33d1a90664..8305b94c0e57 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -231,6 +231,14 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+config OMAP3_PM_OFFMODE
+	bool "Enable Off-Mode"
+	depends on ARCH_OMAP3
+	help
+	  Enables deeper power-saving states of the SOC, so that hwmods
+	  do not only go to RET state but to OFF state. This option
+	  is overridable via debugfs.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5a8839203958..3474027112c2 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,7 +37,11 @@
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 
+#ifdef CONFIG_OMAP3_PM_OFFMODE
+u32 enable_off_mode = 1;
+#else
 u32 enable_off_mode;
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c73776b82348..cd5f98f4d28b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -55,8 +55,12 @@ extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 #ifdef CONFIG_PM_DEBUG
 extern u32 enable_off_mode;
 #else
+#ifdef CONFIG_OMAP3_PM_OFFMODE
+#define enable_off_mode 1
+#else
 #define enable_off_mode 0
 #endif
+#endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1a90050361f1..d7d83a09013f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -416,7 +416,12 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+
+	if (IS_ENABLED(CONFIG_OMAP3_PM_OFFMODE))
+		pwrst->next_state = PWRDM_POWER_OFF;
+	else
+		pwrst->next_state = PWRDM_POWER_RET;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
-- 
2.11.0
