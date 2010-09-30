From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during
 init
Date: Thu, 30 Sep 2010 10:43:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009301040390.5439@utopia.booyaka.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com> <4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com> <4CA49ADE.6080202@ti.com>,<20100930150713.GG3117@atomide.com>,<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54012 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab0I3QnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 12:43:07 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CCF813F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "wim@iguana.be" <wim@iguana.be>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Hello Charu,

On Thu, 30 Sep 2010, Varadarajan, Charulatha wrote:

> > > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > > index 8e2f0aa..9f44fc6 100644
> > > --- a/arch/arm/mach-omap2/devices.c
> > > +++ b/arch/arm/mach-omap2/devices.c
> > > +
> > > +static void __init omap_disable_wdt(void)
> > > +{
> > > +	if (cpu_class_is_omap2())
> > 
> > This code is already in mach-omap2/devices.c, so that test should be 
> > useless.
> 
> I do not see a cpu_class_is_omap2() check in omap2_init_devices(). Please
> point out where this check is done while/before calling omap_disable_wdt()?

It's implicit, due to the directory arch/arm/mach-omap2/ -- code in that 
directory is only built for OMAP2+ systems -- and right now there are no 
plans for OMAP1+ multi-arch booting.  So it's safe to assume that any code 
in arch/arm/mach-omap2 will only run on OMAP2+ boards.


- Paul
