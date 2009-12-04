From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH] PM: Prevent direct cpufreq scaling during initialization
Date: Fri, 04 Dec 2009 16:17:35 +0530
Message-ID: <4B18E8C7.9020707@ti.com>
References: <1259748759.21203.11.camel@boson>	 <48239d390912020733w2981917ap6312eee193f14263@mail.gmail.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301DE87AAD1@dbde02.ent.ti.com> <48239d390912030209n37f042fic8f3eb609e6371e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39469 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445AbZLDKrf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Dec 2009 05:47:35 -0500
In-Reply-To: <48239d390912030209n37f042fic8f3eb609e6371e7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergey Lapin <slapinid@gmail.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sergey Lapin wrote:
> On Thu, Dec 3, 2009 at 9:29 AM, Dasgupta, Romit <romit@ti.com> wrote:
>>
>>>> Signed-off-by: Romit Dasgupta <romit@ti.com>
>>>> ---
>>>> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-
>>> omap.c
>>>> index 449b6b6..f94df20 100644
>>>> --- a/arch/arm/plat-omap/cpu-omap.c
>>>> +++ b/arch/arm/plat-omap/cpu-omap.c
>>>> @@ -149,8 +149,6 @@ static int __init omap_cpu_init(struct
>>> cpufreq_policy *policy)
>>>>                                                        VERY_HI_RATE) /
>>> 1000;
>>>>        }
>>>>
>>>> -       clk_set_rate(mpu_clk, policy->cpuinfo.max_freq * 1000);
>>>> -
>>>>        policy->min = policy->cpuinfo.min_freq;
>>>>        policy->max = policy->cpuinfo.max_freq;
>>>>        policy->cur = omap_getspeed(0);
>>> This patch leads to hang with current PM branch, SRF and CPU IDLE enabled
>>> on OMAP3525 rev C.
>> Verified this to work on Zoom2 + SRF + CPUidle. Can you give some debug info if possible?
>>
> Well, that looks like false alarm - I tried clean tree without local
> patches, and it seems to work.
> 
> However, without this line removed, my system boots faster. Is it possible to
> limit initial speed for unstable setups, but to boot as fast as possible?
> 
> Thanks a lot,
> S.
omap_cpufreq_init is a lateinitcall. So quite some part of the kernel startup
happens with whatever speed the bootloader passes control to kernel
initialization code. Only after we invoke omap_cpufreq_init will the cpufreq
framework try to call the offending code 'clk_set_rate'. Quite soon after this
the cpufreq default governor (whatever it is for your system, performance,
ondemand etc) is initialized. If you choose performance governor it will
immediately scale the frequency to the highest available for the system. So the
way to boot fast would be

a) make your bootcode scale the voltage + freq to support the highest cpu freq.
and/or
b) make performance governor the default.


