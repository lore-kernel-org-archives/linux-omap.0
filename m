From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 2 Nov 2012 18:02:46 +0530
Message-ID: <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761029Ab2KBMef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:35 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

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
is initiated MPU interrupts the WKUP_M3 to let about the
intent of entering DeepSleep0 and waits for an ACK. When
the ACK is received, MPU continues with its suspend process
to suspend all the drivers and then jumps to assembly in
OCMC RAM to put the PLLs in bypass, put the external RAM in
self-refresh mode and then finally execute the WFI instruction.
The WFI instruction triggers another interrupt to the WKUP_M3
which then continues wiht the power down sequence wherein the
clockdomain and powerdomain transition takes place. As part of
the sleep sequence, WKUP_M3 unmasks the interrupt lines for
the wakeup sources. When WKUP_M3 executes WFI, the hardware
disables the main oscillator.

When a wakeup event occurs, WKUP_M3 starts the power-up
sequence by switching on the power domains and finally
enabling the clock to MPU. Since the MPU gets powered down
as part of the sleep sequence, in the resume path ROM code
starts executing. The ROM code detects a wakeup from sleep
and then jumps to the resume location in OCMC which was
populated in one of the IPC registers as part of the suspend
sequence.

The low level code in OCMC relocks the PLLs, enables access
to external RAM and then jumps to the cpu_resume code of
the kernel to finish the resume process.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    2 +
 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/common.h        |   10 +
 arch/arm/mach-omap2/io.c            |    7 +
 arch/arm/mach-omap2/pm.h            |    7 +
 arch/arm/mach-omap2/pm33xx.c        |  429 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm33xx.h        |  100 ++++++
 arch/arm/mach-omap2/sleep33xx.S     |  571 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/sram.c           |   10 +-
 arch/arm/plat-omap/sram.h           |    2 +
 10 files changed, 1138 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm33xx.c
 create mode 100644 arch/arm/mach-omap2/pm33xx.h
 create mode 100644 arch/arm/mach-omap2/sleep33xx.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ae87a3e..80736aa 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -71,6 +71,7 @@ endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
+obj-$(CONFIG_SOC_AM33XX)		+= pm33xx.o sleep33xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap-mpuss-lowpower.o
@@ -80,6 +81,7 @@ obj-$(CONFIG_POWER_AVS_OMAP)		+= sr_device.o
 obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
+AFLAGS_sleep33xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 ifeq ($(CONFIG_PM_VERBOSE),y)
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 601ecdf..23894df 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -109,6 +109,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.map_io		= am33xx_map_io,
 	.init_early	= am33xx_init_early,
+	.init_late	= am33xx_init_late,
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index c925c80..d4319ad 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -109,6 +109,15 @@ static inline int omap3_pm_init(void)
 }
 #endif
 
+#if defined(CONFIG_PM) && defined(CONFIG_SOC_AM33XX)
+int am33xx_pm_init(void);
+#else
+static inline int am33xx_pm_init(void)
+{
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP4)
 int omap4_pm_init(void);
 #else
@@ -157,6 +166,7 @@ void am33xx_init_early(void);
 void omap4430_init_early(void);
 void omap5_init_early(void);
 void omap3_init_late(void);	/* Do not use this one */
+void am33xx_init_late(void);
 void omap4430_init_late(void);
 void omap2420_init_late(void);
 void omap2430_init_late(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4fadc78..d06f84a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -528,6 +528,13 @@ void __init am33xx_init_early(void)
 	omap_hwmod_init_postsetup();
 	am33xx_clk_init();
 }
+
+void __init am33xx_init_late(void)
+{
+	omap_mux_late_init();
+	omap2_common_pm_late_init();
+	am33xx_pm_init();
+}
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 67d6613..d37f20e 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -83,6 +83,13 @@ extern unsigned int omap3_do_wfi_sz;
 /* ... and its pointer from SRAM after copy */
 extern void (*omap3_do_wfi_sram)(void);
 
+/* am33xx_do_wfi function pointer and size, for copy to SRAM */
+extern void am33xx_do_wfi(void);
+extern unsigned int am33xx_do_wfi_sz;
+extern unsigned int am33xx_resume_offset;
+/* ... and its pointer from SRAM after copy */
+extern void (*am33xx_do_wfi_sram)(void);
+
 /* save_secure_ram_context function pointer and size, for copy to SRAM */
 extern int save_secure_ram_context(u32 *addr);
 extern unsigned int save_secure_ram_context_sz;
