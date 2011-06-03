From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary
 CPUs are offline.
Date: Fri, 03 Jun 2011 12:09:09 +0530
Message-ID: <4DE8818D.5030102@ti.com>
References: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com> <BANLkTi=LUMdrTzsOXtVwU_aTcecodaJiPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60124 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab1FCGjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 02:39:15 -0400
Received: by gwj16 with SMTP id 16so764914gwj.37
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 23:39:13 -0700 (PDT)
In-Reply-To: <BANLkTi=LUMdrTzsOXtVwU_aTcecodaJiPg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

On 6/3/2011 8:14 AM, Menon, Nishanth wrote:
> On Thu, Jun 2, 2011 at 09:51, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Current OMAP2PLUS CPUfreq tagret() functions returns when all
>> the CPU's are not online. This will break DVFS when secondary
>> CPUs are offlined.
>>
>> The intention of that check was just avoid CPU frequency change
>> during the window when CPU becomes online but it's cpufreq_init is
>> not done yet.
> is it this requirement a boot requirement or a necessity for
> cpufreq_driver.init being called for online cpus? Since we maintain
> just a single freq_table... why do we care about multiple cpu_inits?
>
I put a comment after ---
After some thinking, I realised
there is no need of that since this is just a counter which
maintains the count for online_cpus = cpufreq_init_cpus.
And we need inits on all CPUs to ensure the CPU relation is
set. It's not all about _one_ table.


> Anyways, tried testing this and .config with CONFIG_SMP_ON_UP and
> USERSPACE. it works with one cpu and does not scale 2 cpus :(
>
You mean userspace governor? I don't think why that can happen.
Vishwa tested this and it did worked. We will test this again.

> After applying this patch on kevin's cpufreq branch, I added some
> prints for logging:

[..]

>
>   	/* FIXME: what's the actual transition time? */
> @@ -212,6 +220,8 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
>   	if (is_smp()) {
>   		cpus_initialized--;
>   		smp_wmb();
> +		pr_err("%s: cpu %d cpus_initialized = %d online=%d\n", __func__,
> +			policy->cpu, cpus_initialized, num_online_cpus());
>   	}
>   	return 0;
>   }
>
> on boot, this is what I see:
> [    0.421020] omap_cpu_init: cpu 0 cpus_initialized = 1 online=2
> [    0.421264] omap_target: cpu 0 not ready to go to 1008000 (inits=1
> vs online=2)
> [    0.421630] omap_cpu_init: cpu 1 cpus_initialized = 2 online=2
> [    0.421691] omap_cpu_exit: cpu 1 cpus_initialized = 1 online=2
This must be becasue hot-plug governor is kicking in here which
is taking CPU1 in and OUT.

> ...
> snip
> ...
> [    2.044128] omap_target: cpu 0 not ready to go to 1008000 (inits=1
> vs online=2)
> [    2.051849] omap_target: cpu 0 not ready to go to 1008000 (inits=1
> vs online=2)

This is expected as well because CPU1 has not really offline yet. And
the code is doing right thing.

> ... snip..
> ...boots up to busybox shell..
> / # head /sys/devices/system/cpu/cpu1/online /sys/devices/system/cpu/cpu0/online
>
> ==>  /sys/devices/system/cpu/cpu1/online<==
> 1
>
> ==>  /sys/devices/system/cpu/cpu0/online<==
> 1
> / # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> 300000 600000 800000 1008000
> / # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 1008000
> / # echo -n "300000">/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> [  130.257385] omap_target: cpu 0 not ready to go to 300000 (inits=1
> vs online=2)
> / # echo -n "0">  /sys/devices/system/cpu/cpu1/online
> [  144.749877] CPU1: shutdown
> / # head /sys/devices/system/cpu/cpu1/online /sys/devices/system/cpu/cpu0/online
>
> ==>  /sys/devices/system/cpu/cpu1/online<==
> 0
>
> ==>  /sys/devices/system/cpu/cpu0/online<==
> 1
> / # echo -n "350000">  /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> [  165.881927] omap_target: cpu 0 ready to go to 350000 (inits=1 vs online=1)
> [  165.889526] cpufreq-omap: transition: 1008000 -->  0
> / #
> / # echo -n "1">  /sys/devices/system/cpu/cpu1/online
> [  176.469360] CPU1: Booted secondary processor
> [  176.469421] CPU1: Unknown IPI message 0x1
> [  176.475280] Switched to NOHz mode on CPU #1
> [  176.600891] omap_cpu_init: cpu 1 cpus_initialized = 2 online=2
> [  176.620178] omap_cpu_exit: cpu 1 cpus_initialized = 1 online=2
> [  176.626373] omap_target: cpu 0 not ready to go to 350000 (inits=1
> vs online=2)
>
All the logs look normal to me. There is nothing wrong here.

regards
Santosh
