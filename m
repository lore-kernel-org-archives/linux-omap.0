From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Mon, 22 Sep 2008 18:26:44 +0300
Message-ID: <20080922152644.GX24627@gandalf.research.nokia.com>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo> <20080912193534.GH7132@frodo> <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com> <20080922151711.GW24627@gandalf.research.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB02C43CA391@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51640 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYIVP1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 11:27:16 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C43CA391@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Sep 22, 2008 at 08:51:29PM +0530, ext Gadiyar, Anand wrote:
> > From: linux-omap-owner@vger.kernel.org On Behalf Of Felipe Balbi
> > 
> > On Mon, Sep 15, 2008 at 12:11:46AM +0530, Vikram Pandita wrote:
> > > Better still is to move the PHY issues to platform/board specific function.
> > > Will try to submit a patch on that.
> > 
> > Any updates on this ?? Could you test the patches I sent you ?
> > Would be nice to have them applied if they're ok.
> 
> I tested the patches for you. I guess you missed my mail. It compiles and runs fine,
> but needs an indefinite while loop removed - haven't looked into why it fails there,
> but EHCI seems to work without that check.

Hmm.. but that seems to be another issue, right ? Wasn't that
clock-related ??

-- 
balbi
