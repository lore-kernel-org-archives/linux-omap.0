From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Problems with powermanagement (suspend/wake/shutdown) on OMAP3530.
Date: Mon, 21 Mar 2011 15:14:08 +0100
Message-ID: <4D875D30.7090809@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070808090207000704040300"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33798 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1CUOOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Mar 2011 10:14:09 -0400
Received: by eyx24 with SMTP id 24so1516686eyx.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Mar 2011 07:14:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808090207000704040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We have a board with OMAP3530 (based on BeagleBoard C3), but with PWRON 
connected. I want to be able to put the board in suspend and shutdown 
from sw, and make it wake when it senses PWRON.

Currently I compile my own Angstrom-rootfs with OpenEmbedded, and 
therefore run the linux-omap-psp 2.6.32 kernel from 
git://arago-project.org/git/projects/linux-omap3.git.

By default the powerbutton worked, but pressing for 8 seconds did 
nothing. I pulled in some twl4030_scripts and setup from a TI Android 
Kernel with working powermanagement (patch attached), and that got the 8 
second reboot working, but I don't know how to get suspend/wake/shutdown 
working.

Suspend:
The following was output in my serial console:

root@board1:~# echo mem > /sys/power/state
[ 4042.726776] PM: Syncing filesystems ... done.

Then I pressed Ctrl-C and got some more output:

^C[ 4046.452270] Freezing user space processes ... (elapsed 0.01 
seconds) done.
[ 4046.478424] Freezing remaining freezable tasks ... (elapsed 0.01 
seconds) done.
[ 4046.501892] Suspending console(s) (use no_console_suspend to debug)

I tried using no_console_suspend, and saw a crash in mmc_suspend_host 
(attached).

Shutdown:
The patch gives me "pm_power_off = twl4030_poweroff", but I don't know 
how to shutdown my board in a way that would cause this function to be run.


And that's pretty much where I am now. I've collected some pieces of the 
puzzle, but I'm not entirely sure it's the right puzzle. Should I be 
able to achieve my goals with this kernel? If so, what's missing/wrong?


Regards,
Tasslehoff

--------------070808090207000704040300
Content-Type: text/x-patch;
 name="0001-Add-powerscript-and-i2c-driver-for-twl4030_poweroff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-powerscript-and-i2c-driver-for-twl4030_poweroff.pat";
 filename*1="ch"

>From c8d51a054bc5c6f926846aa8b1e61bc0c705cb83 Mon Sep 17 00:00:00 2001
From: tasslehoff <tasskjapp@gmail.com>
Date: Tue, 15 Mar 2011 15:33:33 +0100
Subject: [PATCH] Add powerscript and i2c driver for twl4030_poweroff.

---
 arch/arm/mach-omap2/board-omap3beagle.c |  109 +++++++++++++++++
 drivers/i2c/chips/Makefile              |    1 +
 drivers/i2c/chips/twl4030-poweroff.c    |  200 +++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/twl4030-poweroff.c

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 6dc7b23..fd247d1 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -404,6 +404,105 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	return 0;
 }
 
+
+static struct twl4030_ins __initdata sleep_on_seq[] = {
+	/* Turn OFF VAUX2 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VAUX2, RES_STATE_OFF), 2},
+	/* Turn off HFCLKOUT */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_HFCLKOUT, RES_STATE_OFF), 2},
+	/* Turn OFF VDD1 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VDD1, RES_STATE_OFF), 2},
+	/* Turn OFF VDD2 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VDD2, RES_STATE_OFF), 2},
+	/* Turn OFF VPLL1 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VPLL1, RES_STATE_OFF), 2},
+};
+
+static struct twl4030_script sleep_on_script __initdata = {
+	.script	= sleep_on_seq,
+	.size	= ARRAY_SIZE(sleep_on_seq),
+	.flags	= TWL4030_SLEEP_SCRIPT,
+};
+
+static struct twl4030_ins wakeup_p12_seq[] __initdata = {
+	/* Turn on VAUX2 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VAUX2, RES_STATE_ACTIVE), 2},
+	/* Turn on HFCLKOUT */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_HFCLKOUT, RES_STATE_ACTIVE), 2},
+	/* Turn ON VDD1 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VDD1, RES_STATE_ACTIVE), 2},
+	/* Turn ON VDD2 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VDD2, RES_STATE_ACTIVE), 2},
+	/* Turn ON VPLL1 */
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VPLL1, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_p12_script __initdata = {
+	.script	= wakeup_p12_seq,
+	.size	= ARRAY_SIZE(wakeup_p12_seq),
+	.flags	= TWL4030_WAKEUP12_SCRIPT,
+};
+
+static struct twl4030_ins wakeup_p3_seq[] __initdata = {
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_p3_script __initdata = {
+	.script = wakeup_p3_seq,
+	.size   = ARRAY_SIZE(wakeup_p3_seq),
+	.flags  = TWL4030_WAKEUP3_SCRIPT,
+};
+
+static struct twl4030_ins wrst_seq[] __initdata = {
+/*
+ * Reset twl4030.
+ * Reset VDD1 regulator.
+ * Reset VDD2 regulator.
+ * Reset VPLL1 regulator.
+ * Enable sysclk output.
+ * Reenable twl4030.
+ */
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VDD1, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VDD2, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VPLL1, RES_STATE_WRST), 0x60},
+	{MSG_SINGULAR(DEV_GRP_P1, RES_HFCLKOUT, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_P1, RES_VAUX2, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, RES_RESET, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wrst_script __initdata = {
+	.script = wrst_seq,
+	.size   = ARRAY_SIZE(wrst_seq),
+	.flags  = TWL4030_WRST_SCRIPT,
+};
+
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&sleep_on_script,
+	&wakeup_p12_script,
+	&wakeup_p3_script,
+	&wrst_script,
+};
+
+static struct twl4030_resconfig twl4030_rconfig[] = {
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
+		.type2 = -1 },
+/* XXX removed, breaks booting after power-off
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
+		.type2 = -1 },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
+		.type2 = -1 },
+*/
+	{ 0, 0},
+};
+
+static struct twl4030_power_data beagle_power_data __initdata = {
+	.scripts	= twl4030_scripts,
+	.num		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
+};
+
+
 static struct twl4030_gpio_platform_data beagle_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -544,6 +643,7 @@ static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
