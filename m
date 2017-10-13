From: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Subject: Re: [Patch 3/6] ARM: OMAP: DRA7xx: Make CAM clock domain SWSUP only
Date: Fri, 13 Oct 2017 12:59:43 -0500
Message-ID: <20171013175942.GH25400@ti.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-4-bparrot@ti.com>
 <20171013170113.GL4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013170113.GL4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote on Fri [2017-Oct-13 10:01:13 -0700]:
> * Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [171012 12:29]:
> > HWSUP on this domain is only working when VIP1 probes.
> > If only VIP2 on DRA74x or CAL on DRA72x probes the domain does
> > not get enabled. This might indicates an issue in the HW Auto
> > state-machine for this domain.
> >
> > Work around is to set the CAM domain to use SWSUP only.
> 
> Hmm this you might get fixed automatically by configuring the
> parent interconnect target module to use "ti,sysc-omap4" and
> adding VIP1 and VIP2 as children to it.
> 
> The reason why I suspect it will fix the issue is because
> with the parent being "ti,sysc-omap4" with "ti,hwmods" being
> in that parent node too, you automatically get PM runtime
> refcounting keep the parent active for either child.
> 
> Maybe give it a try against today's Linux next and see for
> example how it was done for musb:
> 
> https://patchwork.kernel.org/patch/9978783/
> 
> Just use "ti,sysc-omap2" for type1 and "ti,sysc-omap4"
> for type2.

Hmm interesting, I'll give that a try and if it fixes it.

Benoit

> 
> Regards,
> 
> Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
