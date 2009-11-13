From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 26/32] OMAP3: PM debug: allow runtime toggle of PM
 features
Date: Fri, 13 Nov 2009 15:35:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C87BF@dbde02.ent.ti.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-25-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-26-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-27-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50555 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487AbZKMKGG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 05:06:06 -0500
In-Reply-To: <1256252993-24328-27-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Friday, October 23, 2009 4:40 AM
>>To: linux-omap@vger.kernel.org
>>Cc: linux-arm-kernel@lists.infradead.org
>>Subject: [PATCH v2 26/32] OMAP3: PM debug: allow runtime toggle of PM features
>>
>>Allow enable/disable of low-power states during idle.  To
>>enable low-power idle:
>>
>>   echo 1 > /debug/pm_debug/sleep_while_idle
>>
>> to disable:
>>
>>   echo 0 > /debug/pm_debug/sleep_while_idle
>>
>>Also allow enable/disable of OFF-mode.  To enable:
>>
>>   echo 1 > /debug/pm_debug/enable_off_mode
>>
>> to disable:
>>
>>   echo 0 > /debug/pm_debug/enable_off_mode
>>
>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>---
>> arch/arm/mach-omap2/pm-debug.c |   27 +++++++++++++++++++++++++++
>> arch/arm/mach-omap2/pm.h       |    4 ++++
>> arch/arm/mach-omap2/pm34xx.c   |   22 ++++++++++++++++++++++
>> arch/arm/mach-omap2/serial.c   |    2 --
>> 4 files changed, 53 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
>>index 7eb2c12..1725da3 100644
>>--- a/arch/arm/mach-omap2/pm-debug.c
>>+++ b/arch/arm/mach-omap2/pm-debug.c
>>@@ -527,6 +527,29 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
>> 	return 0;
>> }
>>
>>+static int option_get(void *data, u64 *val)
>>+{
>>+	u32 *option = data;
>>+
>>+	*val = *option;
>>+
>>+	return 0;
>>+}
>>+
>>+static int option_set(void *data, u64 val)
>>+{
>>+	u32 *option = data;
>>+
>>+	*option = val;
>>+
>>+	if (option == &enable_off_mode)
>>+		omap3_pm_off_mode_enable(val);
>>+
>>+	return 0;
>>+}
>>+
>>+DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
>>+
>> static int __init pm_dbg_init(void)
>> {
>> 	int i;
>>@@ -569,6 +592,10 @@ static int __init pm_dbg_init(void)
>>
>> 		}
>>
>>+	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
>>+				   &enable_off_mode, &pm_dbg_option_fops);
>>+	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
>>+				   &sleep_while_idle, &pm_dbg_option_fops);
>> 	pm_dbg_init_done = 1;
>>
>> 	return 0;
>>diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>>index 45cafac..9582793 100644
>>--- a/arch/arm/mach-omap2/pm.h
>>+++ b/arch/arm/mach-omap2/pm.h
>>@@ -13,7 +13,11 @@
>>
>> #include <plat/powerdomain.h>
>>
>>+extern u32 enable_off_mode;
>>+extern u32 sleep_while_idle;
>>+
>> extern void *omap3_secure_ram_storage;
>>+extern void omap3_pm_off_mode_enable(int);
>>
>> extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>> extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>>diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>index 90d1dc5..ade2e4a 100644
>>--- a/arch/arm/mach-omap2/pm34xx.c
>>+++ b/arch/arm/mach-omap2/pm34xx.c
>>@@ -25,6 +25,7 @@
>> #include <linux/list.h>
>> #include <linux/err.h>
>> #include <linux/gpio.h>
>>+#include <linux/clk.h>
>>
>> #include <plat/sram.h>
>> #include <plat/clockdomain.h>
>>@@ -57,6 +58,9 @@
>> #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
>> #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
>>
>>+u32 enable_off_mode;
>>+u32 sleep_while_idle;
>>+
>> struct power_state {
>> 	struct powerdomain *pwrdm;
>> 	u32 next_state;
>>@@ -456,6 +460,8 @@ static int omap3_fclks_active(void)
>>
>> static int omap3_can_sleep(void)
>> {
>>+	if (!sleep_while_idle)
>>+		return 0;
>> 	if (!omap_uart_can_sleep())
>> 		return 0;
>> 	if (omap3_fclks_active())
>>@@ -900,6 +906,22 @@ static void __init prcm_setup_regs(void)
>> 	omap3_d2d_idle();
>> }
>>
>>+void omap3_pm_off_mode_enable(int enable)
>>+{
>>+	struct power_state *pwrst;
>>+	u32 state;
>>+
>>+	if (enable)
>>+		state = PWRDM_POWER_OFF;
>>+	else
>>+		state = PWRDM_POWER_RET;
>>+
>>+	list_for_each_entry(pwrst, &pwrst_list, node) {
>>+		pwrst->next_state = state;
>>+		set_pwrdm_state(pwrst->pwrdm, state);

Shld the next states of MPU and CORE domain also be changed? It should happen only in idle thread or system suspend path. Not at any arbit point where user sets enable_off_mode.
>>+	}
>>+}
>>+
>> int omap3_pm_get_suspend_state(struct powerdomain *pwrdm)
>> {
>> 	struct power_state *pwrst;
>>diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>>index dabc089..2e17b57 100644
>>--- a/arch/arm/mach-omap2/serial.c
>>+++ b/arch/arm/mach-omap2/serial.c
>>@@ -155,8 +155,6 @@ static inline void __init omap_uart_reset(struct omap_uart_state *uart)
>>
>> #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>>
>>-static int enable_off_mode; /* to be removed by full off-mode patches */
>>-
>> static void omap_uart_save_context(struct omap_uart_state *uart)
>> {
>> 	u16 lcr = 0;
>>--
>>1.6.4.3
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html

