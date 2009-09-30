From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Wed, 30 Sep 2009 11:38:17 -0700
Message-ID: <20090930183817.GP16865@atomide.com>
References: <1252418056-5994-1-git-send-email-gadiyar@ti.com> <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309C861B1@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51885 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbZI3SiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:38:16 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

* Gadiyar, Anand <gadiyar@ti.com> [090930 09:59]:
> > > > > > >Thanks for the changes, I will queue this in a for-next branch for .33.
> > > > > >
> > > > > > Is this for .33 or .32?
> > > > >
> > > > > I think it might be a little late for .32.  If there is some crash or
> > > > > instability that this fixes, we could queue it up for .32-fixes ?
> > > >
> > > > Well, without this, there's no way the child clocks can be enabled correctly.
> > > 
> > > OK.  So is it the case that USBHOST/USBTLL/USIM won't work without this
> > > fix?
> > 
> > Yup. Not sure about USIM - will check.
> > 
> > > 
> > > If so then we'll queue it for .32-fixes.  Since .32 is already at -rc9, I
> > > think it is too late for .32.
> > > 
> > 
> > Would be nice. Thanks!
> 
> 
> Paul,
> 
> Is this patch already queued up somewhere, or are you waiting for a clarification
> from me on the USIM?
> 
> (I haven't had a chance to look yet, since this is not in the regular TRM)

I'll add this to omap-fixes-testing while we're waiting to put his fixes
queue together. This way we can get rid of the remaining nasty stuff in
the ehci branch.

Tony