+        .power          = &beagle_power_data,
 	.codec		= &beagle_codec_data,
 	.madc		= &beagle_madc_data,
 	.vmmc1		= &beagle_vmmc1,
@@ -799,6 +899,13 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static void enable_board_wakeup_source(void)
+{
+	/* T2 interrupt line (keypad) */
+	omap_mux_init_signal("sys_nirq",
+		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
+}
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	/* Camera - Parallel Data */
@@ -925,6 +1032,8 @@ static void __init omap3_beagle_init(void)
 
 	usb_musb_init();
 	usb_ehci_init(&ehci_pdata);
+	enable_board_wakeup_source();
+
 	omap3beagle_flash_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index fe0af0f..d085c59 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,6 +11,7 @@
 #
 
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
+obj-$(CONFIG_TWL4030_POWER)     += twl4030-poweroff.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/i2c/chips/twl4030-poweroff.c b/drivers/i2c/chips/twl4030-poweroff.c
new file mode 100644
index 0000000..dbbba72
--- /dev/null
+++ b/drivers/i2c/chips/twl4030-poweroff.c
@@ -0,0 +1,200 @@
+/*
+ * linux/drivers/i2c/chips/twl4030_poweroff.c
+ *
+ * Power off device
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/i2c/twl.h>
+#ifdef CONFIG_MACH_ARCHOS
+#include <mach/board-archos.h>
+#endif
+
+#define PWR_P1_SW_EVENTS	0x10
+#define PWR_P2_SW_EVENTS	0x11
+#define PWR_P3_SW_EVENTS	0x13
+#define PWR_DEVOFF		(1<<0)
+#define PWR_STOPON_POWERON 	(1<<6)
+#define PWR_LVL_WAKEUP		(1<<3)
+
+#define PWR_CFG_P1_TRANSITION	0x00
+#define PWR_CFG_P2_TRANSITION	0x01
+#define PWR_CFG_P3_TRANSITION	0x02
+#define PWR_CFG_P123_TRANSITION	0x03
+
+#define SEQ_OFFSYNC	(1<<0)
+#define STARTON_PWRON		0x01
+#define STARTON_VBUS		0x20
+
+#define R_PROTECT_KEY		0x0E
+#define KEY_1			0xFC
+#define KEY_2 			0x96
+
+#define R_VDD1_DEV_GRP		0x55
+#define R_VDD2_DEV_GRP		0x63
+
+static void twl_dump_power_regs(void)
+{
+	u8 i;
+	
+	for (i = 0; i < 0x25; i++) {
+		u8 regval;
+		twl_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &regval, i);
+		printk("PM_MASTER reg 0x%02x => %02x\n", i, regval);
+	}
+}
+
+static int unprotect_pm_master(void)
+{
+	int err;
+	
+	/* unlock registers for writing
+	 * FIXME: should this sequence be protected with a spin lock?
+	 */
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_1,
+				R_PROTECT_KEY);
+	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_2,
+				R_PROTECT_KEY);
+	if (err)
+		pr_warning("TWL4030 Unable to unlock registers\n");
+
+	return err;
+}
+
+static int protect_pm_master(void)
+{
+	int err;
+
+	/* lock registers again */
+	if ((err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY)) != 0)
+		printk(KERN_ERR
+			"TWL4030 Unable to relock registers\n");
+
+	return err;
+}
+
+static int twl_set_bits(u8 mod_no, u8 val, u8 reg)
+{
+	int err;
+	u8 uninitialized_var(reg_val);
+	
+	err = twl_i2c_read_u8(mod_no, &reg_val, reg);
+	if (err < 0)
+		return err;
+	
+	reg_val |= val;
+	err = twl_i2c_write_u8(mod_no, reg_val, reg);
+	
+	return err;
+}
+
+static int twl_clear_bits(u8 mod_no, u8 val, u8 reg)
+{
+	int err;
+	u8 uninitialized_var(reg_val);
+	
+	err = twl_i2c_read_u8(mod_no, &reg_val, reg);
+	if (err < 0)
+		return err;
+	
+	reg_val &= ~val;
+	err = twl_i2c_write_u8(mod_no, reg_val, reg);
+	
+	return err;	
+}
+
+static void twl4030_poweroff(void)
+{
+	u8 uninitialized_var(val);
+	int err;
+
+	unprotect_pm_master();	
+	/* Make sure SEQ_OFFSYNC is set so that all the res goes to wait-on */
+	err = twl_set_bits(TWL4030_MODULE_PM_MASTER, SEQ_OFFSYNC, 
+			PWR_CFG_P123_TRANSITION);	
+	protect_pm_master();
+
+	if (err < 0) {
+		pr_warning("I2C error %d while setting TWL4030 PM_MASTER CFG_P123_TRANSITION\n", err);
+		return;
+	}
+
+	err = twl_set_bits(TWL4030_MODULE_PM_MASTER, 
+			PWR_STOPON_POWERON | PWR_DEVOFF, PWR_P1_SW_EVENTS);
+	
+	if (err < 0) {
+		pr_warning("I2C error %d while writing TWL4030 PM_MASTER P1_SW_EVENTS\n", err);
+	}
+
+	return;
+}
+
+static int __init twl4030_poweroff_init(void)
+{
+	int err;
+	u8 starton_flags;
+	
+	unprotect_pm_master();
+	
+	starton_flags = STARTON_PWRON;
+	
+	/*if (!machine_has_usbhost_plug())
+          starton_flags |= STARTON_VBUS; */
+	
+	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, starton_flags, 
+			PWR_CFG_P1_TRANSITION);
+	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, starton_flags, 
+			PWR_CFG_P2_TRANSITION);
+	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, starton_flags, 
+			PWR_CFG_P3_TRANSITION);
+	if (err)
+		pr_warning("TWL4030 Unable to configure STARTON transition\n");
+	
+	protect_pm_master();
+
+	err = twl_set_bits(TWL4030_MODULE_PM_MASTER, PWR_STOPON_POWERON, 
+			PWR_P1_SW_EVENTS);
+	err |= twl_set_bits(TWL4030_MODULE_PM_MASTER, PWR_STOPON_POWERON, 
+			PWR_P2_SW_EVENTS);
+	err |= twl_set_bits(TWL4030_MODULE_PM_MASTER, PWR_STOPON_POWERON,
+			PWR_P3_SW_EVENTS);
+	if (err) {
+		printk(KERN_WARNING "I2C error %d while writing TWL4030"
+					"PM_MASTER P1_SW_EVENTS\n", err);
+	}
+
+	pm_power_off = twl4030_poweroff;
+        printk(KERN_INFO "TWL4030 POWEROFF INIT");
+	return 0;
+}
+
+static void __exit twl4030_poweroff_exit(void)
+{
+	pm_power_off = NULL;
+}
+
+module_init(twl4030_poweroff_init);
+module_exit(twl4030_poweroff_exit);
+
+MODULE_ALIAS("i2c:twl4030-poweroff");
+MODULE_DESCRIPTION("Triton2 device power off");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Peter De Schrijver");
-- 
1.7.1


