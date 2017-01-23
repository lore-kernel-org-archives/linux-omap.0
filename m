From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4] mfd: cpcap: Add minimal support
Date: Mon, 23 Jan 2017 08:30:59 -0800
Message-ID: <20170123163059.GS7403@atomide.com>
References: <20170106004439.12249-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170106004439.12249-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170105 16:45]:
> Many Motorola phones like droid 4 are using a custom PMIC called CPCAP
> or 6556002. We can support it's core features quite easily with regmap_spi
> and regmap_irq.
> 
> The children of cpcap, such as regulators, ADC and USB, can be just regular
> device drivers and defined in the dts file. They get probed as we call
> of_platform_populate() at the end of our probe, and then the children
> can just call dev_get_regmap(dev.parent, NULL) to get the regmap.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes from v2:
> 
> - Fix typos in binding documentation for #size-cells and spi-cs-high
> - Add ack from Rob
> 
> Changes from v3:
> 
> - Fix comments from Lee, mostly to simplify cpcap_init_irq_chip()

Lee, it's been few weeks now, do you have any more comments on
this one?

I'd like to get this out of the way for v4.11 to be able to start
sending the CPCAP regulator and USB PHY driver patches for v4.12 :)

Cheers,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
