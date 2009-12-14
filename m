From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH] OMAP3: serial - fix bug introduced in f62349ee9788b1d94c55eb6c291d74a1f69bdd9e
Date: Mon, 14 Dec 2009 15:59:18 +0200
Message-ID: <1260799158-20064-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47592 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902AbZLNN6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 08:58:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Commit f62349ee9788b1d94c55eb6c291d74a1f69bdd9e had side effect that
causes kernel to oops when we are suspending to ram:

	# echo mem > /sys/power/state

	WARNING: at kernel/irq/manage.c:858 __free_irq+0x90/0x174()
	Trying to free already-free IRQ 72
	Modules linked in:
	Backtrace:
	[<c00328d0>] (dump_backtrace+0x0/0x110) from [<c0347298>] (dump_stack+0x18/0x1c)
	 r7:dfd4be08 r6:c009505c r5:c03fbfd1 r4:0000035a
	[<c0347280>] (dump_stack+0x0/0x1c) from [<c005a408>] (warn_slowpath_common+0x50/0x68)
	[<c005a3b8>] (warn_slowpath_common+0x0/0x68) from [<c005a46c>] (warn_slowpath_fmt+0x30)
	 r7:c0474afc r6:00000048 r5:00000000 r4:c0474ac0
	[<c005a43c>] (warn_slowpath_fmt+0x0/0x38) from [<c009505c>] (__free_irq+0x90/0x174)
	 r3:00000048 r2:c03fc0ef
	[<c0094fcc>] (__free_irq+0x0/0x174) from [<c0095184>] (free_irq+0x44/0x64)
	[<c0095140>] (free_irq+0x0/0x64) from [<c0038100>] (omap_uart_enable_irqs+0x4c/0x90)
	 r7:c034d58c r6:00000003 r5:00000000 r4:c0463028
	[<c00380b4>] (omap_uart_enable_irqs+0x0/0x90) from [<c003d8f8>] (omap3_pm_begin+0x1c/0)
	 r5:00000003 r4:00000000
	[<c003d8dc>] (omap3_pm_begin+0x0/0x28) from [<c008d008>] (suspend_devices_and_enter+0x)
	[<c008cfd8>] (suspend_devices_and_enter+0x0/0x1dc) from [<c008d29c>] (enter_state+0xe8)
	 r5:c03f7f46 r4:00000000
	[<c008d1b4>] (enter_state+0x0/0x140) from [<c008c8e0>] (state_store+0x9c/0xc4)
	 r7:c034d58c r6:00000003 r5:00000003 r4:c03f7f46
	[<c008c844>] (state_store+0x0/0xc4) from [<c01cb2dc>] (kobj_attr_store+0x20/0x24)
	[<c01cb2bc>] (kobj_attr_store+0x0/0x24) from [<c0119420>] (sysfs_write_file+0x114/0x14)
	[<c011930c>] (sysfs_write_file+0x0/0x148) from [<c00cb298>] (vfs_write+0xb8/0x164)
	[<c00cb1e0>] (vfs_write+0x0/0x164) from [<c00cb408>] (sys_write+0x44/0x70)
	 r8:4001f000 r7:00000004 r6:df81bd00 r5:00000000 r4:00000000
	[<c00cb3c4>] (sys_write+0x0/0x70) from [<c002f040>] (ret_fast_syscall+0x0/0x38)
	 r8:c002f204 r7:00000004 r6:401fa5e8 r5:4001f000 r4:00000004

This is due the fact that uart_list list was populated in
omap_serial_early_init() and omap_uart_enable_irqs() went through this
list even when serial idle wasn't enabled for all uarts.

This patch moves the code that populates the uart_list and enables uart
clocks into omap_serial_init_port().

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---

Tested with RX-51.

 arch/arm/mach-omap2/serial.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 39b797b..19805a7 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -640,12 +640,9 @@ void __init omap_serial_early_init(void)
 		uart->num = i;
 		p->private_data = uart;
 		uart->p = p;
-		list_add_tail(&uart->node, &uart_list);
 
 		if (cpu_is_omap44xx())
 			p->irq += 32;
-
-		omap_uart_enable_clocks(uart);
 	}
 }
 
@@ -673,9 +670,13 @@ void __init omap_serial_init_port(int port)
 	pdev = &uart->pdev;
 	dev = &pdev->dev;
 
+	omap_uart_enable_clocks(uart);
+
 	omap_uart_reset(uart);
 	omap_uart_idle_init(uart);
 
+	list_add_tail(&uart->node, &uart_list);
+
 	if (WARN_ON(platform_device_register(pdev)))
 		return;
 
-- 
1.5.6.5

