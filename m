From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] Introduce SET_NOIRQ_SYSTEM_SLEEP_PM_OPS and use it
Date: Thu, 30 Apr 2015 19:37:35 +0200
Message-ID: <20150430173735.GC23579@amd>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46726 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbD3Rhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2015 13:37:40 -0400
Content-Disposition: inline
In-Reply-To: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>

On Mon 2015-04-27 21:24:29, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
> 
> While working on suspend-to-disk functionality on TI dra7-evm (DRA7xx SoC)
> i've found that the most common problem I have to dial with is absence
> of corresponding PM callbacks in drivers and, in particular, noirq callbacks.
> So, I've fixed one driver first
> commit 6248015d6867 "ARM: omap-device: add missed callback for suspend-to-disk"
> but then found another one which need to be fixed too (omap_l3_noc.c).
> At this moment I decided to make my life easier and added new macro
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS using the same approach as for the existing
> SET_SYSTEM_SLEEP_PM_OPS macro.
> 
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS: defined for CONFIG_PM_SLEEP and
> assigns ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
> function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
> ->restore_noirq.
> 
> Further two patches reuse this newly introduced macro.
> 
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
>     point ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
>     function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
>     ->restore_noirq.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>

Looks ok to me.

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
