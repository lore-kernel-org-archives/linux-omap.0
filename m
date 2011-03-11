From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/3] [pm-wip/cpufreq] cpufreq cleanup and SMP support
Date: Fri, 11 Mar 2011 11:24:06 +0530
Message-ID: <b8444ec8f2cca50e27d088fa8e2e687e@mail.gmail.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com> <87mxl2haoo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:55233 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388Ab1CKFyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 00:54:09 -0500
Received: by qwh6 with SMTP id 6so2219604qwh.31
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 21:54:07 -0800 (PST)
In-Reply-To: <87mxl2haoo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Friday, March 11, 2011 3:59 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; vishwanath.bs@ti.com
> Subject: Re: [PATCH 0/3] [pm-wip/cpufreq] cpufreq cleanup and SMP
> support
>
> Hi Santosh,
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > This series is an attempt to clean-up omap cpufreq driver.
> > 	- The OMAP1 and OMAP2PLUS cpufreq support is split to avoid
> > 	  any #ifdefery
> > 	- Alias clock nodes are added in all OMAP2PLUS clock-data
> > 	  to avoid any cpu_is_xxx() checks
> > 	- The omap2plus_cupfreq support is updated to work on
> > 	  SMP_ON_UP builds
> > 	- SMP support is added which can be used on OMAP4
> >
> > Thanks to Vishwanath BS <vishwanath.bs@ti.com> for doing testing
> > with his DVFS series and review.
>
> Thanks for this series.  I was planning on doing this cleanup as
> well, but it's been a busy development cycle for linux-omap. ;)
>
> After fixing the minor comments, please rebase on latest pm-
> wip/cpufreq
> and I'll add it to that branch.  This probably won't make it for
> 2.6.39, but I'll aim for early in the .40 cycle.
>
Sure. Will do.

Regards,
Santosh
