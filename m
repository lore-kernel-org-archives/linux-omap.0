From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/RFT] ARM: dts: add minimal DT support for Nokia N950 & N9
Date: Wed, 29 May 2013 17:08:42 -0700
Message-ID: <20130530000841.GQ13507@atomide.com>
References: <1369251845-29605-1-git-send-email-aaro.koskinen@iki.fi>
 <519DC39C.6010809@ti.com>
 <20130529205648.GC3345@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60543 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966530Ab3E3AIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 May 2013 20:08:46 -0400
Content-Disposition: inline
In-Reply-To: <20130529205648.GC3345@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sakari Ailus <sakari.ailus@iki.fi>

* Aaro Koskinen <aaro.koskinen@iki.fi> [130529 14:02]:
> Hi,
> 
> On Thu, May 23, 2013 at 09:22:04AM +0200, Benoit Cousson wrote:
> > On 05/22/2013 09:44 PM, Aaro Koskinen wrote:
> > > Add minimal DT support for Nokia N950 & N9. The basic boot works. I can
> > > connect to both devices with USB networking & ssh. dmesg output looks OK.
> > 
> > That's great! Tony will like that :-)
> > It is too bad I just have a N900 :-(
> > 
> > > Functionality compared to the legacy board file:
> > > 
> > > 	- MMC not detected - reason unknown, any tips welcome
> > 
> > On OMAP4 panda I used to have the similar issue due to the pbias not set
> > properly.
> > 
> > > 	- OneNAND missing completely
> > 
> > The GPMC for OMAP3 support is pretty new, so maybe some tweak are still
> > needed.
> > 
> > Is it RFC because you are still working on the missing functionalities?
> > Otherwise the patches are already good to be merged if you want.
> > As soon as you don't break legacy boot, we can merge even half-working DTS.
> 
> I was hoping to get the MMC working and OneNAND binding added before
> merging this... If we could do that, we could deprecate the legacy board
> file as DT would offer the same functionality.

Great sounds like a plan. Take a look at the wl12xx patches I posted for
setting up the MMC regulators, that might help with the MMC.

I doubt that the missing PBIAS support is an issue as the eMMC has it's
own fixed regulator.

Then the GPMC patches might do the trick with the OneNAND as there have
been patches posted for various boards for NAND and smc911x.
 
> Anyway, if half-working DTS is also fine, I'll resend this as "PATCH"
> in a few days.

Yes that's cool.

Regards,

Tony
