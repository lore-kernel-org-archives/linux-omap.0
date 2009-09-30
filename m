From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Wed, 30 Sep 2009 22:29:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E0@dbde02.ent.ti.com>
References: <1252418056-5994-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9C307DD@dbde02.ent.ti.com>,<alpine.DEB.2.00.0909091022560.8657@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861AF@dbde02.ent.ti.com>,<alpine.DEB.2.00.0909091035120.8657@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C861B1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44230 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970AbZI3Q7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 12:59:42 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309C861B1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

> > > > > >Thanks for the changes, I will queue this in a for-next branch for .33.
> > > > >
> > > > > Is this for .33 or .32?
> > > >
> > > > I think it might be a little late for .32.  If there is some crash or
> > > > instability that this fixes, we could queue it up for .32-fixes ?
> > >
> > > Well, without this, there's no way the child clocks can be enabled correctly.
> > 
> > OK.  So is it the case that USBHOST/USBTLL/USIM won't work without this
> > fix?
> 
> Yup. Not sure about USIM - will check.
> 
> > 
> > If so then we'll queue it for .32-fixes.  Since .32 is already at -rc9, I
> > think it is too late for .32.
> > 
> 
> Would be nice. Thanks!


Paul,

Is this patch already queued up somewhere, or are you waiting for a clarification
from me on the USIM?

(I haven't had a chance to look yet, since this is not in the regular TRM)

- Anand