From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: OMAP2+: omap_hwmod: Add support for earlycon
Date: Wed, 18 Jan 2017 09:17:59 +0530
Message-ID: <88830967-6e83-33fc-8a1c-d776fd694e2f@ti.com>
References: <20170117040336.21700-1-lokeshvutla@ti.com>
 <20170117040336.21700-2-lokeshvutla@ti.com>
 <20170117232310.GX7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117232310.GX7403-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Wednesday 18 January 2017 04:53 AM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [170116 20:06]:
>> Hwmod core tries to reset and idles each IP that is registered with hwmod.
>> In case of earlycon, that specific uart IP cannot be reset or keep it in
>> idle state else earlycon hangs once hwmod resets that uart IP. So add support
>> to not reset uart that is being used as earlycon only if CONFIG_SERIAL_EARLYCON
>> is enabled.
> 
> Nice :)
> 
> I guess this has no dependency to SERIAL_OMAP vs 8250_OMAP selection?

Unfortunately SERIAL_OMAP does not support earlycon yet. As I mentioned
in my cover letter, I verified this series only with 8250_OMAP.

Thanks and regards,
Lokesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
