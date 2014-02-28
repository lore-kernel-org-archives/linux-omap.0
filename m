From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V5 2/4] DRIVERS: IRQCHIP: CROSSBAR: Add support for
 Crossbar IP
Date: Fri, 28 Feb 2014 13:36:30 -0800
Message-ID: <20140228213629.GB13624@atomide.com>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com>
 <1386066445-28245-3-git-send-email-r.sricharan@ti.com>
 <52D7B2CA.8080902@ti.com>
 <52EF7D85.5070705@ti.com>
 <alpine.DEB.2.02.1402041713470.24986@ionos.tec.linutronix.de>
 <52F23887.9060209@ti.com>
 <52F24683.9060200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F24683.9060200-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org> [140205 06:13]:
> Tony,
> 
> On Wednesday 05 February 2014 06:41 PM, Sricharan R wrote:
> > On Tuesday 04 February 2014 09:44 PM, Thomas Gleixner wrote:
> >> On Mon, 3 Feb 2014, Sricharan R wrote:
> >>>> I already have your reviewed-by tag for the first patch in this series.
> >>>>
> >>>> Kevin was pointing out that irqchip maintainer tag is needed for this patch as well
> >>>> to be merged. We are planning to take this series through arm-soc tree.
> >>>>
> >>>> Can i please have your tag for this patch as well ?
> >>
> >> Acked-by-me
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > Thanks Thomas.
> > 
> > Kevin,
> >     I will re-send a branch based on rc1 for this.
> > 
> 
> I have pushed a branch based on mainline,
>    git://github.com/Sricharanti/sricharan.git
>    branch: crossbar_3.14_rc1

OK pulling into omap-for-v3.15/crossbar thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