diff --git a/arch/arm/mach-omap2/pm33xx.c b/arch/arm/mach-omap2/pm33xx.c
new file mode 100644
index 0000000..836af52
--- /dev/null
+++ b/arch/arm/mach-omap2/pm33xx.c
@@ -0,0 +1,429 @@
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
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <linux/completion.h>
+#include <linux/module.h>
+
+#include <plat/prcm.h>
+#include <plat/mailbox.h>
+#include "../plat-omap/sram.h"
+
+#include <asm/suspend.h>
+#include <asm/proc-fns.h>
+#include <asm/sizes.h>
+#include <asm/system_misc.h>
+
+#include "pm.h"
+#include "cm33xx.h"
+#include "pm33xx.h"
+#include "control.h"
+#include "clockdomain.h"
+#include "powerdomain.h"
+#include "omap_hwmod.h"
+#include "omap_device.h"
+#include "soc.h"
+
+void (*am33xx_do_wfi_sram)(void);
+
+static void __iomem *am33xx_emif_base;
+static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm;
+static struct clockdomain *gfx_l3_clkdm, *gfx_l4ls_clkdm;
+static struct wkup_m3_context *wkup_m3;
+
+static DECLARE_COMPLETION(wkup_m3_sync);
+
+#ifdef CONFIG_SUSPEND
+static int am33xx_do_sram_idle(long unsigned int unused)
+{
+	am33xx_do_wfi_sram();
+	return 0;
+}
+
+static int am33xx_pm_suspend(void)
+{
+	int status, ret = 0;
+
+	struct omap_hwmod *gpmc_oh, *usb_oh;
+	struct omap_hwmod *tptc0_oh, *tptc1_oh, *tptc2_oh;
+
+	/*
+	 * By default the following IPs do not have MSTANDBY asserted
+	 * which is necessary for PER domain transition. If the drivers
+	 * are not compiled into the kernel HWMOD code will not change the
+	 * state of the IPs if the IP was not never enabled
+	 */
+	usb_oh		= omap_hwmod_lookup("usb_otg_hs");
+	gpmc_oh		= omap_hwmod_lookup("gpmc");
+	tptc0_oh	= omap_hwmod_lookup("tptc0");
+	tptc1_oh	= omap_hwmod_lookup("tptc1");
+	tptc2_oh	= omap_hwmod_lookup("tptc2");
+
+	omap_hwmod_enable(usb_oh);
+	omap_hwmod_enable(gpmc_oh);
+	omap_hwmod_enable(tptc0_oh);
+	omap_hwmod_enable(tptc1_oh);
+	omap_hwmod_enable(tptc2_oh);
+
+	omap_hwmod_idle(usb_oh);
+	omap_hwmod_idle(gpmc_oh);
+	omap_hwmod_idle(tptc0_oh);
+	omap_hwmod_idle(tptc1_oh);
+	omap_hwmod_idle(tptc2_oh);
+
+	/* Put the GFX clockdomains to sleep */
+	clkdm_sleep(gfx_l3_clkdm);
+	clkdm_sleep(gfx_l4ls_clkdm);
+
+	/* Try to put GFX to sleep */
+	pwrdm_set_next_pwrst(gfx_pwrdm, PWRDM_POWER_OFF);
+
+	ret = cpu_suspend(0, am33xx_do_sram_idle);
+
+	status = pwrdm_read_pwrst(gfx_pwrdm);
+	if (status != PWRDM_POWER_OFF)
+		pr_err("GFX domain did not transition\n");
+	else
+		pr_info("GFX domain entered low power state\n");
+
+	/* Needed to ensure L4LS clockdomain transitions properly */
+	clkdm_wakeup(gfx_l3_clkdm);
+	clkdm_wakeup(gfx_l4ls_clkdm);
+
+	if (ret) {
+		pr_err("Kernel suspend failure\n");
+	} else {
+		status = omap_ctrl_readl(AM33XX_CONTROL_IPC_MSG_REG1);
+		status &= IPC_RESP_MASK;
+		status >>= __ffs(IPC_RESP_MASK);
+
+		switch (status) {
+		case 0:
+			pr_info("Successfully transitioned to low power state\n");
+			if (wkup_m3->sleep_mode == IPC_CMD_DS0)
+				/* XXX: Use SOC specific ops for this? */
+				per_pwrdm->ret_logic_off_counter++;
+			break;
+		case 1:
+			pr_err("Could not enter low power state\n");
+			ret = -1;
+			break;
+		default:
+			pr_err("Something is terribly wrong :(\nStatus = %d\n",
+				status);
+			ret = -1;
+		}
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
+static int am33xx_pm_begin(suspend_state_t state)
+{
+	int ret = 0;
+
+	disable_hlt();
+
+	/*
+	 * Physical resume address to be used by ROM code
+	 */
+	wkup_m3->resume_addr = (AM33XX_OCMC_END - am33xx_do_wfi_sz +
+					am33xx_resume_offset + 0x4);
+
+	wkup_m3->sleep_mode = IPC_CMD_DS0;
+	wkup_m3->ipc_data1  = DS_IPC_DEFAULT;
+	wkup_m3->ipc_data2  = DS_IPC_DEFAULT;
+
+	am33xx_ipc_cmd();
+
+	wkup_m3->state = M3_STATE_MSG_FOR_LP;
+
+	omap_mbox_enable_irq(wkup_m3->mbox, IRQ_RX);
+
+	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);
+	if (ret) {
+		pr_err("A8<->CM3 MSG for LP failed\n");
+		am33xx_m3_state_machine_reset();
+		ret = -1;
+	}
+
+	if (!wait_for_completion_timeout(&wkup_m3_sync,
+					msecs_to_jiffies(500))) {
+		pr_err("A8<->CM3 sync failure\n");
+		am33xx_m3_state_machine_reset();
+		ret = -1;
+	} else {
+		pr_debug("Message sent for entering DeepSleep mode\n");
+		omap_mbox_disable_irq(wkup_m3->mbox, IRQ_RX);
+	}
+
+	return ret;
+}
+
+static void am33xx_pm_end(void)
+{
+	omap_mbox_enable_irq(wkup_m3->mbox, IRQ_RX);
+
+	am33xx_m3_state_machine_reset();
+
+	enable_hlt();
+
+	return;
+}
+
+static const struct platform_suspend_ops am33xx_pm_ops = {
+	.begin		= am33xx_pm_begin,
+	.end		= am33xx_pm_end,
+	.enter		= am33xx_pm_enter,
+	.valid		= suspend_valid_only_mem,
+};
+
+static void am33xx_ipc_cmd(void)
+{
+	omap_ctrl_writel(wkup_m3->resume_addr, AM33XX_CONTROL_IPC_MSG_REG0);
+	omap_ctrl_writel(wkup_m3->sleep_mode, AM33XX_CONTROL_IPC_MSG_REG1);
+	omap_ctrl_writel(wkup_m3->ipc_data1, AM33XX_CONTROL_IPC_MSG_REG2);
+	omap_ctrl_writel(wkup_m3->ipc_data2, AM33XX_CONTROL_IPC_MSG_REG3);
+}
+
+static void am33xx_m3_state_machine_reset(void)
+{
+	int ret = 0;
+
+	wkup_m3->resume_addr	= 0x0;
+	wkup_m3->sleep_mode	= IPC_CMD_RESET;
+	wkup_m3->ipc_data1	= DS_IPC_DEFAULT;
+	wkup_m3->ipc_data2	= DS_IPC_DEFAULT;
+
+	am33xx_ipc_cmd();
+
+	wkup_m3->state = M3_STATE_MSG_FOR_RESET;
+
+	ret = omap_mbox_msg_send(wkup_m3->mbox, 0xABCDABCD);
+	if (!ret) {
+		pr_debug("Message sent for resetting M3 state machine\n");
+		if (!wait_for_completion_timeout(&wkup_m3_sync,
+						msecs_to_jiffies(500)))
+			pr_err("A8<->CM3 sync failure\n");
+	} else {
+		pr_err("Could not reset M3 state machine!!!\n");
+		wkup_m3->state = M3_STATE_UNKNOWN;
+	}
+}
+#endif /* CONFIG_SUSPEND */
+
+/*
+ * Dummy notifier for the mailbox
+ */
+int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg)
+{
+	return 0;
+}
+
+static struct notifier_block wkup_mbox_notifier = {
+	.notifier_call = wkup_mbox_msg,
+};
+
+static irqreturn_t wkup_m3_txev_handler(int irq, void *unused)
+{
+	omap_ctrl_writel(0x1, AM33XX_CONTROL_M3_TXEV_EOI);
+
+	switch (wkup_m3->state) {
+	case M3_STATE_RESET:
+		wkup_m3->state = M3_STATE_INITED;
+		break;
+	case M3_STATE_MSG_FOR_RESET:
+		wkup_m3->state = M3_STATE_INITED;
+		omap_mbox_msg_rx_flush(wkup_m3->mbox);
+		complete(&wkup_m3_sync);
+		break;
+	case M3_STATE_MSG_FOR_LP:
+		omap_mbox_msg_rx_flush(wkup_m3->mbox);
+		complete(&wkup_m3_sync);
+		break;
+	case M3_STATE_UNKNOWN:
+		pr_err("IRQ %d with WKUP_M3 in unknown state\n", irq);
+		omap_mbox_msg_rx_flush(wkup_m3->mbox);
+		return IRQ_NONE;
+	}
+
+	omap_ctrl_writel(0x0, AM33XX_CONTROL_M3_TXEV_EOI);
+	return IRQ_HANDLED;
+}
+
+static void am33xx_pm_firmware_cb(const struct firmware *fw, void *context)
+{
+	struct wkup_m3_context *wkup_m3_context = context;
+	struct platform_device *pdev = to_platform_device(wkup_m3_context->dev);
+	int ret = 0;
+
+	/* no firmware found */
+	if (!fw) {
+		dev_err(wkup_m3_context->dev, "request_firmware failed\n");
+		goto err;
+	}
+
+	memcpy((void *)wkup_m3_context->code, fw->data, fw->size);
+	pr_info("Copied the M3 firmware to UMEM\n");
+
+	wkup_m3->state = M3_STATE_RESET;
+
+	ret = omap_device_deassert_hardreset(pdev, "wkup_m3");
+	if (ret) {
+		pr_err("Could not deassert the reset for WKUP_M3\n");
+		goto err;
+	} else {
+#ifdef CONFIG_SUSPEND
+		suspend_set_ops(&am33xx_pm_ops);
+#endif
+		return;
+	}
+
+err:
+	omap_mbox_put(wkup_m3_context->mbox, &wkup_mbox_notifier);
+}
+
+static int wkup_m3_init(void)
+{
+	int irq, ret = 0;
+	struct resource *mem;
+	struct platform_device *pdev = to_platform_device(wkup_m3->dev);
+
+	omap_device_enable_hwmods(to_omap_device(pdev));
+
+	/* Reserve the MBOX for sending messages to M3 */
+	wkup_m3->mbox = omap_mbox_get("wkup_m3", &wkup_mbox_notifier);
+	if (IS_ERR(wkup_m3->mbox)) {
+		pr_err("Could not reserve mailbox for A8->M3 IPC\n");
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		dev_err(wkup_m3->dev, "no memory resource\n");
+
+	wkup_m3->code = devm_request_and_ioremap(wkup_m3->dev, mem);
+	ret = devm_request_irq(wkup_m3->dev, irq, wkup_m3_txev_handler,
+		  IRQF_DISABLED, "wkup_m3_txev", NULL);
+	if (ret) {
+		dev_err(wkup_m3->dev, "request_irq failed\n");
+		goto err;
+	}
+
+	pr_info("Trying to load am335x-pm-firmware.bin");
+
+	/* We don't want to delay boot */
+	request_firmware_nowait(THIS_MODULE, 0, "am335x-pm-firmware.bin",
+				wkup_m3->dev, GFP_KERNEL, wkup_m3,
+				am33xx_pm_firmware_cb);
+	return 0;
+
+err:
+	omap_mbox_put(wkup_m3->mbox, &wkup_mbox_notifier);
+exit:
+	return ret;
+}
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
+void __iomem *am33xx_get_emif_base(void)
+{
+	return am33xx_emif_base;
+}
+
+int __init am33xx_pm_init(void)
+{
+	int ret;
+
+	if (!soc_is_am33xx())
+		return -ENODEV;
+
+	pr_info("Power Management for AM33XX family\n");
+
+	wkup_m3 = kzalloc(sizeof(struct wkup_m3_context), GFP_KERNEL);
+	if (!wkup_m3) {
+		pr_err("Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	ret = am33xx_map_emif();
+
+	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
+
+	/* CEFUSE domain should be turned off post bootup */
+	cefuse_pwrdm = pwrdm_lookup("cefuse_pwrdm");
+	if (cefuse_pwrdm)
+		pwrdm_set_next_pwrst(cefuse_pwrdm, PWRDM_POWER_OFF);
+	else
+		pr_err("Failed to get cefuse_pwrdm\n");
+
+	gfx_pwrdm = pwrdm_lookup("gfx_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+
+	gfx_l3_clkdm = clkdm_lookup("gfx_l3_clkdm");
+	gfx_l4ls_clkdm = clkdm_lookup("gfx_l4ls_gfx_clkdm");
+
+	wkup_m3->dev = omap_device_get_by_hwmod_name("wkup_m3");
+
+	ret = wkup_m3_init();
+	if (ret)
+		pr_err("Could not initialise firmware loading\n");
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/pm33xx.h b/arch/arm/mach-omap2/pm33xx.h
new file mode 100644
index 0000000..38f8ae7
--- /dev/null
+++ b/arch/arm/mach-omap2/pm33xx.h
@@ -0,0 +1,100 @@
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
+
+#ifndef __ARCH_ARM_MACH_OMAP2_PM33XX_H
+#define __ARCH_ARM_MACH_OMAP2_PM33XX_H
+
+#ifndef __ASSEMBLER__
+struct wkup_m3_context {
+	struct device		*dev;
+	struct firmware		*firmware;
+	struct omap_mbox	*mbox;
+	void __iomem		*code;
+	int			resume_addr;
+	int			ipc_data1;
+	int			ipc_data2;
+	int			sleep_mode;
+	u8			state;
+};
+
+#ifdef CONFIG_SUSPEND
+static void am33xx_ipc_cmd(void);
+static void am33xx_m3_state_machine_reset(void);
+#else
+static inline void am33xx_ipc_cmd(void) {}
+static inline void am33xx_m3_state_machine_reset(void) {}
+#endif /* CONFIG_SUSPEND */
+
+extern void __iomem *am33xx_get_emif_base(void);
+int wkup_mbox_msg(struct notifier_block *self, unsigned long len, void *msg);
+#endif
+
+#define	IPC_CMD_DS0			0x3
+#define IPC_CMD_RESET                   0xe
+#define DS_IPC_DEFAULT			0xffffffff
+
+#define IPC_RESP_SHIFT			16
+#define IPC_RESP_MASK			(0xffff << 16)
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
+/*
+ * This a subset of registers defined in drivers/memory/emif.h
+ * Move that to include/linux/?
+ */
+#define EMIF_MODULE_ID_AND_REVISION			0x0000
+#define EMIF_STATUS					0x0004
+#define EMIF_SDRAM_CONFIG				0x0008
+#define EMIF_SDRAM_CONFIG_2				0x000c
+#define EMIF_SDRAM_REFRESH_CONTROL			0x0010
+#define EMIF_SDRAM_REFRESH_CTRL_SHDW			0x0014
+#define EMIF_SDRAM_TIMING_1				0x0018
+#define EMIF_SDRAM_TIMING_1_SHDW			0x001c
+#define EMIF_SDRAM_TIMING_2				0x0020
+#define EMIF_SDRAM_TIMING_2_SHDW			0x0024
+#define EMIF_SDRAM_TIMING_3				0x0028
+#define EMIF_SDRAM_TIMING_3_SHDW			0x002c
+#define EMIF_LPDDR2_NVM_TIMING				0x0030
+#define EMIF_LPDDR2_NVM_TIMING_SHDW			0x0034
+#define EMIF_POWER_MANAGEMENT_CONTROL			0x0038
+#define EMIF_POWER_MANAGEMENT_CTRL_SHDW			0x003c
+#define EMIF_PERFORMANCE_COUNTER_1			0x0080
+#define EMIF_PERFORMANCE_COUNTER_2			0x0084
+#define EMIF_PERFORMANCE_COUNTER_CONFIG			0x0088
+#define EMIF_PERFORMANCE_COUNTER_MASTER_REGION_SELECT	0x008c
+#define EMIF_PERFORMANCE_COUNTER_TIME			0x0090
+#define EMIF_MISC_REG					0x0094
+#define EMIF_DLL_CALIB_CTRL				0x0098
+#define EMIF_DLL_CALIB_CTRL_SHDW			0x009c
+#define EMIF_SYSTEM_OCP_INTERRUPT_RAW_STATUS		0x00a4
+#define EMIF_SYSTEM_OCP_INTERRUPT_STATUS		0x00ac
+#define EMIF_SYSTEM_OCP_INTERRUPT_ENABLE_SET		0x00b4
+#define EMIF_SYSTEM_OCP_INTERRUPT_ENABLE_CLEAR		0x00bc
+#define EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG	0x00c8
+#define EMIF_READ_WRITE_LEVELING_RAMP_WINDOW		0x00d4
+#define EMIF_READ_WRITE_LEVELING_RAMP_CONTROL		0x00d8
+#define EMIF_READ_WRITE_LEVELING_CONTROL		0x00dc
+#define EMIF_DDR_PHY_CTRL_1				0x00e4
+#define EMIF_DDR_PHY_CTRL_1_SHDW			0x00e8
+
+#endif
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
new file mode 100644
index 0000000..f7b34e5
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -0,0 +1,571 @@
+/*
+ * Low level suspend code for AM33XX SoCs
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
+#include <linux/linkage.h>
+#include <asm/memory.h>
+#include <asm/assembler.h>
+
+#include "cm33xx.h"
+#include "pm33xx.h"
+#include "prm33xx.h"
+#include "control.h"
+
+/* replicated define because linux/bitops.h cannot be included in assembly */
+#define BIT(nr)		(1 << (nr))
+
+	.text
+	.align 3
+
+	.macro	pll_bypass, name, clk_mode_addr, idlest_addr, pll_mode
+pll_bypass_\name:
+	ldr	r0, \clk_mode_addr
+	ldr	r1, [r0]
+	str	r1, clk_mode_\pll_mode
+	bic	r1, r1, #(7 << 0)
+	orr	r1, r1, #0x5
+	str	r1, [r0]
+	ldr	r0, \idlest_addr
+wait_pll_bypass_\name:
+	ldr	r1, [r0]
+	tst	r1, #0x0
+	bne	wait_pll_bypass_\name
+	.endm
+
+	.macro	pll_lock, name, clk_mode_addr, idlest_addr, pll_mode
+pll_lock_\name:
+	ldr	r0, \clk_mode_addr
+	ldr	r1, clk_mode_\pll_mode
+	str	r1, [r0]
+	and	r1, r1, #0x7
+	cmp	r1, #0x7
+	bne	pll_mode_restored_\name
+	ldr	r0, \idlest_addr
+wait_pll_lock_\name:
+	ldr	r1, [r0]
+	ands	r1, #0x1
+	beq	wait_pll_lock_\name
+pll_mode_restored_\name:
+	nop
+	.endm
+
+	.macro	ddr_self_refresh, num
+ddr_self_refresh_\num:
+	add	r1, r0, #EMIF_POWER_MANAGEMENT_CONTROL
+	ldr	r2, [r1]
+	orr	r2, r2, #0xa0		@ a reasonable delay for entering SR
+	str	r2, [r1, #0]
+	str	r2, [r1, #4]		@ write to shadow register also
+
+	ldr	r2, ddr_start		@ do a dummy access to DDR
+	ldr	r3, [r2, #0]
+	ldr	r3, [r1, #0]
+	orr	r3, r3, #0x200		@ now set the LP MODE to Self-Refresh
+	str	r3, [r1, #0]
+
+	mov	r1, #0x1000		@ Give some time for system to enter SR
+wait_sr_\num:
+	subs	r1, r1, #1
+	bne	wait_sr_\num
+	.endm
+
+	.macro	wait_sdram_config, num
+wait_sdram_config_\num:
+	mov	r0, #0x100
+wait_sc_\num:
+	subs	r0, r0 ,#1
+	bne	wait_sc_\num
+	.endm
+
+ENTRY(am33xx_do_wfi)
+	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
+	/* Get the EMIF virtual address */
+	ldr	r0, emif_addr_func
+	blx	r0
+	/* Save it for later use */
+	str	r0, emif_addr_virt
+
+	/* This ensures isb */
+	ldr	r0, dcache_flush
+	blx	r0
+
+	/* Same as v7_flush_icache_all - saving a branch */
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0	@ I+BTB cache invalidate
+
+	ldr	r0, emif_addr_virt
+	/* Save EMIF configuration */
+	ldr	r1, [r0, #EMIF_SDRAM_CONFIG]
+	str	r1, emif_sdcfg_val
+	ldr	r1, [r0, #EMIF_SDRAM_REFRESH_CONTROL]
+	str	r1, emif_ref_ctrl_val
+	ldr	r1, [r0, #EMIF_SDRAM_TIMING_1]
+	str	r1, emif_timing1_val
+	ldr	r1, [r0, #EMIF_SDRAM_TIMING_2]
+	str	r1, emif_timing2_val
+	ldr	r1, [r0, #EMIF_SDRAM_TIMING_3]
+	str	r1, emif_timing3_val
+	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CONTROL]
+	str	r1, emif_pmcr_val
+	ldr	r1, [r0, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
+	str	r1, emif_pmcr_shdw_val
+	ldr	r1, [r0, #EMIF_SDRAM_OUTPUT_IMPEDANCE_CALIBRATION_CONFIG]
+	str	r1, emif_zqcfg_val
+	ldr	r1, [r0, #EMIF_DDR_PHY_CTRL_1]
+	str	r1, emif_rd_lat_val
+
+	/* Ensure that all the writes to DDR leave the A8 */
+	dsb
+	dmb
+	isb
+
+	ddr_self_refresh	1
+
+	/* Disable EMIF at this point */
+	ldr	r1, virt_emif_clkctrl
+	ldr	r2, [r1]
+	bic	r2, r2, #(3 << 0)
+	str	r2, [r1]
+
+	ldr	r1, virt_emif_clkctrl
+wait_emif_disable:
+	ldr	r2, [r1]
+	ldr	r3, module_disabled_val
+	cmp	r2, r3
+	bne	wait_emif_disable
+
+	/*
+	 * For the MPU WFI to be registered as an interrupt
+	 * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
+	 * to DISABLED
+	 */
+	ldr	r1, virt_mpu_clkctrl
+	ldr	r2, [r1]
+	bic	r2, r2, #(3 << 0)
+	str	r2, [r1]
+
+	/* DDR3 reset override and mDDR mode selection */
+	ldr	r0, virt_ddr_io_ctrl
+	mov	r1, #(0x9 << 28)
+	str	r1, [r0]
+
+	/* Weak pull down for DQ, DM */
+	ldr	r1, virt_ddr_data0_ioctrl
+	ldr	r2, susp_io_pull_data
+	str	r2, [r1]
+
+	ldr	r1, virt_ddr_data1_ioctrl
+	ldr	r2, susp_io_pull_data
+	str	r2, [r1]
+
+	/* Disable VTP */
+	ldr	r1, virt_ddr_vtp_ctrl
+	ldr	r2, susp_vtp_ctrl_val
+	str	r2, [r1]
+
+	/* Enable SRAM LDO ret mode */
+	ldr	r0, virt_sram_ldo_addr
+	ldr	r1, [r0]
+	orr	r1, #1
+	str	r1, [r0]
+
+put_pll_bypass:
+	/* Put the PLLs in bypass mode */
+	pll_bypass	core, virt_core_clk_mode, virt_core_idlest, core_val
+	pll_bypass	ddr, virt_ddr_clk_mode, virt_ddr_idlest, ddr_val
+	pll_bypass	disp, virt_disp_clk_mode, virt_disp_idlest, disp_val
+	pll_bypass	per, virt_per_clk_mode, virt_per_idlest, per_val
+	pll_bypass	mpu, virt_mpu_clk_mode, virt_mpu_idlest, mpu_val
+
+	dsb
+	dmb
+	isb
+
+	wfi
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+
+	/* We come here in case of an abort due to a late interrupt */
+
+	/* Set MPU_CLKCTRL.MODULEMODE back to ENABLE */
+	ldr	r1, virt_mpu_clkctrl
+	mov	r2, #0x2
+	str	r2, [r1]
+
+	/* Relock the PLLs */
+	pll_lock	mpu_abt, virt_mpu_clk_mode, virt_mpu_idlest, mpu_val
+	pll_lock	per_abt, virt_per_clk_mode, virt_per_idlest, per_val
+	pll_lock	disp_abt, virt_disp_clk_mode, virt_disp_idlest, disp_val
+	pll_lock	ddr_abt, virt_ddr_clk_mode, virt_ddr_idlest, ddr_val
+	pll_lock	core_abt, virt_core_clk_mode, virt_core_idlest, core_val
+
+	/* Disable SRAM LDO ret mode */
+	ldr	r0, virt_sram_ldo_addr
+	ldr	r1, [r0]
+	bic	r1, #1
+	str	r1, [r0]
+
+	/* Restore the pull for DQ, DM */
+	ldr	r1, virt_ddr_data0_ioctrl
+	ldr	r2, resume_io_pull_data
+	str	r2, [r1]
+
+	ldr	r1, virt_ddr_data1_ioctrl
+	ldr	r2, resume_io_pull_data
+	str	r2, [r1]
+
+	/* Enable EMIF */
+	ldr	r1, virt_emif_clkctrl
+	mov	r2, #0x2
+	str	r2, [r1]
+wait_emif_enable:
+	ldr	r3, [r1]
+	cmp	r2, r3
+	bne	wait_emif_enable
+
+	/* Enable VTP */
+config_vtp_abt:
+	ldr	r0, virt_ddr_vtp_ctrl
+	ldr	r1, [r0]
+	mov	r2, #0x0	@ clear the register
+	str	r2, [r0]
+	mov	r2, #0x6	@ write the filter value
+	str	r2, [r0]
+
+	ldr	r1, [r0]
+	ldr	r2, vtp_enable	@ set the enable bit
+	orr	r2, r2, r1
+	str	r2, [r0]
+
+	ldr	r1, [r0]	@ toggle the CLRZ bit
+	bic	r1, #1
+	str	r1, [r0]
+
+	ldr	r1, [r0]
+	orr	r1, #1
+	str	r1, [r0]
+
+poll_vtp_ready_abt:
+	ldr	r1, [r0]	@ poll for VTP ready
+	tst	r1, #(1 << 5)
+	beq	poll_vtp_ready_abt
+
+	/* DDR3 reset override and mDDR mode clear */
+	ldr	r0, virt_ddr_io_ctrl
+	mov	r1, #0
+	str	r1, [r0]
+
+emif_self_refresh_dis:
+	/* Disable EMIF self-refresh */
+	ldr	r0, emif_addr_virt
+	add	r0, r0, #EMIF_POWER_MANAGEMENT_CONTROL
+	ldr	r1, [r0]
+	bic	r1, r1, #(0x7 << 8)
+	str	r1, [r0]
+	str	r1, [r0, #4]
+
+	/*
+	 * A write to SDRAM CONFIG register triggers
+	 * an init sequence and hence it must be done
+	 * at the end
+	 */
+	ldr r0, emif_addr_virt
+	add r0, r0, #EMIF_SDRAM_CONFIG
+	ldr r4, emif_sdcfg_val
+	str r4, [r0]
+
+	mov r0, #0x1000
+wait_abt:
+	subs   r0, r0, #1
+	bne wait_abt
+
+	/* Let the suspend code know about the abort */
+	mov	r0, #1
+	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
+ENDPROC(am33xx_do_wfi)
+
+	.align
+ENTRY(am33xx_resume_offset)
+	.word . - am33xx_do_wfi
+
+ENTRY(am33xx_resume_from_deep_sleep)
+	/* Take the PLLs out of LP_BYPASS */
+	pll_lock	mpu, phys_mpu_clk_mode, phys_mpu_idlest, mpu_val
+	pll_lock	per, phys_per_clk_mode, phys_per_idlest, per_val
+	pll_lock	disp, phys_disp_clk_mode, phys_disp_idlest, disp_val
+	pll_lock	ddr, phys_ddr_clk_mode, phys_ddr_idlest, ddr_val
+	pll_lock	core, phys_core_clk_mode, phys_core_idlest, core_val
+
+	/* Disable SRAM LDO ret mode */
+	ldr	r0, phys_sram_ldo_addr
+	ldr	r1, [r0]
+	bic	r1, #1
+	str	r1, [r0]
+
+	/* Restore the pull for DQ, DM */
+	ldr	r1, phys_ddr_data0_ioctrl
+	ldr	r2, resume_io_pull_data
+	str	r2, [r1]
+
+	ldr	r1, phys_ddr_data1_ioctrl
+	ldr	r2, resume_io_pull_data
+	str	r2, [r1]
+
+config_vtp:
+	ldr	r0, phys_ddr_vtp_ctrl
+	ldr	r1, [r0]
+	mov	r2, #0x0	@ clear the register
+	str	r2, [r0]
+	mov	r2, #0x6	@ write the filter value
+	str	r2, [r0]
+
+	ldr	r1, [r0]
+	ldr	r2, vtp_enable	@ set the enable bit
+	orr	r2, r2, r1
+	str	r2, [r0]
+
+	ldr	r1, [r0]	@ toggle the CLRZ bit
+	bic	r1, #1
+	str	r1, [r0]
+
+	ldr	r1, [r0]
+	orr	r1, #1
+	str	r1, [r0]
+
+poll_vtp_ready:
+	ldr	r1, [r0]	@ poll for VTP ready
+	tst	r1, #(1 << 5)
+	beq	poll_vtp_ready
+
+	/* DDR3 reset override and mDDR mode clear */
+	ldr	r0, phys_ddr_io_ctrl
+	mov	r1, #0
+	str	r1, [r0]
+
+config_emif_timings:
+	ldr	r3, emif_phys_addr
+	ldr	r4, emif_rd_lat_val
+	str	r4, [r3, #EMIF_DDR_PHY_CTRL_1]
+	str	r4, [r3, #EMIF_DDR_PHY_CTRL_1_SHDW]
+	ldr	r4, emif_timing1_val
+	str	r4, [r3, #EMIF_SDRAM_TIMING_1]
+	str	r4, [r3, #EMIF_SDRAM_TIMING_1_SHDW]
+	ldr	r4, emif_timing2_val
+	str	r4, [r3, #EMIF_SDRAM_TIMING_2]
+	str	r4, [r3, #EMIF_SDRAM_TIMING_2_SHDW]
+	ldr	r4, emif_timing3_val
+	str	r4, [r3, #EMIF_SDRAM_TIMING_3]
+	str	r4, [r3, #EMIF_SDRAM_TIMING_3_SHDW]
+	ldr	r4, emif_ref_ctrl_val
+	str	r4, [r3, #EMIF_SDRAM_REFRESH_CONTROL]
+	str	r4, [r3, #EMIF_SDRAM_REFRESH_CTRL_SHDW]
+	ldr	r4, emif_pmcr_val
+	str	r4, [r3, #EMIF_POWER_MANAGEMENT_CONTROL]
+	ldr	r4, emif_pmcr_shdw_val
+	str	r4, [r3, #EMIF_POWER_MANAGEMENT_CTRL_SHDW]
+
+	/*
+	 * A write to SDRAM CONFIG register triggers
+	 * an init sequence and hence it must be done
+	 * at the end
+	 */
+	ldr	r4, emif_sdcfg_val
+	str	r4, [r3, #EMIF_SDRAM_CONFIG]
+
+	/* Back from la-la-land. Kill some time for sanity to settle in */
+	mov	r0, #0x1000
+wait_resume:
+	subs	r0, r0, #1
+	bne	wait_resume
+
+	/* We are back. Branch to the common CPU resume routine */
+	mov	r0, #0
+	ldr	pc, resume_addr
+ENDPROC(am33xx_resume_from_deep_sleep)
+
+
+/*
+ * Local variables
+ */
+	.align
+resume_addr:
+	.word	cpu_resume - PAGE_OFFSET + 0x80000000
+dcache_flush:
+	.word   v7_flush_dcache_all
+emif_addr_func:
+	.word	am33xx_get_emif_base
+ddr_start:
+	.word	PAGE_OFFSET
+emif_phys_addr:
+	.word	AM33XX_EMIF_BASE
+virt_mpu_idlest:
+	.word	AM33XX_CM_IDLEST_DPLL_MPU
+virt_mpu_clk_mode:
+	.word	AM33XX_CM_CLKMODE_DPLL_MPU
+phys_mpu_clk_mode:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_CLKMODE_DPLL_MPU_OFFSET)
+phys_mpu_idlest:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_IDLEST_DPLL_MPU_OFFSET)
+virt_core_idlest:
+	.word	AM33XX_CM_IDLEST_DPLL_CORE
+virt_core_clk_mode:
+	.word	AM33XX_CM_CLKMODE_DPLL_CORE
+phys_core_clk_mode:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_CLKMODE_DPLL_CORE_OFFSET)
+phys_core_idlest:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_IDLEST_DPLL_CORE_OFFSET)
+virt_per_idlest:
+	.word	AM33XX_CM_IDLEST_DPLL_PER
+virt_per_clk_mode:
+	.word	AM33XX_CM_CLKMODE_DPLL_PER
+phys_per_clk_mode:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_CLKMODE_DPLL_PER_OFFSET)
+phys_per_idlest:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_IDLEST_DPLL_PER_OFFSET)
+virt_disp_idlest:
+	.word	AM33XX_CM_IDLEST_DPLL_DISP
+virt_disp_clk_mode:
+	.word	AM33XX_CM_CLKMODE_DPLL_DISP
+phys_disp_clk_mode:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_CLKMODE_DPLL_DISP_OFFSET)
+phys_disp_idlest:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_IDLEST_DPLL_DISP_OFFSET)
+virt_ddr_idlest:
+	.word	AM33XX_CM_IDLEST_DPLL_DDR
+virt_ddr_clk_mode:
+	.word	AM33XX_CM_CLKMODE_DPLL_DDR
+phys_ddr_clk_mode:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_CLKMODE_DPLL_DDR_OFFSET)
+phys_ddr_idlest:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_WKUP_MOD + \
+		AM33XX_CM_IDLEST_DPLL_DDR_OFFSET)
+virt_sram_ldo_addr:
+	.word	AM33XX_PRM_LDO_SRAM_MPU_CTRL
+phys_sram_ldo_addr:
+	.word	(AM33XX_PRM_BASE + AM33XX_PRM_DEVICE_MOD + \
+		AM33XX_PRM_LDO_SRAM_MPU_CTRL_OFFSET)
+virt_mpu_clkctrl:
+	.word	AM33XX_CM_MPU_MPU_CLKCTRL
+virt_emif_clkctrl:
+	.word	AM33XX_CM_PER_EMIF_CLKCTRL
+phys_emif_clkctrl:
+	.word	(AM33XX_CM_BASE + AM33XX_CM_PER_MOD + \
+		AM33XX_CM_PER_EMIF_CLKCTRL_OFFSET)
+module_disabled_val:
+	.word	0x30000
+
+/* DDR related defines */
+virt_ddr_io_ctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_DDR_IO_CTRL)
+phys_ddr_io_ctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_DDR_IO_CTRL
+virt_ddr_vtp_ctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_VTP0_CTRL_REG)
+phys_ddr_vtp_ctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_VTP0_CTRL_REG
+virt_ddr_cmd0_ioctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_DDR_CMD0_IOCTRL)
+phys_ddr_cmd0_ioctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_DDR_CMD0_IOCTRL
+virt_ddr_cmd1_ioctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_DDR_CMD1_IOCTRL)
+phys_ddr_cmd1_ioctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_DDR_CMD1_IOCTRL
+virt_ddr_cmd2_ioctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_DDR_CMD2_IOCTRL)
+phys_ddr_cmd2_ioctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_DDR_CMD2_IOCTRL
+virt_ddr_data0_ioctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_DDR_DATA0_IOCTRL)
+phys_ddr_data0_ioctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_DDR_DATA0_IOCTRL
+virt_ddr_data1_ioctrl:
+	.word	AM33XX_CTRL_REGADDR(AM33XX_DDR_DATA1_IOCTRL)
+phys_ddr_data1_ioctrl:
+	.word	AM33XX_CTRL_BASE + AM33XX_DDR_DATA1_IOCTRL
+vtp_enable:
+	.word	AM33XX_VTP_CTRL_ENABLE
+
+/* Values recommended by the HW team */
+susp_io_pull_data:
+	.word	0x3FF00003
+susp_io_pull_cmd1:
+	.word   0xFFE0018B
+susp_io_pull_cmd2:
+	.word   0xFFA0098B
+resume_io_pull_data:
+	.word	0x18B
+resume_io_pull_cmd:
+	.word	0x18B
+susp_vtp_ctrl_val:
+	.word	0x10117
+
+/* Placeholder for storing EMIF configuration */
+emif_addr_virt:
+	.word	0xDEADBEEF
+emif_rd_lat_val:
+	.word	0xDEADBEEF
+emif_timing1_val:
+	.word	0xDEADBEEF
+emif_timing2_val:
+	.word	0xDEADBEEF
+emif_timing3_val:
+	.word	0xDEADBEEF
+emif_sdcfg_val:
+	.word	0xDEADBEEF
+emif_ref_ctrl_val:
+	.word	0xDEADBEEF
+emif_zqcfg_val:
+	.word	0xDEADBEEF
+emif_pmcr_val:
+	.word	0xDEADBEEF
+emif_pmcr_shdw_val:
+	.word	0xDEADBEEF
+
+/* Placeholder for storing PLL mode */
+clk_mode_mpu_val:
+	.word	0xDEADBEEF
+clk_mode_per_val:
+	.word	0xDEADBEEF
+clk_mode_disp_val:
+	.word	0xDEADBEEF
+clk_mode_ddr_val:
+	.word	0xDEADBEEF
+clk_mode_core_val:
+	.word	0xDEADBEEF
+
+	.align 3
+ENTRY(am33xx_do_wfi_sz)
+	.word	. - am33xx_do_wfi
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 70dcc22..c96a9d1 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -182,7 +182,7 @@ static void __init omap_map_sram(void)
 		omap_sram_size -= SZ_16K;
 	}
 #endif
-	if (cpu_is_omap34xx()) {
+	if (cpu_is_omap34xx() || soc_is_am33xx()) {
 		/*
 		 * SRAM must be marked as non-cached on OMAP3 since the
 		 * CORE DPLL M2 divider change code (in SRAM) runs with the
@@ -381,10 +381,18 @@ static inline int omap34xx_sram_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_SOC_AM33XX
 static inline int am33xx_sram_init(void)
 {
+	am33xx_push_sram_idle();
 	return 0;
 }
+#else
+static inline int am33xx_sram_init(void)
+{
+	return 0;
+}
+#endif
 
 int __init omap_sram_init(void)
 {
diff --git a/arch/arm/plat-omap/sram.h b/arch/arm/plat-omap/sram.h
index cefda2e..4790340 100644
--- a/arch/arm/plat-omap/sram.h
+++ b/arch/arm/plat-omap/sram.h
@@ -85,8 +85,10 @@ extern unsigned long omap3_sram_configure_core_dpll_sz;
 
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
+extern void am33xx_push_sram_idle(void);
 #else
 static inline void omap_push_sram_idle(void) {}
+static inline void am33xx_push_sram_idle(void) {}
 #endif /* CONFIG_PM */
 
 #endif /* __ASSEMBLY__ */
-- 
1.7.0.4

