From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Fwd: Re: current panda omap kernel stacks
Date: Fri, 30 Aug 2013 08:59:19 +0200
Message-ID: <522042C7.1020809@gmail.com>
References: <CAAk9F99Oy=ozOogZNZo6KzC8o-X4u_vTAdOww64dBCyEsSPgVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:57134 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab3H3G7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 02:59:24 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so1256840wes.32
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 23:59:23 -0700 (PDT)
In-Reply-To: <CAAk9F99Oy=ozOogZNZo6KzC8o-X4u_vTAdOww64dBCyEsSPgVw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

please see the current issues I found on panda running 
3.10.1.0-1-linaro-omap

https://dl.dropboxusercontent.com/u/21820416/panda.syslog.gz
https://dl.dropboxusercontent.com/u/21820416/panda-dmesg

System is generally very unstable.

RCU stall sent in different thread

Chris


-------- Original Message --------
Subject: 	Re: current panda omap kernel stacks
Date: 	Tue, 27 Aug 2013 21:11:12 +0200
From: 	Christian Hoffmann <chrmhoffmann@gmail.com>
To: 	linaro-kernel@lists.linaro.org



Forgot to attach syslog here:
https://dl.dropboxusercontent.com/u/21820416/panda.syslog.gz


On Tue, Aug 27, 2013 at 9:09 PM, Christian Hoffmann
<chrmhoffmann@gmail.com <mailto:chrmhoffmann@gmail.com>> wrote:

     Sorry to reply to myself, but after a while the panda doesn't reply
     any more over network and the syslog has lots of entries like this one:

     Aug 27 13:00:38 panda kernel: [87136.303894] [<c044c1e9>]
     (__schedule_bug+0x39/0x50) from [<c045219f>] (__schedule+0x51f/0x5c4)
     Aug 27 13:00:38 panda kernel: [87136.303924] [<c045219f>]
     (__schedule+0x51f/0x5c4) from [<c045250b>]
     (schedule_preempt_disabled+0xf/0x10)
     Aug 27 13:00:38 panda kernel: [87136.303924] [<c045250b>]
     (schedule_preempt_disabled+0xf/0x10) from [<c0058bbb>]
     (cpu_startup_entry+0x12f/0x164)
     Aug 27 13:00:38 panda kernel: [87136.303955] [<c0058bbb>]
     (cpu_startup_entry+0x12f/0x164) from [<80448ea9>] (0x80448ea9)
     Aug 27 13:00:38 panda kernel: [87136.307403] BUG: scheduling while
     atomic: swapper/1/0/0xffff0000
     Aug 27 13:00:38 panda kernel: [87136.313781] Modules linked in:
     snd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_twl6040
     snd_soc_omap snd_soc_omap_mcbsp snd_soc_core snd_compress regmap_spi
     snd_pcm snd_page_alloc snd_timer snd soundcore gator
     Aug 27 13:00:38 panda kernel: [87136.313842] CPU: 1 PID: 0 Comm:
     swapper/1 Tainted: G        W    3.10.1.0-1-linaro-omap
     #1ubuntu1~ci+130723003933-Ubuntu
     Aug 27 13:00:38 panda kernel: [87136.313842] [<c001175d>]
     (unwind_backtrace+0x1/0x9c) from [<c000f625>] (show_stack+0x11/0x14)
     Aug 27 13:00:38 panda kernel: [87136.313873] [<c000f625>]
     (show_stack+0x11/0x14) from [<c044c1e9>] (__schedule_bug+0x39/0x50)
     Aug 27 13:00:38 panda kernel: [87136.313903] [<c044c1e9>]
     (__schedule_bug+0x39/0x50) from [<c045219f>] (__schedule+0x51f/0x5c4)
     Aug 27 13:00:38 panda kernel: [87136.313934] [<c045219f>]
     (__schedule+0x51f/0x5c4) from [<c045250b>]
     (schedule_preempt_disabled+0xf/0x10)
     Aug 27 13:00:38 panda kernel: [87136.313934] [<c045250b>]
     (schedule_preempt_disabled+0xf/0x10) from [<c0058bbb>]
     (cpu_startup_entry+0x12f/0x164)
     Aug 27 13:00:38 panda kernel: [87136.313964] [<c0058bbb>]
     (cpu_startup_entry+0x12f/0x164) from [<80448ea9>] (0x80448ea9)
     Aug 27 13:00:38 panda kernel: [87136.317382] BUG: scheduling while
     atomic: swapper/1/0/0xffff0000
     Aug 27 13:00:38 panda kernel: [87136.323760] Modules linked in:
     snd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_twl6040
     snd_soc_omap snd_soc_omap_mcbsp snd_soc_core snd_compress regmap_spi
     snd_pcm snd_page_alloc snd_timer snd soundcore gator
     Aug 27 13:00:38 panda kernel: [87136.323822] CPU: 1 PID: 0 Comm:
     swapper/1 Tainted: G        W    3.10.1.0-1-linaro-omap
     #1ubuntu1~ci+130723003933-Ubuntu
     Aug 27 13:00:38 panda kernel: [87136.323822] [<c001175d>]
     (unwind_backtrace+0x1/0x9c) from [<c000f625>] (show_stack+0x11/0x14)
     Aug 27 13:00:38 panda kernel: [87136.323822] [<c000f625>]
     (show_stack+0x11/0x14) from [<c044c1e9>] (__schedule_bug+0x39/0x50)
     Aug 27 13:00:38 panda kernel: [87136.323883] [<c044c1e9>]
     (__schedule_bug+0x39/0x50) from [<c045219f>] (__schedule+0x51f/0x5c4)
     Aug 27 13:00:38 panda kernel: [87136.323913] [<c045219f>]
     (__schedule+0x51f/0x5c4) from [<c045250b>]
     (schedule_preempt_disabled+0xf/0x10)
     Aug 27 13:00:38 panda kernel: [87136.323913] [<c045250b>]
     (schedule_preempt_disabled+0xf/0x10) from [<c0058bbb>]
     (cpu_startup_entry+0x12f/0x164)
     Aug 27 13:00:38 panda kernel: [87136.323944] [<c0058bbb>]
     (cpu_startup_entry+0x12f/0x164) from [<80448ea9>] (0x80448ea9)
     Aug 27 13:00:38 panda kernel: [87136.327392] BUG: scheduling while
     atomic: swapper/1/0/0xffff0000
     Aug 27 13:00:38 panda kernel: [87136.333770] Modules linked in:
     snd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_twl6040
     snd_soc_omap snd_soc_omap_mcbsp snd_soc_core snd_compress regmap_spi
     snd_pcm snd_page_alloc snd_timer snd soundcore gator

     Rgds,
     Chris


     On Tue, Aug 27, 2013 at 8:50 AM, Christian Hoffmann
     <chrmhoffmann@gmail.com <mailto:chrmhoffmann@gmail.com>> wrote:

         Hi,

         running the current panda linaro kernel 3.10.1.0-1-linaro-omap
         from linaro release 13.07, I run into a few kernel stacks.

         Eg.:

         [33222.473022] ------------[ cut here ]------------
         [33222.473052] WARNING: at
         /build/buildd/linux-linaro-omap-3.10.1-3.10.1.0/kernel/timer.c:1122
         call_timer_fn+0x81/0xb0()
         [33222.473083] timer: process_timeout+0x1/0xc preempt leak:
         00000100 -> 00000000
         [33222.473083] Modules linked in: snd_soc_omap_abe_twl6040
         snd_soc_omap_mcpdm snd_soc_twl6040 snd_soc_omap
         snd_soc_omap_mcbsp snd_soc_core snd_compress regmap_spi snd_pcm
         snd_page_alloc snd_timer snd soundcore gator
         [33222.473114] CPU: 1 PID: 0 Comm: swapper/1 Not tainted
         3.10.1.0-1-linaro-omap #1ubuntu1~ci+130723003933-Ubuntu
         [33222.473114] [<c001175d>] (unwind_backtrace+0x1/0x9c) from
         [<c000f625>] (show_stack+0x11/0x14)
         [33222.473114] [<c000f625>] (show_stack+0x11/0x14) from
         [<c002b8ad>] (warn_slowpath_common+0x39/0x54)
         [33222.473236] [<c002b8ad>] (warn_slowpath_common+0x39/0x54)
         from [<c002b933>] (warn_slowpath_fmt+0x23/0x2c)
         [33222.473266] [<c002b933>] (warn_slowpath_fmt+0x23/0x2c) from
         [<c00351e5>] (call_timer_fn+0x81/0xb0)
         [33222.473266] [<c00351e5>] (call_timer_fn+0x81/0xb0) from
         [<c0035cb9>] (run_timer_softirq+0x13d/0x1c8)
         [33222.473297] [<c0035cb9>] (run_timer_softirq+0x13d/0x1c8) from
         [<c003111f>] (__do_softirq+0xc3/0x1c0)
         [33222.473327] [<c003111f>] (__do_softirq+0xc3/0x1c0) from
         [<c0031447>] (irq_exit+0x63/0x88)
         [33222.473327] [<c0031447>] (irq_exit+0x63/0x88) from
         [<c001079d>] (handle_IPI+0x59/0x158)
         [33222.473358] [<c001079d>] (handle_IPI+0x59/0x158) from
         [<c00084ff>] (gic_handle_irq+0x4b/0x50)
         [33222.473358] [<c00084ff>] (gic_handle_irq+0x4b/0x50) from
         [<c045315b>] (__irq_svc+0x3b/0x5c)
         [33222.473388] Exception stack(0xed8cdf50 to 0xed8cdf98)
         [33222.473388] df40:
         00000002 00000000 00000000 00000001
         [33222.473419] df60: edc7664c 00000002 c045c2e0 c0ff00b8
         00000002 c06f189c edc76640 ed8cc000
         [33222.473419] df80: 3b9ac9ff ed8cdf98 c0284b33 c0375b04
         00000173 ffffffff
         [33222.473449] [<c045315b>] (__irq_svc+0x3b/0x5c) from
         [<c0375b04>] (cpuidle_enter_state_coupled+0x1dc/0x210)
         [33222.473480] [<c0375b04>]
         (cpuidle_enter_state_coupled+0x1dc/0x210) from [<c037436d>]
         (cpuidle_idle_call+0xbd/0x158)
         [33222.473480] [<c037436d>] (cpuidle_idle_call+0xbd/0x158) from
         [<c000d4b1>] (arch_cpu_idle+0xd/0x28)
         [33222.473480] [<c000d4b1>] (arch_cpu_idle+0xd/0x28) from
         [<c0058ae9>] (cpu_startup_entry+0x5d/0x164)
         [33222.473541] [<c0058ae9>] (cpu_startup_entry+0x5d/0x164) from
         [<80448ea9>] (0x80448ea9)
         [33222.473541] ---[ end trace 0f39b8196adfb0ec ]---


         Full dmesg can be found here:
         https://dl.dropboxusercontent.com/u/21820416/panda-dmesg

         Is this a known issue?

         Rgds,
         Chris





