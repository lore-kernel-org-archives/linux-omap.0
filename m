From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/3] musb_hdrc, remove MGC_{Read,Write}Csr{8,16}
Date: Mon, 22 Jan 2007 13:59:52 -0800
Message-ID: <200701221359.52370.david-b@pacbell.net>
References: <200701181535.08332.david-b@pacbell.net>
	<200701191549.13745.david-b@pacbell.net>
	<20070122211953.GF7382@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070122211953.GF7382@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 22 January 2007 1:19 pm, Tony Lindgren wrote:

> OK, BTW looks like I'm not getting any VBUS on N800.
> If I ground ID pin and feed back VBUS from hub to N800, then it
> enumerates. (This is with maemo.org 2.6.18 tree)

Hmm, maybe they didn't populate the caps for the chargepump?
If you ground it, VBUS should come automagically.

Here's a patch that addresses one issue I know about.  But
another couple issues joined recently ... not quit sure what's
up with those yet.

- Dave

==============
Recent usbcore "autosuspend" changes redefined the interface for root hubs
in an incompatible way.  This patch makes CONNECT irqs work again.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- h4.orig/drivers/usb/musb/plat_uds.c	2007-01-19 16:43:36.000000000 -0800
+++ h4/drivers/usb/musb/plat_uds.c	2007-01-19 16:43:31.000000000 -0800
@@ -472,9 +472,11 @@ static irqreturn_t musb_stage0_irq(struc
 	}
 
 	if (bIntrUSB & MGC_M_INTR_CONNECT) {
+		struct usb_hcd *hcd = musb_to_hcd(pThis);
+
 		handled = IRQ_HANDLED;
 		pThis->is_active = 1;
-		set_bit(HCD_FLAG_SAW_IRQ, &musb_to_hcd(pThis)->flags);
+		set_bit(HCD_FLAG_SAW_IRQ, &hcd->flags);
 
 		pThis->bEnd0Stage = MGC_END0_START;
 
@@ -496,7 +498,10 @@ static irqreturn_t musb_stage0_irq(struc
 		if (devctl & MGC_M_DEVCTL_LSDEV)
 			pThis->port1_status |= USB_PORT_STAT_LOW_SPEED;
 
-		usb_hcd_poll_rh_status(musb_to_hcd(pThis));
+		if (hcd->status_urb)
+			usb_hcd_poll_rh_status(hcd);
+		else
+			usb_hcd_resume_root_hub(hcd);
 
 		MUSB_HST_MODE(pThis);
 
