From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Tue, 8 Mar 2011 05:43:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A360BF7@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
 <878vwvn0gr.fsf@ti.com> <20110304172832.GZ20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AE@dbde02.ent.ti.com>
 <20110304193746.GG20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605C4@dbde02.ent.ti.com>
 <20110305000156.GI20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605E5@dbde02.ent.ti.com>
 <20110308001002.GB26463@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54526 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1CHANf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 19:13:35 -0500
In-Reply-To: <20110308001002.GB26463@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, March 08, 2011 5:40 AM
> To: DebBarma, Tarun Kanti
> Cc: Hilman, Kevin; linux-omap@vger.kernel.org; Basak, Partha
> Subject: Re: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
> 
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110304 16:20]:
> >
> > Now, coming back to our present requirement where we initialize
> > Only the system timer early and is skipped later, here is the plan:
> >
> > (1) Have a separate class in hwmod database with unique name
> "system_timer"
> > (2) Initialize just this one during early init
> 
> Let's keep the system timer code completely separate. For the
> system timer we really just need to implement one function to
> reprogram one timer.
> 
> What you've implemented is pretty much done for the rest of
> the timers and allows us to turn them into a regular device
> driver eventually.
YES. So, this proposal of mine can be ignored now. 

> 
> Regards,
> 
> Tony
