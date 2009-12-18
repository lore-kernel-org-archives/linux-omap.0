From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/10 V5] omap3: pm: introduce support for 3630 OPPs
Date: Fri, 18 Dec 2009 08:04:58 -0800
Message-ID: <87r5qsxo7p.fsf@deeprootsystems.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>
	<1260594031-17268-1-git-send-email-nm@ti.com>
	<87pr6eadx3.fsf@deeprootsystems.com>
	<873a3aa6lt.fsf@deeprootsystems.com> <4B29A401.1050001@ti.com>
	<87tyvp60p6.fsf@deeprootsystems.com> <4B2B58DD.6020901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:64601 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbZLRQFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 11:05:06 -0500
Received: by gxk3 with SMTP id 3so2157029gxk.1
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 08:05:01 -0800 (PST)
In-Reply-To: <4B2B58DD.6020901@ti.com> (Romit Dasgupta's message of "Fri\, 18 Dec 2009 15\:56\:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Romit Dasgupta <romit@ti.com> writes:

>>>> [...]
>>>>
>>>>   
>>>>> To facilitate the ongoing discussions on OPP rework, and to have a
>>>>> common base, this series is available as a branch in my linux-omap-pm
>>>>> repo[1].
>>>>>
> <snip>
>> 
>> Yes, I'm in the process cleaning that up.
>> 
>> Once I get some of that cleanup done, I plan to rebase your OPP V5 and
>> include it in the PM branch.
>
> I tried the latest HEAD on pm-wip-opp. Looks like the cpufreq tables are not
> initialized because are not initializing {mpu|dsp|l3}_opps. 

Good catch.  The patch below should fix that.  I've folded it into
my "OMAP3: PM: remove OPP interfaces from OMAP PM layer" patch at the
tip of pm-wip-opp and pushed a new version of that branch.

> Looks like the comment on the latest commit is to use OPP APIs
> directly. Is there any patch currently on that direction?
> Otherwise in the pm-wip-opp branch cpufreq is broken.

Please try this patch on top of your current code, or pull a new
version of pm-wip-opp which should have this included.

Kevin

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 37f0f0d..86d0304 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1377,6 +1377,10 @@ void __init omap3_pm_init_opp_table(void)
                /* We dont want half configured system at the moment */
                BUG_ON(IS_ERR(omap3_rate_tables[i]));
        }
+
+       mpu_opps = omap3_mpu_rate_table;
+       dsp_opps = omap3_dsp_reate_table;
+       l3_opps = omap3_l3_rate_table;
 }
 
