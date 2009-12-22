From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization delay
Date: Tue, 22 Dec 2009 08:56:53 -0800
Message-ID: <87vdfzq756.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4B50@dbde02.ent.ti.com>
	<87skbhjwjo.fsf@deeprootsystems.com>
	<87my1pggok.fsf@deeprootsystems.com> <4B25FF04.4040306@ti.com>
	<873a3dfse2.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD07FD36@dbde02.ent.ti.com>
	<87my1lgxjo.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB031DF2DA55@dbde02.ent.ti.com>
	<87iqbzuhn9.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608703001E1C26@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:15252 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbZLVQ46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 11:56:58 -0500
Received: by qw-out-2122.google.com with SMTP id 8so26389qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 22 Dec 2009 08:56:57 -0800 (PST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703001E1C26@dbde02.ent.ti.com> (Vishwanath Sripathy's message of "Tue\, 22 Dec 2009 21\:30\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "Dasgupta, Romit" <romit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Sripathy, Vishwanath" <vishwanath.bs@ti.com> writes:

> Kevin,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Tuesday, December 22, 2009 9:26 PM
>> To: Reddy, Teerth
>> Cc: Dasgupta, Romit; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH] OMAP3: PM: Dynamic calculation of SDRC clock stabilization
>> delay
>> 
>> "Reddy, Teerth" <teerth@ti.com> writes:
>> 
>> > Kevin,
>> >
>> >>
>> >> Here's an uncompiled, untested version of 'measure_sram_delay' using
>> >> the DM Timer API:
>> >>
>> >> unsigned int measure_sram_delay(unsigned int loop)
>> >> {
>> >>     unsigned long start, end, flags;
>> >>     void (*_omap3_sram_delay)(unsigned long);
>> >>     _omap3_sram_delay = omap_sram_push(__sram_wait_delay,
>> >>                                   __sram_wait_delay_sz);
>> >>
>> >>     gpt = omap_dm_timer_request();
>> >>     if (!gpt)
>> >>           pr_err("foo");
>> >>     omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
>> >>     omap_dm_timer_set_load_start(gptimer, 0, 0);
>> >>
>> >>         local_irq_save(flags);
>> >>         start = omap_dm_timer_read_counter(gpt);
>> >>     _omap3_sram_delay(loop);
>> >>         end = omap_dm_timer_read_counter(gpt);
>> >>         local_irq_restore(flags);
>> >>
>> >>     omap_dm_timer_stop(gpt);
>> >>         omap_dm_timer_free(gpt);
>> >>
>> >>     return end - start;
>> >> }
>> >>
>> >
>> > I see one shortcoming with this approach. The DVFS happens even
>> > before the gp timers are initialized, while the kernel boots.
>> 
>> This is a bug.  DVFS should be prevented until system is initialized.
>> 
>
>
> I think DVFS is triggered when CPU Freq driver gets
> initialized. Depending on the default governor cpufreq tries to
> scale the frequency which triggers DVFS.

Correct.

> So do you mean to say that cpufreq initialization should be
> prevented till GPTimer is initialized?

Basically, yes.  

You need to calibrate the delay before you can do DVFS, so what I mean
is that you need to request your GPtimer, and do your delay
measurements using the GPtimer before you enable DVFS (register
CPUfreq.)

Also, please be sure to stop/free the GPtimer when done, otherwise
it will prevent idle.

Kevin





