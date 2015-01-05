From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 6 Jan 2015 01:16:21 +0200
Message-ID: <20150105231620.GC30544@fuloong-minipc.musicnaut.iki.fi>
References: <54A58E23.5080103@gmx.net>
 <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi>
 <20150102161911.GA3298@atomide.com>
 <54A6E408.1090908@gmx.net>
 <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi>
 <20150102204018.GF3298@atomide.com>
 <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi>
 <20150103000220.GE3279@atomide.com>
 <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi>
 <20150105154313.GA19336@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:35989 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbbAEXQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2015 18:16:30 -0500
Content-Disposition: inline
In-Reply-To: <20150105154313.GA19336@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter =?iso-8859-1?Q?K=FCmmel?= <syntheticpp@gmx.net>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>

Hi,

On Mon, Jan 05, 2015 at 09:43:13AM -0600, Felipe Balbi wrote:
> On Sat, Jan 03, 2015 at 02:16:22PM +0200, Aaro Koskinen wrote:
> > > > > > > >>>When updating (custom DM3730 board) from 3.18.1 ro 3.19-rc2
> > > > > > > >>>I see a "In-band ERROR" warning which wasn't present in 3.18.1.
> > > > > > > >>>Could it be that I missed some DT updates?
> > > > > > > >>
> > > > > > > >>>[    0.366882] In-band Error seen by MPU  at address 0
> > > > > > > >>>[    0.366912] ------------[ cut here ]------------
> > > > > > > >>>[    0.366943] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:166 omap3_l3_app_irq+0x100/0x134()
> > > > > > > >>
> > > > > > > >>This appears also on N900/N950/N9...
> > > > > > > >
> > > > > > > >Do you have CONFIG_PREEMPT enabled? It seems there's some
> > > > > > > >regression related to CONFIG_PREEMPT that started happening
> > > > > > > >with the merge window?
> > > > > > > 
> > > > > > > Indeed, when I disable CONFIG_PREEMPT the warning is gone.
> > > > > > 
> > > > > > Yeah, disabling CONFIG_PREEMPT helps here too. Is there some e-mail
> > > > > > thread / patch set for this already; or should we try to bisect this?
> > > > > 
> > > > > AFAIK I'm not aware of other threads, I noticied it with the
> > > > > "OMAP 4430 SDP: rather sick with recent kernels" thread, but
> > > > > never got anywhere with it.
> > > > > 
> > > > > Yeah it seems it's somewhere between v3.18 and v3.19-rc1, but
> > > > > that too should be verified. Sounds like running git bisect on
> > > > > this one is needed.
> > > > 
> > > > I tried to bisect this on N950, and it resulted in:
> > > > 
> > > > aa25729cfd9709156661bea0f9293deb7729f57a is the first bad commit
> > > > commit aa25729cfd9709156661bea0f9293deb7729f57a
> > > > Author: Tony Lindgren <tony@atomide.com>
> > > > Date:   Wed Nov 5 09:21:23 2014 -0800
> > > > 
> > > >     ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tree
> > > > 
> > > > But when I tried to revert this from 3.19-rc2, my board won't boot at
> > > > all...
> > > 
> > > Hmm OK that commit just fixed the omap_l3_smx so we now see
> > > warnings about the unclocked register access.
> > > 
> > > It seems that probably the CONFIG_PREEMPT issue has been lurking
> > > around for longer but we have not seen any errors because
> > > omap_l3_smx just recently started exposing them.
> > > 
> > > Does v3.18 + commit aa25729cfd9 manually applied also produce
> > > the CONFIG_PREEMPT errors?
> > 
> > Yes it does, so I made another bisection between 3.17 and 3.18
> > using the above patch to trigger the issue, and I got:
> > 
> > 55601c9f24670ba926ebdd4d712ac3b177232330 is the first bad commit
> > commit 55601c9f24670ba926ebdd4d712ac3b177232330
> > Author: Felipe Balbi <balbi@ti.com>
> > Date:   Mon Sep 8 17:54:58 2014 -0700
> > 
> >     arm: omap: intc: switch over to linear irq domain
> 
> Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem.
> Perhaps this is something related to another OMAP3-only driver ? Perhaps
> HSI/SSI ?

I did some debugging and it seems the "In-band Error"
occurs when omap_system_dma_probe() is being run, specifically when
the interrupt is enabled. I believe the "DMA" interrupt it's trying
set up is completely wrong:

 28:          0      GPIO   2  DMA

GPIO 2?! Where is that coming from?

With the commit before the "arm: omap: intc: switch over
to linear irq domain" it seems to be more reasonable:

 28:          0      INTC  12  DMA

A.
