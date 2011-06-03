From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary
 CPUs are offline.
Date: Fri, 03 Jun 2011 14:01:34 +0530
Message-ID: <4DE89BE6.40809@ti.com>
References: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com> <87ei3bomn3.fsf@ti.com> <4DE87E78.6000107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38779 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab1FCIbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 04:31:39 -0400
Received: by mail-yw0-f45.google.com with SMTP id 41so804626ywl.32
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 01:31:38 -0700 (PDT)
In-Reply-To: <4DE87E78.6000107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On 6/3/2011 11:56 AM, Santosh Shilimkar wrote:
> On 6/3/2011 4:40 AM, Kevin Hilman wrote:
>> Santosh Shilimkar<santosh.shilimkar@ti.com> writes:
>>
>>> Current OMAP2PLUS CPUfreq tagret() functions returns when all
>>> the CPU's are not online. This will break DVFS when secondary
>>> CPUs are offlined.
>>>
>>> The intention of that check was just avoid CPU frequency change
>>> during the window when CPU becomes online but it's cpufreq_init is
>>> not done yet.
>>>
>>> Fix the check accordingly.
>>>
>>> Thanks for Nishant Menon<nm@ti.com> for reporting it.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Reported-by: Nishanth Menon<nm@ti.com>
>>> Tested-by: Vishwanath BS<vishwanath.bs@ti.com>
>>> ---
>>> There were some question of making the variable atomic etc
>>> in an internal discussion. After some thinking, I realised
>>> there is no need of that since this is just a counter which
>>> maintains the count for online_cpus = cpufreq_init_cpus.
>>
>> Since this is init-time only check, the check for every call to
>> ->target() seems excessive.
>>
>> How about leaving the ->target callback empty until all the CPUs are
>> online.
>>
> Can do that as well.
>
After re-looking at this, seems not straight forward. This check is
not for cpufreqdriver_init time but per-CPU init functions which is
called after the driver is registered to the governor. We don't do 
registration again except the cases where driver is build as a module.

How do we handle that ?

Regards
Santosh
