From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Enabling MUSB support
Date: Fri, 29 Aug 2008 12:25:06 +0300
Message-ID: <20080829092506.GA7041@gandalf.research.nokia.com>
References: <200808272354.28531.david-b@pacbell.net> <20080828090719.GG7354@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5CAF@dbde02.ent.ti.com> <20080828102842.GK7354@gandalf.research.nokia.com> <20080828112032.GL7354@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403CD61A212@dbde02.ent.ti.com> <20080829074908.GR7354@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C418C358@dbde02.ent.ti.com> <20080829091812.GW7354@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C418C399@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18623 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYH2JZQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 05:25:16 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C418C399@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, ext David Brownell <david-b@pacbell.net>, ext Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 29, 2008 at 02:53:03PM +0530, ext Gadiyar, Anand wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
> > On Fri, Aug 29, 2008 at 02:06:45PM +0530, ext Gadiyar, Anand wrote:
> > > > On Fri, Aug 29, 2008 at 10:11:00AM +0530, ext Gupta, Ajay Kumar wrote:
> > > > > 
> > > > > I tested MUSB controller on OMAP35xx EVM 
> > > > (omap3_evm_defconfig) for g_ether gadget and it works fine 
> > > > with Windows XP. I am using v2.6.26-omap2 tag.
> > > > 
> > > > ehehe, cool. So looks like the problem is either on tusb6010 or in
> > > > g_ether itself.
> > > > 
> > > > I'll bisect since I know 2.6.24-omap1 was working.
> > > > 
> > > > -- 
> > > > balbi
> > > 
> > > Er... I didn't get this.
> > > 
> > > Q1. Why tusb6010?
> > > Q2. Given v2.6.26-omap2 is working, isn't 2.6.24-omap1 older
> > > and by default working?
> > 
> > Hmm... you got it working with v2.6.26... I'll bisect between that and
> > HEAD so.
> > 
> 
> I'm guessing you didn't see my previous mail [1].
> 
> Last known good commit is 509f205d6. That'll save you an iteration at least.
> You can go from there, but there's nothing that's changed in the musb folder.
> Strongly suggest you look in drivers/usb/gadget/*. Lots of changes there.

Thanks.

> And you may not be able to bisect unless you have hardware that's in mainline
> or you take the changes manually each time - the usb/gadget/* stuff came in
> from that way.

When you find a commit that doesn't build, you reset to the previous
buildable commit and try it out, git bisect will notice that and act
accordingly

-- 
balbi
