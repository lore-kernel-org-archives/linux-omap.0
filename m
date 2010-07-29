From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
Subject: [PATCH v2] twl4030 reboot workaround
Date: Thu, 29 Jul 2010 09:41:18 +0300
Message-ID: <1280385678-4366-1-git-send-email-ext-mikko.rapeli@nokia.com>
References: <20100729061608.GG12063@edollo>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43107 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0G2Glh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 02:41:37 -0400
In-Reply-To: <20100729061608.GG12063@edollo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mturquette@ti.com, sameo@linux.intel.com

From: Mikko Rapeli <ext-mikko.rapeli@nokia.com>

Original patch: http://marc.info/?l=linux-omap&m=126522625032441&w=2

"Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
in the sleep script being executed on TWL4030. This usually results in
VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
MPU Watch Dog reset or worse, an irrecoverable hang."

Original patch resulted in a crash due to sleeping i2c calls late in the
reboot sequence. Here's how to trigger the crash:

	# cat /dev/urandom > /foo &
	sync();
	reboot(LINUX_REBOOT_CMD_RESTART2);

Kernel trace from 2.6.32:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#2] PREEMPT
...
[<c00b3210>] (exit_mmap+0x1d4/0x1f8) from [<c006069c>] (mmput+0x34/0x110)
[<c006069c>] (mmput+0x34/0x110) from [<c0064a90>] (exit_mm+0x140/0x180)
[<c0064a90>] (exit_mm+0x140/0x180) from [<c00668ec>] (do_exit+0x5d8/0x6ac)
[<c00668ec>] (do_exit+0x5d8/0x6ac) from [<c0035858>] (die+0x2d4/0x2e0)
[<c0035858>] (die+0x2d4/0x2e0) from [<c0035904>] (baddataabort+0x0/0x50)
[<c0035904>] (baddataabort+0x0/0x50) from [<c0274ff4>] (i2c_transfer+0xec/0x104)
[<c0274ff4>] (i2c_transfer+0xec/0x104) from [<00000001>] (0x1)

Fix is to move reboot preparations into a reboot notifier.

Signed-off-by: Mikko Rapeli <ext-mikko.rapeli@nokia.com>
Acked-by: Mike Turquette <mturquette@ti.com>
---

v2: added a new line after variable declarations

v1: http://marc.info/?l=linux-omap&m=128031011323970&w=2

 drivers/mfd/twl4030-power.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 7efa878..5c6da1e 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -28,6 +28,7 @@
 #include <linux/pm.h>
 #include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 
 #include <asm/mach-types.h>
 
@@ -127,6 +128,30 @@ static u8 res_config_addrs[] = {
 	[RES_Main_Ref]	= 0x94,
 };
 
+/*
+ * PRCM on OMAP3 will drive SYS_OFFMODE low during DPLL3 warm reset.
+ * This causes Gaia sleep script to execute, usually killing VDD1 and
+ * VDD2 while code is running.  WA is to disable the sleep script
+ * before warm reset.
+ */
+static int twl4030_prepare_for_reboot(struct notifier_block *this,
+		unsigned long cmd, void *p)
+{
+	int err;
+
+	err = twl4030_remove_script(TWL4030_SLEEP_SCRIPT);
+	if (err)
+		pr_err("TWL4030: error trying to disable sleep script!\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block twl4030_reboot_notifier = {
+		.notifier_call = twl4030_prepare_for_reboot,
+		.next = NULL,
+		.priority = 0
+};
+
 static int __init twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
@@ -549,6 +574,11 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 	err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY);
 	if (err)
 		pr_err("TWL4030 Unable to relock registers\n");
+
+	err = register_reboot_notifier(&twl4030_reboot_notifier);
+	if (err)
+		pr_err("TWL4030 Failed to register reboot notifier\n");
+
 	return;
 
 unlock:
-- 
1.5.6.5

