From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: cpuidle: fix: call cpu_cluster_pm_exit conditionally
Date: Thu, 29 Aug 2013 10:15:36 -0700
Message-ID: <8761uo2zbb.fsf@linaro.org>
References: <1377598250-2355-1-git-send-email-murzin.v@gmail.com>
	<87sixvw2n5.fsf@linaro.org>
	<902E09E6452B0E43903E4F2D568737AB35C674@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:52721 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab3H2RPk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 13:15:40 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so1187163pad.32
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 10:15:39 -0700 (PDT)
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB35C674@DNCE04.ent.ti.com>
	(Grygorii Strashko's message of "Thu, 29 Aug 2013 15:20:18 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>
Cc: Vladimir Murzin <murzin.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>

+Santosh

"Strashko, Grygorii" <grygorii.strashko@ti.com> writes:

> Hi Vladimir, Kevin
>
> On 08/27/2013 06:54 PM, Kevin Hilman wrote:
>> Vladimir Murzin <murzin.v@gmail.com> writes:
>>
>>> We call cpu_cluster_pm_enter for dev->cpu == 0 only, but
>>> cpu_cluster_pm_exit called without that check.
>>>
>>> Because of that unhandled page fault may happen:
>>>
>
> [...]
>
>>>
>>> It is supposed that sar_base is initialized in irq_save_context, which
>>> is called on CPU_CLUSTER_PM_ENTER notification. If this notification
>>> has been missed and CPU_CLUSTER_PM_EXIT is received sar_base is NULL.
>>>
>>> Fix it by calling CPU_CLUSTER_PM_{ENTER,EXIT} under the same condition.
>
> Could you check, if revert of the following patch will solve the issue, pls?
> commit e7457253494fff660a72bc0cedeee97491ccd173
> "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()"
>
>>>
>>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>>
>> Good catch.
>
> Yes, but It seems, that CPUIdle logic is unclear for OAMP4 .
> The above issue may happen if CPU1 enter/exit LP while CPU0:
> - not enter at all (somewhere inside "coupled" core);
> - still entering LP (somewhere before call to omap4_enter_lowpower());
>
> The question is - Should first CPUx, who exited from LP(C3) state,
> restore Cluster context, or it should be done by CPU0 only?
> (on OMAP4 CPUs may return from C3 async).

Well, they're not *supposed* to return async on OMAP4.  IIUC, only CPU0
wakes up and then it's CPU0s job to wake up CPU1. However, the crash
reported here certainly suggests that CPU1 exiting before CPU0, so
one of the possibilities you suggest above is probably happening (I
suspect the latter.)

It looks like we might still need to check the actual hardware state
there to avoid those potential cases.

Alternatively, another solution might be to use
cpuidle_coupled_parallel_barrier() before the cluster_pm_exit()

Kevin


