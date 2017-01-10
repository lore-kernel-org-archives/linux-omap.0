From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 08/11] dmaengine: cppi41: Implement the glue for da8xx
Date: Tue, 10 Jan 2017 07:49:29 -0800
Message-ID: <20170110154929.GU2630@atomide.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-9-abailon@baylibre.com>
 <fbc7f9f3-9b14-bc7f-0b40-15a6fedd48ea@ti.com>
 <b3f902e0-ed08-dbee-52b8-e81afda082ac@baylibre.com>
 <53a40635-2652-64fc-b20d-1cd6d813eacb@ti.com>
 <43b9585d-a22f-a2ff-15d4-5d878bd1586a@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43b9585d-a22f-a2ff-15d4-5d878bd1586a-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170110 07:23]:
> On 01/10/2017 11:05 AM, Sekhar Nori wrote:
> > On DA8xx, CPPI 4.1 DMAengine is not an independent system resource, but
> > embedded within the USB 2.0 controller. So, I think all that is needed
> > is for MUSB DA8xx glue to trigger probe of CPPI 4.1 dmaengine driver
> > when it is ready. I am not sure all this DA850-specific clock handling
> > is really necessary.
> Actually, we have a circular dependency.
> USB core tries to get DMA channels during the probe, which fails because
> CPPI 4.1 driver is not ready.
> But it will never be ready because the USB clock must be enabled before
> DMA driver probe, what will not happen because USB driver have disabled
> the clock when probe failed.
> 
> Someone in the office suggested me to use the component API,
> that could help me to probe the DMA from the USB probe.
> 
> Another way to workaround the dependency would be to do defer the
> function calls that access to hardware to avoid to control clock from
> DMA driver.

Or you really have some wrapper IP block around musb and cppi41 just
like am335x has.

See drivers/usb/musb/musb_am335x.c and compatible properties for
"ti,am33xx-usb" and it's children in am33xx.dtsi.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
