From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Fri, 13 Dec 2013 09:10:25 -0800
Message-ID: <20131213171025.GC28184@atomide.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
 <52A9760A.3000801@ti.com>
 <20131212215913.GB29072@muru.com>
 <1933495.zHe4JMYZyB@avalon>
 <52AADEF3.9040808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52AADEF3.9040808-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [131213 02:19]:
> On 2013-12-13 05:27, Laurent Pinchart wrote:
> > Hi Tony,
> > 
> > On Thursday 12 December 2013 21:59:13 Tony Lindgren wrote:
> >> On Thu, Dec 12, 2013 at 10:38:34AM +0200, Tomi Valkeinen wrote:
> >>> On 2013-12-12 01:44, Laurent Pinchart wrote:
> >>>
> >>> So, are they independent? I don't know =). I think they lean on the
> >>> independent side. dss_core is always needed for the submodules to work,
> >>> but for example DSI could be used without DISPC, using system DMA to
> >>> transfer data from memory to DSI. Not a very useful thing to do, but
> >>> still, there are dedicated DMA channels for that.
> >>
> >> If they have separate hwmod entries, they should be considered separate
> >> independent devices for sure.
> >>
> >> To summarize, here are few reasons why they need to be treated as
> >> separate devices:
> > 
> > Are you talking generally here, or about the DSS modules in particular ?
> > 
> >> 1. The modules maybe clocked/powered/idled separately and can have their
> >>    own idle configuration so they can do the hardware based idling
> >>    separately.
> > 
> > I don't think this applies to the DSS modules.
> 
> The DSS submodules have their own SYSCONFIG register, and idle settings
> can be set per module. So I think they idle separately, even if they are
> in a common power domain.

Yes. Please see the current omap_hwmod_*_data.c files, if they are separate
entries there, that means we need to treat them as separate devices to
avoid the issues I listed.

We do have some entries still missing from omap_hwmod_*_data.c files, like
the SSI entries as they are undocumented. But for the existing ones there
please follow the same layout for the .dts entries.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
