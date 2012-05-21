From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH 3/6] arm: omap4: support pmu
Date: Mon, 21 May 2012 10:56:39 +0800
Message-ID: <CACVXFVNg1rfCjVC-M3XHF8+OSmbd9os1dXSh1=_bvhtXHRNi_g@mail.gmail.com>
References: <1336599350-10944-1-git-send-email-jon-hunter@ti.com>
	<CACVXFVNsniPK0-5bU8+8iZeA1JD5WD1refn37nnArq6cGs5=MA@mail.gmail.com>
	<4FB6923F.3000808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47026 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab2EUC4m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 May 2012 22:56:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SWInZ-0002u8-1w
	for linux-omap@vger.kernel.org; Mon, 21 May 2012 02:56:41 +0000
Received: by dady13 with SMTP id y13so6187667dad.19
        for <linux-omap@vger.kernel.org>; Sun, 20 May 2012 19:56:39 -0700 (PDT)
In-Reply-To: <4FB6923F.3000808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Woodruff Richard <r-woodruff2@ti.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Jon,

On Sat, May 19, 2012 at 2:17 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> I was performing the test you mentioned in the above thread to reprod=
uce the problem. However, I was not able to reproduce the issue. Did yo=
u receive any confirmation from Dmitry this fixed his issue for oprofil=
e?

No, looks Dmitry didn't reply on that thread, but I can
reproduce/verify the problem
easily, see below.

> By the way, I did not find too many details about the actual fix in t=
he above thread. It appears to be mapping the interrupt to another chan=
nel. Can you clarify what this change is doing?
>

If two same channels are used as trigger out channel, any events may ro=
ute to
both CPU, which can be easily observed that there are many unhandled IR=
Q in
one CPU but pmu is just enabled on another CPU.

Using different triger out channels can fix the problem and avoid IRQ
flood problem
which can be triggered by running the below(high frequency sample mode)=
:

              perf record -e cycles -F 40000  noploop 3

> I did see the following kernel dump when running the perf record test=
=2E Applying your change did not help. Have you seen this? I am using t=
he linux-omap master branch.
>

No, I don't see the warning after applying the 6 patches against -next =
tree with
the mmc request_irq fix patch.  From the below log, looks your PMU does=
n't work
and perf is driven by hrtimer.

> [ =A0199.186859] INFO: rcu_sched self-detected stall on CPU { 1} =A0(=
t=3D7680 jiffies)
> [ =A0199.194427] [<c001c5fc>] (unwind_backtrace+0x0/0xf4) from [<c00a=
8788>] (__rcu_pending+0x158/0x45c)
> [ =A0199.203826] [<c00a8788>] (__rcu_pending+0x158/0x45c) from [<c00a=
8afc>] (rcu_check_callbacks+0x70/0x1ac)
> [ =A0199.213653] [<c00a8afc>] (rcu_check_callbacks+0x70/0x1ac) from [=
<c0051a70>] (update_process_times+0x38/0x68)
> [ =A0199.223968] [<c0051a70>] (update_process_times+0x38/0x68) from [=
<c008970c>] (tick_sched_timer+0x88/0xd8)
> [ =A0199.233917] [<c008970c>] (tick_sched_timer+0x88/0xd8) from [<c00=
67550>] (__run_hrtimer+0x7c/0x1e0)
> [ =A0199.243316] [<c0067550>] (__run_hrtimer+0x7c/0x1e0) from [<c0067=
920>] (hrtimer_interrupt+0x108/0x294)
> [ =A0199.252990] [<c0067920>] (hrtimer_interrupt+0x108/0x294) from [<=
c001ad60>] (twd_handler+0x34/0x40)
> [ =A0199.262359] [<c001ad60>] (twd_handler+0x34/0x40) from [<c00a325c=
>] (handle_percpu_devid_irq+0x8c/0x138)
> [ =A0199.272216] [<c00a325c>] (handle_percpu_devid_irq+0x8c/0x138) fr=
om [<c00a02e8>] (generic_handle_irq+0x34/0x44)
> [ =A0199.282714] [<c00a02e8>] (generic_handle_irq+0x34/0x44) from [<c=
00153c0>] (handle_IRQ+0x4c/0xac)
> [ =A0199.291900] [<c00153c0>] (handle_IRQ+0x4c/0xac) from [<c0008480>=
] (gic_handle_irq+0x2c/0x60)
> [ =A0199.300781] [<c0008480>] (gic_handle_irq+0x2c/0x60) from [<c0482=
964>] (__irq_svc+0x44/0x60)
> [ =A0199.309509] Exception stack(0xef217c40 to 0xef217c88)
> [ =A0199.314819] 7c40: 000000a2 00000000 00000000 ef0ef540 00000202 0=
0000000 ef216000 c19c0080
> [ =A0199.323394] 7c60: 00000000 c1a66d00 ef0ef7ac ef217d54 00000000 e=
f217c88 000000a3 c004a380
> [ =A0199.331939] 7c80: 60000113 ffffffff
> [ =A0199.335601] [<c0482964>] (__irq_svc+0x44/0x60) from [<c004a380>]=
 (__do_softirq+0x64/0x214)
