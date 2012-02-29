From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
Date: Wed, 29 Feb 2012 14:31:14 -0800
Message-ID: <20120229223114.GS18901@atomide.com>
References: <1324019153-13316-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A80719AC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41813 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964791Ab2B2WbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:31:19 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A80719AC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Cousson, Benoit" <b-cousson@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120105 02:46]:
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Friday, December 16, 2011 12:36 PM
> > To: linux-omap@vger.kernel.org
> > Cc: tony@atomide.com; linux-arm-kernel@lists.infradead.org; devicetree-
> > discuss@lists.ozlabs.org; grant.likely@secretlab.ca; Cousson, Benoit;
> > Hiremath, Vaibhav
> > Subject: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
> > 
> > Add OMAP3 EVM (OMAP3530, AM/DM37x) DTS file to use the omap3.dtsi SoC file,
> > along with memory node information.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> > Boot tested it on AM/DM37x EVM, kernel parses the info correctly.
> > 
> >  arch/arm/boot/dts/omap3-evm.dts |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap3-evm.dts
> > 
> > diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-
> > evm.dts
> > new file mode 100644
> > index 0000000..2eee16e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap3-evm.dts
> > @@ -0,0 +1,20 @@
> > +/*
> > + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +/dts-v1/;
> > +
> > +/include/ "omap3.dtsi"
> > +
> > +/ {
> > +	model = "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
> > +	compatible = "ti,omap3-evm", "ti,omap3";
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x10000000>; /* 256 MB */
> > +	};
> > +};
> Can this merged? OR anybody has any comments here?

For reference, looks like this one is queued up as
commit f0e15e2b0c6b3e89daade25a1e9a2d80136c14c3.

Tony
