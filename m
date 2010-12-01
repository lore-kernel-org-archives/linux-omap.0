From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP PM: Optimize cpufreq transition latency
Date: Wed, 1 Dec 2010 19:58:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03735A1A55@dbde02.ent.ti.com>
References: <1290692291-25073-1-git-send-email-vishwanath.bs@ti.com>
 <AANLkTin7QLrwjpwkbrq-5qo+5WH9KmqVmcJh61kbwXYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46040 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab0LAO2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 09:28:13 -0500
In-Reply-To: <AANLkTin7QLrwjpwkbrq-5qo+5WH9KmqVmcJh61kbwXYw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Turquette, Mike" <mturquette@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>owner@vger.kernel.org] On Behalf Of Turquette, Mike
>>Sent: Wednesday, December 01, 2010 1:20 AM
>>To: Sripathy, Vishwanath
>>Cc: linux-omap@vger.kernel.org; linaro-dev@lists.linaro.org
>>Subject: Re: [PATCH] OMAP PM: Optimize cpufreq transition latency
>>
>>On Thu, Nov 25, 2010 at 7:38 AM, Vishwanath BS <vishwanath.bs@ti.com>=
 wrote:
>>> Currently cpufreq transition latency value does not really reflect =
the
>>actual
>>> OMAP OPP transition delay. This patch has the actual latency value.
>>> I did profile the DVFS latency on OMAP3430, OMAP3630 and OMAP4 for
>>worstcase(MPU and Core together) and found that in none of these plat=
forms,
>>transiton value
>>> goes beyong 10ms. Added a buffer of 20ms to avoid too frequent onde=
mand
>>timer
>>> expiry.
>>> With this change, performance of ondemand governor is improved when=
 tested
>>> using cpufreqbench tool. Without this patch, cpufreq-bench reported
>>ondemand
>>> performance as 40% of performance governor, and with this patch it'=
s around
>>70%
>>> (using below procedure).
>>>
>>> cpufreq-bench:
>>> http://lwn.net/Articles/339862/
>>> http://ftp.riken.go.jp/archives/Linux/suse/people/ckornacker/cpufre=
q-bench/
>>>
>>> Command used for performance testing:
>>> cpufreq-bench -l 50000 -s 100000 -x 50000 -y 100000 -g ondemand -r =
5 -n 5 -
>>v
>>>
>>> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>>> ---
>>> =A0arch/arm/plat-omap/cpu-omap.c | =A0 =A04 ++--
>>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>> =A0mode change 100644 =3D> 100755 arch/arm/plat-omap/cpu-omap.c
>>>
>>> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu=
-omap.c
>>> old mode 100644
>>> new mode 100755
>>> index c47faf8..d3fc423
>>> --- a/arch/arm/plat-omap/cpu-omap.c
>>> +++ b/arch/arm/plat-omap/cpu-omap.c
>>> @@ -158,8 +158,8 @@ static int __init omap_cpu_init(struct cpufreq_=
policy
>>*policy)
>>> =A0 =A0 =A0 =A0policy->max =3D policy->cpuinfo.max_freq;
>>> =A0 =A0 =A0 =A0policy->cur =3D omap_getspeed(0);
>>>
>>> - =A0 =A0 =A0 /* FIXME: what's the actual transition time? */
>>> - =A0 =A0 =A0 policy->cpuinfo.transition_latency =3D 300 * 1000;
>>> + =A0 =A0 =A0 /* Program the actual transition time for worstcase *=
/
>>> + =A0 =A0 =A0 policy->cpuinfo.transition_latency =3D 30 * 1000;
>>
>>Vishwa,
>>
>>This is a frequent periodic timer.  Does a smaller value have any
>>affect on CPUidle wakeups?

I thought this is a deferred timer and so should not affect the cpuidle=
 thread at all.

Regards
Thara
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
