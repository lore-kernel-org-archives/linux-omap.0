From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: omap_hwmod: Add support for earlycon
Date: Thu, 19 Jan 2017 06:56:50 -0800
Message-ID: <20170119145649.GR7403@atomide.com>
References: <20170117040336.21700-1-lokeshvutla@ti.com>
 <20170117040336.21700-2-lokeshvutla@ti.com>
 <20170117232310.GX7403@atomide.com>
 <88830967-6e83-33fc-8a1c-d776fd694e2f@ti.com>
 <20170118170033.GD7403@atomide.com>
 <61578446-3a10-55ab-dac9-0a95b6e2c77c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <61578446-3a10-55ab-dac9-0a95b6e2c77c-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170119 02:08]:
> 
> 
> On Wednesday 18 January 2017 10:30 PM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170117 19:50]:
> >>
> >>
> >> On Wednesday 18 January 2017 04:53 AM, Tony Lindgren wrote:
> >>> * Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170116 20:06]:
> >>>> Hwmod core tries to reset and idles each IP that is registered with hwmod.
> >>>> In case of earlycon, that specific uart IP cannot be reset or keep it in
> >>>> idle state else earlycon hangs once hwmod resets that uart IP. So add support
> >>>> to not reset uart that is being used as earlycon only if CONFIG_SERIAL_EARLYCON
> >>>> is enabled.
> >>>
> >>> Nice :)
> >>>
> >>> I guess this has no dependency to SERIAL_OMAP vs 8250_OMAP selection?
> >>
> >> Unfortunately SERIAL_OMAP does not support earlycon yet. As I mentioned
> >> in my cover letter, I verified this series only with 8250_OMAP.
> > 
> > OK. So just to understand why it would not work with omap-serial, do we
> > need something implemented in drivers/tty/serial/earlycon.c for non 8250
> > drivers to make it work? Or are there other dependencies?
> 
> Yeah,  OF_EARLYCON_DECLARE should be declared for omap-serial. Just
> posted a patch[1] adding support for earlycon in omap-serial.

OK great. And with Vignesh's fix for omap5, I think we then have 8250-omap
and omap-serial behaving the same way on all SoC variants.

Regards,

Tony

> [1] https://patchwork.kernel.org/patch/9525377/

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
