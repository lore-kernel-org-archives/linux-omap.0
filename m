From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Fri, 27 May 2011 11:56:44 +0530
Message-ID: <4DDF4424.2000706@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <87ipsxcoz0.fsf@ti.com> <4DDF3169.9070503@ti.com> <BANLkTinv3HMBE_FBGWfLvnWyTRM=wXhpxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53210 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189Ab1E0G0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 02:26:50 -0400
Received: by gwaa12 with SMTP id a12so607818gwa.28
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 23:26:49 -0700 (PDT)
In-Reply-To: <BANLkTinv3HMBE_FBGWfLvnWyTRM=wXhpxA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On 5/27/2011 11:37 AM, Menon, Nishanth wrote:
> On Thu, May 26, 2011 at 22:06, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> On 5/26/2011 11:40 PM, Kevin Hilman wrote:
>>>
>>> So here's a dumb question, being rather ignorant of CPUfreq on SMP.
>>>
>>> Should we be running a CPUfreq instance on both CPUs when they cannot be
>>> scaled independently?
>>>
>>> What is being scaled here is actually the cluster (the MPU SS via
>>> dpll_mpu_ck), not an individual CPU.  So to me, it only makes sense to
>>> have a an instance of the driver per scalable device, which in this case
>>> is a single MPU SS.
>>>
>> We are running only one instance and for the exact same reason as above.
>> You are completely right and that's the whole intention of those
>> CPUMASK two lines in the initialization code.
>>
>>
>>> What am I missing?
>>>
>> Not at all.
>
> So not have cpufreq driver registered at all for CPU1? Life would be a
> lot simpler in omap2-cpufreq.c as a result. but that said, two views:
> a) future silicon somewhere ahead might need the current
> infrastructure to scale into different tables..
> b) as far as userspace sees it - cpu0 and cpu1 exists, cool, *but*
> cpu1 is not scalable(no /sys/devices/system/cpu/cpu1/cpufreq.. but
> .../cpu1/online is present). Keep in mind that userspace is usually
> written chip independent. IMHO registering drivers for both devices do
> make sense they reflect what the reality of the system is. 2 cpus
> scaling together - why do we want to OMAP "specific" stuff here?
>
It's not OMAP specific Nishant.
And this feature is supported by CPUFREQ driver. My Intel machine
uses the same exact scheme for CPUFREQ. It's feature provided
specifically for hardwares with individual CPU scaling
limitation. Instead of CPU's, whole CPU cluster scales
together.

Both CPU's still have same consistent view of all CPUFREQ controls.
But in  back-ground, CPU1 is carrying only symbolic links.

We make use of "related/affected cpu" feature which is
supported by generic CPUFREQ driver. Nothing OMAP-specific
here.

And as I said i n other thread, if at all in future we get
CPU's which can scale indepedently, we just need to change
that one line where we specify the relation between CPU's.
It's as trivial as that.

Regards
Santosh




