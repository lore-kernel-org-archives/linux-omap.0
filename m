From: Tony Lindgren <tony@atomide.com>
Subject: Re: HSI: any status updates on omap_ssi?
Date: Tue, 24 Apr 2012 09:42:55 -0700
Message-ID: <20120424164255.GO3739@atomide.com>
References: <20120421105235.GA3296@earth.universe>
 <20120424152316.GH3739@atomide.com>
 <20120424162754.GA9407@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39817 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742Ab2DXQm5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 12:42:57 -0400
Content-Disposition: inline
In-Reply-To: <20120424162754.GA9407@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [120424 09:31]:
> On Tue, Apr 24, 2012 at 08:23:16AM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [120421 04:26]:
> > > Hi,
> > > 
> > > Missing omap_ssi support is currently the most important missing
> > > feature, to make the mainline kernel on the Nokia N900 useful, see
> > > also [0].
> > > 
> > > Can you prepare SSI inclusion into the mainline kernel, now that HSI
> > > has been pulled into 3.4? Do you think we get SSI support in 3.5?
> > 
> > Also FYI related to n900, you need to have bce492c0 (ARM: OMAP2+: UART: Fix
> > incorrect population of default uart pads) applied after v3.1 if using
> > CONFIG_OMAP_MUX to avoid some SSI pins getting wronly muxed to UART.
> 
> Thanks for the info.
> 
> > Then to verify, the hw floating point error you reported a while back
> > with omap2plus_defconfig got resolved, right?
> 
> I have not tried again since then. The error only occured, if the
> kernel has been built with OMAP2 support. It does not show up on
> kernels, which support only OMAP3/OMAP4.

I believe last time I checked it few weeks back it worked correctly with
omap2 compiled in. Or else there are some other .config options needed too.

Care to verify that?

Regards,

Tony
