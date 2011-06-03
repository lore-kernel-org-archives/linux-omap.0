From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2+: CPUfreq: Allow the CPU scaling when secondary
 CPUs are offline.
Date: Fri, 03 Jun 2011 17:34:57 +0530
Message-ID: <4DE8CDE9.1040604@ti.com>
References: <1307026270-313-1-git-send-email-santosh.shilimkar@ti.com> <BANLkTi=LUMdrTzsOXtVwU_aTcecodaJiPg@mail.gmail.com> <4DE8818D.5030102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39859 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179Ab1FCMFC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 08:05:02 -0400
Received: by mail-gw0-f51.google.com with SMTP id 17so731503gwj.10
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 05:05:01 -0700 (PDT)
In-Reply-To: <4DE8818D.5030102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Nishant,

On 6/3/2011 12:09 PM, Santosh Shilimkar wrote:
> On 6/3/2011 8:14 AM, Menon, Nishanth wrote:
>> On Thu, Jun 2, 2011 at 09:51, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>> Current OMAP2PLUS CPUfreq tagret() functions returns when all
>>> the CPU's are not online. This will break DVFS when secondary
>>> CPUs are offlined.
>>>
>>> The intention of that check was just avoid CPU frequency change
>>> during the window when CPU becomes online but it's cpufreq_init is
>>> not done yet.
>> is it this requirement a boot requirement or a necessity for
>> cpufreq_driver.init being called for online cpus? Since we maintain
>> just a single freq_table... why do we care about multiple cpu_inits?
>>
> I put a comment after ---
> After some thinking, I realised
> there is no need of that since this is just a counter which
> maintains the count for online_cpus = cpufreq_init_cpus.
> And we need inits on all CPUs to ensure the CPU relation is
> set. It's not all about _one_ table.
>
>
>> Anyways, tried testing this and .config with CONFIG_SMP_ON_UP and
>> USERSPACE. it works with one cpu and does not scale 2 cpus :(
>>
> You mean userspace governor? I don't think why that can happen.
> Vishwa tested this and it did worked. We will test this again.
>
Your observation is right. This patch and earlier tested patch
had one difference. We were not decrementing the counter in the
exit path. I assumed that during boot you have hot-plug
governor selected and later you were switching to user-space.
It wasn't the case because I could reproduce same observation
as you. Sorry for that.

I did some debug on this overall issue. Will send an updated patch.

Regards
Santosh

