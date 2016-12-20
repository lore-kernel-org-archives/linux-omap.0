From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Tue, 20 Dec 2016 19:40:46 +0100
Message-ID: <20161220184046.livxczyqrqub653l@lenoch>
References: <20161107215020.31399-1-tony@atomide.com>
 <3814185.kgidRBy8ST@avalon>
 <20161111230602.GA17429@uda0271908>
 <64319829.AAeNM2SzI6@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <64319829.AAeNM2SzI6@avalon>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

On Sat, Nov 12, 2016 at 03:21:24AM +0200, Laurent Pinchart wrote:
> Hi Bin,
> 
> http://pandaboard.org/sites/default/files/board_reference/ES/750-2170-002-sch_revb.pdf
> 
> It would seem that the voltage is provided by the TWL6030. I'm not sure what's 
> turning it on as the MUSB driver doesn't seem to perform any set_vbus call in 
> the faulty configuration (I've traced musb_platform_set_vbus(), 
> omap2430_musb_set_vbus(), otg_set_vbus(), omap_usb_set_vbus() and 
> twl6030_set_vbus() and none of them get called).
> 
> An interesting point to note is that the TWL6030 gets probed after MUSB when 
> MUSB is configured in host mode only, and that happens after the call to 
> musb_start().

just gave 4.9.0 more testing on IGEPv2 board (DM3730 based), schematics here:
https://www.isee.biz/support/downloads/item/igepv2-rc-schematics

musb is configured in host only mode, driver compiled in. ID pin is grounded,
VBUS not connected, D+, D-, and GND are connected to self powered hub.

$ lsusb -t
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ehci-omap/3p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=udlfb, 480M
        |__ Port 4: Dev 4, If 0, Class=Hub, Driver=hub/4p, 480M
            |__ Port 4: Dev 5, If 1, Class=CDC Data, Driver=cdc_acm, 12M
            |__ Port 4: Dev 5, If 0, Class=Communications, Driver=cdc_acm, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ohci-omap3/3p, 12M

1) without following patch I'm getting:
   udlfb: wait for urb interrupted: ffffffc2 available: 0
   however, devices get enumerated

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 847d1c2..f043fb4 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2275,7 +2274,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	 * 500 ms for some margin.
 	 */
 	pm_runtime_use_autosuspend(musb->controller);
-	pm_runtime_set_autosuspend_delay(musb->controller, 500);
+	pm_runtime_set_autosuspend_delay(musb->controller, 100);
 	pm_runtime_enable(musb->controller);
 	pm_runtime_get_sync(musb->controller);

2) With the patch above, everything is working correctly, until I unplug all
   devices from hub. Usb core then tries to suspend port which leads to
   endless flood of:
   musb_bus_suspend 2586: trying to suspend as a_idle while active
   Disabling CONFIG_PM causes usb device enumeration stop working.

3) Few boards were still suffering from:
   musb-hdrc musb-hdrc.0.auto: VBUS_ERROR in a_idle (90, <VBusValid), retry #3, port1 00000104
   but that turned out to be hardware problem as they came to customer with
   OTG connector, tvs diodes and capacitor unpopulated and customer's
   technician soldered C834 with wrong polarity, causing twl's charge
   pump surrending its job after a while.

Anyone has a clue how to fix 2?

Best regards,
	ladis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
