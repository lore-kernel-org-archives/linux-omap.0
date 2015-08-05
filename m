From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] memory: omap-gpmc: Don't try to save the GPMC context
Date: Wed,  5 Aug 2015 14:24:15 +0200
Message-ID: <1438777455-28009-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

...if there isn't one already.

If for some reason the GPMC device hasn't been probed yet, gpmc_base is
going to be NULL. Because there's no context yet to be saved, just turn
these functions into no-ops until that device gets probed.

Unable to handle kernel NULL pointer dereference at virtual address 00000010
pgd = c0204000
[00000010] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc5-next-20150804-05947-g23f38fe8eda9 #1
Hardware name: Generic OMAP3-GP (Flattened Device Tree)
task: c0e623e8 ti: c0e5c000 task.ti: c0e5c000
PC is at omap3_gpmc_save_context+0x8/0xc4
LR is at omap_sram_idle+0x154/0x23c
pc : [<c087c7ac>]    lr : [<c023262c>]    psr: 60000193
sp : c0e5df40  ip : c0f92a80  fp : c0999eb0
r10: c0e57364  r9 : c0e66f14  r8 : 00000003
r7 : 00000000  r6 : 00000003  r5 : 00000000  r4 : c0f5f174
r3 : c0fa4fe8  r2 : 00000000  r1 : 00000000  r0 : fa200280
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80204019  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0xc0e5c220)
Stack: (0xc0e5df40 to 0xc0e5e000)
df40: 00000000 c0e66ef8 c0f5f1a4 00000000 00000003 c02333a4 c3813822 00000000
df60: 00000000 c0e5a5c8 cfb8a5d0 c07f0c44 0e4f1d7e 00000000 00000000 00000000
df80: c3813822 00000000 cfb8a5d0 c0e5e4e4 cfb8a5d0 c0e66f14 c0e5a5c8 c0e5e54c
dfa0: c0e5e544 c0e57364 c0999eb0 c0277758 000000fa c0f5d000 00000000 c0d61c18
dfc0: ffffffff ffffffff 00000000 c0d61674 00000000 c0df7a48 00000000 c0f5d5d4
dfe0: c0e5e4c0 c0df7a44 c0e634f8 80204059 00000000 8020807c 00000000 00000000
[<c087c7ac>] (omap3_gpmc_save_context) from [<c023262c>] (omap_sram_idle+0x154/0x23c)
[<c023262c>] (omap_sram_idle) from [<c02333a4>] (omap3_enter_idle_bm+0xec/0x1a8)
[<c02333a4>] (omap3_enter_idle_bm) from [<c07f0c44>] (cpuidle_enter_state+0xbc/0x284)
[<c07f0c44>] (cpuidle_enter_state) from [<c0277758>] (cpu_startup_entry+0x174/0x24c)
[<c0277758>] (cpu_startup_entry) from [<c0d61c18>] (start_kernel+0x358/0x3c0)
[<c0d61c18>] (start_kernel) from [<8020807c>] (0x8020807c)
Code: c0ccace8 c0ccacc0 e59f30b4 e5932000 (e5921010)

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Suggested-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 drivers/memory/omap-gpmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 3a27a84ad3ec..9426276dbe14 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2245,6 +2245,9 @@ void omap3_gpmc_save_context(void)
 {
 	int i;
 
+	if (!gpmc_base)
+		return;
+
 	gpmc_context.sysconfig = gpmc_read_reg(GPMC_SYSCONFIG);
 	gpmc_context.irqenable = gpmc_read_reg(GPMC_IRQENABLE);
 	gpmc_context.timeout_ctrl = gpmc_read_reg(GPMC_TIMEOUT_CONTROL);
@@ -2277,6 +2280,9 @@ void omap3_gpmc_restore_context(void)
 {
 	int i;
 
+	if (!gpmc_base)
+		return;
+
 	gpmc_write_reg(GPMC_SYSCONFIG, gpmc_context.sysconfig);
 	gpmc_write_reg(GPMC_IRQENABLE, gpmc_context.irqenable);
 	gpmc_write_reg(GPMC_TIMEOUT_CONTROL, gpmc_context.timeout_ctrl);
-- 
2.4.3
