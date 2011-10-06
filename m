From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V3 2/4] arm:omap:am33xx: Update common OMAP machine
 specific sources
Date: Thu, 6 Oct 2011 16:03:08 -0700
Message-ID: <20111006230308.GX6324@atomide.com>
References: <hvaibhav@ti.com>
 <1316529142-27564-3-git-send-email-hvaibhav@ti.com>
 <87fwjjcfbt.fsf@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB5930257840691@dbde02.ent.ti.com>
 <87ehyyj6ts.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26843 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759360Ab1JFXDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Oct 2011 19:03:14 -0400
Content-Disposition: inline
In-Reply-To: <87ehyyj6ts.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>

* Kevin Hilman <khilman@ti.com> [110930 09:35]:
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> Actually, looking at this closer, I think the infrastructure is already
> there to handle this cleanly.
> 
> Basically, dpll5 should not even be registered for SoCs where it doesn't
> exist.  Then, any attempts to use DPLL5 would know it doesn't exist
> because the call to clk_get() in omap3_clk_lock_dpll5() would fail.

Yes please use the SoC specific lists, see what we have now queued
up in sram-map-io branch. So using SoC specific map_io + init_early +
set_globals should do the trick.
 
> I think the clock3xxx_data.c needs a bit more cleanup so that only
> clocks that exist for a given SoC are registered.
> 
> Paul already did a similar cleanup for the powerdomain data files by
> creating separate lists for common ones and unique ones.  Looks like we
> need the same for the clock data.

Right.

Regards,

Tony
