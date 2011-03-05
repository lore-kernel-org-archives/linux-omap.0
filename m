From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Fri, 4 Mar 2011 16:01:56 -0800
Message-ID: <20110305000156.GI20560@atomide.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
 <878vwvn0gr.fsf@ti.com>
 <20110304172832.GZ20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AE@dbde02.ent.ti.com>
 <20110304193746.GG20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605C4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58530 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760072Ab1CEACC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 19:02:02 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A3605C4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110304 11:50]:
>
> In that case we have to associate probably a dev attribute to system timer.
> Do you have alternate proposal?

No need for that. Keep the system timer code to the minimum so
it does not have any unnecessary dependencies. That code needs to
be running early and efficient, while the other timers should
really be a device driver.

You can have shared timer read/write functions that don't depend
on dev. And you can just tag the pysical timer used for system
timer as reserved.

Then you can initialize the other timers later on and skip the
system timer. For the other timers you can have dev oriented
timer read/write wrapper functions for the other timers.

Cheers,

Tony
