From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
Date: Fri, 10 Aug 2012 09:49:37 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208100946340.11420@utopia.booyaka.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com> <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com> <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com> <alpine.DEB.2.00.1208081411010.6819@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EB34624@DBDE01.ent.ti.com> <B5906170F1614E41A8A28DE3B8D121433EB375A9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41219 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab2HJPti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Aug 2012 11:49:38 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB375A9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello Vaibhav

On Fri, 10 Aug 2012, Bedia, Vaibhav wrote:

> > Ok. I'll try to do some profiling using a timer to see how much time we
> > spend over here. On AM335x there are 2 such lookups, one for the dma
> > and one for the mcbsp. I could get this done today but will get to it
> > tomorrow. Based on how this goes I'll try out the omap_hwmod_class list
> > like you suggested.
> 
> I used a dmtimer clocked at 24MHz (41ns resolution) to get the time
> spent in the lookup. There are two failed lookups that happen in AM335x
> and following are the times taken
> 
> Run1
> Lookup for dma - 435 cycles -> 17.835 usecs
> Lookup for mcbsp - 83 cycles -> 3.4 usecs
> 
> Run2
> Lookup for dma - 503 cycles -> 20.623 usecs
> Lookup for mcbsp - 90 cycles -> 3.69 usescs
> 
> Run3
> Lookup for dma - 375 cycles -> 15.375 usecs
> Lookup for mcbsp - 91 cycles -> 3.731 usecs
> 
> The 2nd lookup happens immediately after the 1st one so probably
> the difference is coming due to the data sitting in the cache?
> 
> The average times don't look too high to me but I guess you already
> knew that ;)
> 
> If you are ok with a pr_debug() instead of a pr_err() I'll resubmit
> the patch with this change.

Well I'd much rather see a patch that maintains a list of hwmods 
pertaining to each class.  That would solve the performance issue at 
fairly minimal cost (especially if those lists were freed after kernel 
init). 

It sounds like the basic difference in opinion is about whether an 
omap_hwmod_for_each_by_class() that doesn't find anything is an error 
condition or not.  My sense is that it is not.


- Paul
