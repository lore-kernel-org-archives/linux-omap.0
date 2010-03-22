From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH RFC 2/5] usb: ohci: introduce omap3 ohci-hcd driver
Date: Mon, 22 Mar 2010 12:23:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FBD5A@dbde02.ent.ti.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <1269171123-9874-3-git-send-email-gadiyar@ti.com>
 <20100321184345.GB3841@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41615 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab0CVGxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 02:53:42 -0400
In-Reply-To: <20100321184345.GB3841@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Sun, Mar 21, 2010 at 05:02:00PM +0530, Anand Gadiyar wrote:
> > This driver has been sitting in internal trees for a long time,
> > for no real reason. I've finally found the time to clean it
> > up and submit it for review.
> 
> Thanks a lot :-)
> 

Thanks for the review :)

I also noticed some whitespace issues in PATCH 1. I'll fix that
before resending.

> > +struct ohci_hcd_omap {
> > +	struct ohci_hcd		*ohci;
> > +	struct device		*dev;
> > +
> > +	struct clk		*usbhost_ick;
> > +	struct clk		*usbhost2_120m_fck;
> > +	struct clk		*usbhost1_48m_fck;
> > +	struct clk		*usbtll_fck;
> > +	struct clk		*usbtll_ick;
> > +
> > +	/* port_mode: TLL/PHY, 2/3/4/6-PIN, DP-DM/DAT-SE0 */
> > +	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
> > +	void __iomem		*uhh_base;
> > +	void __iomem		*tll_base;
> > +	void __iomem		*ohci_base;
> 
> this is something we need to think carefully, right ? I believe ehci is
> already ioremap()ing uhh_base and tll_base ??
> 

Correct. In it's current form, ehci and ohci will be mutually exclusive.
We'll need to fix this later, but I was hoping to get this driver
in so people can actually use it and test.

Nobody can use EHCI and OHCI together on OMAP3 today anyway - the only
problem we'll have right now is that we cannot build-in both drivers in
the kernel at the same time.

I'll work on getting this in place. I was thinking of moving uhh_* and tll_*
configuration out of these two drivers and into mach-omap2/usb-ehci.c.
Along with this, we have the board files specify one set of port-modes for
each port, instead of one set each for EHCI and OHCI. Then, based on this,
we can ioremap and configure the UHH and TLL blocks once during init.

What do you think?

> > +
> > +	 if (omap_rev() <= OMAP3430_REV_ES2_1) {
> 
> can we do this check on the platform code instead and set a flag on the
> platform_data ??
> 
> the driver has to be compilable on other archs so we don't break
> randconfig.
> 

Yes - good point. I'll do this in the next revision.


> > +	.shutdown	= ohci_hcd_omap_shutdown,
> > +	.driver		= {
> > +		.name	= "ohci-omap3",
> > +	},
> 
> no suspend/resume yet ?? :-(
> 

I made this as similar to the current ehci-omap driver as possible.
I wanted to get the functionality in, while I work on adding the
power-management support.

- Anand
