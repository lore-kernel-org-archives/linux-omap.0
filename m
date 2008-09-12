From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Sat, 13 Sep 2008 02:36:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC7@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
 <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo>
 <200809121216.27116.david-b@pacbell.net>
 <5A47E75E594F054BAF48C5E4FC4B92AB02C4007EC4@dbde02.ent.ti.com>,<20080912203834.GI7132@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54690 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567AbYILVG5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 17:06:57 -0400
In-Reply-To: <20080912203834.GI7132@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> From: Felipe Balbi [me@felipebalbi.com]
> On Sat, Sep 13, 2008 at 01:31:12AM +0530, Gadiyar, Anand wrote:
> > Was planning on cleaning up this driver and sending to linux-omap as Tony
> > suggested, but I'm afraid I won't be able to look at it for a while.
> >
> > So if you're going to be doing this anyway, then could you please meld in
> > Vikram's other patch from [1] as well?
> 
> Do you think we should just drop support for the older versions of the
> expansion board ?
> 
> > By the way, how do you propose to test this driver? Do you have the
> > expansion board for the SDP, or some other hardware that can be used?
> 
> I have one version of beagle with one ehci port ;-)
> 

There were only two major versions of the board - and I don't think there are
many of either version floating around. I'm not sure how many people have the
earlier one and how many have the later. I don't think you'll need to support the
older board.

You could just keep the later one by folding vikram's patch into this. Anyone who
wants the older board would simply need to reverse-apply the patch.

The beagle should do. I guess you have a Rev A. ISTR there were some issues
with data transfers, but you should be able to get enumeration at least.

- Anand
