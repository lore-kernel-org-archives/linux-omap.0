From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 00/10 V5] omap3: pm: introduce support for 3630 OPPs
Date: Fri, 18 Dec 2009 15:56:37 +0530
Message-ID: <4B2B58DD.6020901@ti.com>
References: <[PATCH 02/10 V4] omap3: pm: introduce opp accessor functions>	<1260594031-17268-1-git-send-email-nm@ti.com>	<87pr6eadx3.fsf@deeprootsystems.com>	<873a3aa6lt.fsf@deeprootsystems.com> <4B29A401.1050001@ti.com> <87tyvp60p6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55630 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbZLRK0p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Dec 2009 05:26:45 -0500
In-Reply-To: <87tyvp60p6.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>

>>> [...]
>>>
>>>   
>>>> To facilitate the ongoing discussions on OPP rework, and to have a
>>>> common base, this series is available as a branch in my linux-omap-pm
>>>> repo[1].
>>>>
<snip>
> 
> Yes, I'm in the process cleaning that up.
> 
> Once I get some of that cleanup done, I plan to rebase your OPP V5 and
> include it in the PM branch.
> I tried the latest HEAD on pm-wip-opp. Looks like the cpufreq tables are not
initialized because are not initializing {mpu|dsp|l3}_opps. Looks like the
comment on the latest commit is to use OPP APIs directly. Is there any patch
currently on that direction? Otherwise in the pm-wip-opp branch cpufreq is broken.

Thanks,
-Romit

