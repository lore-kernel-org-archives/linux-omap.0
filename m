From: Nishanth Menon <nm@ti.com>
Subject: next-20160401+: ARM: DRA7: linux-next regression: mm/slab: clean-up
 kmem_cache_node setup
Date: Fri, 8 Apr 2016 15:39:20 -0500
Message-ID: <570816F8.9070301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

http://marc.info/?l=linux-omap&m=146014314115625&w=2 series works with
v4.6-rc2 kernel, however, it fails with linux-next for suspend-to-ram
(mem) on BeagleBoard-X15

next-20160327 - good
next-20160329 - good
next-20160330 - Fails to boot - I2C crashes
next-20160331-  Fails to boot - USB crashes
next-20160401 -> bad
next-20160408 -> bad

Bisect log of next-20160408 vs v4.6-rc2 ->
http://pastebin.ubuntu.com/15697856/

# first bad commit: [2b629704a2b6a5b239f23750e5517a9d8c3a4e8c]
mm/slab: clean-up kmem_cache_node setup

Fail bootlog @ 2b629704a2b6a5b239f23750e5517a9d8c3a4e8c
http://pastebin.ubuntu.com/15698107/

Working bootlog @  7a6bacb133752beacb76775797fd550417e9d3a2:
http://pastebin.ubuntu.com/15698220/

