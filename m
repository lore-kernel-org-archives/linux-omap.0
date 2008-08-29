From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Enabling MUSB support
Date: Fri, 29 Aug 2008 15:02:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C418C3AF@dbde02.ent.ti.com>
References: <200808272354.28531.david-b@pacbell.net>
 <20080828090719.GG7354@gandalf.research.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com>
 <20080828102842.GK7354@gandalf.research.nokia.com>
 <20080828112032.GL7354@gandalf.research.nokia.com>
 <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com>
 <20080829074908.GR7354@gandalf.research.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C418C358@dbde02.ent.ti.com>
 <20080829091812.GW7354@gandalf.research.nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C418C399@dbde02.ent.ti.com>
 <20080829092506.GA7041@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38579 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbYH2Jct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 05:32:49 -0400
In-Reply-To: <20080829092506.GA7041@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, ext David Brownell <david-b@pacbell.net>, ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>

> > > 
> > > Hmm... you got it working with v2.6.26... I'll bisect between that and
> > > HEAD so.
> > > 
> > 
> > I'm guessing you didn't see my previous mail [1].
> > 
> > Last known good commit is 509f205d6. That'll save you an iteration at least.
> > You can go from there, but there's nothing that's changed in the musb folder.
> > Strongly suggest you look in drivers/usb/gadget/*. Lots of changes there.
> 
> Thanks.
> 
> > And you may not be able to bisect unless you have hardware that's in mainline
> > or you take the changes manually each time - the usb/gadget/* stuff came in
> > from that way.
> 
> When you find a commit that doesn't build, you reset to the previous
> buildable commit and try it out, git bisect will notice that and act
> accordingly
> 

Been there, done that. I tried this. The problem in this case is you
don't have a previous buildable commit other than a few near what I mentioned
above. From that point on till the first bad commit, none of the intermediate
kernels are buildable.

Try it out and you'll see for yourself. I'm just saving you the time by giving
you info on what I've done so far.

All intermediate commits have the omap3 stuff missing. So you'll either need one
patch that can give make you compile and boot on omap3 (bare minimum should do).
Or you need to get the USB patches separately and apply those. Haven't done either
of these. If you can find a better way, let me know.

Thanks in advance,
Anand