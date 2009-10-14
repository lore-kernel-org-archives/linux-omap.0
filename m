From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 26/27] OMAP3: PM debug: allow runtime toggle of PM features
Date: Wed, 14 Oct 2009 14:58:09 -0700
Message-ID: <1255557490-16787-27-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-23-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-24-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-25-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-26-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-26-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Allow enable/disable of low-power states during idle.  To
enable low-power idle:

   echo 1 > /debug/pm_debug/sleep_while_idle

 to disable:

   echo 0 > /debug/pm_debug/sleep_while_idle

Also allow enable/disable of OFF-mode.  To enable:

   echo 1 > /debug/pm_debug/enable_off_mode

 to disable:

   echo 0 > /debug/pm_debug/enable_off_mode

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |    4 ++++
 arch/arm/mach-omap2/pm34xx.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/serial.c   |    2 --
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index deed1dd..4e05d29 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -527,6 +527,29 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 	return 0;
 }
 
+static int option_get(void *data, u64 *val)
+{
+	u32 *option = data;
+
+	*val = *option;
+
+	return 0;
+}
+
+static int option_set(void *data, u64 val)
+{
+	u32 *option = data;
+
+	*option = val;
+
+	if (option == &enable_off_mode)
+		omap3_pm_off_mode_enable(val);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
+
 static int __init pm_dbg_init(void)
 {
 	int i;
@@ -569,6 +592,10 @@ static int __init pm_dbg_init(void)
 
 		}
 
+	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
+				   &enable_off_mode, &pm_dbg_option_fops);
+	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
+				   &sleep_while_idle, &pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f1d0214..e47508c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,7 +13,11 @@
 
 #include <mach/powerdomain.h>
 
+extern u32 enable_off_mode;
+extern u32 sleep_while_idle;
+
 extern void *omap3_secure_ram_storage;
+extern void omap3_pm_off_mode_enable(int);
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 80934c3..99996fc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/clk.h>
 
 #include <mach/sram.h>
 #include <mach/prcm.h>
@@ -58,6 +59,9 @@
 #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
 
+u32 enable_off_mode;
+u32 sleep_while_idle;
+
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -457,6 +461,8 @@ static int omap3_fclks_active(void)
 
 static int omap3_can_sleep(void)
 {
+	if (!sleep_while_idle)
+		return 0;
 	if (!omap_uart_can_sleep())
 		return 0;
 	if (omap3_fclks_active())
@@ -900,6 +906,22 @@ static void __init prcm_setup_regs(void)
 	omap3_d2d_idle();
 }
 
+void omap3_pm_off_mode_enable(int enable)
+{
+	struct power_state *pwrst;
+	u32 state;
+
+	if (enable)
+		state = PWRDM_POWER_OFF;
+	else
+		state = PWRDM_POWER_RET;
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		pwrst->next_state = state;
+		set_pwrdm_state(pwrst->pwrdm, state);
+	}
+}
+
 int omap3_pm_get_suspend_state(struct powerdomain *pwrdm)
 {
 	struct power_state *pwrst;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b1ebef4..5fe7684 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -169,8 +169,6 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
 
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
 
-static int enable_off_mode; /* to be removed by full off-mode patches */
-
 static void omap_uart_save_context(struct omap_uart_state *uart)
 {
 	u16 lcr = 0;
-- 
1.6.4.3
