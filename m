From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Save/Restore (PM) support in DSS2
Date: Tue, 23 Mar 2010 18:50:50 +0100
Message-ID: <87tys7apvp.fsf@deeprootsystems.com>
References: <19F8576C6E063C45BE387C64729E7394044DE0E53F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:37495 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab0CWRuz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 13:50:55 -0400
Received: by pxi14 with SMTP id 14so4222170pxi.15
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 10:50:55 -0700 (PDT)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0E53F@dbde02.ent.ti.com> (Vaibhav Hiremath's message of "Mon\, 22 Mar 2010 10\:43\:04 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

> Hi Tomi and others,
>
> As part of our internal release I found that save and restore support doesn't work as expected (I have fixed it for our release and full PM support works fine for me), and below is my analysis/observation and fix for the same - 
>
> Observation - 
> -----------
>
> The save and restore of DSS registers happen inside function dss_clk_enable and dss_clk_disable. The save context gets executed as per expectation when actually required, i.e. when clock usage count goes to 0.
>
> The issue is with restore functionality, the restore is blocked by various conditions - 
>
> void dss_clk_enable(enum dss_clock clks)
> {
>         bool check_ctx = core.num_clks_enabled == 0;
>
>         dss_clk_enable_no_ctx(clks);
>
>         if (check_ctx && cpu_is_omap34xx() && dss_need_ctx_restore())
>                 restore_all_ctx();
> }
>
> The check for clock usage count is mandatory here (which was missing earlier) but I am more concerned about other of two, cpu_is_omap34xx() & dss_need_ctx_restore(). 
>
> Why this is tied only to omap34xx? And 
> Frankly I am quite not sure whether I understood use of dss_need_ctx_restore()? What are we trying to do here with function dss_need_ctx_restore()? It internally calls dss_get_ctx_id() which internally calls pdata->get_last_off_on_transaction_id().
>
> Are we providing control to platform file when to restore? If yes, then what could be the trigger for that decision?
>
> Currently none of OMAP board files defines this function, so it is always going to return 0. That means, without this function (and returns true) restore won't happen at all.
>
> If I understand correctly, irrespective of which platform you are running on and whether you are hitting off/idle/retention state or not, you must save and restore states when your module interface clock usage count goes to zero. I may be missing something here.

You only need restore if the powerdomain has gone to off mode (or
OSWR, which is not yet in l-o.)  For retention or inactive, no context
save/restore is needed.

That pdata pointer was intended to hook up to the OMAP PM layer
funciton of the same name, which uses the has the smarts to determine
if context was actually lost.

Kevin
