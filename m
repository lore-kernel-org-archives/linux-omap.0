From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] [pm-wip/cpufreq] cpufreq cleanup and SMP support
Date: Thu, 10 Mar 2011 14:28:55 -0800
Message-ID: <87mxl2haoo.fsf@ti.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39331 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752327Ab1CJW27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 17:28:59 -0500
Received: by mail-gw0-f52.google.com with SMTP id 15so899794gwj.11
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 14:28:58 -0800 (PST)
In-Reply-To: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 25 Feb 2011 11:40:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, vishwanath.bs@ti.com

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This series is an attempt to clean-up omap cpufreq driver.
> 	- The OMAP1 and OMAP2PLUS cpufreq support is split to avoid
> 	  any #ifdefery
> 	- Alias clock nodes are added in all OMAP2PLUS clock-data
> 	  to avoid any cpu_is_xxx() checks
> 	- The omap2plus_cupfreq support is updated to work on
> 	  SMP_ON_UP builds
> 	- SMP support is added which can be used on OMAP4
>
> Thanks to Vishwanath BS <vishwanath.bs@ti.com> for doing testing with
> his DVFS series and review.

Thanks for this series.  I was planning on doing this cleanup as well,
but it's been a busy development cycle for linux-omap. ;)

After fixing the minor comments, please rebase on latest pm-wip/cpufreq
and I'll add it to that branch.  This probably won't make it for 2.6.39,
but I'll aim for early in the .40 cycle.

Thanks,

Kevin

