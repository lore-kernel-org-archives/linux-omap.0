From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: USB DMA IRQ issue
Date: Thu, 5 Feb 2015 12:19:23 +0100
Message-ID: <CAGm1_ktamp-L8nb7UzGvha6EkEfAnDtv3unPE1th9RjK7RkG1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:57621 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbbBELTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 06:19:44 -0500
Received: by mail-pa0-f50.google.com with SMTP id rd3so9352315pab.9
        for <linux-omap@vger.kernel.org>; Thu, 05 Feb 2015 03:19:43 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>

I have a problem with my am335x based board and USB.

Kernel: Linux version 3.18.1 (YegorYefremov@development1) (gcc version
4.9.2 (Buildroot 2015.02-git-00797-gf1b07c0) ) #1 SMP Thu Jan 15
15:31:27 CET 2015

I took two devices and equipped them with USB WLAN cards: Bus 001
Device 003: ID 148f:5370 Ralink Technology, Corp. RT5370 Wireless
Adapter. One device as AP and another as client. Client makes
permanent ping to AP. And from time to time I start nuttcp session.
After 2-3 days I get following errors:

CPU: 0 PID: 6123 Comm: kworker/u2:2 Tainted: G        W      3.18.1 #1
Workqueue: phy0 rt2x00link_watchdog [rt2x00lib]
[<c001596c>] (unwind_backtrace) from [<c0012218>] (show_stack+0x10/0x14)
[<c0012218>] (show_stack) from [<c05c7fe8>] (dump_stack+0x84/0x9c)
[<c05c7fe8>] (dump_stack) from [<c004031c>] (warn_slowpath_common+0x6c/0x90)
[<c004031c>] (warn_slowpath_common) from [<c00403dc>]
(warn_slowpath_null+0x1c/0x24)
[<c00403dc>] (warn_slowpath_null) from [<c02d0d44>]
(cppi41_dma_control+0x298/0x2e0)
[<c02d0d44>] (cppi41_dma_control) from [<c03eb100>]
(cppi41_dma_channel_abort+0xc0/0x134)
[<c03eb100>] (cppi41_dma_channel_abort) from [<c03e69f8>]
(musb_cleanup_urb.isra.12+0x40/0xfc)
[<c03e69f8>] (musb_cleanup_urb.isra.12) from [<c03e6d04>]
(musb_urb_dequeue+0xe8/0x128)
[<c03e6d04>] (musb_urb_dequeue) from [<c03b74bc>] (usb_hcd_unlink_urb+0x4c/0x84)
[<c03b74bc>] (usb_hcd_unlink_urb) from [<c03b863c>] (usb_kill_urb+0x4c/0xc4)
[<c03b863c>] (usb_kill_urb) from [<bf01291c>]
(rt2x00usb_flush_entry+0x30/0x58 [rt2x00usb])
[<bf01291c>] (rt2x00usb_flush_entry [rt2x00usb]) from [<bf007128>]
(rt2x00queue_for_each_entry+0x84/0x250 [rt2x00lib])
[<bf007128>] (rt2x00queue_for_each_entry [rt2x00lib]) from
[<bf0128e4>] (rt2x00usb_flush_queue+0x98/0xa0 [rt2x00usb])
[<bf0128e4>] (rt2x00usb_flush_queue [rt2x00usb]) from [<bf007bcc>]
(rt2x00queue_flush_queue+0x44/0xa8 [rt2x00lib])
[<bf007bcc>] (rt2x00queue_flush_queue [rt2x00lib]) from [<bf012d50>]
(rt2x00usb_watchdog+0xc4/0xec [rt2x00usb])
[<bf012d50>] (rt2x00usb_watchdog [rt2x00usb]) from [<bf02f950>]
(rt2800usb_watchdog+0x74/0x1c0 [rt2800usb])
[<bf02f950>] (rt2800usb_watchdog [rt2800usb]) from [<bf008b30>]
(rt2x00link_watchdog+0x2c/0x58 [rt2x00lib])
[<bf008b30>] (rt2x00link_watchdog [rt2x00lib]) from [<c005586c>]
(process_one_work+0x1c4/0x494)
[<c005586c>] (process_one_work) from [<c00562dc>] (worker_thread+0x38/0x4bc)
[<c00562dc>] (worker_thread) from [<c005a6e8>] (kthread+0xc8/0xe4)
[<c005a6e8>] (kthread) from [<c000e888>] (ret_from_fork+0x14/0x2c)
---[ end trace 981fe2c9ed6055b8 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6123 at drivers/dma/cppi41.c:320 cppi41_irq+0x144/0x198()
Modules linked in: rt2800usb rt2800lib rt2x00usb rt2x00lib led_class
CPU: 0 PID: 6123 Comm: kworker/u2:2 Tainted: G        W      3.18.1 #1
Workqueue: phy0 rt2x00link_watchdog [rt2x00lib]
[<c001596c>] (unwind_backtrace) from [<c0012218>] (show_stack+0x10/0x14)
[<c0012218>] (show_stack) from [<c05c7fe8>] (dump_stack+0x84/0x9c)
[<c05c7fe8>] (dump_stack) from [<c004031c>] (warn_slowpath_common+0x6c/0x90)
[<c004031c>] (warn_slowpath_common) from [<c00403dc>]
(warn_slowpath_null+0x1c/0x24)
[<c00403dc>] (warn_slowpath_null) from [<c02d12dc>] (cppi41_irq+0x144/0x198)
[<c02d12dc>] (cppi41_irq) from [<c0089544>] (handle_irq_event_percpu+0x3c/0x1d8)
[<c0089544>] (handle_irq_event_percpu) from [<c008971c>]
(handle_irq_event+0x3c/0x5c)
[<c008971c>] (handle_irq_event) from [<c008c2ec>] (handle_level_irq+0xb4/0x144)
[<c008c2ec>] (handle_level_irq) from [<c0088c70>] (generic_handle_irq+0x28/0x3c)
[<c0088c70>] (generic_handle_irq) from [<c0088f38>]
(__handle_domain_irq+0x64/0xc8)
[<c0088f38>] (__handle_domain_irq) from [<c0008780>]
(omap_intc_handle_irq+0xb4/0xc4)
[<c0008780>] (omap_intc_handle_irq) from [<c05cf9a4>] (__irq_svc+0x44/0x5c)
Exception stack(0xcf7a5d30 to 0xcf7a5d78)
5d20:                                     00000001 ccb64af8 00000000 ccb64580
5d40: a0000013 cf5a2010 cf5a2010 00000000 a0000013 c0008300 00000001 cf365934
5d60: 00000002 cf7a5d78 c007cd34 c05cefe8 20000013 ffffffff
[<c05cf9a4>] (__irq_svc) from [<c05cefe8>]
(_raw_spin_unlock_irqrestore+0x34/0x44)
[<c05cefe8>] (_raw_spin_unlock_irqrestore) from [<c03e6cc0>]
(musb_urb_dequeue+0xa4/0x128)
[<c03e6cc0>] (musb_urb_dequeue) from [<c03b74bc>] (usb_hcd_unlink_urb+0x4c/0x84)
[<c03b74bc>] (usb_hcd_unlink_urb) from [<c03b863c>] (usb_kill_urb+0x4c/0xc4)
[<c03b863c>] (usb_kill_urb) from [<bf01291c>]
(rt2x00usb_flush_entry+0x30/0x58 [rt2x00usb])
[<bf01291c>] (rt2x00usb_flush_entry [rt2x00usb]) from [<bf007128>]
(rt2x00queue_for_each_entry+0x84/0x250 [rt2x00lib])
[<bf007128>] (rt2x00queue_for_each_entry [rt2x00lib]) from
[<bf0128e4>] (rt2x00usb_flush_queue+0x98/0xa0 [rt2x00usb])
[<bf0128e4>] (rt2x00usb_flush_queue [rt2x00usb]) from [<bf007bcc>]
(rt2x00queue_flush_queue+0x44/0xa8 [rt2x00lib])
[<bf007bcc>] (rt2x00queue_flush_queue [rt2x00lib]) from [<bf012d50>]
(rt2x00usb_watchdog+0xc4/0xec [rt2x00usb])
[<bf012d50>] (rt2x00usb_watchdog [rt2x00usb]) from [<bf02f950>]
(rt2800usb_watchdog+0x74/0x1c0 [rt2800usb])
[<bf02f950>] (rt2800usb_watchdog [rt2800usb]) from [<bf008b30>]
(rt2x00link_watchdog+0x2c/0x58 [rt2x00lib])
[<bf008b30>] (rt2x00link_watchdog [rt2x00lib]) from [<c005586c>]
(process_one_work+0x1c4/0x494)
[<c005586c>] (process_one_work) from [<c00562dc>] (worker_thread+0x38/0x4bc)
[<c00562dc>] (worker_thread) from [<c005a6e8>] (kthread+0xc8/0xe4)
[<c005a6e8>] (kthread) from [<c000e888>] (ret_from_fork+0x14/0x2c)
---[ end trace 981fe2c9ed6055b9 ]---
cppi41_irq() q 94 desc 8d841060

I've also tried another USB WLAN dongle based on zd1211rw and showed
similar error picture:

CPU: 0 PID: 17069 Comm: kworker/u2:0 Tainted: G        W      3.18.1 #2
Workqueue: phy0 ieee80211_scan_work
[<c001543c>] (unwind_backtrace) from [<c0012228>] (show_stack+0x10/0x14)
[<c0012228>] (show_stack) from [<c0717190>] (dump_stack+0x84/0x9c)
[<c0717190>] (dump_stack) from [<c003fe94>] (warn_slowpath_common+0x6c/0x90)
[<c003fe94>] (warn_slowpath_common) from [<c003ff54>]
(warn_slowpath_null+0x1c/0x24)
[<c003ff54>] (warn_slowpath_null) from [<c02e0314>] (cppi41_irq+0x144/0x198)
[<c02e0314>] (cppi41_irq) from [<c008efd8>] (handle_irq_event_percpu+0x3c/0x1d8)
[<c008efd8>] (handle_irq_event_percpu) from [<c008f1b0>]
(handle_irq_event+0x3c/0x5c)
[<c008f1b0>] (handle_irq_event) from [<c0091d80>] (handle_level_irq+0xb4/0x144)
[<c0091d80>] (handle_level_irq) from [<c008e704>] (generic_handle_irq+0x28/0x3c)
[<c008e704>] (generic_handle_irq) from [<c008e9cc>]
(__handle_domain_irq+0x64/0xc8)
[<c008e9cc>] (__handle_domain_irq) from [<c0008780>]
(omap_intc_handle_irq+0xb4/0xc4)
[<c0008780>] (omap_intc_handle_irq) from [<c071f8e4>] (__irq_svc+0x44/0x5c)
Exception stack(0xcc033c00 to 0xcc033c48)
3c00: 00000001 cc096a08 00000000 cc096440 a0000113 ce52a010 ce52a010 00000000
3c20: a0000113 40020400 00000001 00000002 00000004 cc033c48 c00828b8 c071eef8
3c40: 20000113 ffffffff
[<c071f8e4>] (__irq_svc) from [<c071eef8>]
(_raw_spin_unlock_irqrestore+0x34/0x44)
[<c071eef8>] (_raw_spin_unlock_irqrestore) from [<c049f0d8>]
(musb_urb_dequeue+0xa4/0x128)
[<c049f0d8>] (musb_urb_dequeue) from [<c0468918>] (usb_hcd_unlink_urb+0x4c/0x84)
[<c0468918>] (usb_hcd_unlink_urb) from [<c0469a98>] (usb_kill_urb+0x4c/0xc4)
[<c0469a98>] (usb_kill_urb) from [<c0469e90>] (usb_start_wait_urb+0xa4/0xbc)
[<c0469e90>] (usb_start_wait_urb) from [<c03bd41c>]
(zd_ep_regs_out_msg.constprop.23+0x7c/0x8c)
[<c03bd41c>] (zd_ep_regs_out_msg.constprop.23) from [<c03be774>]
(zd_usb_ioread16v+0x108/0x3a8)
[<c03be774>] (zd_usb_ioread16v) from [<c03b6324>]
(zd_ioread32v_locked+0x8c/0x13c)
[<c03b6324>] (zd_ioread32v_locked) from [<c03b6d54>]
(zd_chip_lock_phy_regs+0x38/0xf0)
[<c03b6d54>] (zd_chip_lock_phy_regs) from [<c03b7a98>]
(zd_chip_set_channel+0x2c/0x358)
[<c03b7a98>] (zd_chip_set_channel) from [<c06c9140>]
(ieee80211_hw_config+0x60/0x36c)
[<c06c9140>] (ieee80211_hw_config) from [<c06d0fa0>]
(ieee80211_scan_work+0x1d0/0x4c8)
[<c06d0fa0>] (ieee80211_scan_work) from [<c005560c>]
(process_one_work+0x1c4/0x494)
[<c005560c>] (process_one_work) from [<c005607c>] (worker_thread+0x38/0x4bc)
[<c005607c>] (worker_thread) from [<c005a488>] (kthread+0xc8/0xe4)
[<c005a488>] (kthread) from [<c000e888>] (ret_from_fork+0x14/0x2c)
---[ end trace 01d726db11c59051 ]---
cppi41_irq() q 134 desc 8e841620
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110
zd1211rw 2-1.4:1.0: error ioread32(CR_REG1): -110

Any idea?

Yegor