> [ =A0199.344268] [<c004a380>] (__do_softirq+0x64/0x214) from [<c004a7=
0c>] (irq_exit+0x90/0x98)
> [ =A0199.352874] [<c004a70c>] (irq_exit+0x90/0x98) from [<c00153c4>] =
(handle_IRQ+0x50/0xac)
> [ =A0199.361145] [<c00153c4>] (handle_IRQ+0x50/0xac) from [<c0008480>=
] (gic_handle_irq+0x2c/0x60)
> [ =A0199.369995] [<c0008480>] (gic_handle_irq+0x2c/0x60) from [<c0482=
964>] (__irq_svc+0x44/0x60)
> [ =A0199.378753] Exception stack(0xef217cf8 to 0xef217d40)
> [ =A0199.384033] 7ce0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000009f 0=
0000001
> [ =A0199.392639] 7d00: 00000000 ef0ef540 00000000 ef1254c0 00000000 e=
f073480 c19de118 c19bd6c0
> [ =A0199.401184] 7d20: ef0ef7ac ef217d54 00000001 ef217d40 000000a0 c=
0071df8 20000113 ffffffff
> [ =A0199.409759] [<c0482964>] (__irq_svc+0x44/0x60) from [<c0071df8>]=
 (finish_task_switch+0x4c/0xf0)
> [ =A0199.418884] [<c0071df8>] (finish_task_switch+0x4c/0xf0) from [<c=
0481234>] (__schedule+0x410/0x808)
> [ =A0199.428283] [<c0481234>] (__schedule+0x410/0x808) from [<c011227=
4>] (pipe_wait+0x58/0x78)
> [ =A0199.436859] [<c0112274>] (pipe_wait+0x58/0x78) from [<c0112c3c>]=
 (pipe_read+0x454/0x584)
> [ =A0199.445343] [<c0112c3c>] (pipe_read+0x454/0x584) from [<c0109220=
>] (do_sync_read+0xac/0xf4)
> [ =A0199.454101] [<c0109220>] (do_sync_read+0xac/0xf4) from [<c0109de=
4>] (vfs_read+0xac/0x130)
> [ =A0199.462646] [<c0109de4>] (vfs_read+0xac/0x130) from [<c0109f38>]=
 (sys_read+0x40/0x70)
> [ =A0199.470855] [<c0109f38>] (sys_read+0x40/0x70) from [<c0014300>] =
(ret_fast_syscall+0x0/0x3c)
>
> At the end of the test I also saw ...
>
> "Processed 18048959 events and lost 26 chunks!
>
> Check IO/CPU overload!"

Generally, that is not a problem, you can save the trace into ram fs to
avoid it.


Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
