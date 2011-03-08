From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 6/8] dmtimer: switch-over to platform device driver
Date: Mon, 7 Mar 2011 16:07:28 -0800
Message-ID: <20110308000727.GA26463@atomide.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
 <1298546811-27055-7-git-send-email-tarun.kanti@ti.com>
 <20110304172320.GY20560@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A3605AB@dbde02.ent.ti.com>
 <20110304193706.GF20560@atomide.com>
 <8580fc0ccffe9e8da3c13fd89ba1c9df@mail.gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A360AD0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19076 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab1CHAHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 19:07:30 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A360AD0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110307 04:52]:
> > 
> > I agree with Tony. We can still registers only the system
> > timer because the timer ID is known well before we do
> > initialization.
> I must say, there was a gap in my understanding of the comment.
> So, here is the implementation change:
> 
> -> Call omap2_dm_timer_early_init(u8 gptimer_id) from omap2_gp_timer_init()
> -> Initialize only gptimer_id inside this function
> -> In the regular init skip initialization of gptimer_id
> 
> As a result of this, we can rid of double registration and related code.

I suggest we keep the system timer completely separate from the
rest of the timers. This way we avoid adding hwmod dependencies
early on when the system timer is initialized, and can still
use hwmod for handling the the rest of the timers nicely.

The rest of the timers can then become just a regular device
driver that ignores the physical system timer.

Regards,

Tony
