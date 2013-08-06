From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Tue, 6 Aug 2013 12:49:35 -0500
Message-ID: <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60831 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756343Ab3HFRux (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 13:50:53 -0400
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lingren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

AM335x supports various low power modes as documented
in section 8.1.4.3 of the AM335x TRM which is available
@ http://www.ti.com/litv/pdf/spruh73f

DeepSleep0 mode offers the lowest power mode with limited
wakeup sources without a system reboot and is mapped as
the suspend state in the kernel. In this state, MPU and
PER domains are turned off with the internal RAM held in
retention to facilitate resume process. As part of the boot
process, the assembly code is copied over to OCMCRAM using
the OMAP SRAM code.

AM335x has a Cortex-M3 (WKUP_M3) which assists the MPU
in DeepSleep0 entry and exit. WKUP_M3 takes care of the
clockdomain and powerdomain transitions based on the
intended low power state. MPU needs to load the appropriate
WKUP_M3 binary onto the WKUP_M3 memory space before it can
leverage any of the PM features like DeepSleep.

The IPC mechanism between MPU and WKUP_M3 uses a mailbox
sub-module and 8 IPC registers in the Control module. MPU
uses the assigned Mailbox for issuing an interrupt to
WKUP_M3 which then goes and checks the IPC registers for
the payload. WKUP_M3 has the ability to trigger on interrupt
to MPU by executing the "sev" instruction.

In the current implementation when the suspend process
is initiated MPU interrupts the WKUP_M3 to let it know about
the intent of entering DeepSleep0 and waits for an ACK. When
the ACK is received MPU continues with its suspend process
to suspend all the drivers and then jumps to assembly in
OCMC RAM. The assembly code puts the PLLs in bypass, puts the
external RAM in self-refresh mode and then finally execute the
WFI instruction. Execution of the WFI instruction triggers another
interrupt to the WKUP_M3 which then continues wiht the power down
sequence wherein the clockdomain and powerdomain transition takes
place. As part of the sleep sequence, WKUP_M3 unmasks the interrupt
lines for the wakeup sources. WFI execution on WKUP_M3 causes the
hardware to disable the main oscillator of the SoC.

When a wakeup event occurs, WKUP_M3 starts the power-up
sequence by switching on the power domains and finally
enabling the clock to MPU. Since the MPU gets powered down
as part of the sleep sequence in the resume path ROM code
starts executing. The ROM code detects a wakeup from sleep
and then jumps to the resume location in OCMC which was
populated in one of the IPC registers as part of the suspend
sequence.

The low level code in OCMC relocks the PLLs, enables access
to external RAM and then jumps to the cpu_resume code of
the kernel to finish the resume process.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Cc: Tony Lingren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <benoit.cousson@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/mach-omap2/pm33xx.c  |  474 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h  |   77 +++++++
 arch/arm/mach-omap2/wkup_m3.c |  183 ++++++++++++++++
 3 files changed, 734 insertions(+)
 create mode 100644 arch/arm/mach-omap2/pm33xx.c
 create mode 100644 arch/arm/mach-omap2/pm33xx.h
 create mode 100644 arch/arm/mach-omap2/wkup_m3.c

diff --git a/arch/arm/mach-omap2/pm33xx.c b/arch/arm/mach-omap2/pm33xx.c
new file mode 100644
index 0000000..d291c76
--- /dev/null
+++ b/arch/arm/mach-omap2/pm33xx.c
@@ -0,0 +1,474 @@
+/*
+ * AM33XX Power Management Routines
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Bedia <vaibhav.bedia@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/ti_emif.h>
+#include <linux/omap-mailbox.h>
+
+#include <asm/suspend.h>
+#include <asm/proc-fns.h>
+#include <asm/sizes.h>
+#include <asm/fncpy.h>
+#include <asm/system_misc.h>
+
+#include "pm.h"
+#include "cm33xx.h"
+#include "pm33xx.h"
+#include "control.h"
+#include "common.h"
+#include "clockdomain.h"
+#include "powerdomain.h"
+#include "omap_hwmod.h"
+#include "omap_device.h"
+#include "soc.h"
+#include "sram.h"
+
+static void __iomem *am33xx_emif_base;
+static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
+static struct clockdomain *gfx_l4ls_clkdm;
+
+struct wakeup_src wakeups[] = {
+	{.irq_nr = 35,	.src = "USB0_PHY"},
+	{.irq_nr = 36,	.src = "USB1_PHY"},
+	{.irq_nr = 40,	.src = "I2C0"},
+	{.irq_nr = 41,	.src = "RTC Timer"},
+	{.irq_nr = 42,	.src = "RTC Alarm"},
+	{.irq_nr = 43,	.src = "Timer0"},
+	{.irq_nr = 44,	.src = "Timer1"},
+	{.irq_nr = 45,	.src = "UART"},
+	{.irq_nr = 46,	.src = "GPIO0"},
+	{.irq_nr = 48,	.src = "MPU_WAKE"},
+	{.irq_nr = 49,	.src = "WDT0"},
+	{.irq_nr = 50,	.src = "WDT1"},
+	{.irq_nr = 51,	.src = "ADC_TSC"},
+};
+
+struct forced_standby_module am33xx_mod[] = {
+	{.oh_name = "usb_otg_hs"},
+	{.oh_name = "tptc0"},
+	{.oh_name = "tptc1"},
+	{.oh_name = "tptc2"},
+	{.oh_name = "cpgmac0"},
+};
+
+static struct am33xx_pm_context *am33xx_pm;
+
+static DECLARE_COMPLETION(am33xx_pm_sync);
+
+static void (*am33xx_do_wfi_sram)(struct am33xx_suspend_params *);
+
+static struct am33xx_suspend_params susp_params;
+
+#ifdef CONFIG_SUSPEND
+
+static int am33xx_do_sram_idle(long unsigned int unused)
+{
+	am33xx_do_wfi_sram(&susp_params);
+	return 0;
+}
+
+static int am33xx_pm_suspend(void)
+{
+	int i, j, ret = 0;
+
+	int status = 0;
+	struct platform_device *pdev;
+	struct omap_device *od;
+
+	/*
+	 * By default the following IPs do not have MSTANDBY asserted
+	 * which is necessary for PER domain transition. If the drivers
+	 * are not compiled into the kernel HWMOD code will not change the
+	 * state of the IPs if the IP was not never enabled. To ensure
+	 * that there no issues with or without the drivers being compiled
+	 * in the kernel, we forcefully put these IPs to idle.
+	 */
+	for (i = 0; i < ARRAY_SIZE(am33xx_mod); i++) {
+		pdev = to_platform_device(am33xx_mod[i].dev);
+		od = to_omap_device(pdev);
+		if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
+			omap_device_enable_hwmods(od);
+			omap_device_idle_hwmods(od);
+		}
+	}
+
+	/* Try to put GFX to sleep */
+	omap_set_pwrdm_state(gfx_pwrdm, PWRDM_POWER_OFF);
+	ret = cpu_suspend(0, am33xx_do_sram_idle);
+
+	status = pwrdm_read_prev_pwrst(gfx_pwrdm);
+	if (status != PWRDM_POWER_OFF)
+		pr_err("PM: GFX domain did not transition\n");
+	else
+		pr_info("PM: GFX domain entered low power state\n");
+
+	/*
+	 * BUG: GFX_L4LS clock domain needs to be woken up to
+	 * ensure thet L4LS clock domain does not get stuck in transition
+	 * If that happens L3 module does not get disabled, thereby leading
+	 * to PER power domain transition failing
+	 */
+	clkdm_wakeup(gfx_l4ls_clkdm);
+	clkdm_sleep(gfx_l4ls_clkdm);
+
+	if (ret) {
+		pr_err("PM: Kernel suspend failure\n");
+	} else {
+		i = am33xx_pm_status();
+		switch (i) {
+		case 0:
+			pr_info("PM: Successfully put all powerdomains to target state\n");
+
+			/*
+			 * The PRCM registers on AM335x do not contain previous state
+			 * information like those present on OMAP4 so we must manually
+			 * indicate transition so state counters are properly incremented
+			 */
+			pwrdm_post_transition(mpu_pwrdm);
+			pwrdm_post_transition(per_pwrdm);
+			break;
+		case 1:
+			pr_err("PM: Could not transition all powerdomains to target state\n");
+			ret = -1;
+			break;
+		default:
+			pr_err("PM: CM3 returned unknown result :(\nStatus = %d\n", i);
+			ret = -1;
+		}
+
+		/* print the wakeup reason */
+		i = am33xx_pm_wake_src();
+		for (j = 0; j < ARRAY_SIZE(wakeups); j++) {
+			if (wakeups[j].irq_nr == i) {
+				pr_info("PM: Wakeup source %s\n", wakeups[j].src);
+				break;
+			}
+		}
+
+		if (j == ARRAY_SIZE(wakeups))
+			pr_info("PM: Unknown wakeup source %d!\n", i);
+	}
+
+	return ret;
+}
+
+static int am33xx_pm_enter(suspend_state_t suspend_state)
+{
+	int ret = 0;
+
+	switch (suspend_state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		ret = am33xx_pm_suspend();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/* returns the error code from msg_send - 0 for success, failure otherwise */
+static int am33xx_ping_wkup_m3(void)
+{
+	int ret = 0;
+
+	/*
+	 * Write a dummy message to the mailbox in order to trigger the RX
+	 * interrupt to alert the M3 that data is available in the IPC
+	 * registers.
+	 */
+	ret = omap_mbox_msg_send(am33xx_pm->mbox, 0xABCDABCD);
+
+	return ret;
+}
+
+static void am33xx_m3_state_machine_reset(void)
+{
+	int i;
+
+	am33xx_pm->ipc.sleep_mode = IPC_CMD_RESET;
+
+	am33xx_pm_ipc_cmd(&am33xx_pm->ipc);
+
+	am33xx_pm->state = M3_STATE_MSG_FOR_RESET;
+
+	pr_info("PM: Sending message for resetting M3 state machine\n");
+
+	if (!am33xx_ping_wkup_m3()) {
+		i = wait_for_completion_timeout(&am33xx_pm_sync,
+					msecs_to_jiffies(500));
+		if (WARN(i == 0, "PM: MPU<->CM3 sync failure\n"))
+			am33xx_pm->state = M3_STATE_UNKNOWN;
+	} else {
+		pr_warn("PM: Unable to ping CM3\n");
+	}
+}
+
+static int am33xx_pm_begin(suspend_state_t state)
+{
+	int i;
+
+	cpu_idle_poll_ctrl(true);
+
+	am33xx_pm->ipc.sleep_mode	= IPC_CMD_DS0;
+	am33xx_pm->ipc.param1		= DS_IPC_DEFAULT;
+	am33xx_pm->ipc.param2		= DS_IPC_DEFAULT;
+
+	am33xx_pm_ipc_cmd(&am33xx_pm->ipc);
+
+	am33xx_pm->state = M3_STATE_MSG_FOR_LP;
+
+	pr_info("PM: Sending message for entering DeepSleep mode\n");
+
+	if (!am33xx_ping_wkup_m3()) {
+		i = wait_for_completion_timeout(&am33xx_pm_sync,
+					msecs_to_jiffies(500));
+		if (WARN(i == 0, "PM: MPU<->CM3 sync failure\n"))
+			return -1;
+	} else {
+		pr_warn("PM: Unable to ping CM3\n");
+	}
+
+	return 0;
+}
+
+static void am33xx_pm_end(void)
+{
+	am33xx_m3_state_machine_reset();
+
+	cpu_idle_poll_ctrl(false);
+
+	return;
+}
+
+static struct platform_suspend_ops am33xx_pm_ops = {
+	.begin		= am33xx_pm_begin,
+	.end		= am33xx_pm_end,
+	.enter		= am33xx_pm_enter,
+};
+
+/*
+ * Dummy notifier for the mailbox
+ */
+
+static int wkup_mbox_msg(struct notifier_block *self, unsigned long len,
+		void *msg)
+{
+	return 0;
+}
+
+static struct notifier_block wkup_mbox_notifier = {
+	.notifier_call = wkup_mbox_msg,
+};
+
+void am33xx_txev_handler(void)
+{
+	switch (am33xx_pm->state) {
+	case M3_STATE_RESET:
+		am33xx_pm->state = M3_STATE_INITED;
+		am33xx_pm->ver = am33xx_pm_version_get();
+		if (am33xx_pm->ver == M3_VERSION_UNKNOWN ||
+			am33xx_pm->ver < M3_BASELINE_VERSION) {
+			pr_warn("PM: CM3 Firmware Version %x not supported\n",
+						am33xx_pm->ver);
+		} else {
+			pr_info("PM: CM3 Firmware Version = 0x%x\n",
+						am33xx_pm->ver);
+			am33xx_pm_ops.valid = suspend_valid_only_mem;
+		}
+		break;
+	case M3_STATE_MSG_FOR_RESET:
+		am33xx_pm->state = M3_STATE_INITED;
+		complete(&am33xx_pm_sync);
+		break;
+	case M3_STATE_MSG_FOR_LP:
+		complete(&am33xx_pm_sync);
+		break;
+	case M3_STATE_UNKNOWN:
+		pr_warn("PM: Unknown CM3 State\n");
+	}
+
+	return;
+}
+
+static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
+{
+	struct am33xx_pm_context *am33xx_pm = context;
+	int ret = 0;
+
+	/* no firmware found */
+	if (!fw) {
+		pr_err("PM: request_firmware failed\n");
+		return;
+	}
+
+	wkup_m3_copy_code(fw->data, fw->size);
+
+	wkup_m3_register_txev_handler(am33xx_txev_handler);
+
+	pr_info("PM: Copied the M3 firmware to UMEM\n");
+
+	/*
+	 * Invalidate M3 firmware version before hardreset.
+	 * Write invalid version in lower 4 nibbles of parameter
+	 * register (ipc_regs + 0x8).
+	 */
+	am33xx_pm_version_clear();
+
+	am33xx_pm->state = M3_STATE_RESET;
+
+	ret = wkup_m3_prepare();
+	if (ret) {
+		pr_err("PM: Could not prepare WKUP_M3\n");
+		return;
+	}
+
+	/* Physical resume address to be used by ROM code */
+	am33xx_pm->ipc.resume_addr = (AM33XX_OCMC_END -
+		am33xx_do_wfi_sz + am33xx_resume_offset + 0x4);
+
+	am33xx_pm->mbox = omap_mbox_get("wkup_m3", &wkup_mbox_notifier);
+
+	if (IS_ERR(am33xx_pm->mbox)) {
+		ret = -EBUSY;
+		pr_err("PM: IPC Request for A8->M3 Channel failed!\n");
+		return;
+	} else {
+		suspend_set_ops(&am33xx_pm_ops);
+	}
+
+	return;
+}
+
+#endif /* CONFIG_SUSPEND */
+
+/*
+ * Push the minimal suspend-resume code to SRAM
+ */
+void am33xx_push_sram_idle(void)
+{
+	am33xx_do_wfi_sram = (void *)omap_sram_push
+					(am33xx_do_wfi, am33xx_do_wfi_sz);
+}
+
+static int __init am33xx_map_emif(void)
+{
+	am33xx_emif_base = ioremap(AM33XX_EMIF_BASE, SZ_32K);
+
+	if (!am33xx_emif_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int __init am33xx_pm_init(void)
+{
+	int ret;
+	u32 temp;
+	struct device_node *np;
+	int i;
+
+	if (!soc_is_am33xx())
+		return -ENODEV;
+
+	pr_info("Power Management for AM33XX family\n");
+
+	/*
+	 * By default the following IPs do not have MSTANDBY asserted
+	 * which is necessary for PER domain transition. If the drivers
+	 * are not compiled into the kernel HWMOD code will not change the
+	 * state of the IPs if the IP was not never enabled
+	 */
+	for (i = 0; i < ARRAY_SIZE(am33xx_mod); i++)
+		am33xx_mod[i].dev = omap_device_get_by_hwmod_name(am33xx_mod[i].oh_name);
+
+	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+
+	gfx_l4ls_clkdm = clkdm_lookup("gfx_l4ls_gfx_clkdm");
+
+	if ((!gfx_pwrdm) || (!per_pwrdm) || (!mpu_pwrdm) || (!gfx_l4ls_clkdm)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	am33xx_pm = kzalloc(sizeof(*am33xx_pm), GFP_KERNEL);
+	if (!am33xx_pm) {
+		pr_err("Memory allocation failed\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = am33xx_map_emif();
+	if (ret) {
+		pr_err("PM: Could not ioremap EMIF\n");
+		goto err;
+	}
+	/* Determine Memory Type */
+	temp = readl(am33xx_emif_base + EMIF_SDRAM_CONFIG);
+	temp = (temp & SDRAM_TYPE_MASK) >> SDRAM_TYPE_SHIFT;
+	/* Parameters to pass to aseembly code */
+	susp_params.emif_addr_virt = am33xx_emif_base;
+	susp_params.dram_sync = am33xx_dram_sync;
+	susp_params.mem_type = temp;
+	am33xx_pm->ipc.param3 = temp;
+
+	np = of_find_compatible_node(NULL, NULL, "ti,am3353-wkup-m3");
+	if (np) {
+		if (of_find_property(np, "ti,needs_vtt_toggle", NULL) &&
+		    (!(of_property_read_u32(np, "vtt-gpio-pin",
+							&temp)))) {
+			if (temp >= 0 && temp <= 31)
+				am33xx_pm->ipc.param3 |=
+					((1 << VTT_STAT_SHIFT) |
+					(temp << VTT_GPIO_PIN_SHIFT));
+		}
+	}
+
+	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
+
+	/* CEFUSE domain can be turned off post bootup */
+	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
+	if (cefuse_pwrdm)
+		omap_set_pwrdm_state(cefuse_pwrdm, PWRDM_POWER_OFF);
+	else
+		pr_err("PM: Failed to get cefuse_pwrdm\n");
+
+#ifdef CONFIG_SUSPEND
+	pr_info("PM: Trying to load am335x-pm-firmware.bin");
+
+	/* We don't want to delay boot */
+	request_firmware_nowait(THIS_MODULE, 0, "am335x-pm-firmware.bin",
+				NULL, GFP_KERNEL, am33xx_pm,
+				am33xx_pm_firmware_cb);
+#endif /* CONFIG_SUSPEND */
+
+err:
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/pm33xx.h b/arch/arm/mach-omap2/pm33xx.h
new file mode 100644
index 0000000..befdd11
--- /dev/null
+++ b/arch/arm/mach-omap2/pm33xx.h
@@ -0,0 +1,77 @@
+/*
+ * AM33XX Power Management Routines
+ *
+ * Copyright (C) 2012 Texas Instruments Inc.
+ * Vaibhav Bedia <vaibhav.bedia@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __ARCH_ARM_MACH_OMAP2_PM33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PM33XX_H
+
+#include "control.h"
+
+#ifndef __ASSEMBLER__
+
+struct am33xx_pm_context {
+	struct am33xx_ipc_data	ipc;
+	struct firmware		*firmware;
+	struct omap_mbox	*mbox;
+	u8			state;
+	u32			ver;
+};
+
+/*
+ * Params passed to suspend routine
+ *
+ * Since these are used to load into registers by suspend code,
+ * entries here must always be in sync with the suspend code
+ * in arm/mach-omap2/sleep33xx.S
+ */
+struct am33xx_suspend_params {
+	void __iomem *emif_addr_virt;
+	u32 mem_type;
+	void __iomem *dram_sync;
+};
+
+struct wakeup_src {
+	int irq_nr;
+	char src[10];
+};
+
+struct forced_standby_module {
+	char oh_name[15];
+	struct device *dev;
+};
+
+int wkup_m3_copy_code(const u8 *data, size_t size);
+int wkup_m3_prepare(void);
+void wkup_m3_register_txev_handler(void (*txev_handler)(void));
+
+#endif
+
+#define	IPC_CMD_DS0			0x3
+#define IPC_CMD_RESET                   0xe
+#define DS_IPC_DEFAULT			0xffffffff
+#define M3_VERSION_UNKNOWN		0x0000ffff
+#define M3_BASELINE_VERSION		0x21
+
+#define M3_STATE_UNKNOWN		0
+#define M3_STATE_RESET			1
+#define M3_STATE_INITED			2
+#define M3_STATE_MSG_FOR_LP		3
+#define M3_STATE_MSG_FOR_RESET		4
+
+#define AM33XX_OCMC_END			0x40310000
+#define AM33XX_EMIF_BASE		0x4C000000
+
+#define MEM_TYPE_DDR2		2
+
+#endif
diff --git a/arch/arm/mach-omap2/wkup_m3.c b/arch/arm/mach-omap2/wkup_m3.c
new file mode 100644
index 0000000..8eaa7f3
--- /dev/null
+++ b/arch/arm/mach-omap2/wkup_m3.c
@@ -0,0 +1,183 @@
+/*
+ * AM33XX Power Management Routines
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Vaibhav Bedia <vaibhav.bedia@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+
+#include "pm33xx.h"
+#include "control.h"
+#include "omap_device.h"
+#include "soc.h"
+
+struct wkup_m3_context {
+	struct device	*dev;
+	void __iomem	*code;
+	void (*txev_handler)(void);
+};
+
+struct wkup_m3_context *wkup_m3;
+
+int wkup_m3_copy_code(const u8 *data, size_t size)
+{
+	if (size > SZ_16K)
+		return -ENOMEM;
+
+	memcpy_toio(wkup_m3->code, data, size);
+
+	return 0;
+}
+
+
+void wkup_m3_register_txev_handler(void (*txev_handler)(void))
+{
+	wkup_m3->txev_handler = txev_handler;
+}
+
+/* have platforms do what they want in atomic context over here? */
+static irqreturn_t wkup_m3_txev_handler(int irq, void *unused)
+{
+	am33xx_txev_eoi();
+
+	/* callback to be executed in atomic context */
+	/* return 0 implies IRQ_HANDLED else IRQ_NONE */
+	wkup_m3->txev_handler();
+
+	am33xx_txev_enable();
+
+	return IRQ_HANDLED;
+}
+
+int wkup_m3_prepare(void)
+{
+	struct platform_device *pdev = to_platform_device(wkup_m3->dev);
+
+	/* check that the code is loaded */
+	omap_device_deassert_hardreset(pdev, "wkup_m3");
+
+	return 0;
+}
+
+static int wkup_m3_probe(struct platform_device *pdev)
+{
+	int irq, ret = 0;
+	struct resource *mem;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (!irq) {
+		dev_err(wkup_m3->dev, "no irq resource\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(wkup_m3->dev, "no memory resource\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	wkup_m3 = kzalloc(sizeof(*wkup_m3), GFP_KERNEL);
+	if (!wkup_m3) {
+		pr_err("Memory allocation failed\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	wkup_m3->dev = &pdev->dev;
+
+	wkup_m3->code = devm_request_and_ioremap(wkup_m3->dev, mem);
+	if (!wkup_m3->code) {
+		dev_err(wkup_m3->dev, "could not ioremap\n");
+		ret = -EADDRNOTAVAIL;
+		goto err;
+	}
+
+	ret = devm_request_irq(wkup_m3->dev, irq, wkup_m3_txev_handler,
+		  IRQF_DISABLED, "wkup_m3_txev", NULL);
+	if (ret) {
+		dev_err(wkup_m3->dev, "request_irq failed\n");
+		goto err;
+	}
+
+err:
+	return ret;
+}
+
+static int wkup_m3_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct of_device_id wkup_m3_dt_ids[] = {
+	{ .compatible = "ti,am3353-wkup-m3" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wkup_m3_dt_ids);
+
+static int wkup_m3_rpm_suspend(struct device *dev)
+{
+	return -EBUSY;
+}
+
+static int wkup_m3_rpm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops wkup_m3_ops = {
+	SET_RUNTIME_PM_OPS(wkup_m3_rpm_suspend, wkup_m3_rpm_resume, NULL)
+};
+
+static struct platform_driver wkup_m3_driver = {
+	.probe		= wkup_m3_probe,
+	.remove		= wkup_m3_remove,
+	.driver		= {
+		.name	= "wkup_m3",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(wkup_m3_dt_ids),
+		.pm	= &wkup_m3_ops,
+	},
+};
+
+static __init int wkup_m3_init(void)
+{
+	return platform_driver_register(&wkup_m3_driver);
+}
+
+static __exit void wkup_m3_exit(void)
+{
+	platform_driver_unregister(&wkup_m3_driver);
+}
+omap_postcore_initcall(wkup_m3_init);
+module_exit(wkup_m3_exit);
-- 
1.7.9.5

