From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: [PATCH] PM: Prevent direct cpufreq scaling during initialization
Date: Thu, 3 Dec 2009 13:09:21 +0300
Message-ID: <48239d390912030209n37f042fic8f3eb609e6371e7@mail.gmail.com>
References: <1259748759.21203.11.camel@boson>
	 <48239d390912020733w2981917ap6312eee193f14263@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87AAD1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:34299 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZLCKJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:09:15 -0500
Received: by ey-out-2122.google.com with SMTP id d26so287678eyd.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Dec 2009 02:09:21 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE87AAD1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 3, 2009 at 9:29 AM, Dasgupta, Romit <romit@ti.com> wrote:
>
>
>> > Signed-off-by: Romit Dasgupta <romit@ti.com>
>> > ---
>> > diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-
>> omap.c
>> > index 449b6b6..f94df20 100644
>> > --- a/arch/arm/plat-omap/cpu-omap.c
>> > +++ b/arch/arm/plat-omap/cpu-omap.c
>> > @@ -149,8 +149,6 @@ static int __init omap_cpu_init(struct
>> cpufreq_policy *policy)
>> >                                                        VERY_HI_RATE) /
>> 1000;
>> >        }
>> >
>> > -       clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
>> > -
>> >        policy->min = policy->cpuinfo.min_freq;
>> >        policy->max = policy->cpuinfo.max_freq;
>> >        policy->cur = omap_getspeed(0);
>>
>> This patch leads to hang with current PM branch, SRF and CPU IDLE enabled
>> on OMAP3525 rev C.
> Verified this to work on Zoom2 + SRF + CPUidle. Can you give some debug info if possible?
>
Well, that looks like false alarm - I tried clean tree without local
patches, and it seems to work.

However, without this line removed, my system boots faster. Is it possible to
limit initial speed for unstable setups, but to boot as fast as possible?

Thanks a lot,
S.
