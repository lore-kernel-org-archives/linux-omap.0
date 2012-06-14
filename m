From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Thu, 14 Jun 2012 05:29:31 -0700
Message-ID: <20120614122930.GM12766@atomide.com>
References: <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:22705 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab2FNM3e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 08:29:34 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 05:00]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 17:22:08, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120614 03:43]:
> > > +       t.clk_activation = fclk_offset_ns;
> > > +
> > 
> > This too should be fclk_offset, not fclk_offset_ns.
> 
> As gpmc_cs_set_timing convert it to ticks from ns,
> shouldn't we put it in ns ? 

Hmm I see, something's wrong though.. Some of these we really
want to specify as ticks instead of ns. Your patch was using
1 tick value as 1 ns value, which won't work. When I changed
it back to what I thought was ticks, it just happened to work
probably because of rounding. That's probably the reason why
some of these have been set directly with gpmc_cs_write_reg
as that sets tick values directly.

It seems that we need to still allow both ns and tick values.

Regards,

Tony
