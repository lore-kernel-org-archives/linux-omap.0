From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
Date: Thu, 9 Aug 2012 14:24:15 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB34624@DBDE01.ent.ti.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
 <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
 <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1208081411010.6819@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39570 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030183Ab2HIOYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 10:24:23 -0400
In-Reply-To: <alpine.DEB.2.00.1208081411010.6819@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "paul@pswan.com" <paul@pswan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On Thu, Aug 09, 2012 at 01:49:34, Paul Walmsley wrote:
> Hi Vaibhav
> 
> On Wed, 8 Aug 2012, Bedia, Vaibhav wrote:
> 
> > On Wed, Aug 08, 2012 at 19:35:50, Paul Walmsley wrote:
> >
> > > It doesn't seem to me that this would necessarily always be an error.  
> > > Suppose some init code to create cpsw devices is running on an OMAP3430.  
> > > Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
> > > wouldn't be an error, right?
> > 
> > Well, I think a failed lookup operation will be a bit expensive since it
> > iterates over the whole list of registered hwmods and hence put in the
> > pr_err().
> 
> If performance is a serious problem there, we can maintain a list of hwmod 
> pointers inside each struct omap_hwmod_class, updated when the hwmods are 
> registered.  But as far as I know, performance hasn't been an issue here 
> yet.  If performance is the real motivation, I'd rather see an 
> implementation of per-class lists as described above.
> 

Ok. I'll try to do some profiling using a timer to see how much time we
spend over here. On AM335x there are 2 such lookups, one for the dma
and one for the mcbsp. I could get this done today but will get to it
tomorrow. Based on how this goes I'll try out the omap_hwmod_class list
like you suggested.

> > But I don't see how the SoC specific example that you pointed out
> > could be handled without putting in cpu_is_* checks in the registration
> > process itself :(
> 
> Hmm, why not?
> 
> To continue the earlier example, the init code in the platform code simply 
> calls omap_hwmod_for_each_by_class(), and creates the appropriate device 
> if anything was found.  If no cpsw IP blocks are present on a given SoC, 
> nothing would happen.  No cpu_is_*() would be needed.
> 
> 

I was thinking of avoiding the lookup process itself and hence mentioned
the need for cpu checks surrounding the platform init code. The current
API does help avoid all this in an excellent manner.

Regards,
Vaibhav B. 

