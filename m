From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: v4.13 on nokia n900: oops during tethering
Date: Wed, 14 Feb 2018 00:24:12 +0200
Message-ID: <20180213222412.GA1116@mara.localdomain>
References: <20180212201000.GA25608@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180212201000.GA25608@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Mon, Feb 12, 2018 at 09:10:00PM +0100, Pavel Machek wrote:
> Hi!
> 
> During tethering, I got oops in ssi_stop_tx(), followed by failure of
> GPRS. I used GPRS tethering a lot with some older kernel, and it was
> stable for hours.
> 
> It seems v4.12 has the same problem. In v4.15 usb networking does not
> work at all, so I can't test... v4.10 seems to have similar problem. (Testing is
> slighlty tricky, as my internet connection is ... tethering using
> N900.)

Based on a quick look ssi_stop_tx() is called too many times (i.e. once
more than ssi_start_tx()). This would appear to be an interal problem
with the SSI codebase (or whatever lies there; I don't know the current
codebase).

Did this work in the past? When? There appear to have been changes in IRQ
handling some time in 2016...

> 
> Any ideas?
> 
> 									Pavel
> 
> [  342.915191] DISPC: dispc_runtime_put
> [  342.915222] DISPC: dispc_save_context
> [  342.915283] DISPC: context saved
> [  342.925781] DSS: dss_save_context
> [  342.925811] DSS: context saved
> [  442.942291] ------------[ cut here ]------------
> [  442.947448] Kernel BUG at c047bf3c [verbose debug info unavailable]
> [  442.954345] Internal error: Oops - BUG: 0 [#1] ARM
> [  442.959625] Modules linked in:
> [  442.963012] CPU: 0 PID: 52 Comm: irq/83-SSI PORT Not tainted 4.13.0-14753-g3f4b230-dirty #473
> [  442.972381] Hardware name: Nokia RX-51 board
> [  442.977081] task: ce522a80 task.stack: ce532000
> [  442.982086] PC is at ssi_stop_tx+0xa0/0xa8
> [  442.986602] LR is at ssi_stop_tx+0x20/0xa8
> [  442.991119] pc : [<c047bf3c>]    lr : [<c047bebc>]    psr: 60000013
> [  442.997985] sp : ce533ea8  ip : 00000000  fp : 01000300
> [  443.003723] r10: ce5ebd3c  r9 : ce394610  r8 : ce617000
> [  443.009429] r7 : ce394610  r6 : ce518c28  r5 : ce513400  r4 : ce518c10
> [  443.016601] r3 : 00000000  r2 : ce532000  r1 : ce533ea0  r0 : ce518c28
> [  443.023742] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  443.031555] Control: 10c5387d  Table: 8e71c019  DAC: 00000051
> [  443.037841] Process irq/83-SSI PORT (pid: 52, stack limit = 0xce532210)
> [  443.045104] Stack: (0xce533ea8 to 0xce534000)
> [  443.049865] 3ea0:                   c047be9c ce5ebcc0 ce61a040 ce5ebd20 ce630d40 c047e430
> [  443.058868] 3ec0: c047e368 ce61a040 ce513400 ce518c10 ce518c38 ce518c4c 00000001 c047a8b0
> [  443.067840] 3ee0: ce518c10 ce61afc0 00000046 00000001 00000001 00000000 ce513400 c015cad8
> [  443.076782] 3f00: ce518c10 ce00b95c 00000000 c047aa8c 0000d6d6 ce533f30 fa058000 c0729ccc
> [  443.085754] 3f20: 60000013 ffffffff 00000051 ce519c40 00000001 ce00b900 ce00b954 c015cad8
> [  443.094726] 3f40: c0c505b6 ce00b95c 00000000 c015caf4 ce519c40 00000001 ce00b900 c015c87c
> [  443.103698] 3f60: 00000000 c015ca1c 00000000 ce516a80 00000000 ce519c00 ce516aa8 ce519c40
> [  443.112670] 3f80: ce04bd54 c015c774 00000000 c014021c ce519c00 c0140110 00000000 00000000
> [  443.121612] 3fa0: 00000000 00000000 00000000 c01076b8 00000000 00000000 00000000 00000000
> [  443.130584] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  443.139526] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 fffffedf ffffffff
> [  443.154663] [<c047bf3c>] (ssi_stop_tx) from [<c047e430>] (ssip_swbreak_complete+0xc8/0x108)
> [  443.170043] [<c047e430>] (ssip_swbreak_complete) from [<c047a8b0>] (ssi_pio_complete+0x120/0x254)
> [  443.186035] [<c047a8b0>] (ssi_pio_complete) from [<c047aa8c>] (ssi_pio_thread+0xa8/0x450)
> [  443.201354] [<c047aa8c>] (ssi_pio_thread) from [<c015caf4>] (irq_thread_fn+0x1c/0x34)
> [  443.216308] [<c015caf4>] (irq_thread_fn) from [<c015c87c>] (irq_thread+0x108/0x1b0)
> [  443.231109] [<c015c87c>] (irq_thread) from [<c014021c>] (kthread+0x10c/0x148)
> [  443.245239] [<c014021c>] (kthread) from [<c01076b8>] (ret_from_fork+0x14/0x3c)
> [  443.259521] Code: e1a00006 eb0ab766 e3a00000 e8bd80f8 (e7f001f2) 
> [  443.272705] DISPC: dispc_runtime_get
> [  443.283447] DSS: dss_restore_context
> [  443.294006] DSS: context restored
> [  443.304199] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1023
> [  443.318145] DISPC: fifo(1) threshold (bytes), old 960/1023, new 960/1023
> [  443.331909] DISPC: fifo(2) threshold (bytes), old 960/1023, new 960/1023
> [  443.345611] DISPC: dispc_restore_context
> [  443.356262] DISPC: context restored
> [  443.366302] DSS: set fck to 72000000
> [  443.376190] DISPC: lck = 72000000 (1)
> [  443.386016] DISPC: pck = 24000000 (3)
> [  443.397705] APPLY: writing mgr 0 regs
> [  443.407165] APPLY: writing ovl 0 regs
> [  443.416442] APPLY: writing ovl 0 regs extra
> [  443.426086] APPLY: writing ovl 1 regs
> [  443.434997] APPLY: writing ovl 1 regs extra
> [  443.444305] APPLY: writing ovl 2 regs
> [  443.452880] APPLY: writing ovl 2 regs extra
> [  443.461883] APPLY: writing mgr 0 regs extra
> [  443.470733] DISPC: channel 0 xres 800 yres 480
> [  443.479949] DISPC: pck 24000000
> [  443.487762] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
> [  443.497741] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level 1 sync_pclk_edge 1
> [  443.511169] DISPC: hsync 28037Hz, vsync 57Hz
> [  443.520019] DISPC: lck = 72000000 (1)
> [  443.528015] DISPC: pck = 24000000 (3)
> [  443.692840] ---[ end trace f03d078078f0bc22 ]---
> [  443.701812] genirq: exiting task "irq/83-SSI PORT" (52) is an active IRQ thread (irq 83)
> [  444.290863] irq 83: nobody cared (try booting with the "irqpoll" option)
> [  444.302032] CPU: 0 PID: 52 Comm: irq/83-SSI PORT Tainted: G      D         4.13.0-14753-g3f4b230-dirty #473
> [  444.320831] Hardware name: Nokia RX-51 board
> [  444.329833] [<c010d5d4>] (unwind_backtrace) from [<c010ae18>] (show_stack+0x10/0x14)
> [  444.342681] [<c010ae18>] (show_stack) from [<c015dbe0>] (__report_bad_irq+0x24/0xc0)
> [  444.355712] [<c015dbe0>] (__report_bad_irq) from [<c015df20>] (note_interrupt+0x23c/0x2a0)
> [  444.369537] [<c015df20>] (note_interrupt) from [<c015bbb4>] (handle_irq_event_percpu+0x48/0x58)
> [  444.383880] [<c015bbb4>] (handle_irq_event_percpu) from [<c015bbfc>] (handle_irq_event+0x38/0x5c)
> [  444.398712] [<c015bbfc>] (handle_irq_event) from [<c015eb68>] (handle_level_irq+0x9c/0x10c)
> [  444.413085] [<c015eb68>] (handle_level_irq) from [<c015b364>] (generic_handle_irq+0x18/0x28)
> [  444.427673] [<c015b364>] (generic_handle_irq) from [<c015b464>] (__handle_domain_irq+0x4c/0xa4)
> [  444.442779] [<c015b464>] (__handle_domain_irq) from [<c010b9ac>] (__irq_svc+0x6c/0x90)
> [  444.457183] [<c010b9ac>] (__irq_svc) from [<c01298e4>] (__do_softirq+0x6c/0x224)
> [  444.471282] [<c01298e4>] (__do_softirq) from [<c0129d48>] (irq_exit+0xc0/0x110)
> [  444.485504] [<c0129d48>] (irq_exit) from [<c015b46c>] (__handle_domain_irq+0x54/0xa4)
> [  444.500518] [<c015b46c>] (__handle_domain_irq) from [<c010b9ac>] (__irq_svc+0x6c/0x90)
> [  444.515838] [<c010b9ac>] (__irq_svc) from [<c0729ccc>] (_raw_spin_unlock_irq+0xc/0x10)
> [  444.531341] [<c0729ccc>] (_raw_spin_unlock_irq) from [<c015c990>] (irq_finalize_oneshot+0x6c/0xf8)
> [  444.555725] [<c015c990>] (irq_finalize_oneshot) from [<c013e8ec>] (task_work_run+0x8c/0xb8)
> [  444.572570] [<c013e8ec>] (task_work_run) from [<c01287d8>] (do_exit+0x304/0x9dc)
> [  444.588531] [<c01287d8>] (do_exit) from [<c010b1cc>] (die+0x3b0/0x404)
> [  444.603668] [<c010b1cc>] (die) from [<c0101154>] (do_undefinstr+0x150/0x1f4)
> [  444.619323] [<c0101154>] (do_undefinstr) from [<c010ba58>] (__und_svc_finish+0x0/0x48)
> [  444.635864] Exception stack(0xce533e58 to 0xce533ea0)
> [  444.649505] 3e40:                                                       ce518c28 ce533ea0
> [  444.666717] 3e60: ce532000 00000000 ce518c10 ce513400 ce518c28 ce394610 ce617000 ce394610
> [  444.684051] 3e80: ce5ebd3c 01000300 00000000 ce533ea8 c047bebc c047bf3c 60000013 ffffffff
> [  444.701354] [<c010ba58>] (__und_svc_finish) from [<c047bf3c>] (ssi_stop_tx+0xa0/0xa8)
> [  444.718292] [<c047bf3c>] (ssi_stop_tx) from [<c047e430>] (ssip_swbreak_complete+0xc8/0x108)
> [  444.735748] [<c047e430>] (ssip_swbreak_complete) from [<c047a8b0>] (ssi_pio_complete+0x120/0x254)
> [  444.753723] [<c047a8b0>] (ssi_pio_complete) from [<c047aa8c>] (ssi_pio_thread+0xa8/0x450)
> [  444.771087] [<c047aa8c>] (ssi_pio_thread) from [<c015caf4>] (irq_thread_fn+0x1c/0x34)
> [  444.787994] [<c015caf4>] (irq_thread_fn) from [<c015c87c>] (irq_thread+0x108/0x1b0)
> [  444.804779] [<c015c87c>] (irq_thread) from [<c014021c>] (kthread+0x10c/0x148)
> [  444.820861] [<c014021c>] (kthread) from [<c01076b8>] (ret_from_fork+0x14/0x3c)
> [  444.837005] handlers:
> [  444.847656] [<c015bc20>] irq_default_primary_handler threaded [<c047a9e4>] ssi_pio_thread
> [  444.864868] Disabling IRQ #83
> [  444.876556] sched: RT throttling activated
> [  445.600189] ssi-protocol ssi-protocol: Watchdog trigerred
> [  445.614593] ssi-protocol ssi-protocol: Main state: 2
> [  445.628082] ssi-protocol ssi-protocol: Recv state: 1
> [  445.641357] ssi-protocol ssi-protocol: Send state: 0
> [  445.654357] ssi-protocol ssi-protocol: CMT Online
> [  445.666839] ssi-protocol ssi-protocol: Wake test 0
> [  445.679229] ssi-protocol ssi-protocol: Data RX id: 61
> [  445.691711] ssi-protocol ssi-protocol: Data TX id: 252
> [  445.703979] cmt-speech cmt-speech: Cmd flushed while driver active
> [  445.723602] gprs0: detached
> [  446.946197] nokia-modem n900-modem: CMT rst line change detected
> [  446.959381] ssi-protocol ssi-protocol: CMT reset detected!
> [  446.971710] ssi-protocol ssi-protocol: Main state: 0
> [  446.983306] ssi-protocol ssi-protocol: Recv state: 0
> [  446.994628] ssi-protocol ssi-protocol: Send state: 0
> [  447.005767] ssi-protocol ssi-protocol: CMT Offline
> [  447.016571] ssi-protocol ssi-protocol: Wake test 0
> [  447.027130] ssi-protocol ssi-protocol: Data RX id: 0
> [  447.037658] ssi-protocol ssi-protocol: Data TX id: 0
> pavel@n900:~/g/tui/ofone$  cat /proc/interrupts 
>            CPU0       
>  23:          6      INTC   7 Edge      TWL4030-PIH
>  25:          0      INTC   9 Edge      l3-debug-irq
>  26:          0      INTC  10 Edge      l3-app-irq
>  28:          0      INTC  12 Edge      DMA
>  29:      24202      INTC  13 Edge      omap-dma-engine
>  36:          0      INTC  20 Edge      gpmc
>  40:          0      INTC  24 Edge      480bd400.mmu
>  41:          6      INTC  25 Edge      OMAP DISPC
>  45:          0      INTC  29 Edge      48310000.gpio
>  46:        331      INTC  30 Edge      49050000.gpio
>  47:          9      INTC  31 Edge      49052000.gpio
>  48:       1399      INTC  32 Edge      49054000.gpio
>  49:        538      INTC  33 Edge      49056000.gpio
>  50:          0      INTC  34 Edge      49058000.gpio
>  53:      34189      INTC  37 Edge      gp_timer
>  72:       3560      INTC  56 Edge      48070000.i2c
>  73:      11983      INTC  57 Edge      48072000.i2c
>  77:         49      INTC  61 Edge      48060000.i2c
>  83:     200001      INTC  67 Edge      SSI PORT
>  87:        566      INTC  71 Edge      gdd_mpu
>  99:      19546      INTC  83 Edge      mmc0
> 102:       1425      INTC  86 Edge      mmc1
> 108:       2384      INTC  92 Edge      musb-hdrc.0.auto
> 154:        331  49050000.gpio  10 Edge      wl1251
> 183:          8  49052000.gpio   7 Edge      Keypad Slide
> 184:          1  49052000.gpio   8 Edge      modem_rst_ind
> 201:          0  49052000.gpio  25 Edge      Proximity Sensor
> 212:       1399  49054000.gpio   4 Edge      tsc200x
> 222:          0  49054000.gpio  14 Edge      Camera Lens Cover
> 225:          0  49054000.gpio  17 Edge      Lock Button
> 263:        538  49056000.gpio  23 Edge      SSI cawake
> 289:          0  49058000.gpio  17 Edge      avdet-gpio
> 293:          0  49058000.gpio  21 Edge      lis3lv02d
> 304:      19186      PRCM     Edge      pm_wkup
> 313:          0      PRCM     Edge      pinctrl, pinctrl, pinctrl, pm_io
> 337:          0   twl4030   0 Edge      twl4030_gpio
> 338:          3   twl4030   1 Edge      48070000.i2c:twl@48:keypad
> 339:          2   twl4030   2 Edge      48070000.i2c:twl@48:bci
> 340:          0   twl4030   3 Edge      twl4030_madc
> 342:          0   twl4030   5 Edge      twl4030_power
> 345:          0   twl4030   8 Edge      twl4030_pwrbutton
> 346:          0   twl4030   9 Edge      48070000.i2c:twl@48:bci
> 347:          0   twl4030  10 Edge      twl4030_usb
> 348:          0   twl4030  11 Edge      rtc0
> Err:          0
> pavel@n900:~/g/tui/ofone$ ping atrey
> 
> ----- v4.10 problem:
> 
> [  345.690307] DISPC: pck = 24000000 (3)
> [  346.649139] sched: RT throttling activated
> [  352.172729] BUG: spinlock lockup suspected on CPU#0, irq/263-SSI
> caw/77
> [  352.183654]  lock: 0xce5851a8, .magic: dead4ead, .owner: irq/83-SSI
> PORT/76, .owner_cpu: 0
> [  352.196472] CPU: 0 PID: 77 Comm: irq/263-SSI caw Not tainted
> 4.10.0-00233-gf1c0c95-dirty #477
> [  352.209686] Hardware name: Nokia RX-51 board
> [  352.218444] [<c010c9a4>] (unwind_backtrace) from [<c010a254>]
> (show_stack+0x10/0x14)
> [  352.231231] [<c010a254>] (show_stack) from [<c0151ec0>]
> (do_raw_spin_lock+0x104/0x14c)
> [  352.244171] [<c0151ec0>] (do_raw_spin_lock) from [<c0471dcc>]
> (ssip_pn_xmit+0x94/0x210)
> [  352.257476] [<c0471dcc>] (ssip_pn_xmit) from [<c0564694>]
> (dev_hard_start_xmit+0x80/0x118)
> [  352.271331] [<c0564694>] (dev_hard_start_xmit) from [<c0582f6c>]
> (sch_direct_xmit+0xf4/0x18c)
> [  352.285552] [<c0582f6c>] (sch_direct_xmit) from [<c0564ac0>]
> (__dev_queue_xmit+0x2d0/0x5dc)
> [  352.299804] [<c0564ac0>] (__dev_queue_xmit) from [<c0637804>]
> (pn_send+0x148/0x1f4)
> [  352.313476] [<c0637804>] (pn_send) from [<c06381d8>]
> (pn_skb_send+0x150/0x1b4)
> [  352.326782] [<c06381d8>] (pn_skb_send) from [<c0638d30>]
> (pipe_skb_send+0xb0/0xf4)
> [  352.340698] [<c0638d30>] (pipe_skb_send) from [<c063a8e4>]
> (gprs_xmit+0x70/0xfc)
> [  352.354583] [<c063a8e4>] (gprs_xmit) from [<c0564694>]
> (dev_hard_start_xmit+0x80/0x118)
> [  352.369354] [<c0564694>] (dev_hard_start_xmit) from [<c0582f6c>]
> (sch_direct_xmit+0xf4/0x18c)
> [  352.384918] [<c0582f6c>] (sch_direct_xmit) from [<c0564ac0>]
> (__dev_queue_xmit+0x2d0/0x5dc)
> [  352.400573] [<c0564ac0>] (__dev_queue_xmit) from [<c05a5f44>]
> (ip_finish_output2+0x1ac/0x350)
> [  352.416687] [<c05a5f44>] (ip_finish_output2) from [<c05a6e58>]
> (ip_output+0xec/0xfc)
> [  352.432159] [<c05a6e58>] (ip_output) from [<c05a31f8>]
> (ip_forward_finish+0x90/0xa4)
> [  352.447906] [<c05a31f8>] (ip_forward_finish) from [<c05a3628>]
> (ip_forward+0x41c/0x490)
> [  352.464080] [<c05a3628>] (ip_forward) from [<c05a14e0>]
> (ip_rcv_finish+0x244/0x3a0)
> [  352.479949] [<c05a14e0>] (ip_rcv_finish) from [<c05a1d8c>]
> (ip_rcv+0x2e4/0x484)
> [  352.495605] [<c05a1d8c>] (ip_rcv) from [<c055e5c8>]
> (__netif_receive_skb_core+0x2bc/0x8b8)
> [  352.512420] [<c055e5c8>] (__netif_receive_skb_core) from
> [<c05619dc>] (process_backlog+0x6c/0xe0)
> [  352.529937] [<c05619dc>] (process_backlog) from [<c056222c>]
> (net_rx_action+0xf8/0x2ac)
> [  352.546539] [<c056222c>] (net_rx_action) from [<c0129d0c>]
> (__do_softirq+0xc8/0x218)
> [  352.562988] [<c0129d0c>] (__do_softirq) from [<c012a108>]
> (irq_exit+0xc0/0x110)
> [  352.579223] [<c012a108>] (irq_exit) from [<c0158520>]
> (__handle_domain_irq+0x54/0xa4)
> [  352.596130] [<c0158520>] (__handle_domain_irq) from [<c010adac>]
> (__irq_svc+0x6c/0x90)
> [  352.613189] [<c010adac>] (__irq_svc) from [<c06adcec>]
> (_raw_spin_unlock_irq+0xc/0x10)
> [  352.630157] [<c06adcec>] (_raw_spin_unlock_irq) from [<c0144168>]
> (finish_task_switch+0x58/0x158)
> [  352.648193] [<c0144168>] (finish_task_switch) from [<c06a8300>]
> (schedule+0x38/0x9c)
> [  352.664947] [<c06a8300>] (schedule) from [<c0159860>]
> (irq_thread+0x98/0x1b0)
> [  352.680999] [<c0159860>] (irq_thread) from [<c013fc40>]
> (kthread+0xf0/0x12c)
> [  352.696990] [<c013fc40>] (kthread) from [<c01076d8>]
> (ret_from_fork+0x14/0x3c)
> [  359.178649] BUG: spinlock lockup suspected on CPU#0, irq/263-SSI
> caw/77
> [  359.194122]  lock: 0xce4a7c28, .magic: dead4ead, .owner: irq/83-SSI
> PORT/76, .owner_cpu: 0
> [  359.211395] CPU: 0 PID: 77 Comm: irq/263-SSI caw Not tainted
> 4.10.0-00233-gf1c0c95-dirty #477
> [  359.228973] Hardware name: Nokia RX-51 board
> [  359.241943] [<c010c9a4>] (unwind_backtrace) from [<c010a254>]
> (show_stack+0x10/0x14)
> [  359.258728] [<c010a254>] (show_stack) from [<c0151ec0>]
> (do_raw_spin_lock+0x104/0x14c)
> [  359.275695] [<c0151ec0>] (do_raw_spin_lock) from [<c046fdbc>]
> (ssi_start_tx+0x18/0x60)
> [  359.292694] [<c046fdbc>] (ssi_start_tx) from [<c0471ef4>]
> (ssip_pn_xmit+0x1bc/0x210)
> [  359.309509] [<c0471ef4>] (ssip_pn_xmit) from [<c0564694>]
> (dev_hard_start_xmit+0x80/0x118)
> [  359.326812] [<c0564694>] (dev_hard_start_xmit) from [<c0582f6c>]
> (sch_direct_xmit+0xf4/0x18c)
> [  359.344421] [<c0582f6c>] (sch_direct_xmit) from [<c0564ac0>]
> (__dev_queue_xmit+0x2d0/0x5dc)
> [  359.361816] [<c0564ac0>] (__dev_queue_xmit) from [<c0637804>]
> (pn_send+0x148/0x1f4)
> [  359.378448] [<c0637804>] (pn_send) from [<c06381d8>]
> (pn_skb_send+0x150/0x1b4)
> [  359.394622] [<c06381d8>] (pn_skb_send) from [<c0638d30>]
> (pipe_skb_send+0xb0/0xf4)
> [  359.411193] [<c0638d30>] (pipe_skb_send) from [<c063a8e4>]
> (gprs_xmit+0x70/0xfc)
> [  359.427581] [<c063a8e4>] (gprs_xmit) from [<c0564694>]
> (dev_hard_start_xmit+0x80/0x118)
> [  359.444641] [<c0564694>] (dev_hard_start_xmit) from [<c0582f6c>]
> (sch_direct_xmit+0xf4/0x18c)
> [  359.462341] [<c0582f6c>] (sch_direct_xmit) from [<c0564ac0>]
> (__dev_queue_xmit+0x2d0/0x5dc)
> [  359.479797] [<c0564ac0>] (__dev_queue_xmit) from [<c05a5f44>]
> (ip_finish_output2+0x1ac/0x350)
> [  359.497406] [<c05a5f44>] (ip_finish_output2) from [<c05a6e58>]
> (ip_output+0xec/0xfc)
> [  359.514221] [<c05a6e58>] (ip_output) from [<c05a31f8>]
> (ip_forward_finish+0x90/0xa4)
> [  359.531005] [<c05a31f8>] (ip_forward_finish) from [<c05a3628>]
> (ip_forward+0x41c/0x490)
> [  359.548034] [<c05a3628>] (ip_forward) from [<c05a14e0>]
> (ip_rcv_finish+0x244/0x3a0)
> [  359.564636] [<c05a14e0>] (ip_rcv_finish) from [<c05a1d8c>]
> (ip_rcv+0x2e4/0x484)
> [  359.580902] [<c05a1d8c>] (ip_rcv) from [<c055e5c8>]
> (__netif_receive_skb_core+0x2bc/0x8b8)
> [  359.598175] [<c055e5c8>] (__netif_receive_skb_core) from
> [<c05619dc>] (process_backlog+0x6c/0xe0)
> [  359.616058] [<c05619dc>] (process_backlog) from [<c056222c>]
> (net_rx_action+0xf8/0x2ac)
> [  359.633056] [<c056222c>] (net_rx_action) from [<c0129d0c>]
> (__do_softirq+0xc8/0x218)
> [  359.649780] [<c0129d0c>] (__do_softirq) from [<c012a108>]
> (irq_exit+0xc0/0x110)
> [  359.666076] [<c012a108>] (irq_exit) from [<c0158520>]
> (__handle_domain_irq+0x54/0xa4)
> [  359.682922] [<c0158520>] (__handle_domain_irq) from [<c010adac>]
> (__irq_svc+0x6c/0x90)
> [  359.699829] [<c010adac>] (__irq_svc) from [<c06adcec>]
> (_raw_spin_unlock_irq+0xc/0x10)
> [  359.716644] [<c06adcec>] (_raw_spin_unlock_irq) from [<c0144168>]
> (finish_task_switch+0x58/0x158)
> [  359.734527] [<c0144168>] (finish_task_switch) from [<c06a8300>]
> (schedule+0x38/0x9c)
> [  359.751159] [<c06a8300>] (schedule) from [<c0159860>]
> (irq_thread+0x98/0x1b0)
> [  359.767181] [<c0159860>] (irq_thread) from [<c013fc40>]
> (kthread+0xf0/0x12c)
> [  359.783081] [<c013fc40>] (kthread) from [<c01076d8>]
> (ret_from_fork+0x14/0x3c)
> [  359.822143] ssi-protocol ssi-protocol: Watchdog trigerred
> [  359.836578] ssi-protocol ssi-protocol: Main state: 2
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 



-- 
Sakari Ailus
sakari.ailus@linux.intel.com
