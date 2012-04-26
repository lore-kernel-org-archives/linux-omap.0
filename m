From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Thu, 26 Apr 2012 16:20:46 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FF794@DBDE01.ent.ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
 <CA+Bv8XYemH3zW48id_ZAvC2gU_uZMFei6dMO1GUog_YTvFBV2Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83E9FE722@DBDE01.ent.ti.com>
 <CA+Bv8XaWkBr7ZDTjmjDg_K+JhEfWdYEt=eKQ5Gj8NMbw4K=Jmg@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83E9FE807@DBDE01.ent.ti.com>
 <CA+Bv8XYDNKWByVEMWniYruH6bcDtOihne5ecoXWJs6fYq418bQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83E9FF456@DBDE01.ent.ti.com>
 <4F997097.7010009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35358 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757811Ab2DZQUy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 12:20:54 -0400
In-Reply-To: <4F997097.7010009@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Russ Dill <russ.dill@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, Ming Lei <tom.leiming@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Apr 26, 2012 at 21:28:15, Hunter, Jon wrote:
> Hi Vaibhav, Russ,
> 
> On 04/26/2012 08:46 AM, Hiremath, Vaibhav wrote:
> > On Thu, Apr 26, 2012 at 13:15:18, Russ Dill wrote:
> >> On Wed, Apr 25, 2012 at 11:23 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >>> On Thu, Apr 26, 2012 at 11:26:09, Russ Dill wrote:
> >>>> On Wed, Apr 25, 2012 at 10:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> >>>>> On Thu, Apr 26, 2012 at 10:06:40, Russ Dill wrote:
> >>>>>> On Tue, Apr 24, 2012 at 2:45 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >>>>>>> Current OMAP code supports couple of clocksource options based
> >>>>>>> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> >>>>>>> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> >>>>>>> So there can be 3 options -
> >>>>>>>
> >>>>>>> 1. 32KHz sync-timer
> >>>>>>> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> >>>>>>> 3. 32KHz based gptimer.
> >>>>>>>
> > <Snip>
> >>>
> >>> You mean to say, on Beagleboard it boots up fine. And same fails on EVM?
> >>
> >>
> >> yes
> >>
> > 
> > I am able to reproduce this issue, and it seems the issue is really weird 
> > and I am completely clueless here.
> > 
> > With below patch/change it always works, 100% success. The moment I add 0x10 
> > offset to the ioremaped virtual base address, gone...95% of the time it 
> > fails.
> > I have observed that, the execution always stays at wfi (default_idle) 
> > thread. Really strange behavior...and I am clueless now.
> > 
> >  - The 32k sync timer address space is part of iotable.
> >  - The ioremap() internally masks the addr to page aligned addr and gets pfn,
> >    At the end, offset is being added. So I don't really understand how is it
> >    different than adding offset before and after ioremap().
> > 
> > 
> > Also, this issue is nothing to do with my patch, it also happens with the 
> > original code.
> > Just add 0x10 offset after ioremap(), and booooooom.... (95% of the time)
> > 
> > 
> > ----------Patch which works (on top of this patch-series)----------
> > 
> > diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> > index 3e3cdab..b0ef8ce 100644
> > --- a/arch/arm/plat-omap/counter_32k.c
> > +++ b/arch/arm/plat-omap/counter_32k.c
> > @@ -90,6 +90,7 @@ int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
> >          * For this to work we must have a static mapping in io.c
> >          * for this area
> >          */
> > +       pbase = pbase + OMAP2_32KSYNCNT_CR_OFF;
> >         base = ioremap(pbase, size);
> 
> What is size set to in the failing case on the am37xx device? Any chance
> we are not mapping enough space?
> 

I do not think it is related to mapping size. I have already explored this 
path.

Thanks,
Vaibhav
