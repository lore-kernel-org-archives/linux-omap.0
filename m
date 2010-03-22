From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Save/Restore (PM) support in DSS2
Date: Mon, 22 Mar 2010 10:43:04 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E53F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59034 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab0CVFNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 01:13:11 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi and others,

As part of our internal release I found that save and restore support doesn't work as expected (I have fixed it for our release and full PM support works fine for me), and below is my analysis/observation and fix for the same - 

Observation - 
-----------

The save and restore of DSS registers happen inside function dss_clk_enable and dss_clk_disable. The save context gets executed as per expectation when actually required, i.e. when clock usage count goes to 0.

The issue is with restore functionality, the restore is blocked by various conditions - 

void dss_clk_enable(enum dss_clock clks)
{
        bool check_ctx = core.num_clks_enabled == 0;

        dss_clk_enable_no_ctx(clks);

        if (check_ctx && cpu_is_omap34xx() && dss_need_ctx_restore())
                restore_all_ctx();
}

The check for clock usage count is mandatory here (which was missing earlier) but I am more concerned about other of two, cpu_is_omap34xx() & dss_need_ctx_restore(). 

Why this is tied only to omap34xx? And 
Frankly I am quite not sure whether I understood use of dss_need_ctx_restore()? What are we trying to do here with function dss_need_ctx_restore()? It internally calls dss_get_ctx_id() which internally calls pdata->get_last_off_on_transaction_id().

Are we providing control to platform file when to restore? If yes, then what could be the trigger for that decision?

Currently none of OMAP board files defines this function, so it is always going to return 0. That means, without this function (and returns true) restore won't happen at all.

If I understand correctly, irrespective of which platform you are running on and whether you are hitting off/idle/retention state or not, you must save and restore states when your module interface clock usage count goes to zero. I may be missing something here.

So the function should be some thing like -


if (check_ctx || dss_need_ctx_restore())
    restore_all_ctx();

Although, I am not quite comfortable with function dss_need_ctx_restore(), so may not required at all.


Thanks,
Vaibhav Hiremath
