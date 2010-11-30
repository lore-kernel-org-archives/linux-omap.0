From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2 6/8] usb: ehci-omap: add helpers for checking port
 mode
Date: Tue, 30 Nov 2010 06:49:18 -0800
Message-ID: <20101130144918.GA11007@suse.de>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
 <1291051537-23743-7-git-send-email-gadiyar@ti.com>
 <4CF4ED4E.1080707@ru.mvista.com>
 <4CF50DD4.5080006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56182 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab0K3OuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 09:50:08 -0500
Content-Disposition: inline
In-Reply-To: <4CF50DD4.5080006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tue, Nov 30, 2010 at 08:14:36PM +0530, Anand Gadiyar wrote:
> On 11/30/2010 5:55 PM, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 29-11-2010 20:25, Anand Gadiyar wrote:
> > 
> >> Introduce helper functions to test port mode. These checks are
> >> performed in several places in the driver, and these helpers
> >> improve readability.
> > 
> >> Signed-off-by: Anand Gadiyar<gadiyar@ti.com>
> > [...]
> > 
> >> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> >> index 7a4682c..dd9d5c1 100644
> >> --- a/drivers/usb/host/ehci-omap.c
> >> +++ b/drivers/usb/host/ehci-omap.c
> > [...]
> >> @@ -387,27 +390,27 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
> >>       /* Bypass the TLL module for PHY mode operation */
> >>       if (cpu_is_omap3430()&&  (omap_rev()<= OMAP3430_REV_ES2_1)) {
> >>           dev_dbg(omap->dev, "OMAP3 ES version<= ES2.1\n");
> >> -        if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
> >> -            (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
> >> -                (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
> >> +        if (is_ehci_phy_mode(omap->port_mode[0]) ||
> >> +            is_ehci_phy_mode(omap->port_mode[1]) ||
> >> +                is_ehci_phy_mode(omap->port_mode[2]))
> > 
> >    Why there's another indentation level whenre there shouldn't be one?
> > 
> 
> No particular reason, other than that it was a find-and-replace change.
> I can fix it up if you insist.

No, it's not needed.

thanks,

greg k-h
