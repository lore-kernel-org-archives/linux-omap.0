From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP3: PM: Configure CPUidle latencies/thresholds from board files
Date: Tue, 30 Jun 2009 15:58:45 -0700
Message-ID: <87ab3p49cq.fsf@deeprootsystems.com>
References: <1246286113-21197-1-git-send-email-rnayak@ti.com>
	<1246286113-21197-2-git-send-email-rnayak@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301D83B1E1C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:17884 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZF3W6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jun 2009 18:58:44 -0400
Received: by wf-out-1314.google.com with SMTP id 26so177366wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2009 15:58:47 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301D83B1E1C@dbde02.ent.ti.com> (Sanjeev Premi's message of "Tue\, 30 Jun 2009 17\:11\:18 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>>  extern void omap1_map_common_io(void);
>>  extern void omap1_init_common_hw(void);
>> @@ -234,7 +235,8 @@ extern void omap2_init_common_hw(struct 
>> omap_sdrc_params *sp,
>>  				 struct omap_opp *mpu_opps,
>>  				 struct omap_opp *dsp_opps,
>>  				 struct omap_opp *l3_opps,
>> -				 struct prm_setup_vc *setup_times);
>> +				 struct prm_setup_vc *setup_times,
>> +				 struct cpuidle_params *idle_params);
>
> Rajendra, all,
>
> Aren't we 'overloading' omap2_init_common_hw() each time we add another
> argument to it?
>
> Shouldn't we defined define a function specific for PM initialization?
> Some of the initialization actually doesn't even touch the HW.
>

Completely agree.

We are absolutely overloading init_common_hw() and this is on the list
of things I'd like to see changed before those change go upstream.  I
just haven't got to that yet.

I would happily welcome any proposals or cleanups to this.

My current feeling is that I think these board-specific settings
should just be using platform_driver/platform_device model and then
board-specifics could be passed via platform_data.  If not settings
are given, conservative defaults can be used.  But honestly, I haven't
given it much more thought, other than I *really* don't like the
current overloading of that function.

Kevin


