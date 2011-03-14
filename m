From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Mon, 14 Mar 2011 12:18:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DDEE1@dbde02.ent.ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
 <20110309220241.GR26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD852@dbde02.ent.ti.com>
 <20110310175611.GV26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD9D2@dbde02.ent.ti.com>
 <20110311191417.GF10079@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59630 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629Ab1CNGsI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Mar 2011 02:48:08 -0400
In-Reply-To: <20110311191417.GF10079@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Saturday, March 12, 2011 12:44 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device
> driver
> 
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110310 21:33]:
> > [...]
> > > > >
> > > > > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> > > > > > switch-over to platform device driver through following changes:
> > > > > > (a) initiate dmtimer early initialization from
> omap2_gp_timer_init()
> > > > > > in timer-gp.c. This is equivalent of timer_init()->timer-
> >init().
> > > > > > (b) modify plat-omap/dmtimer routines to use new register map
> and
> > > > > > platform data.
> > > > >
> > > > > This patch breaks booting for 2420 and makes boot hang early
> > > > > on 2430. Note that to test with omap-for-linus branch you need
> > > > > to disable the following in omap2plus_defconfig:
> > > > >
> > > > > CONFIG_ARCH_OMAP3
> > > > > CONFIG_ARCH_OMAP4
> > > > > CONFIG_CPU_32v6K
> > > > I disabled above options on omap-for-linus *WITHOUT* my patch
> series.
> > > > I am still seeing crash. Here is the log.
> > > > I tried on two different setups. Not sure if I am missing something.
> > >
> > > Hmm sounds like H4 needs some attention. Can you try the following
> > > completely untested patch?
> >
> > This works fine!
> 
> OK thanks, can I add your Tested-by then?
YES.

> 
> Tony
