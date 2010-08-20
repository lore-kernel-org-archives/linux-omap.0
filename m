From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/5] usb: ehci: relocate PHY reset code
Date: Fri, 20 Aug 2010 15:11:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324305BA2@dbde02.ent.ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
 <20100819060126.GS4385@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100819060126.GS4385-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> On Wed, Aug 18, 2010 at 04:55:43AM +0200, ext Keshava Munegowda wrote:
> >The PHY reset code is moved at the begining and end of the function
> >omap_start_ehc. This simplfies the writing clocks enabling code for
> >OMAP4 later.
> >
> >Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> >---
> > drivers/usb/host/ehci-omap.c |   52 +++++++++++++++++++++----------------------
> > 1 file changed, 26 insertions(+), 26 deletions(-)
> >
> >Index: linux-2.6/drivers/usb/host/ehci-omap.c
> >===================================================================
> >--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
> >+++ linux-2.6/drivers/usb/host/ehci-omap.c
> >@@ -279,6 +279,24 @@ static int omap_start_ehc(struct ehci_hc
> >
> > 	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
> >
> >+	if (omap->phy_reset) {
> >+		/* Refer: ISSUE1 */
> >+		if (gpio_is_valid(omap->reset_gpio_port[0])) {
> >+			gpio_request(omap->reset_gpio_port[0],
> >+						"USB1 PHY reset");
> >+			gpio_direction_output(omap->reset_gpio_port[0], 0);
> >+		}
> >+
> >+		if (gpio_is_valid(omap->reset_gpio_port[1])) {
> >+			gpio_request(omap->reset_gpio_port[1],
> >+						"USB2 PHY reset");
> >+			gpio_direction_output(omap->reset_gpio_port[1], 0);
> >+		}
> >+
> >+		/* Hold the PHY in RESET for enough time till DIR is high */
> >+		udelay(10);
> >+	}
> 
> there was another patch doing this with ulpi messages and that's more 
> portable as every board will have support for softreset but we can't 
> guarantee all of them will have these gpio routed correctly, right ?

This is just reorganizing existing code - these are for OMAP3 boards, all
of which have been designed with a GPIO to hold the transceiver in reset
until the OMAP is configured for them.

At the point of time at which this code executes, the ULPI link is not up,
and we cannot use ulpi messages to reset the transceivers.


- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
