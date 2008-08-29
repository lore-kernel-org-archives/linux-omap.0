From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: <Solved !!!> RE: OMAP35xx MUSB kernel crash with Linux 2.6.26
Date: Fri, 29 Aug 2008 14:01:27 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403CD61A341@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394034F30B16D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394034F30B16D-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Back porting drivers/usb/storage from v2.6.27rc4 to v2.6.26-omap1 solved this kernel panic.

Regards,
Ajay

-----Original Message-----
From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Gupta, Ajay Kumar
Sent: Friday, August 08, 2008 11:21 AM
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: OMAP35xx MUSB kernel crash with Linux 2.6.26

Hi,

I observed kernel crash in Linux 2.6.26 on OMAP35xx EVM with MUSB. The issue is described here.

Case-1:
1) Connect USB stick to root hub of OMAP35xx board.
2) It gets detected successfully.
3) Disconnect the stick and connect it again
4) repeat step-3 and we get kernel crash (log-1 attached below).

Case-2:
1) Connect USB stick to root hub of OMAP35xx board.
2) It gets detected successfully.
3) Mount it and try to read.
4) During read it gets stuck and kernel crash observed (log-2 attached below).

Regards,
Ajay
==============================================[log-1]================================================
<7>musb_start_urb 214: qh c7eb71e0 urb c7eea140 dev2 ep0out, hw_ep 0, ffc00020/8
<7>musb_ep_program 644: --> hw0 urb c7eea140 spd3 dev2 ep0out h_addr00 h_port00 bytes 8
<7>musb_write_fifo 171: TX ep0 fifo c8800020 count 8 buf ffc00020
<7>musb_start_urb 256: Start TX0 pio
<7>musb_hub_control 344: port status 00030101
<7>musb_hub_control 278: clear feature 16
<7>musb_hub_control 278: clear feature 17
<6>usb 1-1: USB disconnect, address 2
usb 1-1: USB disconnect, address 2
<7>musb_urb_dequeue 1979: urb=c7eea140, dev2 ep2out
<7>__musb_giveback 292: complete c7eea140 (-115), dev2 ep2out, 0/31
<4>------------[ cut here ]------------
------------[ cut here ]------------
<4>WARNING: at lib/kref.c:43 kref_get+0x28/0x44()
WARNING: at lib/kref.c:43 kref_get+0x28/0x44()
Modules linked in:Modules linked in:

[<c002be04>] [<c002be04>] (dump_stack+0x0/0x14) (dump_stack+0x0/0x14) from [<c004aafc>] from [<c004aafc>] (warn_on_slowpath+0x4c/0x68)
(warn_on_slowpath+0x4c/0x68)
[<c004aab0>] [<c004aab0>] (warn_on_slowpath+0x0/0x68) (warn_on_slowpath+0x0/0x68) from [<c015e69c>] from [<c015e69c>] (kref_get+0x28/0x44)
(kref_get+0x28/0x44)
 r6:c7d1d034 r6:c7d1d034 r5:c7c75800 r5:c7c75800 r4:c7eea1e0 r4:c7eea1e0
[<c015e674>] [<c015e674>] (kref_get+0x0/0x44) (kref_get+0x0/0x44) from [<c01d5050>] from [<c01d5050>] (usb_get_urb+0x18/0x20)
(usb_get_urb+0x18/0x20)
 r5:c7c75800 r5:c7c75800 r4:c7eea1e0 r4:c7eea1e0
[<c01d5038>] [<c01d5038>] (usb_get_urb+0x0/0x20) (usb_get_urb+0x0/0x20) from [<c01d43ec>] from [<c01d43ec>] (usb_hcd_flush_endpoint+0x3c/0xcc)
(usb_hcd_flush_endpoint+0x3c/0xcc)
 r5:c7c75800 r5:c7c75800 r4:c7eea1e0 r4:c7eea1e0
