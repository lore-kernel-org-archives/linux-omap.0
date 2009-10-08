From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [RFC][PATCH] OMAP3: introduce OMAP3630
Date: Thu, 8 Oct 2009 11:08:37 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A6FC7FC@dlee02.ent.ti.com>
References: <[PATCH][RFC] OMAP3630: Create architecture macros and config>
 <1254977223-4236-1-git-send-email-nm@ti.com>
 <A24693684029E5489D1D202277BE89444CBE44DF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502AbZJHQJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 12:09:24 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444CBE44DF@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: Aguirre Rodriguez, Sergio Alberto
> Sent: Thursday, October 08, 2009 9:31 AM
> To: Menon, Nishanth; linux-omap
> Cc: Chikkature Rajashekar, Madhusudhan; Pandita, Vikram; Pais, Allen;
> Gadiyar, Anand; Cousson, Benoit; Kevin Hilman; Premi, Sanjeev; Shilimkar,
> Santosh; Tony Lindgren
> Subject: RE: [RFC][PATCH] OMAP3: introduce OMAP3630
> 
> Nishanth,
> 
> > -----Original Message-----
> > From: Menon, Nishanth
> > Sent: Wednesday, October 07, 2009 11:47 PM
> > To: linux-omap
> > Cc: Menon, Nishanth; Chikkature Rajashekar, Madhusudhan;
> > Pandita, Vikram; Pais, Allen; Gadiyar, Anand; Cousson,
> > Benoit; Kevin Hilman; Premi, Sanjeev; Shilimkar, Santosh;
> > Aguirre Rodriguez, Sergio Alberto; Tony Lindgren
> > Subject: [RFC][PATCH] OMAP3: introduce OMAP3630
> >
> > Device intro:
> > OMAP3630 is the latest in the family of OMAP3 devices
> > and among the changes it introduces are:
> >
> > New OPP levels for new voltage and frequency levels. a bunch of
> > Bug fixes to various modules feature additions, notably with ISP,
> > sDMA etc.
> >
> > Details about the chip is available here:
> > http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?t
> > emplateId=6123&navigationId=12836&contentId=52606
> >
> > Strategy used:
> > Strategy to introduce this device into Linux was discussed here:
> > Ref: http://marc.info/?t=125343303400003&r=1&w=2
> >
> > Two approaches were available:
> > a) Consider 3630 generation of devices as a new family of silicon
> > b) Consider 3630 as an offshoot of 3430 family of devices
> >
> > As a common consensus, (b) seems to be more valid for 3630 as:
> > * There are changes which are easily handled by looking at rev
> > * Most of existing 34xx infrastructure can be reused(almost 90%+)
> > 	- so no ugly if (cpu_is_omap34xx() || cpu_is_omap36xx())
> > 	  all over the place
> 
> And how about cpu_is_omap3() ?
> 
> That would be valid across 34xx (zoom2, n900), 35xx (beagle, pandora), and
> 36xx (zoom3).
> 
> IMO, returning positive in a 3630/3530 to cpu_is_omap34xx() could make the
> code
> quite unreadable.
> 
> 1. If you need to do something 34xx specific, then use cpu_is_34xx()
> 2. If your code is valid for all 34xx, 35xx, 36xx, then why not using
> cpu_is_omap3() ?
> 
> What do you think?

Not at this stage, lets bring in rename over time once 35xx changes from Sanjeev are also in.. 

> 
> > 	- lesser chance of bugs due to reuse of proven code flow
> > 	- 36xx specific handling can still be done where required
> > 	  within the existing infrastructure
> >
> > NOTE:
> > * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
> >   added on top of the existing 3630 ones are renumbered
> >
> > This patch was tested on SDP3430.
> 
> Maybe this should say:
> 
> This patch didn't broke SDP3430.
> 
No. it means what it says -> I tested this patch and booted the l-o kernel on SDP3430==> OMAP3430 is fine.

Regards,
Nishanth Menon

