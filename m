From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Inconsistent lock state caused by omap_mbox_msg_send() called
 from tidspbridge
Date: Sun, 12 Dec 2010 15:34:38 +0200
Message-ID: <AANLkTinb7aqXdnqpsYih0t=+yaiuojnCkAqYL=SzvsGM@mail.gmail.com>
References: <201012121344.51245.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f170.google.com ([209.85.214.170]:39771 "EHLO
	mail-iw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab0LLNe7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 08:34:59 -0500
Received: by iwn6 with SMTP id 6so7797065iwn.1
        for <linux-omap@vger.kernel.org>; Sun, 12 Dec 2010 05:34:58 -0800 (PST)
In-Reply-To: <201012121344.51245.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti>
Cc: linux-omap@vger.kernel.org

Hi Laurent,

On Sun, Dec 12, 2010 at 2:44 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> > > [ =A0191.085479] {IN-SOFTIRQ-W}
state was registered at:
> [ =A0191.090576] =A0 [<c008e914>] __lock_acquire+0x5f0/0x17c4
> [ =A0191.095947] =A0 [<c008fbc0>] lock_acquire+0xd8/0xfc
> [ =A0191.100860] =A0 [<c0373d3c>] _raw_spin_lock+0x30/0x40
> [ =A0191.105957] =A0 [<bf000744>] omap_mbox_msg_send+0x18/0xa4 [mailb=
ox]
> [ =A0191.112335] =A0 [<bf014a08>] sm_interrupt_dsp+0xe0/0x114 [bridge=
driver]
> [ =A0191.119201] =A0 [<bf0122d4>] io_dpc+0x364/0x6c4 [bridgedriver]
> [ =A0191.125152] =A0 [<c0067294>] tasklet_action+0x70/0x100
> [ =A0191.130371] =A0 [<c0067974>] __do_softirq+0xc4/0x1b4
> [ =A0191.135375] =A0 [<c0067b44>] do_softirq+0x44/0x68
> [ =A0191.140136] =A0 [<c0067bcc>] run_ksoftirqd+0x64/0x10c
> [ =A0191.145233] =A0 [<c007c3a0>] kthread+0x84/0x8c
> [ =A0191.149688] =A0 [<c003aad0>] kernel_thread_exit+0x0/0x8
> [ =A0191.154968] irq event stamp: 3602
> [ =A0191.158447] hardirqs last =A0enabled at (3602): [<c0067dd0>]
> local_bh_enable_ip+0xe0/0xf4
> [ =A0191.166809] hardirqs last disabled at (3600): [<c0067d50>]
> local_bh_enable_ip+0x60/0xf4
> [ =A0191.175170] softirqs last =A0enabled at (3601): [<bf00f848>]
> bridge_chnl_add_io_req+0x2f4/0x348 [bridgedriver]
> [ =A0191.185485] softirqs last disabled at (3599): [<c0373f24>]
> _raw_spin_lock_bh+0x14/0x4c
> [ =A0191.193756]
> [ =A0191.193756] other info that might help us debug this:
> [ =A0191.200592] 1 lock held by dummy/1544:
> [ =A0191.204498] =A0#0: =A0(&node_mgr_obj->node_mgr_lock){+.+.+.}, at=
: [<bf025da0>]
> node_create+0x88/0x28c [bridgedriver]
> [ =A0191.215240]
> [ =A0191.215240] stack backtrace:
> [ =A0191.219818] [<c003eca4>] (unwind_backtrace+0x0/0xec) from [<c008=
caf4>]
> (print_usage_bug+0x170/0x1b4)
> [ =A0191.229370] [<c008caf4>] (print_usage_bug+0x170/0x1b4) from [<c0=
08ce90>]
> (mark_lock+0x358/0x628)
> [ =A0191.238555] [<c008ce90>] (mark_lock+0x358/0x628) from [<c008e9a0=
>]
> (__lock_acquire+0x67c/0x17c4)
> [ =A0191.247741] [<c008e9a0>] (__lock_acquire+0x67c/0x17c4) from [<c0=
08fbc0>]
> (lock_acquire+0xd8/0xfc)
> [ =A0191.257019] [<c008fbc0>] (lock_acquire+0xd8/0xfc) from [<c0373d3=
c>]
> (_raw_spin_lock+0x30/0x40)
> [ =A0191.266021] [<c0373d3c>] (_raw_spin_lock+0x30/0x40) from [<bf000=
744>]
> (omap_mbox_msg_send+0x18/0xa4 [mailbox])
> [ =A0191.276519] [<bf000744>] (omap_mbox_msg_send+0x18/0xa4 [mailbox]=
) from
> [<bf014a08>] (sm_interrupt_dsp+0xe0/0x114 [bridgedriver])
> [ =A0191.288696] [<bf014a08>] (sm_interrupt_dsp+0xe0/0x114 [bridgedri=
ver]) from
> [<bf00f85c>] (bridge_chnl_add_io_req+0x308/0x348 [bridgedriver])
> [ =A0191.301910] [<bf00f85c>] (bridge_chnl_add_io_req+0x308/0x348
> [bridgedriver]) from [<bf021694>] (send_message+0x14c/0x164 [bridgedr=
iver])
> [ =A0191.314880] [<bf021694>] (send_message+0x14c/0x164 [bridgedriver=
]) from
> [<bf021f18>] (disp_node_create+0x4c8/0x508 [bridgedriver])
> [ =A0191.327301] [<bf021f18>] (disp_node_create+0x4c8/0x508 [bridgedr=
iver]) from
> [<bf025ea8>] (node_create+0x190/0x28c [bridgedriver])
> [ =A0191.339630] [<bf025ea8>] (node_create+0x190/0x28c [bridgedriver]=
) from
> [<bf019018>] (api_call_dev_ioctl+0xf0/0x118 [bridgedriver])
> [ =A0191.352081] [<bf019018>] (api_call_dev_ioctl+0xf0/0x118 [bridged=
river])
> from [<bf02e0dc>] (bridge_ioctl+0x148/0x17c [bridgedriver])
> [ =A0191.364532] [<bf02e0dc>] (bridge_ioctl+0x148/0x17c [bridgedriver=
]) from
> [<c00f5870>] (vfs_ioctl+0x20/0x3c)
> [ =A0191.374633] [<c00f5870>] (vfs_ioctl+0x20/0x3c) from [<c00f5f5c>]
> (do_vfs_ioctl+0x4fc/0x544)
> [ =A0191.383361] [<c00f5f5c>] (do_vfs_ioctl+0x4fc/0x544) from [<c00f5=
ff0>]
> (sys_ioctl+0x4c/0x6c)
> [ =A0191.392089] [<c00f5ff0>] (sys_ioctl+0x4c/0x6c) from [<c003a0c0>]
> (ret_fast_syscall+0x0/0x3c)
>
> Googling for a solution returned a pretty long mail thread (http://ww=
w.mail-
> archive.com/linux-omap@vger.kernel.org/msg30492.html)

Yeah, the problem was (is??) that dspbridge uses mailbox from both
process context and softirq context (its tasklet).

> and a dspbridge patch
> (https://patchwork.kernel.org/patch/107522/) part of a bigger patch s=
et.
>
> That code doesn't seem to have hit mainline. Do you have a status upd=
ate on
> this ?

Big parts of it are being pursued by Hari nowadays, but anyway they
are not relevant to the lockdep problem, so don't wait for it...

There are two possible solutions to the lockdep problem:
1. Have dspbridge defer messages to a workqueue instead of a tasklet
or
2. Add sufficient locking into mailbox that would allow softirq usage t=
oo

I recommended to follow (1), but that needs verification that
performance isn't hurt (it shouldn't since that context is anyway
meant to defer messages in case the bridge is still waiting for
previous ones to be processed by the dsp).

But otherwise (2) will work too (see proposal by Deepak in the
original bug report).

Looping in Omar, Fernando, Felipe, Deepak, Hari,...

Thanks,
Ohad.

>
> --
> Regards,
>
> Laurent Pinchart
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
