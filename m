From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/6] arm: omap4: support pmu
Date: Fri, 18 May 2012 13:17:35 -0500
Message-ID: <4FB6923F.3000808@ti.com>
References: <1336599350-10944-1-git-send-email-jon-hunter@ti.com> <CACVXFVNsniPK0-5bU8+8iZeA1JD5WD1refn37nnArq6cGs5=MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59014 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790Ab2ERSRp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 14:17:45 -0400
In-Reply-To: <CACVXFVNsniPK0-5bU8+8iZeA1JD5WD1refn37nnArq6cGs5=MA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Woodruff Richard <r-woodruff2@ti.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Ming,

On 05/16/2012 05:12 AM, Ming Lei wrote:
> On Thu, May 10, 2012 at 5:35 AM, Jon Hunter <jon-hunter@ti.com> wrote:
> 
>> +
>> +       /*configure CTI0 for pmu irq routing*/
>> +       cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
>> +       cti_unlock(&omap4_cti[0]);
>> +       cti_map_trigger(&omap4_cti[0], 1, 6, 2);
>> +
>> +       /*configure CTI1 for pmu irq routing*/
>> +       cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
>> +       cti_unlock(&omap4_cti[1]);
>> +       cti_map_trigger(&omap4_cti[1], 1, 6, 2);
> 
> As pointed in another thread, the above line should be changed to below:
> 
>              cti_map_trigger(&omap4_cti[1], 1, 6, 3);
> 
> which can avoid irq flood issue at high frequency sample mode.
> For detailed description about the issue and fix, see below link:
> 
>       http://permalink.gmane.org/gmane.linux.linaro.devel/10532

I was performing the test you mentioned in the above thread to reproduce the problem. However, I was not able to reproduce the issue. Did you receive any confirmation from Dmitry this fixed his issue for oprofile?

By the way, I did not find too many details about the actual fix in the above thread. It appears to be mapping the interrupt to another channel. Can you clarify what this change is doing?

I did see the following kernel dump when running the perf record test. Applying your change did not help. Have you seen this? I am using the linux-omap master branch.

[  199.186859] INFO: rcu_sched self-detected stall on CPU { 1}  (t=7680 jiffies)
[  199.194427] [<c001c5fc>] (unwind_backtrace+0x0/0xf4) from [<c00a8788>] (__rcu_pending+0x158/0x45c)
[  199.203826] [<c00a8788>] (__rcu_pending+0x158/0x45c) from [<c00a8afc>] (rcu_check_callbacks+0x70/0x1ac)
[  199.213653] [<c00a8afc>] (rcu_check_callbacks+0x70/0x1ac) from [<c0051a70>] (update_process_times+0x38/0x68)
[  199.223968] [<c0051a70>] (update_process_times+0x38/0x68) from [<c008970c>] (tick_sched_timer+0x88/0xd8)
[  199.233917] [<c008970c>] (tick_sched_timer+0x88/0xd8) from [<c0067550>] (__run_hrtimer+0x7c/0x1e0)
[  199.243316] [<c0067550>] (__run_hrtimer+0x7c/0x1e0) from [<c0067920>] (hrtimer_interrupt+0x108/0x294)
[  199.252990] [<c0067920>] (hrtimer_interrupt+0x108/0x294) from [<c001ad60>] (twd_handler+0x34/0x40)
[  199.262359] [<c001ad60>] (twd_handler+0x34/0x40) from [<c00a325c>] (handle_percpu_devid_irq+0x8c/0x138)
[  199.272216] [<c00a325c>] (handle_percpu_devid_irq+0x8c/0x138) from [<c00a02e8>] (generic_handle_irq+0x34/0x44)
[  199.282714] [<c00a02e8>] (generic_handle_irq+0x34/0x44) from [<c00153c0>] (handle_IRQ+0x4c/0xac)
[  199.291900] [<c00153c0>] (handle_IRQ+0x4c/0xac) from [<c0008480>] (gic_handle_irq+0x2c/0x60)
[  199.300781] [<c0008480>] (gic_handle_irq+0x2c/0x60) from [<c0482964>] (__irq_svc+0x44/0x60)
[  199.309509] Exception stack(0xef217c40 to 0xef217c88)
[  199.314819] 7c40: 000000a2 00000000 00000000 ef0ef540 00000202 00000000 ef216000 c19c0080
[  199.323394] 7c60: 00000000 c1a66d00 ef0ef7ac ef217d54 00000000 ef217c88 000000a3 c004a380
[  199.331939] 7c80: 60000113 ffffffff
[  199.335601] [<c0482964>] (__irq_svc+0x44/0x60) from [<c004a380>] (__do_softirq+0x64/0x214)
[  199.344268] [<c004a380>] (__do_softirq+0x64/0x214) from [<c004a70c>] (irq_exit+0x90/0x98)
[  199.352874] [<c004a70c>] (irq_exit+0x90/0x98) from [<c00153c4>] (handle_IRQ+0x50/0xac)
[  199.361145] [<c00153c4>] (handle_IRQ+0x50/0xac) from [<c0008480>] (gic_handle_irq+0x2c/0x60)
[  199.369995] [<c0008480>] (gic_handle_irq+0x2c/0x60) from [<c0482964>] (__irq_svc+0x44/0x60)
[  199.378753] Exception stack(0xef217cf8 to 0xef217d40)
[  199.384033] 7ce0:                                                       0000009f 00000001
[  199.392639] 7d00: 00000000 ef0ef540 00000000 ef1254c0 00000000 ef073480 c19de118 c19bd6c0
[  199.401184] 7d20: ef0ef7ac ef217d54 00000001 ef217d40 000000a0 c0071df8 20000113 ffffffff
[  199.409759] [<c0482964>] (__irq_svc+0x44/0x60) from [<c0071df8>] (finish_task_switch+0x4c/0xf0)
[  199.418884] [<c0071df8>] (finish_task_switch+0x4c/0xf0) from [<c0481234>] (__schedule+0x410/0x808)
[  199.428283] [<c0481234>] (__schedule+0x410/0x808) from [<c0112274>] (pipe_wait+0x58/0x78)
[  199.436859] [<c0112274>] (pipe_wait+0x58/0x78) from [<c0112c3c>] (pipe_read+0x454/0x584)
[  199.445343] [<c0112c3c>] (pipe_read+0x454/0x584) from [<c0109220>] (do_sync_read+0xac/0xf4)
[  199.454101] [<c0109220>] (do_sync_read+0xac/0xf4) from [<c0109de4>] (vfs_read+0xac/0x130)
[  199.462646] [<c0109de4>] (vfs_read+0xac/0x130) from [<c0109f38>] (sys_read+0x40/0x70)
[  199.470855] [<c0109f38>] (sys_read+0x40/0x70) from [<c0014300>] (ret_fast_syscall+0x0/0x3c)

At the end of the test I also saw ...

"Processed 18048959 events and lost 26 chunks!

Check IO/CPU overload!"

Let me know if you have any thoughts.

Cheers
Jon
