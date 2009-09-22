From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 5/9] ehci: increase timeout to fix ehci failure
Date: Tue, 22 Sep 2009 18:40:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436C43D6F@dbde02.ent.ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-5-git-send-email-ajay.gupta@ti.com>
 <20090922011009.GJ27699@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50237 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756536AbZIVNKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 09:10:24 -0400
In-Reply-To: <20090922011009.GJ27699@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>

Tony,
> * Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 05:13]:
> > Sometime during TLL reset and waiting loop for TLL reset timeouts and
> thus
> > ehci init fails. Fixing this by increasing timeout value.
> 
> Applying patches 6 - 9 to ehci branch also.

One patch is missing which causes compilation error.
[0002-omap3-Add-CHIP_GE_OMAP3430ES3-for-HSUSB.patch]

Apart from this I have two more EHCI fixes and one patch to fix compilation warning on OMAP3EVM.

I am submitting all four patches , Please review them.

-Ajay
 
> 
> Tony
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/usb/host/ehci-omap.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> > index 55e5259..c7631f5 100644
> > --- a/drivers/usb/host/ehci-omap.c
> > +++ b/drivers/usb/host/ehci-omap.c
> > @@ -244,7 +244,7 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap
> *omap, u8 tll_channel_mask)
> >   */
> >  static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd
> *hcd)
> >  {
> > -	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> >  	unsigned reg = 0;
> >  	int ret = 0;
> >
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

