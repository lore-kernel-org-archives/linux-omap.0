From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb:
 ehci: fix use of hcd->regs)
Date: Sun, 21 Sep 2008 17:28:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809211726590.16972@utopia.booyaka.com>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo> <20080912193534.GH7132@frodo>
 <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080914185721.GB6943@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02C4348928@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60538 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbYIUX27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Sep 2008 19:28:59 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4348928@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello Anand,

On Thu, 18 Sep 2008, Gadiyar, Anand wrote:

> Ideally the clock framework should be taking care of enabling DPLL5 when 
> the corresponding clocks are enabled, but this does not happen today.

It will do that now; but what it will not do is set DPLL5's rate 
correctly.

> @ Paul,
> 	Would it be possible for you to look at this please?

Yes, will send patches for this soon.


- Paul
