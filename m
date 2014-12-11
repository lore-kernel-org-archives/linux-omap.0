From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 5/7] arm: omap: hwmod: allow for registration of
 class-less hwmods
Date: Thu, 11 Dec 2014 09:32:28 -0800
Message-ID: <20141211173228.GB2990@atomide.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-6-git-send-email-balbi@ti.com>
 <54882576.8020609@ti.com>
 <20141210145433.GC4602@saruman>
 <20141211005238.GC5585@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581AbaLKRfq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2014 12:35:46 -0500
Content-Disposition: inline
In-Reply-To: <20141211005238.GC5585@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, "Kristo, Tero" <t-kristo@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [141210 16:55]:
> On Wed, Dec 10, 2014 at 08:54:33AM -0600, Felipe Balbi wrote:
> > > @@ -2449,6 +2559,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
> > >  		else if (np && index)
> > >  			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
> > >  				oh->name, np->name);
> > > +
> > > +		if (np) {
> > > +			r = omap_hwmod_init_sysc(np, oh, 0);
> > 
> > this won't handle any binding which lists more than one hwmod on its
> > ti,hwmods property.
> 
> I think Tony planned to remove this kind of multi hwmod references.

Yes we really should do that. But that involves repairs in the drivers,
dts files, and hwmod.

We really should aim for 1 to 1 to 1 mapping of the dts compatible
property to device hwmod to device sysc registers.

Once all the devices are mapped that way, we can deprecate
ti,hwmods in the dts files and set it up automatically based on
the compatible and the instance number of the device.

For an example of how to fix the interlaced device dts entries,
let's look at the EDMA. Instead of the current setup in
am33xx.dtsi:

edma: edma@49000000 {
	compatible = "ti,edma3";
	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
	reg =   <0x49000000 0x10000>,
		<0x44e10f90 0x40>;
		interrupts = <12 13 14>;
		#dma-cells = <1>;
};

It really should be set up in the following way (eventually
without ti,hwmods):

edma: edma@49000000 {
	compatible = "ti,edma3";
	reg =   <0x49000000 0x10000>,
		<0x44e10f90 0x40>;
	interrupts = <12>;
	#dma-cells = <1>;
};

tptc0 {
	compatible = "ti,edma3-tptc";
	reg = <0x49800000 0x100000>;
	interrupts = <13>;
};

tptc1 {
	compatible = "ti,edma3-tptc";
	reg = <0x49900000 0x100000>;
	interrupts = <14>;
};

tptc2 {
	compatible = "ti,edma3-tptc";
	reg = <0x49900000 0x100000>;
	interrupts = <15>;
};

This is because each tptc entry has it's own sysc register and
can idle on it's own. With the above we can have 1 to 1 to 1 mapping
of compatible property to hwmod to sysc registers for each device.

> IMHO instead of DT referencing the hwmod stuff using ti,hwmods the
> hwmod database should reference the compatible values. This depends
> on omap3 being DT only of course.

Yes agreed.

Regards,

Tony
