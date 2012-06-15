From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Fri, 15 Jun 2012 03:45:43 -0700
Message-ID: <20120615104542.GR12766@atomide.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
 <20120614122930.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999C13@DBDE01.ent.ti.com>
 <20120614165337.GO12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A28B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A2C4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:35401 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2FOKpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 06:45:46 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E99A2C4@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Mohammed, Afzal <afzal@ti.com> [120614 23:20]:
> Hi Tony,
> 
> On Fri, Jun 15, 2012 at 11:12:46, Mohammed, Afzal wrote:
> 
> > But I am unable to find reason for failure upon using
> > gpmc_ticks_to_ns(1), which seems to me right thing to be used.
> > Let me try to invoke tusb6010 functions in beagle board,
> > observe timings so that at least I will get an idea
> > what is going on here (even though it is guaranteed to crash)
> 
> Checked simulating on beagle board, I am at total loss to
> understand why using gpmc_ticks_to_ns(1) has failed for n8x0
> 
> clk_activation timings with both values as follows,
>  
> [1] With t.clk_activation = gpmc_ticks_to_ns(1);
> 
> GPMC CS4: clk_activation:   1 ticks,   6 ns (was   0 ticks)   6 ns
> 
> [2] With t.clk_activation = 1;
> 
> GPMC CS4: clk_activation:   1 ticks,   6 ns (was   0 ticks)   1 ns
> 
> Last field show in ns the time we are trying to set,
> and for both cases, 1 ticks are being programmed in register.

Yes tired it again it is working correctly. I must have messed up
something yesterday when manually patching the clk_activation, maybe
I put the clk_activation value into async timings instead as I was
seeing the tick value set to 0 for the sync mode.

So looks OK to me, n800 tusb6010 and onenand behave as earlier,
also onenand on n900 seems to get detected as earlier.

Regards,

Tony
