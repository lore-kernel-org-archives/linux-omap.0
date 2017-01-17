From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: omap_hwmod: Add support for earlycon
Date: Tue, 17 Jan 2017 10:47:03 +0000
Message-ID: <20170117104703.GA11939@leverpostej>
References: <20170117040336.21700-1-lokeshvutla@ti.com>
 <20170117040336.21700-2-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170117040336.21700-2-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 17, 2017 at 09:33:32AM +0530, Lokesh Vutla wrote:
> Hwmod core tries to reset and idles each IP that is registered with hwmod.
> In case of earlycon, that specific uart IP cannot be reset or keep it in
> idle state else earlycon hangs once hwmod resets that uart IP. So add support
> to not reset uart that is being used as earlycon only if CONFIG_SERIAL_EARLYCON
> is enabled.

> +	np = of_find_node_by_path("/chosen");
> +	if (!np)
> +		np = of_find_node_by_path("/chosen@0");

I think you can drop the second case here. There shouldn't be an "@0" on
a chosen node; core code handles that only to cater for some legacy
(PPC?) DTBs, and I don't beleive it's necessary for OMAP.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
