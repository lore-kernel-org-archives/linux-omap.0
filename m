From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Fri, 4 Mar 2011 09:28:32 -0800
Message-ID: <20110304172832.GZ20560@atomide.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
 <878vwvn0gr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42016 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665Ab1CDR2q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 12:28:46 -0500
Content-Disposition: inline
In-Reply-To: <878vwvn0gr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>

* Kevin Hilman <khilman@ti.com> [110303 17:22]:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Add pm_runtime support to dmtimer. Since dmtimer is used during
> > early boot before pm_runtime is initialized completely there are
> > provisions to enable/disable clocks directly in the code during
> > early boot.
> 
> I'm still not crazy about the duplicate logic (both early & normal) in
> all the enable/disable functions.
> 
> As I've suggested in the past, why not just do a clk_get, clk_enable in
> when the early timers are initialized, then do a clk_disable, clk_put()
> as soon as the "normal" device is ready and PM runtime is enabled.

Even better would be to have separate handling for the system timer
with minimal dependencies to anything.

> That will greatly simplify the code and eliminate the unnecessary checks
> for ->is_early_device which will always be false except for in early
> boot (when these functions are not likely to be called anyways.)

And please note that only the system timer needs to be initialized early.
We might as well treat the system timer separately to avoid these issues.

Regards,

Tony
