From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
Date: Fri, 10 Aug 2012 15:21:57 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB375A9@DBDE01.ent.ti.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
 <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1208081411010.6819@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EB34624@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33967 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758656Ab2HJPWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Aug 2012 11:22:07 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB34624@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "paul@pswan.com" <paul@pswan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

[...]

> > > On Wed, Aug 08, 2012 at 19:35:50, Paul Walmsley wrote:
> > >
> > > > It doesn't seem to me that this would necessarily always be an error.  
> > > > Suppose some init code to create cpsw devices is running on an OMAP3430.  
> > > > Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
> > > > wouldn't be an error, right?
> > > 
> > > Well, I think a failed lookup operation will be a bit expensive since it
> > > iterates over the whole list of registered hwmods and hence put in the
> > > pr_err().
> > 
> > If performance is a serious problem there, we can maintain a list of hwmod 
> > pointers inside each struct omap_hwmod_class, updated when the hwmods are 
> > registered.  But as far as I know, performance hasn't been an issue here 
> > yet.  If performance is the real motivation, I'd rather see an 
> > implementation of per-class lists as described above.
> > 
> 
> Ok. I'll try to do some profiling using a timer to see how much time we
> spend over here. On AM335x there are 2 such lookups, one for the dma
> and one for the mcbsp. I could get this done today but will get to it
> tomorrow. Based on how this goes I'll try out the omap_hwmod_class list
> like you suggested.
> 

I used a dmtimer clocked at 24MHz (41ns resolution) to get the time
spent in the lookup. There are two failed lookups that happen in AM335x
and following are the times taken

Run1
Lookup for dma - 435 cycles -> 17.835 usecs
Lookup for mcbsp - 83 cycles -> 3.4 usecs

Run2
Lookup for dma - 503 cycles -> 20.623 usecs
Lookup for mcbsp - 90 cycles -> 3.69 usescs

Run3
Lookup for dma - 375 cycles -> 15.375 usecs
Lookup for mcbsp - 91 cycles -> 3.731 usecs

The 2nd lookup happens immediately after the 1st one so probably
the difference is coming due to the data sitting in the cache?

The average times don't look too high to me but I guess you already
knew that ;)

If you are ok with a pr_debug() instead of a pr_err() I'll resubmit
the patch with this change.

Regards,
Vaibhav B.