Crash Signature (from full log):
> 
> rtcwake: wakeup from "mem" using /dev/rtc0 at Mon Jan  1 00:00:53 2001
> [   51.631373] PM: Syncing filesystems ... done.
> [   51.683927] Freezing user space processes ... (elapsed 0.003 seconds) done.
> [   51.694960] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   51.875457] PM: suspend of devices complete after 167.835 msecs
> [   51.885396] PM: late suspend of devices complete after 3.714 msecs
> [   51.896333] PM: noirq suspend of devices complete after 4.441 msecs
> [   51.902972] Disabling non-boot CPUs ...
> [   51.911312] CPU1: shutdown
> [   51.950123] Powerdomain (l4per_pwrdm) didn't enter target state 1
> [   51.950123] Powerdomain (l3init_pwrdm) didn't enter target state 1
> [   51.950123] Could not enter target state in pm_suspend
> [   51.950123] A possible cause could be an old bootloader - try u-boot >= v2012.07
> [   51.950407] Enabling non-boot CPUs ...
> [   52.005646] CPU1: smp_ops.cpu_die() returned, trying to resuscitate
> [   52.006271] CPU1 is up
> [   52.018194] PM: noirq resume of devices complete after 2.846 msecs
> [   52.028303] PM: early resume of devices complete after 2.998 msecs
> [   52.037132] net eth0: initializing cpsw version 1.15 (0)
> [   52.042545] Unable to handle kernel paging request at virtual address ffffff81
> [   52.042549] pgd = c0004000
> [   52.042559] [ffffff81] *pgd=afffd861, *pte=00000000, *ppte=00000000
> [   52.042566] Internal error: Oops: 837 [#1] SMP ARM
> [   52.042642] Modules linked in: xhci_plat_hcd xhci_hcd usbcore encoder_tpd12s015 connector_hdmi omapfb cfbcopyarea
> cfbimgblt cfbfillrect dwc3 leds_gpio snd_soc_simple_card led_class evdev cpufreq_dt udc_core gpio_fan omapdss extcon_
> usb_gpio snd_soc_tlv320aic3x snd_soc_davinci_mcasp phy_omap_usb2 omap_wdt rtc_omap extcon_palmas snd_soc_omap snd_soc
> _edma ti_soc_thermal tmp102 snd_soc_core snd_pcm_dmaengine dwc3_omap rtc_palmas extcon snd_pcm snd_timer palmas_pwrbu
> tton thermal_sys snd at24 nvmem_core rtc_ds1307 hwmon soundcore
> [   52.042649] CPU: 0 PID: 78 Comm: kworker/0:2 Not tainted 4.6.0-rc2-00128-g1f5f5556aac5 #40
> [   52.042651] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   52.042667] Workqueue: events cache_reap
> [   52.042671] task: ee73b0c0 ti: ee73c000 task.ti: ee73c000
> [   52.042676] PC is at free_block+0xf4/0x160
> [   52.042680] LR is at 0xeddf51e0
> [   52.042684] pc : [<c0276c44>]    lr : [<eddf51e0>]    psr: 20070093
> [   52.042684] sp : ee73de18  ip : 00000002  fp : ee73de50
> [   52.042687] r10: c1882280  r9 : 00000100  r8 : 00000200
> [   52.042691] r7 : ffffff7f  r6 : 00000005  r5 : 04f4a70a  r4 : ee3dbd00
> [   52.042694] r3 : ef46b674  r2 : ee484190  r1 : ee484014  r0 : ee26d980
> [   52.042698] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   52.042701] Control: 10c5387d  Table: acc8c06a  DAC: 00000051
> [   52.042705] Process kworker/0:2 (pid: 78, stack limit = 0xee73c218)
> [   52.042708] Stack: (0xee73de18 to 0xee73e000)
> [   52.042711] de00:                                                       ee3dbd20 ee3dbd30
> [   52.042717] de20: c10035f0 ee484000 ee73de50 00000060 ee26d980 ee3dbd00 ee484010 ee73de78
> [   52.042723] de40: c10035f0 c027779c ee73de50 c07930fc ee73de50 ee73de50 ee3dbc00 ee26d980
> [   52.042728] de60: ee3dbd00 00000000 c1002100 c104dc68 ee73c000 c0277b10 00000000 00000000
> [   52.042733] de80: 00000000 eed717d0 ee720580 eed717d0 ee720580 eed74100 ee73dec8 eed7aa00
> [   52.042738] dea0: c10029cc c10c1ca0 00000001 c01537fc 00000001 00000000 c0153744 eed74100
> [   52.042743] dec0: 00000000 00000000 c1882fd8 c12107e0 00000000 c09a8e70 ee720580 eed74100
> [   52.042749] dee0: ee720598 00000008 eed74134 ee73c000 c1002100 eed74100 ee720580 c0153c88
> [   52.042753] df00: 00000000 ee720580 c0153c4c 00000000 ee723000 ee720580 c0153c4c 00000000
> [   52.042758] df20: 00000000 00000000 00000000 c0159b74 00000000 00000000 ee0ea100 ee720580
> [   52.042764] df40: 00000000 00000000 dead4ead ffffffff ffffffff c10c7db0 00000000 00000000
> [   52.042769] df60: c0994a18 ee73df64 ee73df64 00000000 00000000 dead4ead ffffffff ffffffff
> [   52.042774] df80: c10c7db0 00000000 00000000 c0994a18 ee73df90 ee73df90 ee723000 ee723000
> [   52.042779] dfa0: c0159aa4 00000000 00000000 c01078d0 00000000 00000000 00000000 00000000
> [   52.042784] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   52.042789] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [   52.042800] [<c0276c44>] (free_block) from [<c027779c>] (drain_array+0xb4/0xf4)
> [   52.042808] [<c027779c>] (drain_array) from [<c0277b10>] (cache_reap+0xc0/0x140)
> [   52.042820] [<c0277b10>] (cache_reap) from [<c01537fc>] (process_one_work+0x1fc/0x64c)
> [   52.042828] [<c01537fc>] (process_one_work) from [<c0153c88>] (worker_thread+0x3c/0x544)
> [   52.042836] [<c0153c88>] (worker_thread) from [<c0159b74>] (kthread+0xd0/0xf0)
> [   52.042845] [<c0159b74>] (kthread) from [<c01078d0>] (ret_from_fork+0x14/0x24)
> [   52.042852] Code: e2477001 e1a05635 0583e008 e583700c (e7cc5007)
> [   52.042858] ---[ end trace 0ea6e7e1bbe6e428 ]---
> [   52.042917] Unable to handle kernel paging request at virtual address ffffffd0
> [   52.042919] pgd = c0004000
> [   52.042927] [ffffffd0] *pgd=afffd861, *pte=00000000, *ppte=00000000
> [   52.042932] Internal error: Oops: 37 [#2] SMP ARM
> [   52.043001] Modules linked in: xhci_plat_hcd xhci_hcd usbcore encoder_tpd12s015 connector_hdmi omapfb cfbcopyarea
> cfbimgblt cfbfillrect dwc3 leds_gpio snd_soc_simple_card led_class evdev cpufreq_dt udc_core gpio_fan omapdss extcon_
> usb_gpio snd_soc_tlv320aic3x snd_soc_davinci_mcasp phy_omap_usb2 omap_wdt rtc_omap extcon_palmas snd_soc_omap snd_soc
> _edma ti_soc_thermal tmp102 snd_soc_core snd_pcm_dmaengine dwc3_omap rtc_palmas extcon snd_pcm snd_timer palmas_pwrbu
> tton thermal_sys snd at24 nvmem_core rtc_ds1307 hwmon soundcore
> [   52.043006] CPU: 0 PID: 78 Comm: kworker/0:2 Tainted: G      D         4.6.0-rc2-00128-g1f5f5556aac5 #40
> [   52.043008] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   52.043019] task: ee73b0c0 ti: ee73c000 task.ti: ee73c000
> [   52.043023] PC is at kthread_data+0x4/0xc
> [   52.043029] LR is at wq_worker_sleeping+0x8/0xcc
> [   52.043033] pc : [<c015a33c>]    lr : [<c0154b8c>]    psr: 20070193
> [   52.043033] sp : ee73dbd0  ip : eed74cc8  fp : ee73dc2c
> [   52.043035] r10: 00000001  r9 : ee73b4fc  r8 : eed74700
> [   52.043038] r7 : eed74710  r6 : c0ffa700  r5 : ee73b0c0  r4 : eed74700
> [   52.043040] r3 : 00000000  r2 : 00000020  r1 : 00000000  r0 : ee73b0c0
> [   52.043044] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   52.043047] Control: 10c5387d  Table: acc8c06a  DAC: 00000051
> [   52.043050] Process kworker/0:2 (pid: 78, stack limit = 0xee73c218)
> [   52.043053] Stack: (0xee73dbd0 to 0xee73e000)
> [   52.043058] dbc0:                                     eed74700 c0791d0c 00000000 00000000
> [   52.043063] dbe0: 00000001 c045219c 60070193 c0451d48 ee56fd2c c0792218 ee73b4f0 60070113
> [   52.043069] dc00: 00000000 ee26d580 ee73d88c ee73c000 00000000 ee0c4d40 ee73dc40 00000000
> [   52.043075] dc20: ee73b458 00000001 ee73dc3c c0792218 ee73b0c0 ee73d88c c0276c46 c013c58c
> [   52.043080] dc40: ee73dc40 ee73dc40 00000000 60070193 c0276c46 c010c554 ee73c218 0000000b
> [   52.043086] dc60: c0276c48 ee73c000 00000000 00000008 65000000 37373432 20313030 30613165
> [   52.043091] dc80: 35333635 38353020 30306533 35652038 30373338 28206330 63633765 37303035
> [   52.043097] dca0: c0002029 ee73dcc4 000007ff ffffff81 ee73ddc8 00000837 00000000 00000000
> [   52.043102] dcc0: 00000000 c1882280 ee73de50 c011d658 ffffff81 c0797f00 c10c13c9 c018c4e0
> [   52.043108] dce0: 60070093 c018a240 00000001 ee73b660 00000000 ee73b140 eed74760 00007b45
> [   52.043114] dd00: 00000000 c10097cc 00000837 c0797d18 ffffff81 ee73ddc8 00000100 c1882280
> [   52.043120] dd20: ee73de50 c0101344 c11fef60 ee73b668 ffffe000 00000000 60070093 00000000
> [   52.043126] dd40: 000001a9 ee73b140 00000072 00000001 ee73b6c8 c10808ac c1864394 ee73b0c0
> [   52.043132] dd60: c11f16a0 c018fb14 540f0072 0000aa07 c11f8eb0 ee73b668 ee73b660 c10808ac
> [   52.043137] dd80: c1864394 ee73b0c0 c11f16a0 c018fb14 503aa078 00000005 00000001 ee73b668
> [   52.043143] dda0: ee73b660 ee73b668 ee73b660 c018c4e0 c0276c44 20070093 ffffffff ee73ddfc
> [   52.043149] ddc0: 00000200 c07973ec ee26d980 ee484014 ee484190 ef46b674 ee3dbd00 04f4a70a
> [   52.043154] dde0: 00000005 ffffff7f 00000200 00000100 c1882280 ee73de50 00000002 ee73de18
> [   52.043160] de00: eddf51e0 c0276c44 20070093 ffffffff 00000051 ee3dbd00 ee3dbd20 ee3dbd30
> [   52.043166] de20: c10035f0 ee484000 ee73de50 00000060 ee26d980 ee3dbd00 ee484010 ee73de78
> [   52.043172] de40: c10035f0 c027779c ee73de50 c07930fc ee73de50 ee73de50 ee3dbc00 ee26d980
> [   52.043177] de60: ee3dbd00 00000000 c1002100 c104dc68 ee73c000 c0277b10 00000000 00000000
> [   52.043183] de80: 00000000 eed717d0 ee720580 eed717d0 ee720580 eed74100 ee73dec8 eed7aa00
> [   52.043188] dea0: c10029cc c10c1ca0 00000001 c01537fc 00000001 00000000 c0153744 eed74100
> [   52.043194] dec0: 00000000 00000000 c1882fd8 c12107e0 00000000 c09a8e70 ee720580 eed74100
> [   52.043200] dee0: ee720598 00000008 eed74134 ee73c000 c1002100 eed74100 ee720580 c0153c88
> [   52.043206] df00: 00000000 ee720580 c0153c4c 00000000 ee723000 ee720580 c0153c4c 00000000
> [   52.043211] df20: 00000000 00000000 00000000 c0159b74 00000000 00000000 ee0ea100 ee720580
> [   52.043217] df40: 00000000 00000000 dead4ead ffffffff ffffffff c10c7db0 00000000 00000000
> [   52.043222] df60: c0994a18 ee73df64 ee73df64 00000001 00010001 dead4ead ffffffff ffffffff
> [   52.043228] df80: c10c7db0 00000000 00000000 c0994a18 ee73df90 ee73df90 ee723000 ee723000
> [   52.043233] dfa0: c0159aa4 00000000 00000000 c01078d0 00000000 00000000 00000000 00000000
> [   52.043238] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   52.043243] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [   52.043251] [<c015a33c>] (kthread_data) from [<c0154b8c>] (wq_worker_sleeping+0x8/0xcc)
> [   52.043263] [<c0154b8c>] (wq_worker_sleeping) from [<c0791d0c>] (__schedule+0x750/0xc14)
> [   52.043270] [<c0791d0c>] (__schedule) from [<c0792218>] (schedule+0x48/0xa0)
> [   52.043278] [<c0792218>] (schedule) from [<c013c58c>] (do_exit+0x6f4/0xaf8)
> [   52.043283] [<c013c58c>] (do_exit) from [<c010c554>] (die+0x440/0x498)
> [   52.043290] [<c010c554>] (die) from [<c011d658>] (__do_kernel_fault.part.0+0x54/0x1e4)
> [   52.043298] [<c011d658>] (__do_kernel_fault.part.0) from [<c0797f00>] (do_page_fault+0x1e8/0x404)
> [   52.043305] [<c0797f00>] (do_page_fault) from [<c0101344>] (do_DataAbort+0x34/0xb4)
> [   52.043311] [<c0101344>] (do_DataAbort) from [<c07973ec>] (__dabt_svc+0x4c/0x80)
> [   52.043314] Exception stack(0xee73ddc8 to 0xee73de10)
> [   52.043319] ddc0:                   ee26d980 ee484014 ee484190 ef46b674 ee3dbd00 04f4a70a
> [   52.043324] dde0: 00000005 ffffff7f 00000200 00000100 c1882280 ee73de50 00000002 ee73de18
> [   52.043328] de00: eddf51e0 c0276c44 20070093 ffffffff
> [   52.043336] [<c07973ec>] (__dabt_svc) from [<c0276c44>] (free_block+0xf4/0x160)
> [   52.043344] [<c0276c44>] (free_block) from [<c027779c>] (drain_array+0xb4/0xf4)
> [   52.043352] [<c027779c>] (drain_array) from [<c0277b10>] (cache_reap+0xc0/0x140)
> [   52.043360] [<c0277b10>] (cache_reap) from [<c01537fc>] (process_one_work+0x1fc/0x64c)
> [   52.043367] [<c01537fc>] (process_one_work) from [<c0153c88>] (worker_thread+0x3c/0x544)
> [   52.043374] [<c0153c88>] (worker_thread) from [<c0159b74>] (kthread+0xd0/0xf0)
> [   52.043381] [<c0159b74>] (kthread) from [<c01078d0>] (ret_from_fork+0x14/0x24)
> [   52.043386] Code: c01597c4 c10c7db0 c0994a18 e59033f0 (e5130030)
> [   52.043390] ---[ end trace 0ea6e7e1bbe6e429 ]---
> [   52.043393] Fixing recursive fault but reboot is needed!
> [   53.046293] Generic PHY 48485000.mdio:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=48485000.mdio:01, ir
> q=-1)
> [   53.428374] BUG: spinlock lockup suspected on CPU#0, kworker/0:2/78
> [   53.434953]  lock: 0xeed74700, .magic: dead4ead, .owner: kworker/0:2/78, .owner_cpu: 0
> [   53.443263] CPU: 0 PID: 78 Comm: kworker/0:2 Tainted: G      D         4.6.0-rc2-00128-g1f5f5556aac5 #40
> [   53.453209] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   53.459619] [<c010feec>] (unwind_backtrace) from [<c010c110>] (show_stack+0x10/0x14)
> [   53.467748] [<c010c110>] (show_stack) from [<c0471024>] (dump_stack+0xac/0xe0)
> [   53.475335] [<c0471024>] (dump_stack) from [<c0194bc0>] (do_raw_spin_lock+0xec/0x1e8)
> [   53.483556] [<c0194bc0>] (do_raw_spin_lock) from [<c07916b8>] (__schedule+0xfc/0xc14)
> [   53.491774] [<c07916b8>] (__schedule) from [<c0792218>] (schedule+0x48/0xa0)
> [   53.499170] [<c0792218>] (schedule) from [<c013c7ec>] (do_exit+0x954/0xaf8)
> [   53.506473] [<c013c7ec>] (do_exit) from [<c010c554>] (die+0x440/0x498)
> [   53.513321] [<c010c554>] (die) from [<c011d658>] (__do_kernel_fault.part.0+0x54/0x1e4)
> [   53.521631] [<c011d658>] (__do_kernel_fault.part.0) from [<c0797f00>] (do_page_fault+0x1e8/0x404)
> [   53.530946] [<c0797f00>] (do_page_fault) from [<c0101344>] (do_DataAbort+0x34/0xb4)
> [   53.538979] [<c0101344>] (do_DataAbort) from [<c07973ec>] (__dabt_svc+0x4c/0x80)
> [   53.546740] Exception stack(0xee73db80 to 0xee73dbc8)
> [   53.552043] db80: ee73b0c0 00000000 00000020 00000000 eed74700 ee73b0c0 c0ffa700 eed74710
> [   53.560623] dba0: eed74700 ee73b4fc 00000001 ee73dc2c eed74cc8 ee73dbd0 c0154b8c c015a33c
> [   53.569199] dbc0: 20070193 ffffffff
> [   53.572862] [<c07973ec>] (__dabt_svc) from [<c015a33c>] (kthread_data+0x4/0xc)
> [   53.580439] [<c015a33c>] (kthread_data) from [<c0154b8c>] (wq_worker_sleeping+0x8/0xcc)
> [   53.588834] [<c0154b8c>] (wq_worker_sleeping) from [<c0791d0c>] (__schedule+0x750/0xc14)
> [   53.597328] [<c0791d0c>] (__schedule) from [<c0792218>] (schedule+0x48/0xa0)
> [   53.604728] [<c0792218>] (schedule) from [<c013c58c>] (do_exit+0x6f4/0xaf8)
> [   53.612034] [<c013c58c>] (do_exit) from [<c010c554>] (die+0x440/0x498)
> [   53.618886] [<c010c554>] (die) from [<c011d658>] (__do_kernel_fault.part.0+0x54/0x1e4)
> [   53.627198] [<c011d658>] (__do_kernel_fault.part.0) from [<c0797f00>] (do_page_fault+0x1e8/0x404)
> [   53.636511] [<c0797f00>] (do_page_fault) from [<c0101344>] (do_DataAbort+0x34/0xb4)
> [   53.644543] [<c0101344>] (do_DataAbort) from [<c07973ec>] (__dabt_svc+0x4c/0x80)
> [   53.652299] Exception stack(0xee73ddc8 to 0xee73de10)
> [   53.657600] ddc0:                   ee26d980 ee484014 ee484190 ef46b674 ee3dbd00 04f4a70a
> [   53.666180] dde0: 00000005 ffffff7f 00000200 00000100 c1882280 ee73de50 00000002 ee73de18
> [   53.674759] de00: eddf51e0 c0276c44 20070093 ffffffff
> [   53.680063] [<c07973ec>] (__dabt_svc) from [<c0276c44>] (free_block+0xf4/0x160)
> [   53.687732] [<c0276c44>] (free_block) from [<c027779c>] (drain_array+0xb4/0xf4)
> [   53.695406] [<c027779c>] (drain_array) from [<c0277b10>] (cache_reap+0xc0/0x140)
> [   53.703169] [<c0277b10>] (cache_reap) from [<c01537fc>] (process_one_work+0x1fc/0x64c)
> [   53.711483] [<c01537fc>] (process_one_work) from [<c0153c88>] (worker_thread+0x3c/0x544)
> [   53.719980] [<c0153c88>] (worker_thread) from [<c0159b74>] (kthread+0xd0/0xf0)
> [   53.727553] [<c0159b74>] (kthread) from [<c01078d0>] (ret_from_fork+0x14/0x24)
> [   53.735129] Sending NMI to all CPUs:
> [   53.740082] NMI backtrace for cpu 0
> [   53.743743] CPU: 0 PID: 78 Comm: kworker/0:2 Tainted: G      D         4.6.0-rc2-00128-g1f5f5556aac5 #40
> [   53.753683] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   53.760071] [<c010feec>] (unwind_backtrace) from [<c010c110>] (show_stack+0x10/0x14)
> [   53.768193] [<c010c110>] (show_stack) from [<c0471024>] (dump_stack+0xac/0xe0)
> [   53.775765] [<c0471024>] (dump_stack) from [<c0474b38>] (nmi_cpu_backtrace+0xe0/0xfc)
> [   53.783983] [<c0474b38>] (nmi_cpu_backtrace) from [<c010dab4>] (raise_nmi+0x60/0x70)
> [   53.792102] [<c010dab4>] (raise_nmi) from [<c0474dd8>] (nmi_trigger_all_cpu_backtrace+0x220/0x264)
> [   53.801497] [<c0474dd8>] (nmi_trigger_all_cpu_backtrace) from [<c0194bcc>] (do_raw_spin_lock+0xf8/0x1e8)
> [   53.811446] [<c0194bcc>] (do_raw_spin_lock) from [<c07916b8>] (__schedule+0xfc/0xc14)
> [   53.819659] [<c07916b8>] (__schedule) from [<c0792218>] (schedule+0x48/0xa0)
> [   53.827054] [<c0792218>] (schedule) from [<c013c7ec>] (do_exit+0x954/0xaf8)
> [   53.834355] [<c013c7ec>] (do_exit) from [<c010c554>] (die+0x440/0x498)
> [   53.841201] [<c010c554>] (die) from [<c011d658>] (__do_kernel_fault.part.0+0x54/0x1e4)
> [   53.849505] [<c011d658>] (__do_kernel_fault.part.0) from [<c0797f00>] (do_page_fault+0x1e8/0x404)
> [   53.858815] [<c0797f00>] (do_page_fault) from [<c0101344>] (do_DataAbort+0x34/0xb4)
> [   53.866843] [<c0101344>] (do_DataAbort) from [<c07973ec>] (__dabt_svc+0x4c/0x80)
> [   53.874601] Exception stack(0xee73db80 to 0xee73dbc8)
> [   53.879895] db80: ee73b0c0 00000000 00000020 00000000 eed74700 ee73b0c0 c0ffa700 eed74710
> [   53.888472] dba0: eed74700 ee73b4fc 00000001 ee73dc2c eed74cc8 ee73dbd0 c0154b8c c015a33c
> [   53.897047] dbc0: 20070193 ffffffff
> [   53.900706] [<c07973ec>] (__dabt_svc) from [<c015a33c>] (kthread_data+0x4/0xc)
> [   53.908282] [<c015a33c>] (kthread_data) from [<c0154b8c>] (wq_worker_sleeping+0x8/0xcc)
> [   53.916679] [<c0154b8c>] (wq_worker_sleeping) from [<c0791d0c>] (__schedule+0x750/0xc14)
> [   53.925161] [<c0791d0c>] (__schedule) from [<c0792218>] (schedule+0x48/0xa0)
> [   53.932554] [<c0792218>] (schedule) from [<c013c58c>] (do_exit+0x6f4/0xaf8)
> [   53.939852] [<c013c58c>] (do_exit) from [<c010c554>] (die+0x440/0x498)
> [   53.946697] [<c010c554>] (die) from [<c011d658>] (__do_kernel_fault.part.0+0x54/0x1e4)
> [   53.955006] [<c011d658>] (__do_kernel_fault.part.0) from [<c0797f00>] (do_page_fault+0x1e8/0x404)
> [   53.964317] [<c0797f00>] (do_page_fault) from [<c0101344>] (do_DataAbort+0x34/0xb4)
> [   53.972346] [<c0101344>] (do_DataAbort) from [<c07973ec>] (__dabt_svc+0x4c/0x80)
> [   53.980105] Exception stack(0xee73ddc8 to 0xee73de10)
> [   53.985404] ddc0:                   ee26d980 ee484014 ee484190 ef46b674 ee3dbd00 04f4a70a
> [   53.993990] dde0: 00000005 ffffff7f 00000200 00000100 c1882280 ee73de50 00000002 ee73de18
> [   54.002573] de00: eddf51e0 c0276c44 20070093 ffffffff
> [   54.007868] [<c07973ec>] (__dabt_svc) from [<c0276c44>] (free_block+0xf4/0x160)
> [   54.015533] [<c0276c44>] (free_block) from [<c027779c>] (drain_array+0xb4/0xf4)
> [   54.023196] [<c027779c>] (drain_array) from [<c0277b10>] (cache_reap+0xc0/0x140)
> [   54.030953] [<c0277b10>] (cache_reap) from [<c01537fc>] (process_one_work+0x1fc/0x64c)
> [   54.039256] [<c01537fc>] (process_one_work) from [<c0153c88>] (worker_thread+0x3c/0x544)
> [   54.047778] [<c0153c88>] (worker_thread) from [<c0159b74>] (kthread+0xd0/0xf0)
> [   54.055352] [<c0159b74>] (kthread) from [<c01078d0>] (ret_from_fork+0x14/0x24)
> [   54.062920] NMI backtrace for cpu 1
> [   54.066576] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.6.0-rc2-00128-g1f5f5556aac5 #40
> [   54.076246] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   54.082636] task: ee0ea100 ti: ee0ee000 task.ti: ee0ee000
> [   54.088295] PC is at cpu_startup_entry+0xc0/0x328
> [   54.093226] LR is at cpu_startup_entry+0xa8/0x328
> [   54.098159] pc : [<c0183a4c>]    lr : [<c0183a34>]    psr: 200c0013
> [   54.104725] sp : ee0effe0  ip : 00000000  fp : 00000000
> [   54.110203] r10: 00000000  r9 : c10029cc  r8 : c10c2218
> [   54.115680] r7 : 00000000  r6 : c1002a34  r5 : 00000000  r4 : ee0ee000
> [   54.122531] r3 : 00000001  r2 : ee0ea100  r1 : 00000000  r0 : c0183a34
> [   54.129375] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   54.136861] Control: 10c5387d  Table: acc8c06a  DAC: 00000051
> [   54.142884] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         4.6.0-rc2-00128-g1f5f5556aac5 #40
> [   54.152555] Hardware name: Generic DRA74X (Flattened Device Tree)
> [   54.158945] [<c010feec>] (unwind_backtrace) from [<c010c110>] (show_stack+0x10/0x14)
> [   54.167064] [<c010c110>] (show_stack) from [<c0471024>] (dump_stack+0xac/0xe0)
> [   54.174630] [<c0471024>] (dump_stack) from [<c0474af8>] (nmi_cpu_backtrace+0xa0/0xfc)
> [   54.182849] [<c0474af8>] (nmi_cpu_backtrace) from [<c010e38c>] (handle_IPI+0xe4/0x2b8)
> [   54.191151] [<c010e38c>] (handle_IPI) from [<c0101580>] (gic_handle_irq+0x94/0xb0)
> [   54.199092] [<c0101580>] (gic_handle_irq) from [<c0797478>] (__irq_svc+0x58/0x78)
> [   54.206940] Exception stack(0xee0eff90 to 0xee0effd8)
> [   54.212240] ff80:                                     c0183a34 00000000 ee0ea100 00000001
> [   54.220824] ffa0: ee0ee000 00000000 c1002a34 00000000 c10c2218 c10029cc 00000000 00000000
> [   54.229403] ffc0: 00000000 ee0effe0 c0183a34 c0183a4c 200c0013 ffffffff
> [   54.236345] [<c0797478>] (__irq_svc) from [<c0183a4c>] (cpu_startup_entry+0xc0/0x328)
> [   54.244560] [<c0183a4c>] (cpu_startup_entry) from [<c010df40>] (arch_cpu_idle_dead+0x60/0x9c)
> [   55.049340] cpsw 48484000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx


-- 
Regards,
Nishanth Menon
