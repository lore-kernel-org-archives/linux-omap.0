From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH][pm-wip/cpufreq] OMAP2+: CPUfreq: Remove superfluous check in target() for online CPU's.
Date: Mon, 06 Jun 2011 16:04:29 -0700
Message-ID: <87r576v9xe.fsf@ti.com>
References: <1307103417-22721-1-git-send-email-santosh.shilimkar@ti.com>
	<BANLkTindbwTeYLt7c25PRO3eDn9E=mg3Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43376 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750722Ab1FFXEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 19:04:32 -0400
Received: by pzk28 with SMTP id 28so2564672pzk.8
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 16:04:31 -0700 (PDT)
In-Reply-To: <BANLkTindbwTeYLt7c25PRO3eDn9E=mg3Dg@mail.gmail.com> (Nishanth
	Menon's message of "Mon, 6 Jun 2011 11:56:52 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Fri, Jun 3, 2011 at 07:16, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Current OMAP2PLUS CPUfreq tagret() functions returns when all
>> the CPU's are not online. This breaks CPUfreq when secondary CPUs
>> are offlined on SMP system.
>>
>> The intention of that check was just avoid CPU frequency change
>> during the window when CPU becomes online but it's cpufreq_init is
>> not done yet. Otherwise it can lead to notifiers being sent on
>> a CPU which is not yet registered to the governor.
>>
>> But this race conditions is already managed by the CPUfreq
>> core driver by updating the available cpumask accordingly.
>>
>> OMAP CPUFReq driver make use same cpumask for the notifiers
>> so the above problem doesn't exist. In my initial implementation
>> of the OMAP4 CPUFreq driver, I was using 'for_each_online_cpu()'
>> for notifiers which lead me to add that check. Later I fixed
>> the notifies but didn't realise that the check has become
>> redundant then.
>>
>> Fix it by removing the superfluous check in target().
>>
>> Thanks for Nishant Menon <nm@ti.com> for reporting issue
>> with hot-plug and Kevin Hilman <khilman@ti.com> for his
>> comment on excessive check in target().
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Tested-by: Nishanth Menon <nm@ti.com>

Thanks, applied to pm-wip/cpufreq

Kevin
