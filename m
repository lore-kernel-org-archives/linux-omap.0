From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] arm/kdump: fix kernel panic for masking disabled irq
Date: Sun, 17 Jan 2016 11:56:46 +0800
Message-ID: <20160117035646.GA15086@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

kdump testing on Beaglebone black triggered below kernel panic which is caused by
accessing some disabled gpio module.

In booting phase omap_gpio_probe -> ... -> __irq_do_set_handler -> mask_ack_irq
will mask/disable the irq desc since handle == handle_bad_irq.

Thus fix it by only masking the unmasked irq desc to avoid kernel panic.  

[   66.344456] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa1ac140
[   66.352142] pgd = dd9f0000
[   66.354856] [fa1ac140] *pgd=48011452(bad)
[   66.358896] Internal error: : 1028 [#2] SMP THUMB2
[   66.363703] Modules linked in: ti_cpsw cpsw_ale cpsw_common omap_hwspinlock hwspinlock_core ir_lirc_codec lirc_dev ir_xmp_decoder is
[   66.391072] CPU: 0 PID: 402 Comm: bash Not tainted 4.4.0-rc6+ #80
[   66.397190] Hardware name: Generic AM33XX (Flattened Device Tree)
[   66.403307] task: df51d240 ti: ddc38000 task.ti: ddc38000
[   66.408731] PC is at omap_set_gpio_triggering+0x86/0x23c
[   66.414065] LR is at omap_set_gpio_triggering+0x87/0x23c
[   66.419398] pc : [<c01f2276>]    lr : [<c01f2277>]    psr: a00e01b3
[   66.419398] sp : ddc39c30  ip : 0000001f  fp : c021e550
[   66.430923] r10: 00000002  r9 : c021e554  r8 : 00000001
[   66.436168] r7 : fa1ac000  r6 : 00000000  r5 : df0d4a10  r4 : fa1ac140
[   66.442721] r3 : 00000001  r2 : 00000007  r1 : 00000000  r0 : 00000020
[   66.449276] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment none
[   66.456701] Control: 50c5387d  Table: 9d9f0019  DAC: 00000051
[   66.462469] Process bash (pid: 402, stack limit = 0xddc38218)
[   66.468237] Stack: (0xddc39c30 to 0xddc3a000)
[   66.472612] 9c20:                                     df0d4a10 df0d4a64 00000000 a00e0193
[   66.480827] 9c40: 0000000b c021e554 00000002 c01f2551 c01f2529 df0d7700 0000005a df0d7890
[   66.489041] 9c60: c06f3530 c0012f35 ddc39c78 c0768f04 ddc39c80 ddc39e58 200e0113 c00803fd
[   66.497256] 9c80: 00000063 df93647c 1f26a000 00000000 00000001 00000063 00000007 c0702e3c
[   66.505471] 9ca0: 00000000 ddc38000 00000000 7f70d614 00000030 ddc39ea8 c021e54b c021e54c
[   66.513686] 9cc0: 600e0033 ffffffff c0730644 c06d86f4 ddc39e58 c0010f51 ddc38218 0000000b
[   66.521901] 9ce0: 600e0113 200e0113 00000020 ddc38000 bf000000 00000004 38000000 20653466
[   66.530116] 9d00: 61663566 37396620 33322064 28203030 63313037 64622029 00203031 df78b5c4
[   66.538331] 9d20: 00000031 c005f8df c05f3de0 ddc39d4c 0000000a 00000000 ddc39e58 00000805
[   66.546546] 9d40: df78b580 df78b580 c076c724 df78b5c4 00000031 c001bc23 00000000 c0412e11
[   66.554761] 9d60: c06cd6dc 00000000 00000000 c006021b c005f36e 00010000 00000800 00000000
[   66.562976] 9d80: c0755f44 c041250d 00000000 c06d8a0c 00000805 00000000 ddc39e8c ddc39e58
[   66.571191] 9da0: c06d8a5c 00000000 7f70d614 c00091ff 00000000 00000001 00000e65 00000406
[   66.579405] 9dc0: 00000000 00000406 600e0013 c0412165 00000406 c005f1c3 0000000f 0a2f88ba
[   66.587620] 9de0: 0000000f c0753f28 c07335f8 c0753308 600e0013 c06f3408 00000000 00000001
[   66.595834] 9e00: df936478 00000001 1f26a000 1f26a000 200e0013 c005f00b 00000001 0000000f
[   66.604049] 9e20: 00000001 c005f665 dfd4c668 c041215b 9b34a83f c00b49b9 00000000 c021e54c
[   66.612265] 9e40: 600e0033 ffffffff ddc39e8c 00000000 ddc38000 c041247b 00000063 df93647c
[   66.620480] 9e60: 1f26a000 00000000 00000001 00000063 00000007 c0702e3c 00000000 ddc38000
[   66.628696] 9e80: 00000000 7f70d614 00000030 ddc39ea8 c021e54b c021e54c 600e0033 ffffffff
[   66.636910] 9ea0: 00000051 c021e54b c06f349c c021e8b5 00000055 00000002 00000051 00000001
[   66.645125] 9ec0: 00000000 df26d7c0 ddc38000 c021ec79 ddc39f88 c021ec35 00000000 c010695f
[   66.653340] 9ee0: df241200 c010691d c0423f80 ddc39f88 00000002 c00ca6a3 c06d8a7c 00000000
[   66.661556] 9f00: be9ac93c c00091ff 00000400 c0019001 b6f7a000 00001000 df78b580 00000002
[   66.669770] 9f20: dec84c38 df241200 00000000 c00cab05 00000073 c00b82f7 000b6f7a be9ac380
[   66.677985] 9f40: df241200 00000002 b6f7a000 ddc39f88 00000002 00000000 7f70d614 c00cacd7
[   66.686200] 9f60: 00000000 00000000 be9ac93c df241200 df241200 00000000 00000000 00000002
[   66.694415] 9f80: ddc38000 c00cb313 00000000 00000000 00000002 b6f7a000 b6ee2d60 00000004
[   66.702630] 9fa0: c000df84 c000ddc1 00000002 b6f7a000 00000001 b6f7a000 00000002 00000000
[   66.710845] 9fc0: 00000002 b6f7a000 b6ee2d60 00000004 00000002 00000000 7f72cd94 7f70d614
[   66.719060] 9fe0: 00000000 be9ac8fc b6dfcae4 b6e60690 600e0010 00000001 00000000 00000000
[   66.727278] [<c01f2276>] (omap_set_gpio_triggering) from [<c01f2551>] (omap_gpio_mask_irq+0x29/0x34)
[   66.736457] [<c01f2551>] (omap_gpio_mask_irq) from [<c0012f35>] (machine_crash_shutdown+0xb9/0x104)
[   66.745551] [<c0012f35>] (machine_crash_shutdown) from [<c00803fd>] (crash_kexec+0x35/0x68)
[   66.753942] [<c00803fd>] (crash_kexec) from [<c0010f51>] (die+0x1b9/0x390)
[   66.760859] [<c0010f51>] (die) from [<c001bc23>] (__do_kernel_fault.part.0+0x4f/0x1cc)
[   66.768824] [<c001bc23>] (__do_kernel_fault.part.0) from [<c0412e11>] (do_page_fault+0x155/0x29c)
[   66.777740] [<c0412e11>] (do_page_fault) from [<c00091ff>] (do_DataAbort+0x2f/0x88)
[   66.785432] [<c00091ff>] (do_DataAbort) from [<c041247b>] (__dabt_svc+0x3b/0x80)
[   66.792858] Exception stack(0xddc39e58 to 0xddc39ea0)
[   66.797929] 9e40:                                                       00000063 df93647c
[   66.806144] 9e60: 1f26a000 00000000 00000001 00000063 00000007 c0702e3c 00000000 ddc38000
[   66.814359] 9e80: 00000000 7f70d614 00000030 ddc39ea8 c021e54b c021e54c 600e0033 ffffffff
[   66.822575] [<c041247b>] (__dabt_svc) from [<c021e54c>] (sysrq_handle_crash+0x18/0x1c)
[   66.830530] [<c021e54c>] (sysrq_handle_crash) from [<c021e8b5>] (__handle_sysrq+0x79/0x10c)
[   66.838919] [<c021e8b5>] (__handle_sysrq) from [<c021ec79>] (write_sysrq_trigger+0x45/0x50)
[   66.847310] [<c021ec79>] (write_sysrq_trigger) from [<c010695f>] (proc_reg_write+0x43/0x68)
[   66.855700] [<c010695f>] (proc_reg_write) from [<c00ca6a3>] (__vfs_write+0xf/0x8c)
[   66.863304] [<c00ca6a3>] (__vfs_write) from [<c00cacd7>] (vfs_write+0x5f/0x128)
[   66.870646] [<c00cacd7>] (vfs_write) from [<c00cb313>] (SyS_write+0x2b/0x68)
[   66.877729] [<c00cb313>] (SyS_write) from [<c000ddc1>] (ret_fast_syscall+0x1/0x4c)
[   66.885332] Code: 443c 4643 f6a9 f9a1 (6823) 0732
[   66.890145] ---[ end trace 5a39094ece4dc200 ]---
[   66.894782] Kernel panic - not syncing: Fatal exception
[   66.900033] ---[ end Kernel panic - not syncing: Fatal exception

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux.orig/arch/arm/kernel/machine_kexec.c
+++ linux/arch/arm/kernel/machine_kexec.c
@@ -106,7 +106,7 @@ static void machine_kexec_mask_interrupt
 		if (chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
+		if ((chip->irq_mask) && !irqd_irq_masked(&desc->irq_data))
 			chip->irq_mask(&desc->irq_data);
 
 		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
