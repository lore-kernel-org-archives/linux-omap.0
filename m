From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock
 stabilization delay
Date: Tue, 22 Dec 2009 21:30:18 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703001E1C26@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>
	<87skbhjwjo.fsf@deeprootsystems.com>	<87my1pggok.fsf@deeprootsystems.com>
 <4B25FF04.4040306@ti.com>	<873a3dfse2.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD07FD36@dbde02.ent.ti.com>
	<87my1lgxjo.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB031DF2DA55@dbde02.ent.ti.com>
 <87iqbzuhn9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741AbZLVQAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 11:00:36 -0500
In-Reply-To: <87iqbzuhn9.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Reddy, Teerth" <teerth@ti.com>
Cc: "Dasgupta, Romit" <romit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Tuesday, December 22, 2009 9:26 PM
> To: Reddy, Teerth
> Cc: Dasgupta, Romit; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: PM: Dynamic calculation of SDRC clock stabilization
> delay
> 
> "Reddy, Teerth" <teerth@ti.com> writes:
> 
> > Kevin,
> >
> >>
> >> Here's an uncompiled, untested version of 'measure_sram_delay' using
> >> the DM Timer API:
> >>
> >> unsigned int measure_sram_delay(unsigned int loop)
> >> {
> >>     unsigned long start, end, flags;
> >>     void (*_omap3_sram_delay)(unsigned long);
> >>     _omap3_sram_delay = omap_sram_push(__sram_wait_delay,
> >>                                   __sram_wait_delay_sz);
> >>
> >>     gpt = omap_dm_timer_request();
> >>     if (!gpt)
> >>           pr_err("foo");
> >>     omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
> >>     omap_dm_timer_set_load_start(gptimer, 0, 0);
> >>
> >>         local_irq_save(flags);
> >>         start = omap_dm_timer_read_counter(gpt);
> >>     _omap3_sram_delay(loop);
> >>         end = omap_dm_timer_read_counter(gpt);
> >>         local_irq_restore(flags);
> >>
> >>     omap_dm_timer_stop(gpt);
> >>         omap_dm_timer_free(gpt);
> >>
> >>     return end - start;
> >> }
> >>
> >
> > I see one shortcoming with this approach. The DVFS happens even
> > before the gp timers are initialized, while the kernel boots.
> 
> This is a bug.  DVFS should be prevented until system is initialized.
> 


I think DVFS is triggered when CPU Freq driver gets initialized. Depending on the default governor cpufreq tries to scale the frequency which triggers DVFS. So do you mean to say that cpufreq initialization should be prevented till GPTimer is initialized?

> Kevin
> 
> > I am trying to use gp timers and I came across this problem. I
> > didn't see this issue with PMC. Please correct me if my
> > understanding is wrong.
> 
> > --Snip---
> > Kernel command line: mem=128M, console=ttyS0,115200n8 noinitrd
> root=/dev/nfs rw nfsroot=172.24.190.217:/data/nfs-
> share/teerth/target11,nolock,rsize=1024,wsize=1024 ip=dhcp devfs=mount
> > PID hash table entries: 512 (order: -1, 2048 bytes)
> > Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> > Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> > Memory: 128MB = 128MB total
> > Memory: 125780KB available (3496K code, 358K data, 128K init, 0K highmem)
> > SLUB: Genslabs=9, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > Hierarchical RCU implementation.
> > NR_IRQS:402
> > Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
> > Reprogramming SDRC clock to 332000000 Hz
> > ------
> >  GPMC revision 5.0
> > IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
> > Total of 96 interrupts on 1 active controller
> > OMAP GPIO hardware version 2.5
> > OMAP clockevent source: GPTIMER1 at 32768 Hz
> > ------
> > Console: colour dummy device 80x30
> > Calibrating delay loop... 498.87 BogoMIPS (lpj=1945600)
> > Mount-cache hash table entries: 512
> > CPU: Testing write buffer coherency: ok
> > regulator: core version 0.5
> >
> > Regards
> > Teerth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
