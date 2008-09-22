From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Mon, 22 Sep 2008 20:51:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C43CA391@dbde02.ent.ti.com>
References: <20080912121024.GG759@gandalf.research.nokia.com>
 <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo>
 <200809121216.27116.david-b@pacbell.net>
 <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo>
 <20080912193534.GH7132@frodo>
 <FCCFB4CDC6E5564B9182F639FC356087022A25316B@dbde02.ent.ti.com>
 <20080922151711.GW24627@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59438 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYIVPVw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Sep 2008 11:21:52 -0400
In-Reply-To: <20080922151711.GW24627@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

> From: linux-omap-owner@vger.kernel.org On Behalf Of Felipe Balbi
> 
> On Mon, Sep 15, 2008 at 12:11:46AM +0530, Vikram Pandita wrote:
> > Better still is to move the PHY issues to platform/board specific function.
> > Will try to submit a patch on that.
> 
> Any updates on this ?? Could you test the patches I sent you ?
> Would be nice to have them applied if they're ok.

I tested the patches for you. I guess you missed my mail. It compiles and runs fine,
but needs an indefinite while loop removed - haven't looked into why it fails there,
but EHCI seems to work without that check.

<http://marc.info/?l=linux-omap&m=122173056311024&w=2>
