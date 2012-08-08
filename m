From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix dmtimer set source clock failure
Date: Tue, 7 Aug 2012 23:47:22 -0700
Message-ID: <20120808064722.GB11011@atomide.com>
References: <1342210323-2129-1-git-send-email-jon-hunter@ti.com>
 <87boim36mj.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44758 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2HHGrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 02:47:25 -0400
Content-Disposition: inline
In-Reply-To: <87boim36mj.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [120807 11:21]:
> Jon Hunter <jon-hunter@ti.com> writes:
> 
> > Calling the dmtimer function omap_dm_timer_set_source() fails if following a
> > call to pm_runtime_put() to disable the timer. For example the following
> > sequence would fail to set the parent clock ...
> >
> > 	omap_dm_timer_stop(gptimer);
> > 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_32_KHZ);
> >
> > The following error message would be seen ...
> >
> > omap_dm_timer_set_source: failed to set timer_32k_ck as parent
> >
> > The problem is that, by design, pm_runtime_put() simply decrements the usage
> > count and returns before the timer has actually been disabled. Therefore,
> > setting the parent clock failed because the timer was still active when the
> > trying to set the parent clock. Setting a parent clock will fail if the clock
> > you are setting the parent of has a non-zero usage count. To ensure that this
> > does not fail use pm_runtime_put_sync() when disabling the timer.
> >
> > Note that this will not be seen on OMAP1 devices, because these devices do
> > not use the clock framework for dmtimers.
> >
> > Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks applying into fixes with Cc stable.

Tony
