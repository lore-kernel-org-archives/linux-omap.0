From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] of/platform: Allow secondary compatible match in
 of_dev_lookup
Date: Thu, 7 Apr 2016 09:58:43 -0700
Message-ID: <20160407165842.GJ16484@atomide.com>
References: <1459546504-32668-1-git-send-email-tony@atomide.com>
 <20160401214053.GQ9329@atomide.com>
 <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+PcTD=duHmWgHyx_ywYbT10vEtcm=79x5o5wYSkgG63g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [160406 21:53]:
> On Fri, Apr 1, 2016 at 4:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [160401 14:37]:
> >> We currently try to match of_dev_auxdata based on compatible,
> >> IO address, and device name. But in some cases we have multiple
> >> instances of drivers that can use the same auxdata.
> >>
> >> Let's add an additional secondary lookup for generic compatible
> >> match for auxdata if no device specific match is found. This does
> >> not change the existing matching, and still allows adding device
> >> specific auxdata.
> >>
> >> This simplifies things as specifying the IO address and device
> >> name is prone errors as it requires maintaining an in kernel
> >> database for each SoC.
> >
> > And here's what I can apply later on to get rid of some
> > ifdeffery.
> >
> > I'm also planning to move some of the legacy omap hwmod
> > functionality into proper device drivers, so can generic
> > pdata for that too.
> 
> Why can't the platform data be moved into the driver given that it
> appears to be only SoC family specific? Auxdata was somewhat intended
> to be temporary. It appears there is already some per compatible match
> data for these OMAP parts in the driver.

There are just too many dependencies to move legacy code into drivers
directly. Especially when moving the omap hwmod code into drivers,
we still to use hwmod callbacks at least for clockdomain configuration,
wake-up dependencies and clock autogating configuration.

When we have Linux generic frameworks available for all this we no longer
need the auxdata. But meanwhile, removing the depenencies by using
auxdata already allows moving big chunks of the hwmod code into regular
device drivers.

Regards,

Tony
