From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Tue, 29 Mar 2011 10:52:52 -0700
Message-ID: <20110329175252.GM4016@atomide.com>
References: <20110314171240.GB7258@atomide.com>
 <8762rhtnje.fsf@ti.com>
 <20110319002719.GF18583@atomide.com>
 <b65bf7960033964fba8f03e774b46905@mail.gmail.com>
 <20110321170758.GF2811@atomide.com>
 <87sjuge31n.fsf@ti.com>
 <20110321191114.GH2811@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A7E21D7@dbde02.ent.ti.com>
 <20110325155549.GZ2811@atomide.com>
 <20110329171345.GH4016@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1C2Rw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:52:56 -0400
Content-Disposition: inline
In-Reply-To: <20110329171345.GH4016@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

* Tony Lindgren <tony@atomide.com> [110329 10:11]:
> 
> - You can pick the reserved clockevent and clocksource timers based
>   on the sys_timer_reserved mask and then create proper dev entries
>   for those too later on during the init

Actually you can now just register (but not reset) the struct
omap_dm_timer pointers for clockevent and clocksource directly in
arch/arm/mach-omap2/timer.c, so sys_timer_reserved probably becomes
unnecessary after your patches.

Tony
