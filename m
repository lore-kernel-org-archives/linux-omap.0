From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 7/8] OMAP: dmtimer: pm_runtime support
Date: Sat, 5 Mar 2011 01:22:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A3605C4@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-8-git-send-email-tarun.kanti@ti.com>
 <878vwvn0gr.fsf@ti.com> <20110304172832.GZ20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AE@dbde02.ent.ti.com>
 <20110304193746.GG20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1CDTw0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 14:52:26 -0500
In-Reply-To: <20110304193746.GG20560@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

Tony, Kevin,
[...]
> > >
> > > * Kevin Hilman <khilman@ti.com> [110303 17:22]:
> > > > Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> > > >
> > > > > Add pm_runtime support to dmtimer. Since dmtimer is used during
> > > > > early boot before pm_runtime is initialized completely there are
> > > > > provisions to enable/disable clocks directly in the code during
> > > > > early boot.
> > > >
> > > > I'm still not crazy about the duplicate logic (both early & normal)
> in
> > > > all the enable/disable functions.
> > > >
> > > > As I've suggested in the past, why not just do a clk_get, clk_enable
> in
> > > > when the early timers are initialized, then do a clk_disable,
> clk_put()
> > > > as soon as the "normal" device is ready and PM runtime is enabled.
> > >
> > > Even better would be to have separate handling for the system timer
> > > with minimal dependencies to anything.
> > >
> > > > That will greatly simplify the code and eliminate the unnecessary
> checks
> > > > for ->is_early_device which will always be false except for in early
> > > > boot (when these functions are not likely to be called anyways.)
> > >
> > > And please note that only the system timer needs to be initialized
> early.
> > > We might as well treat the system timer separately to avoid these
> issues.
> > >
> > Yes, this is applicable normally for the system timer only.
> > But as I said earlier, we are giving flexibility whereby any one of the
> GPTs
> > Can be system timer.
> 
> Any one of them can be used, but no need to register the others this
> early.
In that case we have to associate probably a dev attribute to system timer.
Do you have alternate proposal?

> 
> Tony
