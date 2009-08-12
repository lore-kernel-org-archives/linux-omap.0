From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v2
Date: Wed, 12 Aug 2009 22:11:09 +0300
Message-ID: <20090812191109.GB21001@gandalf>
References: <20090812120926.17601.85860.stgit@localhost>
 <20090812122415.17601.44872.stgit@localhost>
 <20090812122710.GA23166@nokia.com>
 <20090812165258.GM7278@atomide.com>
 <87d471vti5.fsf@deeprootsystems.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59835 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbZHLTLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 15:11:21 -0400
Content-Disposition: inline
In-Reply-To: <87d471vti5.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jason Kridner <jkridner@beagleboard.org>

On Wed, Aug 12, 2009 at 10:20:34AM -0700, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Felipe Balbi <felipe.balbi@nokia.com> [090812 15:29]:
> >> Hi,
> >> 
> >> On Wed, Aug 12, 2009 at 02:24:15PM +0200, ext Tony Lindgren wrote:
> >> > From: Paul Walmsley <paul@pwsan.com>
> >> > 
> >> > Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
> >> > Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard
> >> > rev C2.
> >> > 
> >
> > <snip>
> >
> >> > @@ -981,10 +987,11 @@ CONFIG_RTC_INTF_DEV=y
> >> >  #
> >> >  # Voltage and Current regulators
> >> >  #
> >> > -# CONFIG_REGULATOR is not set
> >> > +CONFIG_REGULATOR=y
> >> >  # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> >> >  # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> >> >  # CONFIG_REGULATOR_BQ24022 is not set
> >> > +CONFIG_REGULATOR_TWL4030=y
> >> >  # CONFIG_UIO is not set
> >> 
> >> musb will still fail here if we don't have twl4030-usb enabled.
> >> 
> >> could you updated the patch to add that as well ??
> >
> > Updated. Maybe take a look and see if the USB options make sense
> > to you? I could not enable OTG for some reason..
> >
> 
> Probably because OTG depends on CONFIG_PM I think.

correct

-- 
balbi