[<c01d43b0>] [<c01d43b0>] (usb_hcd_flush_endpoint+0x0/0xcc) (usb_hcd_flush_endpoint+0x0/0xcc) from [<c01d55e0>] from [<c01d55e0>] (usb_disable_endpoint+0x5c/0x6
c)
(usb_disable_endpoint+0x5c/0x6c)
 r7:c7d1d060 r7:c7d1d060 r6:0000001f r6:0000001f r5:c7d1d000 r5:c7d1d000 r4:c7d1d034 r4:c7d1d034
[<c01d5584>] [<c01d5584>] (usb_disable_endpoint+0x0/0x6c) (usb_disable_endpoint+0x0/0x6c) from [<c01d560c>] from [<c01d560c>] (usb_disable_device+0x1c/0xf8)
(usb_disable_device+0x1c/0xf8)
 r5:c7d1d000 r5:c7d1d000 r4:00000000 r4:00000000
[<c01d55f0>] [<c01d55f0>] (usb_disable_device+0x0/0xf8) (usb_disable_device+0x0/0xf8) from [<c01d176c>] from [<c01d176c>] (usb_disconnect+0x90/0xd0)
(usb_disconnect+0x90/0xd0)
 r7:c7d1d060 r7:c7d1d060 r6:0000001f r6:0000001f r5:c7d1d07c r5:c7d1d07c r4:c7d1d000 r4:c7d1d000
[<c01d16dc>] [<c01d16dc>] (usb_disconnect+0x0/0xd0) (usb_disconnect+0x0/0xd0) from [<c01d1c14>] from [<c01d1c14>] (hub_thread+0x358/0xb5c)
(hub_thread+0x358/0xb5c)
[<c01d18bc>] [<c01d18bc>] (hub_thread+0x0/0xb5c) (hub_thread+0x0/0xb5c) from [<c005d69c>] from [<c005d69c>] (kthread+0x54/0x80)
(kthread+0x54/0x80)
[<c005d648>] [<c005d648>] (kthread80) (kthread+0x0/0x80) from [<c004db40>] from [<c004db40>] (do_exit+0x0/0x5fc)
(do_exit+0x0/0x5fc)
 r5:00000000 r5:00000000 r4:00000000 r4:00000000
