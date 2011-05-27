From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 0/6 V3] Cleanups for cpufreq
Date: Fri, 27 May 2011 10:33:39 -0500
Message-ID: <BANLkTiktQAt3q=a3-cNaFrTH5UeNH21tmg@mail.gmail.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com> <87ipsxcoz0.fsf@ti.com>
 <4DDF3169.9070503@ti.com> <BANLkTinv3HMBE_FBGWfLvnWyTRM=wXhpxA@mail.gmail.com>
 <4DDF4424.2000706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50778 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753965Ab1E0Pd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 11:33:59 -0400
Received: by mail-qw0-f53.google.com with SMTP id 7so1085373qwb.12
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 08:33:59 -0700 (PDT)
In-Reply-To: <4DDF4424.2000706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, May 27, 2011 at 1:26 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/27/2011 11:37 AM, Menon, Nishanth wrote:
>>
>> On Thu, May 26, 2011 at 22:06, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> =A0wrote:
>>>
>>> On 5/26/2011 11:40 PM, Kevin Hilman wrote:
>>>>
>>>> So here's a dumb question, being rather ignorant of CPUfreq on SMP=
=2E
>>>>
>>>> Should we be running a CPUfreq instance on both CPUs when they can=
not be
>>>> scaled independently?
>>>>
>>>> What is being scaled here is actually the cluster (the MPU SS via
>>>> dpll_mpu_ck), not an individual CPU. =A0So to me, it only makes se=
nse to
>>>> have a an instance of the driver per scalable device, which in thi=
s case
>>>> is a single MPU SS.
>>>>
>>> We are running only one instance and for the exact same reason as a=
bove.
>>> You are completely right and that's the whole intention of those
>>> CPUMASK two lines in the initialization code.
>>>
>>>
>>>> What am I missing?
>>>>
>>> Not at all.
>>
>> So not have cpufreq driver registered at all for CPU1? Life would be=
 a
>> lot simpler in omap2-cpufreq.c as a result. but that said, two views=
:
>> a) future silicon somewhere ahead might need the current
>> infrastructure to scale into different tables..
>> b) as far as userspace sees it - cpu0 and cpu1 exists, cool, *but*
>> cpu1 is not scalable(no /sys/devices/system/cpu/cpu1/cpufreq.. but
>> .../cpu1/online is present). Keep in mind that userspace is usually
>> written chip independent. IMHO registering drivers for both devices =
do
>> make sense they reflect what the reality of the system is. 2 cpus
>> scaling together - why do we want to OMAP "specific" stuff here?
>>
> It's not OMAP specific Nishant.
> And this feature is supported by CPUFREQ driver. My Intel machine
> uses the same exact scheme for CPUFREQ. It's feature provided
> specifically for hardwares with individual CPU scaling
> limitation. Instead of CPU's, whole CPU cluster scales
> together.
>
> Both CPU's still have same consistent view of all CPUFREQ controls.
> But in =A0back-ground, CPU1 is carrying only symbolic links.
>
> We make use of "related/affected cpu" feature which is
> supported by generic CPUFREQ driver. Nothing OMAP-specific
> here.

Santosh is referring to this code in our cpufreq driver:

        /*
         * On OMAP SMP configuartion, both processors share the voltage
         * and clock. So both CPUs needs to be scaled together and henc=
e
         * needs software co-ordination. Use cpufreq affected_cpus
         * interface to handle this scenario. Additional is_smp() check
         * is to keep SMP_ON_UP build working.
         */
        if (is_smp()) {
                policy->shared_type =3D CPUFREQ_SHARED_TYPE_ANY;
                cpumask_or(cpumask, cpumask_of(policy->cpu), cpumask);
                cpumask_copy(policy->cpus, cpumask);
        }

policy->cpus knows about each CPU now (in fact, due to this you will
see /sys/devices/system/cpu/cpu1/cpufreq is in fact a symlink to its
cpu0 sibling!)

This is pretty good in fact, since governors like ondemand take into
consideration *all* of the CPUs in policy->cpus:

        /* Get Absolute Load - in terms of freq */
        max_load_freq =3D 0; <- tracks greatest need across all CPUs

        for_each_cpu(j, policy->cpus) {
                ... find max_load_freq ...

Ultimate effect is that we run a single workqueue only on CPU0
(kondemand or whatever) that takes the load characteristics of both
CPU0 and CPU1 into account.

Regards,
Mike


> And as I said i n other thread, if at all in future we get
> CPU's which can scale indepedently, we just need to change
> that one line where we specify the relation between CPU's.
> It's as trivial as that.
>
> Regards
> Santosh
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
