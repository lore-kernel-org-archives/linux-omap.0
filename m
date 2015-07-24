From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/7] serial: 8250_omap: workaround for IP errata
Date: Fri, 24 Jul 2015 05:01:08 -0700
Message-ID: <20150724120108.GI16878@atomide.com>
References: <cover.1436855646.git.nsekhar@ti.com>
 <55A4FEEC.3080101@hurleysoftware.com>
 <20150714124908.GE10928@atomide.com>
 <55B1DE10.60408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B1DE10.60408-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, John Ogness <john.ogness-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [150723 23:44]:
> Hi Greg,
> 
> On Tuesday 14 July 2015 06:19 PM, Tony Lindgren wrote:
> > * Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> [150714 05:24]:
> >> On 07/14/2015 04:02 AM, Sekhar Nori wrote:
> >>> This series works around "Advisory 21" as documented in
> >>> AM437x SoC errata[1]. This errata prevents UART module
> >>> from idling after DMA is used. AM335x and DRA7x also suffer
> >>> from the same errata and chip design team is in the process
> >>> of updating the errata documents of those devices as well.
> >>>
> >>> Patch 1/7 fixes a related bug but can be applied independently.
> >>
> >> Looks good. Thanks Sekhar!
> >>
> >> For series,
> >>
> >> Reviewed-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
> > 
> > Also things still work for me, and the dts changes should
> > not cause merge conflicts during v4.3 merge window based on
> > what I have queued. So please feel free to queue these
> > all via the tty tree and add:
> > 
> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> 
> 
> Looks like you have queued the first 6 patches of this series but left
> out 7/7 which is a DTS update. Based on above, Tony is okay with you
> going ahead and queuing that DTS patch too. Can you please go ahead and
> queue 7/7 as well?

OK seems it won't cause merge conflicts so I've acked it.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
