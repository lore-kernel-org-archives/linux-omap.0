From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] alsa: add Beagleboard SoC configuration.
Date: Fri, 3 Oct 2008 23:34:04 -0700
Message-ID: <200810032334.04565.david-b@pacbell.net>
References: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:21605 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751169AbYJDGeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Oct 2008 02:34:08 -0400
In-Reply-To: <1221597643-29601-1-git-send-email-felipe.contreras@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Tuesday 16 September 2008, Felipe Contreras wrote:
> This is exactly the same as the overo configuration. It might make sense
> to have them in a single one.

I got a hard lockup (no timer ticking), no blinkenlights, etc ...
doesn't look like the issue is *this* driver.


% aplay dedodedo.wav
=============================================
[ INFO: possible recursive locking detected ]
2.6.27-rc8-omap1 #174
---------------------------------------------
aplay/1816 is trying to acquire lock:
 (clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70

but task is already holding lock:
 (clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70

other info that might help us debug this:
3 locks held by aplay/1816:
 #0:  (&pcm->open_mutex){--..}, at: [<c0239ffc>] snd_pcm_open+0xac/0x168
 #1:  (pcm_mutex){--..}, at: [<c0258690>] soc_pcm_open+0x40/0x350
 #2:  (clockfw_lock){....}, at: [<c0036be4>] clk_enable+0x24/0x70

stack backtrace:
[<c002ce78>] (dump_stack+0x0/0x14) from [<c006a498>] (print_deadlock_bug+0xa0/0xcc)
[<c006a3f8>] (print_deadlock_bug+0x0/0xcc) from [<c006a61c>] (check_deadlock+0x158/0x18c)
 r7:c046efe8 r6:c781f1c0 r5:c781f518 r4:80000093
[<c006a4c4>] (check_deadlock+0x0/0x18c) from [<c006d050>] (validate_chain+0x3c0/0x4e8)
[<c006cc90>] (validate_chain+0x0/0x4e8) from [<c006d73c>] (__lock_acquire+0x5c4/0x668)
[<c006d178>] (__lock_acquire+0x0/0x668) from [<c006d844>] (lock_acquire+0x64/0x78)
[<c006d7e0>] (lock_acquire+0x0/0x78) from [<c030c874>] (_spin_lock_irqsave+0x4c/0x60)
 r7:c7939c00 r6:80000093 r5:c0036be4 r4:c03f3030
[<c030c828>] (_spin_lock_irqsave+0x0/0x60) from [<c0036be4>] (clk_enable+0x24/0x70)
 r6:c0411130 r5:c03ec7e4 r4:c03f13e0
[<c0036bc0>] (clk_enable+0x0/0x70) from [<c0033918>] (omap_mcbsp_clk_enable+0x24/0x3c)
 r5:c03ec7e4 r4:00000000
[<c00338f4>] (omap_mcbsp_clk_enable+0x0/0x3c) from [<c0031724>] (_omap2_clk_enable+0x38/0x88)
 r5:80000013 r4:c03ec7e4
[<c00316ec>] (_omap2_clk_enable+0x0/0x88) from [<c00318b8>] (omap2_clk_enable+0x5c/0x9c)
 r5:80000013 r4:c03ec7e4
[<c003185c>] (omap2_clk_enable+0x0/0x9c) from [<c0036c08>] (clk_enable+0x48/0x70)
 r5:80000013 r4:c03ec7e4
[<c0036bc0>] (clk_enable+0x0/0x70) from [<c003b7ac>] (omap_mcbsp_request+0x74/0x1dc)
 r5:c78248cc r4:c7824800
[<c003b738>] (omap_mcbsp_request+0x0/0x1dc) from [<c025c664>] (omap_mcbsp_dai_startup+0x34/0x38)
 r5:c7b2c400 r4:c0410ff0
[<c025c630>] (omap_mcbsp_dai_startup+0x0/0x38) from [<c02586a4>] (soc_pcm_open+0x54/0x350)
[<c0258650>] (soc_pcm_open+0x0/0x350) from [<c0239e68>] (snd_pcm_open_substream+0x5c/0xa4)
[<c0239e0c>] (snd_pcm_open_substream+0x0/0xa4) from [<c0239ee4>] (snd_pcm_open_file+0x34/0xa0)
 r5:c7b9ddcc r4:c7b7a780
[<c0239eb0>] (snd_pcm_open_file+0x0/0xa0) from [<c023a010>] (snd_pcm_open+0xc0/0x168)
 r6:c7b9c000 r5:c7939a00 r4:00000000
[<c0239f50>] (snd_pcm_open+0x0/0x168) from [<c023a364>] (snd_pcm_playback_open+0x34/0x38)
[<c023a330>] (snd_pcm_playback_open+0x0/0x38) from [<c022d1c4>] (__snd_open+0xd0/0x158)
 r5:c7b7a780 r4:c031eab4
[<c022d0f4>] (__snd_open+0x0/0x158) from [<c022d25c>] (snd_open+0x10/0x14)
 r7:c7a4adc0 r6:00000000 r5:c7860340 r4:00000000
[<c022d24c>] (snd_open+0x0/0x14) from [<c009f80c>] (chrdev_open+0x150/0x174)
[<c009f6bc>] (chrdev_open+0x0/0x174) from [<c009ad98>] (__dentry_open+0x138/0x250)
 r8:c7a23180 r7:00000000 r6:c009f6bc r5:c7a4adc0 r4:c7b7a780
[<c009ac60>] (__dentry_open+0x0/0x250) from [<c009aee8>] (nameidata_to_filp+0x38/0x50)
[<c009aeb0>] (nameidata_to_filp+0x0/0x50) from [<c00a8018>] (do_filp_open+0x2ac/0x630)
 r4:00000000
[<c00a7d6c>] (do_filp_open+0x0/0x630) from [<c009ab78>] (do_sys_open+0x5c/0xec)
[<c009ab1c>] (do_sys_open+0x0/0xec) from [<c009ac40>] (sys_open+0x24/0x28)
 r8:c0028d84 r7:00000005 r6:00000001 r5:00000000 r4:00000000
[<c009ac1c>] (sys_open+0x0/0x28) from [<c0028c00>] (ret_fast_syscall+0x0/0x2c)


BUG: spinlock lockup on CPU#0, aplay/1816, c03f3030
[<c002ce78>] (dump_stack+0x0/0x14) from [<c016d690>] (__spin_lock_debug+0x90/0xa4)
[<c016d600>] (__spin_lock_debug+0x0/0xa4) from [<c016d7e0>] (_raw_spin_lock+0x84/0xa4)
 r8:c0411344 r7:c7939c00 r6:00000000 r5:c7b9c000 r4:c03f3030
[<c016d75c>] (_raw_spin_lock+0x0/0xa4) from [<c030c87c>] (_spin_lock_irqsave+0x54/0x60)
 r7:c7939c00 r6:80000093 r5:c0036be4 r4:c03f3030
[<c030c828>] (_spin_lock_irqsave+0x0/0x60) from [<c0036be4>] (clk_enable+0x24/0x70)
 r6:c0411130 r5:c03ec7e4 r4:c03f13e0
[<c0036bc0>] (clk_enable+0x0/0x70) from [<c0033918>] (omap_mcbsp_clk_enable+0x24/0x3c)
 r5:c03ec7e4 r4:00000000
[<c00338f4>] (omap_mcbsp_clk_enable+0x0/0x3c) from [<c0031724>] (_omap2_clk_enable+0x38/0x88)
 r5:80000013 r4:c03ec7e4
[<c00316ec>] (_omap2_clk_enable+0x0/0x88) from [<c00318b8>] (omap2_clk_enable+0x5c/0x9c)
 r5:80000013 r4:c03ec7e4
[<c003185c>] (omap2_clk_enable+0x0/0x9c) from [<c0036c08>] (clk_enable+0x48/0x70)
 r5:80000013 r4:c03ec7e4
[<c0036bc0>] (clk_enable+0x0/0x70) from [<c003b7ac>] (omap_mcbsp_request+0x74/0x1dc)
 r5:c78248cc r4:c7824800
[<c003b738>] (omap_mcbsp_request+0x0/0x1dc) from [<c025c664>] (omap_mcbsp_dai_startup+0x34/0x38)
 r5:c7b2c400 r4:c0410ff0
[<c025c630>] (omap_mcbsp_dai_startup+0x0/0x38) from [<c02586a4>] (soc_pcm_open+0x54/0x350)
[<c0258650>] (soc_pcm_open+0x0/0x350) from [<c0239e68>] (snd_pcm_open_substream+0x5c/0xa4)
[<c0239e0c>] (snd_pcm_open_substream+0x0/0xa4) from [<c0239ee4>] (snd_pcm_open_file+0x34/0xa0)
 r5:c7b9ddcc r4:c7b7a780
[<c0239eb0>] (snd_pcm_open_file+0x0/0xa0) from [<c023a010>] (snd_pcm_open+0xc0/0x168)
 r6:c7b9c000 r5:c7939a00 r4:00000000
[<c0239f50>] (snd_pcm_open+0x0/0x168) from [<c023a364>] (snd_pcm_playback_open+0x34/0x38)
[<c023a330>] (snd_pcm_playback_open+0x0/0x38) from [<c022d1c4>] (__snd_open+0xd0/0x158)
 r5:c7b7a780 r4:c031eab4
[<c022d0f4>] (__snd_open+0x0/0x158) from [<c022d25c>] (snd_open+0x10/0x14)
 r7:c7a4adc0 r6:00000000 r5:c7860340 r4:00000000
[<c022d24c>] (snd_open+0x0/0x14) from [<c009f80c>] (chrdev_open+0x150/0x174)
[<c009f6bc>] (chrdev_open+0x0/0x174) from [<c009ad98>] (__dentry_open+0x138/0x250)
 r8:c7a23180 r7:00000000 r6:c009f6bc r5:c7a4adc0 r4:c7b7a780
[<c009ac60>] (__dentry_open+0x0/0x250) from [<c009aee8>] (nameidata_to_filp+0x38/0x50)
[<c009aeb0>] (nameidata_to_filp+0x0/0x50) from [<c00a8018>] (do_filp_open+0x2ac/0x630)
 r4:00000000
[<c00a7d6c>] (do_filp_open+0x0/0x630) from [<c009ab78>] (do_sys_open+0x5c/0xec)
[<c009ab1c>] (do_sys_open+0x0/0xec) from [<c009ac40>] (sys_open+0x24/0x28)
 r8:c0028d84 r7:00000005 r6:00000001 r5:00000000 r4:00000000
[<c009ac1c>] (sys_open+0x0/0x28) from [<c0028c00>] (ret_fast_syscall+0x0/0x2c)

