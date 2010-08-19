From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 5/6] usb: ohci: don't hard-code TLL channel count
Date: Thu, 19 Aug 2010 11:56:06 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B39A33E9@dbde02.ent.ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-5-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-6-git-send-email-keshava_mgowda@ti.com>
 <20100819060308.GT4385@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100819060308.GT4385-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


 

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org]
> Sent: Thursday, August 19, 2010 11:33 AM
> To: Munegowda, Keshava
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gadiyar, Anand
> Subject: Re: [PATCH 5/6] usb: ohci: don't hard-code TLL channel count
> 
> Hi,
> 
> On Wed, Aug 18, 2010 at 04:55:45AM +0200, ext Keshava Munegowda wrote:
> >@@ -245,7 +245,8 @@ static unsigned ohci_omap3_fslsmode(enum
> > 	}
> > }
> >
> >-static void ohci_omap3_tll_config(struct ohci_hcd_omap3 *omap)
> >+static void ohci_omap3_tll_config(struct ohci_hcd_omap3 *omap,
> >+					u8 tll_channel_count)
> > {
> > 	u32 reg;
> > 	int i;
> >@@ -263,7 +264,7 @@ static void ohci_omap3_tll_config(struct
> > 	 * REVISIT: Only the 3-pin and 4-pin PHY modes have
> > 	 * actually been tested.
> > 	 */
> >-	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
> >+	for (i = 0; i < tll_channel_count; i++) {
> >
> > 		/* Enable only those channels that are actually used */
> > 		if (omap->port_mode[i] == OMAP_OHCI_PORT_MODE_UNUSED)
> >@@ -422,7 +423,7 @@ static int omap3_start_ohci(struct ohci_
> > 	ohci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
> > 	dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
> >
> >-	ohci_omap3_tll_config(omap);
> >+	ohci_omap3_tll_config(omap, OMAP_TLL_CHANNEL_COUNT);
> 
> it's still hardcoded, are you planning to change this in any way ?
> Otherwise I don't see the point for this patch.
> 
> --
> balbi

The function ohci_omap3_tll_config will be used with different tll channel count in case of OMAP4 support soon, hence this change is required.  We have removed only the hardcoded values used by this function.
Keshava Munegowda 


> DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
