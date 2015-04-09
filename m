From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Thu, 9 Apr 2015 12:12:07 -0700
Message-ID: <20150409191206.GU18048@atomide.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
 <20150409151846.GR18048@atomide.com>
 <5526C9E5.4070601@ti.com>
 <20150409190126.GT18048@atomide.com>
 <5526CD6A.8010300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5526CD6A.8010300-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150409 12:07]:
> On 04/09/2015 10:01 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150409 11:55]:
> >> On 04/09/2015 06:18 PM, Tony Lindgren wrote:
> >>> * Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [150409 02:37]:
> >>>> The sDMA requests are routed through the DMA crossbar and without the
> >>>> crossbar only peripherals using DMA request 0-127 can be used.
> >>>
> >>> I assume this can be merged separately from the driver
> >>> changes?
> >>
> >> Unfortunately not. We need to have the drivers in place for the DTS changes to
> >> work.
> > 
> > Right but just merging the driver changes presumably won't
> > break things?
> 
> No, they will not break anything. We just do not have control over the DMA
> crossbar (in a same way as we don't have control right now).

OK good to hear.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
