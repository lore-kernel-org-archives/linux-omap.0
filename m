From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Thu, 20 Oct 2016 05:35:24 -0700
Message-ID: <20161020123524.oepmqvlhzzu7elgj@atomide.com>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161020082318.GA2903-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161020 01:24]:
> On Wed, Oct 19, 2016 at 12:03:38PM -0500, Bin Liu wrote:
> > Hi Greg,
> > 
> > Here are musb pm fixes for v4.9-rc2.  Please let me know if any change is
> > needed.
> 
> Hi Bin, Tony,
> 
> just moved away from 4.6 where musb worked (well, not quite reliably, but...)
> in host only mode with dma on dm3730. Later kernels do not work at all,
> devices get enumerated, but after a while I get:
> [   23.750061] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   23.757232] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   23.764739] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   23.771850] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   23.778900] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   23.785980] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   23.793151] musb_host_rx 1970: Rx interrupt with no errors or packet!
> [   29.281494] udlfb: wait for urb interrupted: ffffffc2 available: 0
> 
> Last line is printed repeatedly even after I disconnect udlfb device, so
> driver is unnoticed about disconnect.

I don't think I've seen that error..

> Diffing linux-4.7 (not working) against 4.6 didn't show anything suspicious
> and 4.8 adds only some tracepoints over 4.7, so the above is with 4.8.2.
> 
> Any pointers how to best do my homework and find what's wrong?

There are few patches that we seem to need for v4.7 and v4.8 stable.
At least these two fixes that should be merged for v4.9 should be
in:

[PATCH 0/2] Fixes for two more musb regressions

Then two patches for phy-twl4030-usb.c:

b78ea84a7d45 ("phy-twl4030-usb: initialize charging-related stuff via
pm_runtime")
78489c7c48d4 ("phy-twl4030-usb: better handle musb_mailbox() failure")

Are you using the twl4030 phy or something else? Also, care to try
with v4.9-rc + [PATCH 0/2] Fixes for two more musb regressions?

Regards,

Tony

> $ lsusb -t
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ehci-omap/3p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=udlfb, 480M
>         |__ Port 4: Dev 4, If 0, Class=Hub, Driver=hub/4p, 480M
>             |__ Port 4: Dev 5, If 1, Class=CDC Data, Driver=cdc_acm, 12M
>             |__ Port 4: Dev 5, If 0, Class=Communications, Driver=cdc_acm, 12M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ohci-omap3/3p, 12M
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
