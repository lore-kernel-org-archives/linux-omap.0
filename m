From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Mon, 7 Mar 2011 16:10:02 -0800
Message-ID: <20110308001002.GB26463@atomide.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
 <878vwvn0gr.fsf@ti.com>
 <20110304172832.GZ20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AE@dbde02.ent.ti.com>
 <20110304193746.GG20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605C4@dbde02.ent.ti.com>
 <20110305000156.GI20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20034 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab1CHAKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 19:10:04 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A3605E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110304 16:20]:
> 
> Now, coming back to our present requirement where we initialize
> Only the system timer early and is skipped later, here is the plan:
> 
> (1) Have a separate class in hwmod database with unique name "system_timer"
> (2) Initialize just this one during early init

Let's keep the system timer code completely separate. For the
system timer we really just need to implement one function to
reprogram one timer.

What you've implemented is pretty much done for the rest of
the timers and allows us to turn them into a regular device
driver eventually.

Regards,

Tony
