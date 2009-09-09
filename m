From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Wed, 9 Sep 2009 10:47:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0909091035120.8657@utopia.booyaka.com>
References: <1252418056-5994-1-git-send-email-gadiyar@ti.com> <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC35608702F9C307DD@dbde02.ent.ti.com>,<alpine.DEB.2.00.0909091022560.8657@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38101 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbZIIQrm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 12:47:42 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C861AF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, 9 Sep 2009, Gadiyar, Anand wrote:

> On Wed, 9 Sep 2009, Paul Walmsley wrote:
> > On Wed, 9 Sep 2009, Pandita, Vikram wrote:
> > 
> > > >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul
> > > >Walmsley
> > > >> $SUBJECT to reflect the change.
> > > >
> > > >Thanks for the changes, I will queue this in a for-next branch for .33.
> > >
> > > Is this for .33 or .32?
> > 
> > I think it might be a little late for .32.  If there is some crash or
> > instability that this fixes, we could queue it up for .32-fixes ?
> 
> Well, without this, there's no way the child clocks can be enabled correctly.

OK.  So is it the case that USBHOST/USBTLL/USIM won't work without this 
fix?  

If so then we'll queue it for .32-fixes.  Since .32 is already at -rc9, I 
think it is too late for .32.


- Paul