<4>---[ end trace 1c3c0ed6dfe75056 ]---
---[ end trace 1c3c0ed6dfe75056 ]---
<1>Unable to handle kernel NULL pointer dereference at virtual address 0000002c
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
<1>pgd = c0004000
pgd = c0004000
<1>[0000002c] *pgd=00000000[0000002c] *pgd=00000000
Internal error: Oops: 17 [#1]
Internal error: Oops: 17 [#1]
Modules linked in:Modules linked in:
CPU: 0    Tainted: G        W  (2.6.26-omap1 #23)
CPU: 0    Tainted: G        W  (2.6.26-omap1 #23)
PC is at unlink1+0x1c/0xac
PC is at unlink1+0x1c/0xac
LR is at usb_hcd_flush_endpoint+0x4c/0xcc
LR is at usb_hcd_flush_endpoint+0x4c/0xcc
pc : [<c01d3a3c>]    lr : [<c01d43fc>]    psr: 60000093
sp : c7c65ec0  ip : c7c65ee8  fp : c7c65ee4
pc : [<c01d3a3c>]    lr : [<c01d43fc>]    psr: 60000093
sp : c7c65ec0  ip : c7c65ee8  fp : c7c65ee4
r10: c7c11230  r9 : 00000001  r8 : ffffff94
r10: c7c11230  r9 : 00000001  r8 : ffffff94
r7 : c7d1d060  r6 : c7eea1e0  r5 : c7c75800  r4 : c7c75800
r7 : c7d1d060  r6 : c7eea1e0  r5 : c7c75800  r4 : c7c75800
r3 : 00000000  r2 : ffffff94  r1 : c7eea1e0  r0 : c7c75800
r3 : 00000000  r2 : ffffff94  r1 : c7eea1e0  r0 : c7c75800
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 87c98018  DAC: 00000017
Control: 00c5387f  Table: 87c98018  DAC: 00000017
Process khubd (pid: 91, stack limit = 0xc7c642e0)
Process khubd (pid: 91, stack limit = 0xc7c642e0)
Stack: (0xc7c65ec0 to 0xc7c66000)
Stack: (0xc7c65ec0 to 0xc7c66000)
----
----
Backtrace: Backtrace:
[<c01d3a20>] [<c01d3a20>] (unlink1+0x0/0xac) (unlink1+0x0/0xac) from [<c01d43fc>] from [<c01d43fc>] (usb_hcd_flush_endpoint+0x4c/0xcc)
(usb_hcd_flush_endpoint+0x4c/0xcc)
 r9:00000001 r9:00000001 r8:c7d1d108 r8:c7d1d108 r7:c7d1d060 r7:c7d1d060 r6:c7d1d034 r6:c7d1d034 r5:c7c75800 r5:c7c75800
r4:c7eea1e0
r4:c7eea1e0
[<c01d43b0>] [<c01d43b0>] (usb_hcd_flush_endpoint+0x0/0xcc) (usb_hcd_flush_endpoint+0x0/0xcc) from [<c01d55e0>] from [<c01d55e0>] (usb_disable_endpoint+0x5c/0x6
c)
(usb_disable_endpoint+0x5c/0x6c)
 r7:c7d1d060 r7:c7d1d060 r6:0000001f r6:0000001f r5:c7d1d000 r5:c7d1d000 r4:c7d1d034 r4:c7d1d034
[<c01d5584>] [<c01d5584>] (usb_disable_endpoint+0x0/0x6c) (usb_disable_endpoint+0x0/0x6c) from [<c01d560c>] from [<c01d560c>] (usb_disable_device+0x1c/0xf8)
(usb_disable_device+0x1c/0xf8)
 r5:c7d1d000 r5:c7d1d000 r4:00000000 r4:00000000
[<c01d55f0>] [<c01d55f0>] (usb_disable_device+0x0/0xf8) (usb_disable_device+0x0/0xf8) from [<c01d176c>] from [<c01d176c>] (usb_disconnect+0x90/0xd0)
(usb_disconnect+0x90/0xd0)
 r7:c7d1d060 r7:c7d1d060 r6:0000001f r6:0000001f r5:c7d1d07c r5:c7d1d07c r4:c7d1d000 r4:c7d1d000
[<c01d16dc>] [<c01d16dc>] (usb_disconnect+0x0/0xd0) (usb_disconnect+0x0/0xd0) from [<c01d1c14>] from [<c01d1c14>] (hub_thread+0x358/0xb5c)
(hub_thread+0x358/0xb5c)
[<c01d18bc>] [<c01d18bc>] (hub_thread+0x0/0xb5c) (hub_thread+0x0/0xb5c) from [<c005d69c>] from [<c005d69c>] (kthread+0x54/0x80)
(kthread+0x54/0x80)
[<c005d648>] [<c005d648>] (kthread+0x0/0x80) (kthread+0x0/0x80) from [<c004db40>] from [<c004db40>] (do_exit+0x0/0x5fc)
(do_exit+0x0/0x5fc)
 r5:00000000 r5:00000000 r4:00000000 r4:00000000
Code: Code: e5913028 e5913028 e1a06001 e1a06001 e1a04000 e1a04000 e1a08002 e1a08002 (e593302c) (e593302c)
<4>---[ end trace 1c3c0ed6dfe75056 ]---
---[ end trace 1c3c0ed6dfe75056 ]---
<7>usb-storage: device scan complete
usb-storage: device scan complete
<7>musb_interrupt 1547: ** IRQ peripheral usb0020 tx0000 rx0000
musb_interrupt 1547: ** IRQ peripheral usb0020 tx0000 rx0000
<7>musb_stage2_irq 771: DISCONNECT (a_host) as Host, devctl 19
musb_stage2_irq 771: DISCONNECT (a_host) as Host, devctl 19
<7>musb_platform_try_idle 139: a_wait_bcon inactive, for idle timer for 1101 ms
musb_platform_try_idle 139: a_wait_bcon inactive, for idle timer for 1101 ms
============================================[log-2]============================================
[root@OMAP3EVM /]# cd /home/ajay/
[root@OMAP3EVM ajay]# ls
176_144.yuv           saMmapLoopback        saMmapLoopback450450
capture               saMmapLoopback00      saMmapLoopback640480
modules               saMmapLoopback176144  stick
mplayer               saMmapLoopback320240  test.yuv
mplayer1              saMmapLoopback352288  uvcvideo.ko
 [root@OMAP3EVM ajay]# <7>musb_stage0_irq 637: CONNECT (a_host) devctl 5d
<6>usb 1-1: new high speed USB device using musb_hdrc and address 2
usb 1-1: new high speed USB device using musb_hdrc and address 2
<6>usb 1-1: configuration #1 chosen from 1 choice
usb 1-1: configuration #1 chosen from 1 choice
<6>scsi0 : SCSI emulation for USB Mass Storage devices
scsi0 : SCSI emulation for USB Mass Storage devices
<7>usb-storage: device found at 2
<7>usb-storage: waiting for device to settle before scanning
<5>scsi 0:0:0:0: Direct-Access     SanDisk  USB Flash Drive  6.51 PQ: 0 ANSI: 0 CCS
scsi 0:0:0:0: Direct-Access     SanDisk  USB Flash Drive  6.51 PQ: 0 ANSI: 0 CCS
<5>sd 0:0:0:0: [sda] 7883775 512-byte hardware sectors (4036 MB)
sd 0:0:0:0: [sda] 7883775 512-byte hardware sectors (4036 MB)
<5>sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 45 00 00 08
<3>sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Assuming drive cache: write through
<5>sd 0:0:0:0: [sda] 7883775 512-byte hardware sectors (4036 MB)
sd 0:0:0:0: [sda] 7883775 512-byte hardware sectors (4036 MB)
<5>sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write Protect is off
<7>sd 0:0:0:0: [sda] Mode Sense: 45 00 00 08
<3>sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] Assuming drive cache: write through
<6> sda: sda: sda1 sda1
<5>sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 0:0:0:0: [sda] Attached SCSI removable disk
<7>usb-storage: device scan complete
[root@OMAP3EVM ajay]# mount /dev/sda1  stick/
[root@OMAP3EVM ajay]# ls -lh stick/
-rwxr-xr-x    1 root     root         1.0G Jan  1  1980 1gbfile.bin
-rwxr-xr-x    1 root     root         7.4M Jan  1  1980 mplayer
drwxr-xr-x    2 root     root         4.0k Jul 24  2008 omap
[root@OMAP3EVM ajay]# cp stick/mplayer .
<7>musb_stage0_irq 568: VBUS_ERROR in a_host (91, <VBusValid), retry #1, port1 00000503
<7>musb_stage0_irq 637: CONNECT (a_host) devctl 5d
<6>usb 1-1: USB disconnect, address 2
usb 1-1: USB disconnect, address 2
<3>BUG: soft lockup - CPU#0 stuck for 61s! [khubd:89]
BUG: soft lockup - CPU#0 stuck for 61s! [khubd:89]
Modules linked in:Modules linked in:
Pid: 89, comm:                khubd
Pid: 89, comm:                khubd
CPU: 0    Not tainted  (2.6.26-omap1-04731-g6279b89 #1)
CPU: 0    Not tainted  (2.6.26-omap1-04731-g6279b89 #1)
PC is at usb_hcd_flush_endpoint+0xa8/0xcc
PC is at usb_hcd_flush_endpoint+0xa8/0xcc
LR is at usb_get_urb+0x18/0x20
LR is at usb_get_urb+0x18/0x20
pc : [<c01d4458>]    lr : [<c01d5050>]    psr: a0000013
sp : c7cbdee8  ip : c7cbded0  fp : c7cbdf04
pc : [<c01d4458>]    lr : [<c01d5050>]    psr: a0000013
sp : c7cbdee8  ip : c7cbded0  fp : c7cbdf04
r10: c7c11230  r9 : 00000001  r8 : c7d39108
r10: c7c11230  r9 : 00000001  r8 : c7d39108
r7 : c7d39060  r6 : c7e96680  r5 : c7c95160  r4 : c7e96678
r7 : c7d39060  r6 : c7e96680  r5 : c7c95160  r4 : c7e96678
r3 : 00000000  r2 : 00000002  r1 : c01d50c0  r0 : c7c95160
r3 : 00000000  r2 : 00000002  r1 : c01d50c0  r0 : c7c95160
FlQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 87ea8018  DAC: 00000017
Control: 00c5387f  Table: 87ea8018  DAC: 00000017
[<c002900c>] [<c002900c>] (show_regs+0x0/0x50) (show_regs+0x0/0x50) from [<c006dc68>] from <c006dc68>] (softlockup_tick+0xe8/0x10c)
(softlockup_tick+0xe8/0x10c)
 r5:00000096 r5:00000096 r4:00000059 r4:00000059
[<c006db80>] [<c006db80>] (softlockup_tick+0x0/0x10c) (softlockup_tick+0x0/0x10c) from [<c00538a8>] from [<c00538a8>] (run_local_timers+0x1c/0x20)
(run_local_timers+0x1c/0x20)
 r8:ffffffff r8:ffffffff r7:00000094 r7:00000094 r6:1a8c5394 r6:1a8c5394 r5:c7c60680 r5:c7c60680 r4:00000000 r4:00000000
[<c005388c>] [<c005388c>] (run_local_timers+0x0/0x20) (run_local_timers+0x0/0x20) from [<c0053b34>] from [<c0053b34>] (update_process_times+0x30/0x5c)
(update_process_times+0x30/0x5c)
[<c0053b04>] [<c0053b04>] (update_process_times+0x0/0x5c) (update_process_times+0x0/0x5c) from [<c0065cac>] from [<c0065cac>] (tick_sched_timer+0x8c/0xd8)
(tick_sched_timer+0x8c/0xd8)
 r5:c7cbdea0 r5:c7cbdea0 r4:c0381a28 r4:c0381a28
[<c0065c20>] [<c0065c20>] (tick_sched_timer+0x0/0xd8) (tick_sched_timer+0x0/0xd8) from [<c0060428>] from [<c0060428>] (__run_hrtimer+0x30/0x68)
(__run_hrtimer+0x30/0x68)
 r7:c035ead8 r7:c035ead8 r6:c0381a28 r6:c0381a28 r5:c035ead8 r5:c035ead8 r4:c0381a28 r4:c0381a28
[<c00603f8>] [<c00603f8>] (__run_hrtimer+0x0/0x68) (__run_hrtimer+0x0/0x68) from [<c0060f50>] from [<c0060f50>] (hrtimer_interrupt+0x130/0x1a0)
(hrtimer_interrupt+0x130/0x1a0)
 r5:00000094 r5:00000094 r4:1a8c5394 r4:1a8c5394
[<c0060e20>] [<c0060e20>] (hrtimer_interrupt+0x0/0x1a0) (hrtimer_interrupt+0x0/0x1a0) from <c00327e4>] from [<c00327e4>] (omap2_gp_timer_interrupt+0x28/0x34)
(omap2_gp_timer_interrupt+0x28/0x34)
[<c00327bc>] [<c00327bc>] (omap2_gp_timer_interrupt+0x0/0x34) (omap2_gp_timer_interrupt+0x0/0x34) from [<c006e0ec>] from [<c006e0ec>] (handle_IRQ_event+0x3c/0x7
4)
(handle_IRQ_event+0x3c/0x74)
[<c006e0b0>] [<c006e0b0>] (handle_IRQ_event+0x0/0x74) (handle_IRQ_event+0x0/0x74) from [<c006f9c4>] from [<c006f9c4>] (handle_level_irq+0xd4/0xf0)
(handle_level_irq+0xd4/0xf0)
 r7:c7d39060 r7:c7d39060 r6:00000000 r6:00000000 r5:00000025 r5:00000025 r4:c035f830 r4:c035f830

[<c006f8f0>] [<c006f8f0>] (handle_level_irq+0x0/0xf0) (handle_level_irq+0x0/0xf0) from [<c0027048>] from [<c0027048>] (__exception_text_start+0x48/0x64)
(__exception_text_start+0x48/0x64)
 r5:c035f830 r5:c035f830 r4:00000025 r4:00000025

[<c0027000>] [<c0027000>] (__exception_text_start+0x0/0x64) (__exception_text_start+0x0/0x64) from [<c0027690>] from [<c0027690>] (__irq_svc+0x30/0x80)

__irq_svc+0x30/0x80)
Exception stack(0xc7cbdea0 to 0xc7cbdee8)
Exception stack(0xc7cbdea0 to 0xc7cbdee8)
dea0: dea0: c7c95160 c7c95160 c01d50c0 c01d50c0 00000002 00000002 00000000 00000000 c7e96678 c7e96678 c7c95160 c7c95160 c7e96680 c7e96680 c7d39060 c7d39060

dec0: dec0: c7d39108 c7d39108 00000001 00000001 c7c11230 c7c11230 c7cbdf04 c7cbdf04 c7cbded0 c7cbded0 c7cbdee8 c7cbdee8 c01d5050 c01d5050 c01d4458 c01d4458
dee0: dee0: a0000013 a0000013 ffffffff ffffffff
 r7:c7d39060 r7:c7d39060 r6:c7e96680 r6:c7e96680 r5:d8200000 r5:d8200000 r4:ffffffff r4:ffffffff
[<c01d43b0>] [<c01d43b0>] (usb_hcd_flush_endpoint+0x0/0xcc) (usb_hcd_flush_endpoint+0x0/0xcc) from [<c01d55e0>] from [<c01d55e0>] (usb_disable_endpoint+0x5c/0x6
c)
(usb_disable_endpoint+0x5c/0x6c)
 r7:c7d39060 r7:c7d39060 r6:0000001f r6:0000001f r5:c7d39000 r5:c7d39000 r4:c7e96680 r4:c7e96680
[<c01d5584>] [<c01d5584>] (usb_disable_endpoint+0x0/0x6c) (usb_disable_endpoint+0x0/0x6c) from [<c01d561c>] from [<c01d561c>] (usb_disable_device+0x2c/0xf8)
(usb_disable_device+0x2c/0xf8)
 r5:c7d39000 r5:c7d39000 r4:00000002 r4:00000002
[<c01d55f0>] [<c01d55f0>] (usb_disable_device+0x0/0xf8) (usb_disable_device+0x0/0xf8) from [<c01d176c>] from [<c01d176c>] (usb_disconnect+0x90/0xd0)
(usb_disconnect+0x90/0xd0)
 r7:c7d39060 r7:c7d39060 r6:0000001f r6:0000001f r5:c7d3907c r5:c7d3907c r4:c7d39000 r4:c7d39000
[<c01d16dc>] [<c01d16dc>] (usb_disconnect+0x0/0xd0) (usb_disconnect+0x0/0xd0) from [<c01d1c14>] from [<c01d1c14>] (hub_thread+0x358/0xb5c)
(hub_thread+0x358/0xb5c)
[<c01d18bc>] [<c01d18bc>] (hub_thread+0x0/0xb5c) (hub_thread+0x0/0xb5c) from [<c005d69c>] from [<c005d69c>] (kthread+0x54/0x80)
(kthread+0x54/0x80)
[<c005d648>] [<c005d648>] (kthread+0x0/0x80) (kthread+0x0/0x80) from [<c004db40>] from [<c004db40>] (do_exit+0x0/0x5fc)
(do_exit+0x0/0x5fc)
 r5:00000000 r5:00000000 r4:00000000 r4:00000000
<3>BUG: soft lockup - CPU#0 stuck for 61s! [khubd:89]
BUG: soft lockup - CPU#0 stuck for 61s! [khubd:89]
Modules linked in:Modules linked in:

===================================================================================================
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
