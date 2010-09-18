From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Sat, 18 Sep 2010 06:49:30 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402784DCD7B@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-10-git-send-email-manjugk@ti.com>
	<87sk1qtpnu.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A93@dbde02.ent.ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402784DC7D5@dbde02.ent.ti.com>
	<4C9317B5.3050308@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402784DC994@dbde02.ent.ti.com>
	<4C9342FB.30401@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402784DCB8E@dbde02.ent.ti.com>
	<4C938066.2080908@ti.com> <87hbhoz8qw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50372 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab0IRBTi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 21:19:38 -0400
In-Reply-To: <87hbhoz8qw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, September 17, 2010 9:02 PM
> To: Cousson, Benoit
> Cc: G, Manjunath Kondaiah; linux-omap@vger.kernel.org; 
> Shilimkar, Santosh
> Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic 
> errata handling
> 
> "Cousson, Benoit" <b-cousson@ti.com> writes:
> 
> [...]
> 
> >>>>> If you cannot do that, you will need to add an 
> omap_device API as 
> >>>>> well.
> >>>>
> >>>> There is already one such API exists in hwmod layer for handling 
> >>>> this type of errata(omap_hwmod_set_slave_idlemode in 
> omap_hwmod.c).
> >>>> Above proposal is based on similar implementation.
> >>>
> >>> Maybe, but this is not enough. In both case you should not use 
> >>> directly this API from the driver, so if you want to use 
> that kind 
> >>> of approach, you will need the omap_device layer as well.
> >>
> >> Does that mean, extending omap device layer for modifying 
> sysconfig?
> >
> > Yes,
> >
> 
> Just to re-iterate Benoit's point:
> 
> Driver's should not have any knowledge of omap_hwmods.  All 
> the interaction with hwmods is done via the omap_device layer. 
> 
> So, if it is decide that you need a new API for this 
> sysconfig change, you have to add it to *both* the hwmod 
> layer and the omap_device layer.
> 
> As with all the other functions, driver calls omap_device, 
> and omap_device calls omap_hwmod as needed.

Ok. Agreed.

-Manjunath
 