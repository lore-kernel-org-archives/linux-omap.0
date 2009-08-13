From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v2
Date: Thu, 13 Aug 2009 10:02:33 +0300
Message-ID: <20090813070233.GP7278@atomide.com>
References: <20090812120926.17601.85860.stgit@localhost> <20090812122415.17601.44872.stgit@localhost> <20090812122710.GA23166@nokia.com> <20090812165258.GM7278@atomide.com> <87d471vti5.fsf@deeprootsystems.com> <20090812191109.GB21001@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54164 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbZHMHCt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 03:02:49 -0400
Content-Disposition: inline
In-Reply-To: <20090812191109.GB21001@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <felipe.balbi@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>

* Felipe Balbi <me@felipebalbi.com> [090812 22:11]:
> On Wed, Aug 12, 2009 at 10:20:34AM -0700, Kevin Hilman wrote:
> > Tony Lindgren <tony@atomide.com> writes:
> > 
> > > * Felipe Balbi <felipe.balbi@nokia.com> [090812 15:29]:
> > >> Hi,
> > >> 
> > >> On Wed, Aug 12, 2009 at 02:24:15PM +0200, ext Tony Lindgren wrote:
> > >> > From: Paul Walmsley <paul@pwsan.com>
> > >> > 
> > >> > Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
> > >> > Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard
> > >> > rev C2.
> > >> > 
> > >
> > > <snip>
> > >
> > >> > @@ -981,10 +987,11 @@ CONFIG_RTC_INTF_DEV=y
> > >> >  #
> > >> >  # Voltage and Current regulators
> > >> >  #
> > >> > -# CONFIG_REGULATOR is not set
> > >> > +CONFIG_REGULATOR=y
> > >> >  # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> > >> >  # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> > >> >  # CONFIG_REGULATOR_BQ24022 is not set
> > >> > +CONFIG_REGULATOR_TWL4030=y
> > >> >  # CONFIG_UIO is not set
> > >> 
> > >> musb will still fail here if we don't have twl4030-usb enabled.
> > >> 
> > >> could you updated the patch to add that as well ??
> > >
> > > Updated. Maybe take a look and see if the USB options make sense
> > > to you? I could not enable OTG for some reason..
> > >
> > 
> > Probably because OTG depends on CONFIG_PM I think.
> 
> correct

I don't have a Beagle, so somebody please check this defconfig and enable
PM and OTG if possible.

Tony
