From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
Date: Fri, 7 Sep 2012 10:33:37 -0700
Message-ID: <20120907173337.GC1303@atomide.com>
References: <504A11E4.6000406@ti.com>
 <20120907170621.GZ1303@atomide.com>
 <20120907172500.GB9208@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62717 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2IGRdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 13:33:43 -0400
Content-Disposition: inline
In-Reply-To: <20120907172500.GB9208@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

* Felipe Balbi <balbi@ti.com> [120907 10:30]:
> Hi,
> 
> On Fri, Sep 07, 2012 at 10:06:22AM -0700, Tony Lindgren wrote:
> > * Benoit Cousson <b-cousson@ti.com> [120907 08:26]:
> > > Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> > > (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
> > > we can now specify reg and interrupts using standard device tree
> > > attributes.
> > > 
> > > Update the OMAP4 dtsi file with missing reg and interrupts attributes.
> > > 
> > > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Cc: Tony Lindgren <tony@atomide.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > ---
> > > 
> > > Hi Tony,
> > > 
> > > This is the first step toward reduction of the hwmod data inside mach-omap2.
> > > OMAP2/3/4 data still need to be there for legacy boards, but it will allow
> > > OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.
> > 
> > That's good to hear, that should cut down the data by some hundreds of lines :)
> 
> more than you think, I guess :-)

Very cool, we're only two board files away from making omap4 data shrink by:
omap_hwmod_44xx_data.c | 1432 -------------------------------------------------

But basically no need to merge similar data at all for am33xx and omap5.

Regards,

Tony
