From: "Premi, Sanjeev" <premi@ti.com>
Subject: [RFC] OMAP3: PM: twl4030 keypad wakeup with off mode
Date: Fri, 6 Nov 2009 22:11:34 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39663 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611AbZKFQlj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 11:41:39 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA6GffZx031910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 6 Nov 2009 10:41:44 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA6Gffld013760
	for <linux-omap@vger.kernel.org>; Fri, 6 Nov 2009 22:11:41 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

Past few days, I had been noticing problem in waking up from
keypad when OFF mode was enabled.

I believe that I have "almost" fixed the issue with the patch
below. I say almost because I have so far tested only with the
EVM. Also I need to debug the "Unbalanced IRQ" seen in the log
below.

Also, the initialization of new fields in board-omap3-evm.c is
ad-hoc for quick testing. And there may be some redundant code
that I added during debug.

One question:
  The "board-h4.c" uses "omap_kp_platform_data" defined in
  "mach/keypad.h". All other boards use "twl4030_keypad_data"
  in "linux/i2c/twl4030.h". (Fields are same - just few additions)

  Which one is the preferred?

BTW, this patch is heavily based on similar code in "serial.c".

Best regards,
Sanjeev

==== LOG FROM CONSOLE ====

[root@OMAP3EVM /]# echo 1 > /sys/power/enable_off_mode
[root@OMAP3EVM /]#
[root@OMAP3EVM /]#
[root@OMAP3EVM /]# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.05 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
twl4030_keypad twl4030_keypad: suspending...
Successfully put all powerdomains to target state
twl4030_keypad twl4030_keypad: resuming...
------------[ cut here ]------------
WARNING: at kernel/irq/manage.c:356 set_irq_wake+0x78/0xdc()
Unbalanced IRQ 369 wake disable
Modules linked in:
[<c002f408>] (unwind_backtrace+0x0/0xdc) from [<c0053f6c>] (warn_slowpath_common+0x48/0x60)
[<c0053f6c>] (warn_slowpath_common+0x48/0x60) from [<c0053fbc>] (warn_slowpath_fmt+0x24/0x30)
[<c0053fbc>] (warn_slowpath_fmt+0x24/0x30) from [<c00798a8>] (set_irq_wake+0x78/0xdc)
[<c00798a8>] (set_irq_wake+0x78/0xdc) from [<c01f1ef4>] (twl4030_kp_resume+0x44/0x98)
[<c01f1ef4>] (twl4030_kp_resume+0x44/0x98) from [<c01bb474>] (platform_pm_resume+0x48/0x54)
[<c01bb474>] (platform_pm_resume+0x48/0x54) from [<c01bd07c>] (pm_op+0x4c/0x74)
[<c01bd07c>] (pm_op+0x4c/0x74) from [<c01bd6f0>] (dpm_resume_end+0x80/0x328)
[<c01bd6f0>] (dpm_resume_end+0x80/0x328) from [<c0077ca8>] (suspend_devices_and_enter+0x150/0x18c)
[<c0077ca8>] (suspend_devices_and_enter+0x150/0x18c) from [<c0077d90>] (enter_state+0xac/0xec)
[<c0077d90>] (enter_state+0xac/0xec) from [<c0077518>] (state_store+0x94/0xbc)
[<c0077518>] (state_store+0x94/0xbc) from [<c0176050>] (kobj_attr_store+0x18/0x1c)
[<c0176050>] (kobj_attr_store+0x18/0x1c) from [<c00e5124>] (sysfs_write_file+0x108/0x13c)
[<c00e5124>] (sysfs_write_file+0x108/0x13c) from [<c00a2468>] (vfs_write+0xac/0x154)
[<c00a2468>] (vfs_write+0xac/0x154) from [<c00a25bc>] (sys_write+0x3c/0x68)
[<c00a25bc>] (sys_write+0x3c/0x68) from [<c0029dc0>] (ret_fast_syscall+0x0/0x2c)
---[ end trace 54f593fa7172d35d ]---
Restarting tasks ... done.
[root@OMAP3EVM /]#
[root@OMAP3EVM /]#
[root@OMAP3EVM /]#