--------------070808090207000704040300
Content-Type: text/plain;
 name="suspend-crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="suspend-crash.txt"

root@board1:~# echo mem > /sys/power/state 
[  469.046936] PM: Syncing filesystems ... done.


^C[  478.647308] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  478.673461] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[  478.765441] Unable to handle kernel paging request at virtual address 3d454341
[  478.772735] pgd = cf0c0000
[  478.775451] [3d454341] *pgd=00000000
[  478.779052] Internal error: Oops: 805 [#1] PREEMPT
[  478.783874] last sysfs file: /sys/devices/platform/ehci-omap.0/usb2/2-2/2-2.4/devnum
[  478.791656] Modules linked in: sdmak lpm_omap3530 dsplinkk cmemk ipv6 rtc_twl rtc_core
[  478.799682] CPU: 0    Tainted: G        W   (2.6.32 #3)
[  478.804931] PC is at del_timer+0xbc/0x138
[  478.808959] LR is at lock_timer_base+0x34/0x6c
[  478.813446] pc : [<c0075dcc>]    lr : [<c0075cd8>]    psr: 60000093
[  478.813446] sp : cfb81e78  ip : cfb81e60  fp : cfb81ec8
[  478.824981] r10: c064f240  r9 : 00000005  r8 : 00000002
[  478.830230] r7 : 00000000  r6 : 656e0064  r5 : c05c70dd  r4 : c05c6f15
[  478.836791] r3 : 00000000  r2 : 46524554  r1 : 3d454341  r0 : 46524554
[  478.843383] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  478.850646] Control: 10c5387d  Table: 8f0c0019  DAC: 00000015
[  478.856414] Process sh (pid: 809, stack limit = 0xcfb802f0)
[  478.861999] Stack: (0xcfb81e78 to 0xcfb82000)
[  478.866394] 1e60:                                                       c0632c08 20000013
[  478.874633] 1e80: c05c6f15 00000000 cf887808 c03826f8 cfa28240 00000000 cf887808 c038bc24
[  478.882843] 1ea0: c04a8c58 00000000 cf887860 00000002 cf88783c c02b7d7c cf887808 c02ba8bc
[  478.891082] 1ec0: cf887808 c02badc4 cf887660 cfbe7658 c056cf42 00000000 00000003 00000003
[  478.899291] 1ee0: c0485878 cfbe8000 cf21e4d8 00000004 000a3008 c009da34 c05707a0 00000000
[  478.907531] 1f00: c056cf42 c009dca0 c056cf42 00000003 00000003 c009d324 4001e000 00000004
[  478.915740] 1f20: cf80eba8 cf21e4c0 cf81ba00 c0649d08 cfb81f80 c0252534 cf80eba8 c013dbd8
[  478.923980] 1f40: cf11cec0 4001e000 cfb81f80 4001e000 00000004 cfb80000 00000001 c00e89b4
[  478.932220] 1f60: 00000003 00000007 00000000 00000000 cf11cec0 4001e000 00000004 c00e8b60
[  478.940429] 1f80: 00000000 00000000 c0039144 00000000 00000004 4001e000 401bc5d0 00000004
[  478.948669] 1fa0: c0039144 c0038fc0 00000004 4001e000 00000001 4001e000 00000004 00000000
[  478.956878] 1fc0: 00000004 4001e000 401bc5d0 00000004 00000004 000a33f0 00000001 000a3008
[  478.965118] 1fe0: 00000000 bed5a5b0 400fa028 4014d32c 60000010 00000001 00000000 00000000
[  478.973358] [<c0075dcc>] (del_timer+0xbc/0x138) from [<c03826f8>] (mmc_suspend_host+0x44/0x1c4)
[  478.982116] [<c03826f8>] (mmc_suspend_host+0x44/0x1c4) from [<c038bc24>] (omap_hsmmc_suspend+0x74/0x104)
[  478.991668] [<c038bc24>] (omap_hsmmc_suspend+0x74/0x104) from [<c02b7d7c>] (platform_pm_suspend+0x4c/0x5c)
[  479.001403] [<c02b7d7c>] (platform_pm_suspend+0x4c/0x5c) from [<c02ba8bc>] (pm_op+0x30/0x7c)
[  479.009887] [<c02ba8bc>] (pm_op+0x30/0x7c) from [<c02badc4>] (dpm_suspend_start+0x36c/0x4a0)
[  479.018402] [<c02badc4>] (dpm_suspend_start+0x36c/0x4a0) from [<c009da34>] (suspend_devices_and_enter+0x40/0x1cc)
[  479.028717] [<c009da34>] (suspend_devices_and_enter+0x40/0x1cc) from [<c009dca0>] (enter_state+0xe0/0x138)
[  479.038452] [<c009dca0>] (enter_state+0xe0/0x138) from [<c009d324>] (state_store+0x94/0xc8)
[  479.046844] [<c009d324>] (state_store+0x94/0xc8) from [<c0252534>] (kobj_attr_store+0x1c/0x24)
[  479.055511] [<c0252534>] (kobj_attr_store+0x1c/0x24) from [<c013dbd8>] (sysfs_write_file+0x104/0x138)
[  479.064788] [<c013dbd8>] (sysfs_write_file+0x104/0x138) from [<c00e89b4>] (vfs_write+0xac/0x1a0)
[  479.073638] [<c00e89b4>] (vfs_write+0xac/0x1a0) from [<c00e8b60>] (sys_write+0x40/0x6c)
[  479.081695] [<c00e8b60>] (sys_write+0x40/0x6c) from [<c0038fc0>] (ret_fast_syscall+0x0/0x2c)
[  479.090209] Code: eb102aaa e5952000 e5951004 e3a03000 (e5812000) 

--------------070808090207000704040300--
