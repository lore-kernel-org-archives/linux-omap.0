From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: omap_hwmod: Add support for earlycon
Date: Tue, 17 Jan 2017 15:23:10 -0800
Message-ID: <20170117232310.GX7403@atomide.com>
References: <20170117040336.21700-1-lokeshvutla@ti.com>
 <20170117040336.21700-2-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170117040336.21700-2-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170116 20:06]:
> Hwmod core tries to reset and idles each IP that is registered with hwmod.
> In case of earlycon, that specific uart IP cannot be reset or keep it in
> idle state else earlycon hangs once hwmod resets that uart IP. So add support
> to not reset uart that is being used as earlycon only if CONFIG_SERIAL_EARLYCON
> is enabled.

Nice :)

I guess this has no dependency to SERIAL_OMAP vs 8250_OMAP selection?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
