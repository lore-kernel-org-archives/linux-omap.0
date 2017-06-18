From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: power: supply: cpcap-battery: Add
 power-supplies property
Date: Sun, 18 Jun 2017 09:04:47 -0500
Message-ID: <20170618140447.b3yrfpjpdl3lzy4r@rob-hp-laptop>
References: <20170612072025.30033-1-tony@atomide.com>
 <20170612142217.tg7gidqg63uagwm4@earth>
 <20170612160400.GY3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170612160400.GY3730-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 12, 2017 at 09:04:00AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170612 07:26]:
> > On Mon, Jun 12, 2017 at 12:20:25AM -0700, Tony Lindgren wrote:
> > > +- power-supplies: List of devices that supply power, typically cpcap_charger
> > 
> > This is missing the info, that its about phandles. Maybe:
> > 
> > - power-supplies: List of phandles for power-supplying devices, as
> >                   described in power_supply.txt. Typically a reference
> >                   to cpcap_charger.
> 
> Sure, updated patch below.
> 
> Regards,
> 
> Tony
> 
> 8< ------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Mon, 12 Jun 2017 00:13:45 -0700
> Subject: [PATCH] dt-bindings: power: supply: cpcap-battery: Add
>  power-supplies property
> 
> The binding for cpcap-battery is missing the standard power-supplies
> property as noted by Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/supply/cpcap-battery.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
