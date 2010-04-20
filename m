From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] Serial: Avoid enabling clocks when clock node is null.
Date: Tue, 20 Apr 2010 13:32:01 +0530 (IST)
Message-ID: <40436.192.168.10.89.1271750521.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46173 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab0DTICI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Apr 2010 04:02:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Venkatraman S <svenkatr@ti.com>


This patch ensures that if a particular uart clock node
was not acquired then do not proceed with enabling clock
and device registration for that uart.

Without this patch if uart_ick/fck value was null
then it throw oops as below and boot will halt.

<1>Unable to handle kernel NULL pointer dereference at virtual address 0000001c
<1>pgd = c0004000
<1>[0000001c] *pgd=00000000
<0>Internal error: Oops: 5 [#1]
<0>last sysfs file:
<d>Modules linked in:
CPU: 0    Not tainted  (2.6.34-rc3-00006-g7da06f1-dirty #15)
PC is at omap_serial_init_port+0x64/0x3a0
LR is at 0x8
pc : [<c000f51c>]    lr : [<00000008>]    psr: 60000013
sp : dfc2bf80  ip : 00000000  fp : 00000000
r10: 000007c8  r9 : c05c65f8  r8 : 00000000
r7 : c05c6dc0  r6 : c000b44c  r5 : 00000000  r4 : 00000004
r3 : 00000007  r2 : c05c6538  r1 : fb020000  r0 : c05c6dc0
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004019  DAC: 00000017
<0>Process swapper (pid: 1, stack limit = 0xdfc2a2f0)
<0>Stack: (0xdfc2bf80 to 0xdfc2c000)
<0>bf80: 00000003 fb020000 00000004 00000000 c000b44c 00000000 00000000 00000000
<0>bfa0: 00000000 c000f880 c002e288 c00135e0 c002e288 c00137f4 c002e288 c000b464
<0>bfc0: c002e288 c003e34c 00000031 00000000 00000000 00000192 00000000 c002e288
<0>bfe0: 00000000 00000000 00000000 c0008578 00000000 c003f970 ffffffff ffffffff
[<c000f51c>] (omap_serial_init_port+0x64/0x3a0) from [<c000f880>] (omap_serial_init+0x28/0x3c)
[<c000f880>] (omap_serial_init+0x28/0x3c) from [<c00135e0>] (zoom_peripherals_init+0x44/0x6c)
[<c00135e0>] (zoom_peripherals_init+0x44/0x6c) from [<c00137f4>] (omap_sdp_init+0x14/0x54)
[<c00137f4>] (omap_sdp_init+0x14/0x54) from [<c000b464>] (customize_machine+0x18/0x24)
[<c000b464>] (customize_machine+0x18/0x24) from [<c003e34c>] (do_one_initcall+0x5c/0x1b8)
[<c003e34c>] (do_one_initcall+0x5c/0x1b8) from [<c0008578>] (kernel_init+0x90/0x144)
[<c0008578>] (kernel_init+0x90/0x144) from [<c003f970>] (kernel_thread_exit+0x0/0x8)
<0>Code: eb00ef8f e597c06c e3a0e008 e3a03007 (e5dc201c)
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill init!

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Reported-by: Venkatraman S <svenkatr@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index da77930..6d21872 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -727,6 +727,14 @@ void __init omap_serial_init_port(int port)
 	pdev = &uart->pdev;
 	dev = &pdev->dev;

+	/*
+	 * If clock nodes where not acquired
+	 * then do not proceed with enabling
+	 * clocks and device registration.
+	 */
+	if (!uart->fck || !uart->ick)
+		return;
+
 	omap_uart_enable_clocks(uart);

 	omap_uart_reset(uart);
-- 
1.6.3.3




