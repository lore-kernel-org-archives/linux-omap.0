From: hvaibhav@ti.com
Subject: [PATCH FIX] OMAP: DSS: Fix for kernel crash during reboot
Date: Fri, 12 Mar 2010 11:04:22 +0530
Message-ID: <1268372062-5269-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59786 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab0CLFee (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 00:34:34 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Kernel crash is observed when you include DSS, respctive drivers and issue
"reboot" command.
Added return from function omapdss_dpi_display_disable, if interface is already
disabled.

Crash Log -
============
root@omap3evm:~# reboot

Broadcast message from root (ttyS0) (Fri Dec  4 03:51:10 2009):

The system is going down for reboot NOW!
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
INIT:Stopping telnet daemon.
Stopping syslogd/klogd: stopped syslogd (pid 1187)
stopped klogd (pid 1189)
done
Stopping thttpd.
NOT deconfiguring network interfaces: / is an NFS mount
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Unmounting remote filesystems...
Deactivating swap...
Unmounting local filesystems...
mount: can't find /mnt/ram in /proc/mounts
umount: none busy - remounted read-only
mount: cannot read /proc/mounts: No such file or directory
Rebooting... Unable to handle kernel NULL pointer dereference at virtual
address 0000007c
pgd = c7dac000
[0000007c] *pgd=87f52031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in:
CPU: 0    Not tainted  (2.6.34-rc1-07844-g49f7ae9-dirty #1)
PC is at omapdss_dpi_display_disable+0x14/0x3c
LR is at omapdss_dpi_display_disable+0x18/0x3c
pc : [<c019d64c>]    lr : [<c019d650>]    psr: 60000013
sp : c6ccde40  ip : fa070000  fp : 00000000
r10: 00000000  r9 : c6ccc000  r8 : c0030028
r7 : 00000002  r6 : 00000000  r5 : c019d8e0  r4 : c03d7a98
r3 : 00000000  r2 : 00000000  r1 : 00000002  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87dac019  DAC: 00000015
Process reboot (pid: 1237, stack limit = 0xc6ccc2e8)
Stack: (0xc6ccde40 to 0xc6cce000)
de40: c03d7a98 c01a5ea8 00000000 c019d8f0 00000000 c01c7e48 c7c44cf8 c7c84170
de60: c03d8ad8 c03da84c fee1dead c01c944c c03d8ad8 c01c5490 00000000 c0063f9c
de80: 00000000 c0063fdc 00000000 c0064178 c7f3d6c0 c0094168 000000b4 00000000
dea0: 00000000 c028a0e4 bee2fc90 000000ee 00000000 000003b8 c7dad000 00000000
dec0: 00000002 c6d54b20 c7c166c0 c7f3d6c0 400ee980 c7f3d6f4 00000200 c7c166c0
dee0: c7f3d6c0 c0036560 c7e1c040 c0240700 c03cdfc4 c03ce034 00000007 c6ccdfb0
df00: 400ee980 000121d8 c7e1c040 c7e1c0e0 c6c88740 c028bc08 c7e1c040 00000000
df20: c6ccdf20 c6ccdf20 c789c6e8 c789db98 ffffffff c00b7508 c7801398 c789db98
df40: ffffffff c00b4958 c789db98 00000000 ffffffff c00b4fe0 00000014 c00a74c8
df60: 00000000 00000000 c6c88740 00000000 c6f866c0 00000006 c6c88740 00000000
df80: c6f866c0 c00a45ec c6f866e8 c6f866c0 c6c88740 00000000 00000001 00000004
dfa0: 00000058 c002fe80 00000000 00000001 fee1dead 28121969 01234567 00000002
dfc0: 00000000 00000001 00000004 00000058 000121d0 00000001 00000001 00000000
dfe0: 400f6710 bee2fcb8 000092f0 400f6728 60000010 fee1dead 00000000 00000000
[<c019d64c>] (omapdss_dpi_display_disable+0x14/0x3c) from [<c01a5ea8>]
(generic_panel_disable+0xc/0x18)
[<c01a5ea8>] (generic_panel_disable+0xc/0x18) from [<c019d8f0>]
(dss_disable_device+0x10/0x18)
[<c019d8f0>] (dss_disable_device+0x10/0x18) from [<c01c7e48>]
(bus_for_each_dev+0x44/0x74)
[<c01c7e48>] (bus_for_each_dev+0x44/0x74) from [<c01c944c>]
(platform_drv_shutdown+0x18/0x1c)
[<c01c944c>] (platform_drv_shutdown+0x18/0x1c) from [<c01c5490>]
(device_shutdown+0x54/0x84)
[<c01c5490>] (device_shutdown+0x54/0x84) from [<c0063f9c>]
(kernel_restart_prepare+0x24/0x34)
[<c0063f9c>] (kernel_restart_prepare+0x24/0x34) from [<c0063fdc>]
(kernel_restart+0xc/0x40)
[<c0063fdc>] (kernel_restart+0xc/0x40) from [<c0064178>]
(sys_reboot+0x160/0x1b8)
[<c0064178>] (sys_reboot+0x160/0x1b8) from [<c002fe80>]
(ret_fast_syscall+0x0/0x2c)
Code: e59031a4 e1a04000 e1a00003 e1a0e00f (e593f07c)
***[ end trace c52dd0f51f03150e ]***

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..70c6902 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -210,6 +210,9 @@ EXPORT_SYMBOL(omapdss_dpi_display_enable);

 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
+	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
+		return;
+
 	dssdev->manager->disable(dssdev->manager);

 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
--
1.6.2.4