==== PATCH ====

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8283215..d485f23 100755
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -55,7 +55,9 @@
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
+#include "prm.h"
 #include "pm.h"
+#include "prm-regbits-34xx.h"
 #include "omap3-opp.h"
 #include "board-omap3evm-camera.h"
 
@@ -742,6 +744,13 @@ static void __init omap3_evm_init(void)
 
 	omap35x_pmic_init();
 
+#ifdef CONFIG_PM
+	omap3evm_kp_data.wk_st		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKEN1);
+	omap3evm_kp_data.wk_en		= OMAP34XX_PRM_REGADDR(WKUP_MOD, PM_WKST1);
+	omap3evm_kp_data.wk_mask	= (1 << 3);
+	omap3evm_kp_data.padconf	= 0x1e0 ;
+#endif
+
 	omap3_evm_i2c_init();
 
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 9a60979..d16a1cf 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -32,7 +32,9 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/io.h>
 #include <mach/keypad.h>
+#include <mach/control.h>
 
 /*
  * The TWL4030 family chips include a keypad controller that supports
@@ -315,6 +317,7 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 	if (!kp)
 		return -ENOMEM;
 
+	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, kp);
 
 	/* Get the debug Device */
@@ -458,6 +461,68 @@ static int __devexit twl4030_kp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int twl4030_kp_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
+	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
+
+	/* JUST FOR DEBUG */
+	dev_err(&pdev->dev, "suspending...");
+
+	/* Set wake-enable bit */
+	if (pdata->wk_en && pdata->wk_mask) {
+		u32 v = __raw_readl(pdata->wk_en);
+		v |= pdata->wk_mask;
+		__raw_writel(v, pdata->wk_en);
+	}
+
+	/* Ensure IOPAD wake-enables are set */
+	if (cpu_is_omap34xx() && pdata->padconf) {
+		u16 v = omap_ctrl_readw(pdata->padconf);
+		v |= OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, pdata->padconf);
+	}
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(kp->irq);
+
+	return 0;
+}
+
+static int twl4030_kp_resume(struct platform_device *pdev)
+{
+	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
+	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
+
+	/* JUST FOR DEBUG */
+	dev_err(&pdev->dev, "resuming...");
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(kp->irq);
+
+	/* Clear wake-enable bit */
+	if (pdata->wk_en && pdata->wk_mask) {
+		u32 v = __raw_readl(pdata->wk_en);
+		v &= ~pdata->wk_mask;
+		__raw_writel(v, pdata->wk_en);
+	}
+
+	/* Ensure IOPAD wake-enables are cleared */
+	if (cpu_is_omap34xx() && pdata->padconf) {
+		u16 v = omap_ctrl_readw(pdata->padconf);
+		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
+		omap_ctrl_writew(v, pdata->padconf);
+	}
+
+	return 0;
+}
+#else
+#define twl4030_kp_suspend	NULL
+#define twl4030_kp_resume	NULL
+#endif
+
+
 /*
  * NOTE: twl4030 are multi-function devices connected via I2C.
  * So this device is a child of an I2C parent, thus it needs to
@@ -469,6 +534,8 @@ MODULE_ALIAS("platform:twl4030_keypad");
 static struct platform_driver twl4030_kp_driver = {
 	.probe		= twl4030_kp_probe,
 	.remove		= __devexit_p(twl4030_kp_remove),
+	.suspend        = twl4030_kp_suspend,
+	.resume         = twl4030_kp_resume,
 	.driver		= {
 		.name	= "twl4030_keypad",
 		.owner	= THIS_MODULE,
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 9633be2..03925df 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -352,6 +352,12 @@ struct twl4030_keypad_data {
 	int irq;
 	unsigned int keymapsize;
 	unsigned int rep:1;
+#ifdef CONFIG_PM
+	void __iomem *wk_st;
+	void __iomem *wk_en;
+	u32 wk_mask;
+	u32 padconf;
+#endif
 };
 
 enum twl4030_usb_mode {
