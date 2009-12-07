From: Tony Lindgren <tony@atomide.com>
Subject: Re: What's in omap git tree for 2.6.33
Date: Mon, 7 Dec 2009 09:58:55 -0800
Message-ID: <20091207175855.GB24013@atomide.com>
References: <20091204182604.GC24013@atomide.com>
 <4B1B21ED.30003@blueyonder.co.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C863BE@dbde02.ent.ti.com>
 <4B1CE04F.5000806@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60187 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964858AbZLGR6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 12:58:51 -0500
Content-Disposition: inline
In-Reply-To: <4B1CE04F.5000806@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Sid Boyce <sboyce@blueyonder.co.uk> [091207 02:59]:
> On 06/12/09 03:37, Gadiyar, Anand wrote:
> > Sid Boyce wrote:
> >> Still a few fragments missing on beagleboard - Very roughly:
> >> drivers/usb/Kconfig
> >> +       default y if ARCH_OMAP34X
> > 
> > 
> > This one's in Greg's queue for sure.
> > 
> > <http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/usb/usb-ehci-allow-ehci-to-be-built-on-omap3.patch>
> > 
> > And I did point out the other one. Olaf sent a patch too.
> > We can get that in during the merge window, or right after.
> > 
> > So, wait up for -rc1 to be tagged.
> > 
> > - Anand
> > 
> > 
> 
> That's one bit, but with EHCI an integral part of the beagleboard, there
> shouldn't be a need to hunt around for patches as without this support
> it limits what you can do. OTG with the solder bridge couldn't see any
> of my USB hubs, so I had to rely on the EHCI.

Right. Sounds like we should have omap EHCI working by -rc1 with
these fixes.

Regards,

Tony
