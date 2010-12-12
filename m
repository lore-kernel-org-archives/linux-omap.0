From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: Inconsistent lock state caused by omap_mbox_msg_send() called
 from tidspbridge
Date: Sun, 12 Dec 2010 16:15:39 +0200
Message-ID: <1292163339.2375.2.camel@atlantis.mindbit.ro>
References: <201012121344.51245.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:45567 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab0LLOPu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Dec 2010 09:15:50 -0500
In-Reply-To: <201012121344.51245.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: ohad@wizery.com, linux-omap@vger.kernel.org

Hi Laurent,

On Sun, 2010-12-12 at 13:44 +0100, Laurent Pinchart wrote:
> Hi Ohad,
> 
> While testing the tidspbridge driver (2.6.37-rc5, plus patches from the 
> dspbridge branch in linux-omap-2.6) I ran into the following lock 
> inconsistency:
> 
> [  191.045166] =================================
> [  191.051269] [ INFO: inconsistent lock state ]
> [  191.055816] 2.6.37-rc5-00062-gd8b8a63 #8
> [  191.059906] ---------------------------------
> [  191.064453] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> [  191.070709] dummy/1544 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [  191.075988]  (&(&mq->lock)->rlock){+.?...}, at: [<bf000744>] 
> omap_mbox_msg_send+0x18/0xa4 [mailbox]
> [  191.085479] {IN-SOFTIRQ-W} state was registered at:
> [  191.090576]   [<c008e914>] __lock_acquire+0x5f0/0x17c4
> [  191.095947]   [<c008fbc0>] lock_acquire+0xd8/0xfc
> [  191.100860]   [<c0373d3c>] _raw_spin_lock+0x30/0x40
> [  191.105957]   [<bf000744>] omap_mbox_msg_send+0x18/0xa4 [mailbox]
> [  191.112335]   [<bf014a08>] sm_interrupt_dsp+0xe0/0x114 [bridgedriver]
> [  191.119201]   [<bf0122d4>] io_dpc+0x364/0x6c4 [bridgedriver]
> [  191.125152]   [<c0067294>] tasklet_action+0x70/0x100
> [  191.130371]   [<c0067974>] __do_softirq+0xc4/0x1b4
> [  191.135375]   [<c0067b44>] do_softirq+0x44/0x68
> [  191.140136]   [<c0067bcc>] run_ksoftirqd+0x64/0x10c
> [  191.145233]   [<c007c3a0>] kthread+0x84/0x8c
> [  191.149688]   [<c003aad0>] kernel_thread_exit+0x0/0x8
> [  191.154968] irq event stamp: 3602


I noticed this too, but this patch should fix it:

https://patchwork.kernel.org/patch/365292/

Ionut.

