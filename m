From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Sat, 5 Mar 2011 05:52:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A3605E5@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
 <878vwvn0gr.fsf@ti.com> <20110304172832.GZ20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AE@dbde02.ent.ti.com>
 <20110304193746.GG20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605C4@dbde02.ent.ti.com>
 <20110305000156.GI20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38347 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1CEAXE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 19:23:04 -0500
In-Reply-To: <20110305000156.GI20560@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Saturday, March 05, 2011 5:32 AM
> To: DebBarma, Tarun Kanti
> Cc: Hilman, Kevin; linux-omap@vger.kernel.org; Basak, Partha
> Subject: Re: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
> 
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110304 11:50]:
> >
> > In that case we have to associate probably a dev attribute to system
> timer.
> > Do you have alternate proposal?
> 
> No need for that. Keep the system timer code to the minimum so
> it does not have any unnecessary dependencies. That code needs to
> be running early and efficient, while the other timers should
> really be a device driver.
> 
> You can have shared timer read/write functions that don't depend
> on dev. And you can just tag the pysical timer used for system
> timer as reserved.
> 
> Then you can initialize the other timers later on and skip the
> system timer. For the other timers you can have dev oriented
> timer read/write wrapper functions for the other timers.
There is a single timer list created during driver probe.
It can not be done separately for system timer except through
Common build and probe. If we try other way it would get complicated
I believe with the current design because clockevent management code
in timer-gp.c calls common exported APIs.

Now, coming back to our present requirement where we initialize
Only the system timer early and is skipped later, here is the plan:

(1) Have a separate class in hwmod database with unique name "system_timer"
(2) Initialize just this one during early init

> 
> Cheers,
> 
> Tony
