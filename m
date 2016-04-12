From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in
 of_dev_lookup
Date: Tue, 12 Apr 2016 09:31:57 -0700
Message-ID: <20160412163156.GQ5995@atomide.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com>
 <20160401214053.GQ9329@atomide.com>
 <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com>
 <20160407165842.GJ16484@atomide.com>
 <CAL_Jsq+XrNoqEjCnQ=rLJVdQe9EdHb+MopUtvM2vy12N2veo3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+XrNoqEjCnQ=rLJVdQe9EdHb+MopUtvM2vy12N2veo3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160412 08:57]:
> On Thu, Apr 7, 2016 at 11:58 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160406 21:53]:
> >> On Fri, Apr 1, 2016 at 4:40 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160401 14:37]:
> >> >> We currently try to match of_dev_auxdata based on compatible,
> >> >> IO address, and device name. But in some cases we have multiple
> >> >> instances of drivers that can use the same auxdata.
> >> >>
> >> >> Let's add an additional secondary lookup for generic compatible
> >> >> match for auxdata if no device specific match is found. This does
> >> >> not change the existing matching, and still allows adding device
> >> >> specific auxdata.
> >> >>
> >> >> This simplifies things as specifying the IO address and device
> >> >> name is prone errors as it requires maintaining an in kernel
> >> >> database for each SoC.
> >> >
> >> > And here's what I can apply later on to get rid of some
> >> > ifdeffery.
> >> >
> >> > I'm also planning to move some of the legacy omap hwmod
> >> > functionality into proper device drivers, so can generic
> >> > pdata for that too.
> >>
> >> Why can't the platform data be moved into the driver given that it
> >> appears to be only SoC family specific? Auxdata was somewhat intended
> >> to be temporary. It appears there is already some per compatible match
> >> data for these OMAP parts in the driver.
> >
> > There are just too many dependencies to move legacy code into drivers
> > directly. Especially when moving the omap hwmod code into drivers,
> > we still to use hwmod callbacks at least for clockdomain configuration,
> > wake-up dependencies and clock autogating configuration.
> >
> > When we have Linux generic frameworks available for all this we no longer
> > need the auxdata. But meanwhile, removing the depenencies by using
> > auxdata already allows moving big chunks of the hwmod code into regular
> > device drivers.
> 
> Okay. In that case:
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> Apply it when you have actual users depending on it.

OK thanks will do.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
