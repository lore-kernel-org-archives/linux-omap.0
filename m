From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V2] ARM: AM33XX: Add missing .clkdm_name to
 clkdiv32k_ick clock
Date: Fri, 17 May 2013 10:10:17 -0700
Message-ID: <20130517171016.GV5600@atomide.com>
References: <1364378666-23641-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1303271744510.17356@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EC8BFA7@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19679 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab3EQRKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 13:10:22 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC8BFA7@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [130517 03:36]:
> 
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, March 27, 2013 11:15 PM
> > To: Tony Lindgren; Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > Nayak, Rajendra
> > Subject: Re: [PATCH-V2] ARM: AM33XX: Add missing .clkdm_name to
> > clkdiv32k_ick clock
> > 
> > On Wed, 27 Mar 2013, Vaibhav Hiremath wrote:
> > 
> > > It is required to enable respective clock-domain before
> > > enabling any clock/module inside that clock-domain.
> > >
> > > During common-clock migration, .clkdm_name field got missed
> > > for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> > > unused; so it will be disabled even if childs of this clock-domain
> > > is enabled, which keeps child modules in idle mode.
> > >
> > > This fixes the kernel crash observed on AM335xEVM-SK platform,
> > > where clkdiv32_ick clock is being used as a gpio debounce clock
> > > and since clkdiv32k_ick is in idle mode it leads to below crash -
> > >
> > > Crash Log:
> > > ==========
> > > [    2.598347] Unhandled fault: external abort on non-linefetch
> > (0x1028) at
> > > 0xfa1ac150
> > > [    2.606434] Internal error: : 1028 [#1] SMP ARM
> > > [    2.611207] Modules linked in:
> > > [    2.614449] CPU: 0    Not tainted  (3.8.4-01382-g1f449cd-dirty #4)
> > > [    2.620973] PC is at _set_gpio_debounce+0x60/0x104
> > > [    2.626025] LR is at clk_enable+0x30/0x3c
> > >
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Paul Walmsley <paul@pwsan.com>
> > > Cc: Rajendra Nayak <rnayak@ti.com>
> > 
> > Acked-by: Paul Walmsley <paul@pwsan.com>
> > 
> > Tony, if it isn't too late, could this one be added to your 3.9-rc
> > fixes
> > series?
> > 
> > 
> 
> Looks like we missed this so far.
> 
> Tony, can you merge this patch for v3.10-rc ?

Oops, sorry somehow this did not make it. I'll apply it to omap-for-v3.10/fixes
with cc: stable flag.

Regards,

Tony
