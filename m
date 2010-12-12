From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Inconsistent lock state caused by omap_mbox_msg_send() called from tidspbridge
Date: Sun, 12 Dec 2010 13:44:50 +0100
Message-ID: <201012121344.51245.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49748 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab0LLMoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 07:44:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com
Cc: linux-omap@vger.kernel.org

Hi Ohad,

While testing the tidspbridge driver (2.6.37-rc5, plus patches from the 
dspbridge branch in linux-omap-2.6) I ran into the following lock 
inconsistency:

[  191.045166] =================================
[  191.051269] [ INFO: inconsistent lock state ]
[  191.055816] 2.6.37-rc5-00062-gd8b8a63 #8
[  191.059906] ---------------------------------
[  191.064453] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  191.070709] dummy/1544 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  191.075988]  (&(&mq->lock)->rlock){+.?...}, at: [<bf000744>] 
omap_mbox_msg_send+0x18/0xa4 [mailbox]
[  191.085479] {IN-SOFTIRQ-W} state was registered at:
[  191.090576]   [<c008e914>] __lock_acquire+0x5f0/0x17c4
[  191.095947]   [<c008fbc0>] lock_acquire+0xd8/0xfc
[  191.100860]   [<c0373d3c>] _raw_spin_lock+0x30/0x40
[  191.105957]   [<bf000744>] omap_mbox_msg_send+0x18/0xa4 [mailbox]
[  191.112335]   [<bf014a08>] sm_interrupt_dsp+0xe0/0x114 [bridgedriver]
[  191.119201]   [<bf0122d4>] io_dpc+0x364/0x6c4 [bridgedriver]
[  191.125152]   [<c0067294>] tasklet_action+0x70/0x100
[  191.130371]   [<c0067974>] __do_softirq+0xc4/0x1b4
[  191.135375]   [<c0067b44>] do_softirq+0x44/0x68
[  191.140136]   [<c0067bcc>] run_ksoftirqd+0x64/0x10c
[  191.145233]   [<c007c3a0>] kthread+0x84/0x8c
[  191.149688]   [<c003aad0>] kernel_thread_exit+0x0/0x8
[  191.154968] irq event stamp: 3602
[  191.158447] hardirqs last  enabled at (3602): [<c0067dd0>] 
local_bh_enable_ip+0xe0/0xf4
[  191.166809] hardirqs last disabled at (3600): [<c0067d50>] 
local_bh_enable_ip+0x60/0xf4
[  191.175170] softirqs last  enabled at (3601): [<bf00f848>] 
bridge_chnl_add_io_req+0x2f4/0x348 [bridgedriver]
[  191.185485] softirqs last disabled at (3599): [<c0373f24>] 
_raw_spin_lock_bh+0x14/0x4c
[  191.193756] 
[  191.193756] other info that might help us debug this:
[  191.200592] 1 lock held by dummy/1544:
[  191.204498]  #0:  (&node_mgr_obj->node_mgr_lock){+.+.+.}, at: [<bf025da0>] 
node_create+0x88/0x28c [bridgedriver]
[  191.215240] 
[  191.215240] stack backtrace:
[  191.219818] [<c003eca4>] (unwind_backtrace+0x0/0xec) from [<c008caf4>] 
(print_usage_bug+0x170/0x1b4)
[  191.229370] [<c008caf4>] (print_usage_bug+0x170/0x1b4) from [<c008ce90>] 
(mark_lock+0x358/0x628)
[  191.238555] [<c008ce90>] (mark_lock+0x358/0x628) from [<c008e9a0>] 
(__lock_acquire+0x67c/0x17c4)
[  191.247741] [<c008e9a0>] (__lock_acquire+0x67c/0x17c4) from [<c008fbc0>] 
(lock_acquire+0xd8/0xfc)
[  191.257019] [<c008fbc0>] (lock_acquire+0xd8/0xfc) from [<c0373d3c>] 
(_raw_spin_lock+0x30/0x40)
[  191.266021] [<c0373d3c>] (_raw_spin_lock+0x30/0x40) from [<bf000744>] 
(omap_mbox_msg_send+0x18/0xa4 [mailbox])
[  191.276519] [<bf000744>] (omap_mbox_msg_send+0x18/0xa4 [mailbox]) from 
[<bf014a08>] (sm_interrupt_dsp+0xe0/0x114 [bridgedriver])
[  191.288696] [<bf014a08>] (sm_interrupt_dsp+0xe0/0x114 [bridgedriver]) from 
[<bf00f85c>] (bridge_chnl_add_io_req+0x308/0x348 [bridgedriver])
[  191.301910] [<bf00f85c>] (bridge_chnl_add_io_req+0x308/0x348 
[bridgedriver]) from [<bf021694>] (send_message+0x14c/0x164 [bridgedriver])
[  191.314880] [<bf021694>] (send_message+0x14c/0x164 [bridgedriver]) from 
[<bf021f18>] (disp_node_create+0x4c8/0x508 [bridgedriver])
[  191.327301] [<bf021f18>] (disp_node_create+0x4c8/0x508 [bridgedriver]) from 
[<bf025ea8>] (node_create+0x190/0x28c [bridgedriver])
[  191.339630] [<bf025ea8>] (node_create+0x190/0x28c [bridgedriver]) from 
[<bf019018>] (api_call_dev_ioctl+0xf0/0x118 [bridgedriver])
[  191.352081] [<bf019018>] (api_call_dev_ioctl+0xf0/0x118 [bridgedriver]) 
from [<bf02e0dc>] (bridge_ioctl+0x148/0x17c [bridgedriver])
[  191.364532] [<bf02e0dc>] (bridge_ioctl+0x148/0x17c [bridgedriver]) from 
[<c00f5870>] (vfs_ioctl+0x20/0x3c)
[  191.374633] [<c00f5870>] (vfs_ioctl+0x20/0x3c) from [<c00f5f5c>] 
(do_vfs_ioctl+0x4fc/0x544)
[  191.383361] [<c00f5f5c>] (do_vfs_ioctl+0x4fc/0x544) from [<c00f5ff0>] 
(sys_ioctl+0x4c/0x6c)
[  191.392089] [<c00f5ff0>] (sys_ioctl+0x4c/0x6c) from [<c003a0c0>] 
(ret_fast_syscall+0x0/0x3c)

Googling for a solution returned a pretty long mail thread (http://www.mail-
archive.com/linux-omap@vger.kernel.org/msg30492.html) and a dspbridge patch 
(https://patchwork.kernel.org/patch/107522/) part of a bigger patch set.

That code doesn't seem to have hit mainline. Do you have a status update on 
this ?

-- 
Regards,

Laurent Pinchart
