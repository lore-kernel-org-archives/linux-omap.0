From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
Date: Tue, 12 Oct 2010 00:22:09 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010120016130.16871@utopia.booyaka.com>
References: <1285059116-26366-1-git-send-email-tarun.kanti@ti.com> <4CA4FC22.9030806@ti.com> <alpine.DEB.2.00.1010011623020.22941@utopia.booyaka.com> <4CA98739.9040309@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E840680@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB035E970C49@dbde02.ent.ti.com> <alpine.DEB.2.00.1010110811400.16871@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E970E76@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60351 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab0JLGWL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 02:22:11 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035E970E76@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>

Hello Tarun

On Tue, 12 Oct 2010, DebBarma, Tarun Kanti wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Monday, October 11, 2010 7:49 PM
> > To: DebBarma, Tarun Kanti
> > Cc: Cousson, Benoit; Hilman, Kevin; linux-omap@vger.kernel.org; Gopinath,
> > Thara; Basak, Partha; Tony Lindgren
> > Subject: RE: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
> > 
> > On Mon, 11 Oct 2010, DebBarma, Tarun Kanti wrote:
> > 
> > > In the present implementation there is inconsistency in the clock source
> > > names for the different platforms, viz. OMAP2, OMAP3 and OMAP4 as shown
> > > below. Therefore, I will have to modify the names so that they all have
> > > common name across the platforms for the same type of clock. In this
> > > regard I am proposing to modify the clock source names similar to OMAP4.
> > > Of course we also have to look around to see if there are other modules
> > > who are using the clock and make the necessary changes.
> > 
> > Please look again at the links that I sent you.  All you need to change
> > are the clkdev alias names for those clocks for that particular platform
> > device name, "timer" or whatever it will be called.  That won't affect any
> > other modules, since they will have different platform device names.  The
> > struct clk.name fields will stay the same.
> I have already made the change to device names shown below. However, we are talking about other clock sources to devices. On OMAP4 here is are the clock sources:
> CLK(NULL,       "sys_32k_ck",                   &sys_32k_ck,    CK_443X),
> CLK(NULL,       "sys_clkin_ck",                 &sys_clkin_ck,  CK_443X),
> CLK(NULL,       "syc_clk_div_ck",               &syc_clk_div_ck,        CK_443X),
> 
>         CLK("omap-timer.1",     "fck",          &timer1_fck,    CK_443X),
>         CLK("omap-timer.10",    "fck",          &timer10_fck,   CK_443X),
>         CLK("omap-timer.11",    "fck",          &timer11_fck,   CK_443X),
>         CLK("omap-timer.2",     "fck",          &timer2_fck,    CK_443X),
>         CLK("omap-timer.3",     "fck",          &timer3_fck,    CK_443X),
>         CLK("omap-timer.4",     "fck",          &timer4_fck,    CK_443X),
>         CLK("omap-timer.5",     "fck",          &timer5_fck,    CK_443X),
>         CLK("omap-timer.6",     "fck",          &timer6_fck,    CK_443X),
>         CLK("omap-timer.7",     "fck",          &timer7_fck,    CK_443X),
>         CLK("omap-timer.8",     "fck",          &timer8_fck,    CK_443X),
>         CLK("omap-timer.9",     "fck",          &timer9_fck,    CK_443X),
> 
> Let me know if I am misunderstanding your point!

What I am attempting to express is that you can define aliases for the 
parent clocks specifically for the omap-timer instances, if you need to.  
So for example you can add:

CLK("omap-timer.1",       "counter_32k",         &sys_32k_ck,     CK_443X),
CLK("omap-timer.2",       "counter_32k",         &sys_32k_ck,     CK_443X),
CLK("omap-timer.3",       "counter_32k",         &sys_32k_ck,     CK_443X),
...

and then similarly in the OMAP3 clock tree something like

CLK("omap-timer.1",  "counter_32k", &omap_32k_fck,     CK_3XXX),
CLK("omap-timer.2",  "counter_32k", &omap_32k_fck,     CK_3XXX),
CLK("omap-timer.3",  "counter_32k", &omap_32k_fck,     CK_3XXX),

and something similar in the OMAP2420/2430 clock trees.

Then in your omap-timer code, you can completely get rid of all but one 
table of parent clock names.

Please let me know if this still does not make sense,


- Paul
