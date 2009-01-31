From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Soft lockups with 2.6.29-rc3 when using ASoC?
Date: Sat, 31 Jan 2009 08:06:18 -0800
Message-ID: <5e088bd90901310806u2bfb914bq40d5b150823aa613@mail.gmail.com>
References: <5e088bd90901310651o59b31a80yda2d2e51c9074679@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:36753 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZAaQGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 11:06:21 -0500
Received: by fxm13 with SMTP id 13so717257fxm.13
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2009 08:06:18 -0800 (PST)
In-Reply-To: <5e088bd90901310651o59b31a80yda2d2e51c9074679@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

On Sat, Jan 31, 2009 at 6:51 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> I did a quick test of 2.6.29-rc3.  Things looked pretty good till I
> tried mplayer.

I neglected to mention that this test was done on an Overo system.

Steve

> There was a one minute hang (no sound), then a set of soft lockup messages:
>
> Starting playback...
> BUG: soft lockup - CPU#0 stuck for 61s! [mplayer:1892]
> Modules linked in: ipv6 uvcvideo rtl8187 eeprom_93cx6 videodev v4l1_compat
>
> Pid: 1892, comm:              mplayer
> CPU: 0    Not tainted  (2.6.29-rc3-omap1 #1)
> PC is at handle_IRQ_event+0x28/0x74
> LR is at handle_level_irq+0xd4/0xf0
> pc : [<c0138bf0>]    lr : [<c013a52c>]    psr: 40000113
> sp : cf2c1d90  ip : cf2c1db0  fp : cf2c1dac
> r10: 0000000a  r9 : 00000014  r8 : 00000000
> r7 : 0000003f  r6 : 00000000  r5 : 0000003f  r4 : cfbe2e00
> r3 : 00000000  r2 : c053d65c  r1 : cfbe2e00  r0 : 0000003f
> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8e3f0019  DAC: 00000015
> [<c00f0d74>] (show_regs+0x0/0x50) from [<c01386d8>]
> (softlockup_tick+0x100/0x140)
>  r5:0000008d r4:00000050
> [<c01385d8>] (softlockup_tick+0x0/0x140) from [<c0119800>]
> (run_local_timers+0x1c/0x20)
> [<c01197e4>] (run_local_timers+0x0/0x20) from [<c0119c28>]
> (update_process_times+0x30/0x60)
> [<c0119bf8>] (update_process_times+0x0/0x60) from [<c012dc5c>]
> (tick_sched_timer+0x8c/0xc8)
>  r5:cf2c1d48 r4:c0543ec8
> [<c012dbd0>] (tick_sched_timer+0x0/0xc8) from [<c0126764>]
> (__run_hrtimer+0x74/0xb8)
>  r7:7fffffff r6:ffffffff r5:c0513a90 r4:c0543ec8
> [<c01266f0>] (__run_hrtimer+0x0/0xb8) from [<c01270ec>]
> (hrtimer_interrupt+0xf0/0x154)
>  r5:00000086 r4:333ae255
> [<c0126ffc>] (hrtimer_interrupt+0x0/0x154) from [<c00f97bc>]
> (omap2_gp_timer_interrupt+0x28/0x34)
>  r8:00000000 r7:00000025 r6:00000000 r5:00000000 r4:c050b300
> [<c00f9794>] (omap2_gp_timer_interrupt+0x0/0x34) from [<c0138c04>]
> (handle_IRQ_event+0x3c/0x74)
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:0000003f r6:00000000 r5:00000025 r4:c0514a5c
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1de0 r4:00000025
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1d48 to 0xcf2c1d90)
> 1d40:                   0000003f cfbe2e00 c053d65c 00000000 cfbe2e00 0000003f
> 1d60: 00000000 0000003f 00000000 00000014 0000000a cf2c1dac cf2c1db0 cf2c1d90
> 1d80: c013a52c c0138bf0 40000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:0000005c r6:00000000 r5:0000003f r4:c0515074
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1e78 r4:0000003f
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1de0 to 0xcf2c1e28)
> 1de0: 0000005c cf9c3540 c053d6d0 00000000 cf9c3540 0000005c 00000000 0000005c
> 1e00: 00000000 00000014 0000000a cf2c1e44 cf2c1e48 cf2c1e28 c013a52c c0138bf0
> 1e20: 40000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:00000002 r6:cf9ce800 r5:0000005c r4:c0515740
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1f18 r4:0000005c
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1e78 to 0xcf2c1ec0)
> 1e60:                                                       80000000 cf2c0000
> 1e80: 00000000 c05427a0 0000003f cf2c0000 cf9ce800 00000002 00000000 00000014
> 1ea0: 0000000a cf2c1eec cf2c1ef0 cf2c1ec0 c0115970 c01156ac 20000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0115664>] (__do_softirq+0x0/0xf4) from [<c0115970>] (irq_exit+0x48/0x90)
> [<c0115928>] (irq_exit+0x0/0x90) from [<c00ef05c>]
> (__exception_text_start+0x5c/0x70)
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1f18 to 0xcf2c1f60)
> 1f00:                                                       c053d100 00000002
> 1f20: cf2c0000 ce38c80c cf9e2400 00000002 cf9ce800 cf9e2400 38a39d7b 00000014
> 1f40: cf9cea70 cf2c1f74 ce38c7e0 cf2c1f60 c040408c c010c76c a0000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c010c73c>] (finish_task_switch+0x0/0x84) from [<c040408c>]
> (schedule+0x3e0/0x41c)
>  r5:ce38c7e0 r4:00000000
> [<c0403cac>] (schedule+0x0/0x41c) from [<c00efe54>] (ret_slow_syscall+0x0/0x10)
> BUG: soft lockup - CPU#0 stuck for 61s! [mplayer:1892]
> Modules linked in: ipv6 uvcvideo rtl8187 eeprom_93cx6 videodev v4l1_compat
>
> Pid: 1892, comm:              mplayer
> CPU: 0    Not tainted  (2.6.29-rc3-omap1 #1)
> PC is at handle_IRQ_event+0x28/0x74
> LR is at handle_level_irq+0xd4/0xf0
> pc : [<c0138bf0>]    lr : [<c013a52c>]    psr: 40000113
> sp : cf2c1d90  ip : cf2c1db0  fp : cf2c1dac
> r10: 0000000a  r9 : 00000014  r8 : 00000000
> r7 : 0000003f  r6 : 00000000  r5 : 0000003f  r4 : cfbe2e00
> r3 : 00000000  r2 : c053d65c  r1 : cfbe2e00  r0 : 0000003f
> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8e3f0019  DAC: 00000015
> [<c00f0d74>] (show_regs+0x0/0x50) from [<c01386d8>]
> (softlockup_tick+0x100/0x140)
>  r5:000000ca r4:0000008d
> [<c01385d8>] (softlockup_tick+0x0/0x140) from [<c0119800>]
> (run_local_timers+0x1c/0x20)
> [<c01197e4>] (run_local_timers+0x0/0x20) from [<c0119c28>]
> (update_process_times+0x30/0x60)
> [<c0119bf8>] (update_process_times+0x0/0x60) from [<c012dc5c>]
> (tick_sched_timer+0x8c/0xc8)
>  r5:cf2c1d48 r4:c0543ec8
> [<c012dbd0>] (tick_sched_timer+0x0/0xc8) from [<c0126764>]
> (__run_hrtimer+0x74/0xb8)
>  r7:7fffffff r6:ffffffff r5:c0513a90 r4:c0543ec8
> [<c01266f0>] (__run_hrtimer+0x0/0xb8) from [<c01270ec>]
> (hrtimer_interrupt+0xf0/0x154)
>  r5:000000c8 r4:14f647c2
> [<c0126ffc>] (hrtimer_interrupt+0x0/0x154) from [<c00f97bc>]
> (omap2_gp_timer_interrupt+0x28/0x34)
>  r8:00000000 r7:00000025 r6:00000000 r5:00000000 r4:c050b300
> [<c00f9794>] (omap2_gp_timer_interrupt+0x0/0x34) from [<c0138c04>]
> (handle_IRQ_event+0x3c/0x74)
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:0000003f r6:00000000 r5:00000025 r4:c0514a5c
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1de0 r4:00000025
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1d48 to 0xcf2c1d90)
> 1d40:                   0000003f cfbe2e00 c053d65c 00000000 cfbe2e00 0000003f
> 1d60: 00000000 0000003f 00000000 00000014 0000000a cf2c1dac cf2c1db0 cf2c1d90
> 1d80: c013a52c c0138bf0 40000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:0000005c r6:00000000 r5:0000003f r4:c0515074
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1e78 r4:0000003f
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1de0 to 0xcf2c1e28)
> 1de0: 0000005c cf9c3540 c053d6d0 00000000 cf9c3540 0000005c 00000000 0000005c
> 1e00: 00000000 00000014 0000000a cf2c1e44 cf2c1e48 cf2c1e28 c013a52c c0138bf0
> 1e20: 40000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:00000002 r6:cf9ce800 r5:0000005c r4:c0515740
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1f18 r4:0000005c
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1e78 to 0xcf2c1ec0)
> 1e60:                                                       80000000 cf2c0000
> 1e80: 00000000 c05427a0 0000003f cf2c0000 cf9ce800 00000002 00000000 00000014
> 1ea0: 0000000a cf2c1eec cf2c1ef0 cf2c1ec0 c0115970 c01156ac 20000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0115664>] (__do_softirq+0x0/0xf4) from [<c0115970>] (irq_exit+0x48/0x90)
> [<c0115928>] (irq_exit+0x0/0x90) from [<c00ef05c>]
> (__exception_text_start+0x5c/0x70)
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1f18 to 0xcf2c1f60)
> 1f00:                                                       c053d100 00000002
> 1f20: cf2c0000 ce38c80c cf9e2400 00000002 cf9ce800 cf9e2400 38a39d7b 00000014
> 1f40: cf9cea70 cf2c1f74 ce38c7e0 cf2c1f60 c040408c c010c76c a0000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c010c73c>] (finish_task_switch+0x0/0x84) from [<c040408c>]
> (schedule+0x3e0/0x41c)
>  r5:ce38c7e0 r4:00000000
> [<c0403cac>] (schedule+0x0/0x41c) from [<c00efe54>] (ret_slow_syscall+0x0/0x10)
> BUG: soft lockup - CPU#0 stuck for 61s! [mplayer:1892]
> Modules linked in: ipv6 uvcvideo rtl8187 eeprom_93cx6 videodev v4l1_compat
>
> Pid: 1892, comm:              mplayer
> CPU: 0    Not tainted  (2.6.29-rc3-omap1 #1)
> PC is at handle_IRQ_event+0x28/0x74
> LR is at handle_level_irq+0xd4/0xf0
> pc : [<c0138bf0>]    lr : [<c013a52c>]    psr: 40000113
> sp : cf2c1d90  ip : cf2c1db0  fp : cf2c1dac
> r10: 0000000a  r9 : 00000014  r8 : 00000000
> r7 : 0000003f  r6 : 00000000  r5 : 0000003f  r4 : cfbe2e00
> r3 : 00000000  r2 : c053d65c  r1 : cfbe2e00  r0 : 0000003f
> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8e3f0019  DAC: 00000015
> [<c00f0d74>] (show_regs+0x0/0x50) from [<c01386d8>]
> (softlockup_tick+0x100/0x140)
>  r5:00000107 r4:000000ca
> [<c01385d8>] (softlockup_tick+0x0/0x140) from [<c0119800>]
> (run_local_timers+0x1c/0x20)
> [<c01197e4>] (run_local_timers+0x0/0x20) from [<c0119c28>]
> (update_process_times+0x30/0x60)
> [<c0119bf8>] (update_process_times+0x0/0x60) from [<c012dc5c>]
> (tick_sched_timer+0x8c/0xc8)
>  r5:cf2c1d48 r4:c0543ec8
> [<c012dbd0>] (tick_sched_timer+0x0/0xc8) from [<c0126764>]
> (__run_hrtimer+0x74/0xb8)
>  r7:7fffffff r6:ffffffff r5:c0513a90 r4:c0543ec8
> [<c01266f0>] (__run_hrtimer+0x0/0xb8) from [<c01270ec>]
> (hrtimer_interrupt+0xf0/0x154)
>  r5:00000109 r4:32c3358d
> [<c0126ffc>] (hrtimer_interrupt+0x0/0x154) from [<c00f97bc>]
> (omap2_gp_timer_interrupt+0x28/0x34)
>  r8:00000000 r7:00000025 r6:00000000 r5:00000000 r4:c050b300
> [<c00f9794>] (omap2_gp_timer_interrupt+0x0/0x34) from [<c0138c04>]
> (handle_IRQ_event+0x3c/0x74)
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:0000003f r6:00000000 r5:00000025 r4:c0514a5c
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1de0 r4:00000025
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1d48 to 0xcf2c1d90)
> 1d40:                   0000003f cfbe2e00 c053d65c 00000000 cfbe2e00 0000003f
> 1d60: 00000000 0000003f 00000000 00000014 0000000a cf2c1dac cf2c1db0 cf2c1d90
> 1d80: c013a52c c0138bf0 40000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:0000005c r6:00000000 r5:0000003f r4:c0515074
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1e78 r4:0000003f
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1de0 to 0xcf2c1e28)
> 1de0: 0000005c cf9c3540 c053d6d0 00000000 cf9c3540 0000005c 00000000 0000005c
> 1e00: 00000000 00000014 0000000a cf2c1e44 cf2c1e48 cf2c1e28 c013a52c c0138bf0
> 1e20: 40000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0138bc8>] (handle_IRQ_event+0x0/0x74) from [<c013a52c>]
> (handle_level_irq+0xd4/0xf0)
>  r7:00000002 r6:cf9ce800 r5:0000005c r4:c0515740
> [<c013a458>] (handle_level_irq+0x0/0xf0) from [<c00ef058>]
> (__exception_text_start+0x58/0x70)
>  r5:cf2c1f18 r4:0000005c
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1e78 to 0xcf2c1ec0)
> 1e60:                                                       80000000 cf2c0000
> 1e80: 00000000 c05427a0 0000003f cf2c0000 cf9ce800 00000002 00000000 00000014
> 1ea0: 0000000a cf2c1eec cf2c1ef0 cf2c1ec0 c0115970 c01156ac 20000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c0115664>] (__do_softirq+0x0/0xf4) from [<c0115970>] (irq_exit+0x48/0x90)
> [<c0115928>] (irq_exit+0x0/0x90) from [<c00ef05c>]
> (__exception_text_start+0x5c/0x70)
> [<c00ef000>] (__exception_text_start+0x0/0x70) from [<c00ef9b0>]
> (__irq_svc+0x30/0x80)
> Exception stack(0xcf2c1f18 to 0xcf2c1f60)
> 1f00:                                                       c053d100 00000002
> 1f20: cf2c0000 ce38c80c cf9e2400 00000002 cf9ce800 cf9e2400 38a39d7b 00000014
> 1f40: cf9cea70 cf2c1f74 ce38c7e0 cf2c1f60 c040408c c010c76c a0000113 ffffffff
>  r5:d8200000 r4:ffffffff
> [<c010c73c>] (finish_task_switch+0x0/0x84) from [<c040408c>]
> (schedule+0x3e0/0x41c)
>  r5:ce38c7e0 r4:00000000
> [<c0403cac>] (schedule+0x0/0x41c) from [<c00efe54>] (ret_slow_syscall+0x0/0x10)
> BUG: soft lockup - CPU#0 stuck for 61s! [mplayer:1892]
> Modules linked in: ipv6 uvcvideo rtl8187 eeprom_93cx6 videodev v4l1_compat
>
> <repeats as above>
>
> Has anyone else seen this?  I'm running with some additional patches
> for smxc911x, LCD and touchscreen so I want to check to see if others
> are having the same experience before starting to back out patches.
>
> I do not see this issue with 2.6.29-rc2
> (675e66d8261d3327bc467426f8a7e15ec8ffad2c) and the identical patch
> set.
>
> Thanks!
>
> Steve
>
