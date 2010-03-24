From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Save/Restore (PM) support in DSS2
Date: Wed, 24 Mar 2010 09:55:00 +0200
Message-ID: <1269417300.3032.18.camel@tubuntu.research.nokia.com>
References: <19F8576C6E063C45BE387C64729E7394044DE0E53F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30561 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab0CXHzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 03:55:45 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0E53F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Mon, 2010-03-22 at 06:13 +0100, ext Hiremath, Vaibhav wrote:
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

That's to make to code not to be run on OMAP2 boards. I don't think
there's similar PM on OMAP2s. If there is, the DSS PM code probably
needs some work to support it.

> Frankly I am quite not sure whether I understood use of dss_need_ctx_restore()? What are we trying to do here with function dss_need_ctx_restore()? It internally calls dss_get_ctx_id() which internally calls pdata->get_last_off_on_transaction_id().
> 
> Are we providing control to platform file when to restore? If yes, then what could be the trigger for that decision?
> 
> Currently none of OMAP board files defines this function, so it is always going to return 0. That means, without this function (and returns true) restore won't happen at all.
> 
> If I understand correctly, irrespective of which platform you are running on and whether you are hitting off/idle/retention state or not, you must save and restore states when your module interface clock usage count goes to zero. I may be missing something here.

I think Kevin already answered to all these. So basically you just set
the get_last_off_on_transaction_id to point to the PM's function, and it
will tell if context has been lost. 

 Tomi


