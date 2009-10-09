From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC][PATCH] OMAP3: introduce OMAP3630
Date: Fri, 9 Oct 2009 20:10:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB13DA05@dbde02.ent.ti.com>
References: <[PATCH][RFC] OMAP3630: Create architecture macros and config>
 <1254977223-4236-1-git-send-email-nm@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB13D1EF@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA02389D@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDD75DAE@dbde02.ent.ti.com>
 <4ACDF9E3.4010701@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB13D57B@dbde02.ent.ti.com>
 <4ACF4423.5080307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55030 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933339AbZJIOlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 10:41:37 -0400
In-Reply-To: <4ACF4423.5080307@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Friday, October 09, 2009 7:40 PM
> Cc: Premi, Sanjeev; Pandita, Vikram; linux-omap; Chikkature Rajashekar,
> Madhusudhan; Pais, Allen; Gadiyar, Anand; Cousson, Benoit; Kevin Hilman;
> Aguirre Rodriguez, Sergio Alberto; Tony Lindgren
> Subject: Re: [RFC][PATCH] OMAP3: introduce OMAP3630
> 
> Shilimkar, Santosh had written, on 10/08/2009 11:29 PM, the following:
> >> -----Original Message-----
> >> From: Menon, Nishanth
> >> Sent: Thursday, October 08, 2009 8:11 PM
> >> To: Premi, Sanjeev
> >> Cc: Pandita, Vikram; Shilimkar, Santosh; linux-omap; Chikkature
> Rajashekar,
> >> Madhusudhan; Pais, Allen; Gadiyar, Anand; Cousson, Benoit; Kevin
> Hilman;
> >> Aguirre Rodriguez, Sergio Alberto; Tony Lindgren
> >> Subject: Re: [RFC][PATCH] OMAP3: introduce OMAP3630
> >>
> [...]
> >>>>>> +#define OMAP3630_REV_ES1_0	0x34305034
> >>>>>>
> >>>>>>  #define OMAP443X_CLASS		0x44300034
> >>>>> Was expecting that this patch will add "cpu_is_omap36xx()" in cpu.h
> >>>>> apart from above. Is this handled in another patch ?
> >>>> Idea is to re-use all 34xx code for 36xx, as per the mail
> >>>> thread on list, and given in reference.
> >>>> Hence at run time, the check could be:
> >>>>
> >>>> if (omap_rev() == OMAP3630_REV_ES1_0)
> >>>> 	xxxxx
> >>>>
> >>>> cpu_is_omap34xx() will be true for 36xx as well.
> >>> [sp] This case seems quite similar to the OMAP35x.
> >>>      Can you look at this thread:
> >>>
> >>>      http://marc.info/?l=linux-omap&m=125372581804902&w=2
> >>>
> >>>      It applies equally well here as well...
> >>>      I will be submitting updated patch tomorrow.
> >> yes, any specifics should be  feature based IMHO. we will need to
> extend
> >> the feature list.
> >
> > If we are going to handle the delta 3630 changes w.r.t 3430 with feature
> based approach, its probably is the best thing.
> yes. i guess I can take this as an ACK ;)
> >
> > But in case delat code will be added like below then having a
> cpu_is_omap36xx() makes more sense.
> >>> if (omap_rev() == OMAP3630_REV_ES1_0)
> >>>> 	xxxxx
> > There is no harm having both cpu_is_omap36xx() and cpu_is_omap34xx()
> true for 3630
> what is the need for this? if feature settings can handle the deltas.
> give me specific example where this will be needed. if needed, we can
> add this at a later point.
No need if you follow the feature based approach. 

" But in case delta code will be added like ....... So there was a IF condition :)


Regards,
Santosh
