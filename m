From: Mohan V <mohanvforum@gmail.com>
Subject: OMAP3: Enabling IO Daisy Chain
Date: Thu, 30 Jun 2011 12:39:03 +0530
Message-ID: <BANLkTinw1Qz7Q7H0n+d=3WA93Hpzty_g5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50139 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212Ab1F3HJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 03:09:04 -0400
Received: by vws1 with SMTP id 1so1418141vws.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 00:09:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com

Hello all,

I am trying to correct the implementation of the enabling/disabling IO
daisy chain in omap3. I am
following the steps as listed in the OMAP36xx TRM Sec. 3.5.7.2.2 for the same.

Branch: linux-omap-pm: "pm" branch
config: omap2plus_defconfig

Please find the below patch for the same.
------------------------------------------------------------

From: Mohan <mohanv@ti.com>
Date: Thu, 30 Jun 2011 12:19:55 +0530
Subject: [PATCH] omap3: pm: correct enable/disable of daisy io chain

Currently the enabling and disabling of IO Daisy chain is not
according to the TRM.
The below steps are followed to enable/disable the IO chain.

Steps to enable IO chain:
(a) Set PM_WKEN_WKUP.EN_IO bit
(b) Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
(c) Poll for PM_WKST_WKUP.ST_IO_CHAIN. When set to 1, clear it.

Steps to disable IO chain:
[a] Clear PM_WKEN_WKUP.EN_IO_CHAIN bit
[b] Clear PM_WKEN_WKUP.EN_IO bit
[c] Clear PM_WKST_WKUP.ST_IO bit by writing 1 to it.

Signed-off-by: Mohan V <mohanv@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d8c00e4..7f0d371 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -91,7 +91,7 @@ static void omap3_enable_io_chain(void)
 		/* Do a readback to assure write has been done */
 		prm_read_mod_reg(WKUP_MOD, PM_WKEN);

-		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -99,9 +99,9 @@ static void omap3_enable_io_chain(void)
 				       "activation failed.\n");
 				return;
 			}
-			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKEN);
 		}
+		prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
+					     WKUP_MOD, PM_WKST);
 	}
 }

@@ -572,6 +572,7 @@ void omap_sram_idle(void)
 			core_next_state < PWRDM_POWER_ON) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
+		prm_set_mod_reg_bits(OMAP3430_ST_IO_MASK, WKUP_MOD, PM_WKST);
 	}

 	pwrdm_post_transition();
-- 
1.7.1

------------------------------------------------------------

But I am seeing below continuous warning messages being printed after
this change, once the system comes
back from suspend with this change.

sh-4.1# echo mem > /sys/power/state
[   15.584960] PM: Syncing filesystems ... done.
[   16.477020] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   16.507537] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   16.544555] Suspending console(s) (use no_console_suspend to debug)
[   16.796661] PM: suspend of devices complete after 240.203 msecs
[   16.799652] PM: late suspend of devices complete after 2.929 msecs
[   16.799743] Disabling non-boot CPUs ...
[   16.800384] omap_device: omap_uart.2: new worst case deactivate
latency 0: 91552
[   39.979492] omap_device: omap_uart.0: new worst case activate
latency 0: 61035
[   39.979705] Successfully put all powerdomains to target state
[   39.981750] PM: early resume of devices complete after 1.831 msecs
[   39.982299] ------------[ cut here ]------------
[   39.982330] WARNING: at arch/arm/mach-omap2/pm34xx.c:291
prcm_interrupt_handler+0xfc/0x11c()
[   39.982330] prcm: WARNING: PRCM indicated MPU wakeup but no wakeup
sources are marked
[   39.982360] Modules linked in:
[   39.982391] [<c0065764>] (unwind_backtrace+0x0/0xf4) from
[<c009ca4c>] (warn_slowpath_common+0x4c/0x64)
[   39.982421] [<c009ca4c>] (warn_slowpath_common+0x4c/0x64) from
[<c009caf8>] (warn_slowpath_fmt+0x30/0x40)
[   39.982452] [<c009caf8>] (warn_slowpath_fmt+0x30/0x40) from
[<c0073858>] (prcm_interrupt_handler+0xfc/0x11c)
[   39.982482] [<c0073858>] (prcm_interrupt_handler+0xfc/0x11c) from
[<c00e60ac>] (handle_irq_event_percpu+0x5c/0x22c)
[   39.982513] [<c00e60ac>] (handle_irq_event_percpu+0x5c/0x22c) from
[<c00e62b8>] (handle_irq_event+0x3c/0x5c)
[   39.982543] [<c00e62b8>] (handle_irq_event+0x3c/0x5c) from
[<c00e8994>] (handle_level_irq+0xac/0x118)
[   39.982574] [<c00e8994>] (handle_level_irq+0xac/0x118) from
[<c00e5c14>] (generic_handle_irq+0x34/0x44)
[   39.982604] [<c00e5c14>] (generic_handle_irq+0x34/0x44) from
[<c005204c>] (asm_do_IRQ+0x4c/0xac)
[   39.982635] [<c005204c>] (asm_do_IRQ+0x4c/0xac) from [<c0491c5c>]
(__irq_svc+0x3c/0x120)
[   39.982635] Exception stack(0xef2c1e88 to 0xef2c1ed0)
[   39.982666] 1e80:                   00027a5f 00027a60 00000006
ef2c0000 a0000013 c062c9cc
[   39.982696] 1ea0: a0000013 c068372c c062c980 c04b3674 ef801820
be891bcc 00000003 ef2c1ed0
[   39.982696] 1ec0: c00d2fb0 c04919ac 20000013 ffffffff
[   39.982727] [<c0491c5c>] (__irq_svc+0x3c/0x120) from [<c04919ac>]
(_raw_spin_unlock_irqrestore+0x34/0x44)
[   39.982757] [<c04919ac>] (_raw_spin_unlock_irqrestore+0x34/0x44)
from [<c00ea7e8>] (resume_device_irqs+0x58/0x7c)
[   39.982788] [<c00ea7e8>] (resume_device_irqs+0x58/0x7c) from
[<c00e28a8>] (suspend_devices_and_enter+0x11c/0x284)
[   39.982818] [<c00e28a8>] (suspend_devices_and_enter+0x11c/0x284)
from [<c00e2afc>] (enter_state+0xec/0x128)
[   39.982818] [<c00e2afc>] (enter_state+0xec/0x128) from [<c00e1fa4>]
(state_store+0xd0/0x124)
[   39.982849] [<c00e1fa4>] (state_store+0xd0/0x124) from [<c0280a24>]
(kobj_attr_store+0x18/0x1c)
[   39.982879] [<c0280a24>] (kobj_attr_store+0x18/0x1c) from
[<c01a4bc0>] (sysfs_write_file+0xfc/0x180)
[   39.982910] [<c01a4bc0>] (sysfs_write_file+0xfc/0x180) from
[<c0148acc>] (vfs_write+0xb0/0x134)
[   39.982940] [<c0148acc>] (vfs_write+0xb0/0x134) from [<c0148c20>]
(sys_write+0x40/0x70)
[   39.982971] [<c0148c20>] (sys_write+0x40/0x70) from [<c005df40>]
(ret_fast_syscall+0x0/0x3c)
[   39.983001] ---[ end trace e50a27d94f6bdb1d ]---

--------------------------

Can anyone please let me know if I am missing something? I found this
link regarding the similar problem,
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33325.html

Thanks,
Mohan
