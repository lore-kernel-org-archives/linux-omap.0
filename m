From: Tony Lindgren <tony@atomide.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Mon, 4 May 2015 07:11:03 -0700
Message-ID: <20150504141103.GD24469@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48928 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbbEDOLG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 10:11:06 -0400
Content-Disposition: inline
In-Reply-To: <20150504064323.GU15254@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi,

Adding Peter to Cc as well.

* Robert Schwebel <r.schwebel@pengutronix.de> [150503 23:44]:
> Hi,
> 
> since 5e863c561, I get this warning for an AM335x board:
> 
>   omap_hwmod: tptc0 using broken dt data from edma
>   omap_hwmod: tptc1 using broken dt data from edma
>   omap_hwmod: tptc2 using broken dt data from edma
> 
> It seems like the code in arch/arm/mach-omap2/omap_hwmod.c expects the oftree
> entry to look differently than what we currently have in
> arch/arm/boot/dts/am33xx.dtsi:
> 
>   edma: edma@49000000 {
>           compatible = "ti,edma3";
>           ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";    <==========
>           reg =   <0x49000000 0x10000>,
>                   <0x44e10f90 0x40>;
>           interrupts = <12 13 14>;
>           #dma-cells = <1>;
>   };
> 
> The patch description says the device should be split into more devices instead
> of specifying several ti,hwmods entries, but unfortunately the Documentation
> still suggests the above format in Documentation/devicetree/bindings/dma/ti-edma.txt.
> 
> How would a correct entry look like?

Each tptc instance has it's own sysconfig register. This means each
one of them can be clocked and idled independently. They should be
treated as separate device instances. I believe the interrupts all
belong to the tpcc, which should be also treated as a separate
device instance.

In order to get rid of the ti,hwmods property, we want to have a
1-1-1 mapping of the compatible property, ti,hwmod property, and
the device entry.

Looking at the TRM "Table 2-1. L3 Memory Map", these all are on
the L3, so they should be like this for now (assuming the
interrupts all belong to tpcc):

ocp {
	...

	edma: tpcc@49000000 {
		compatible = "ti,edma3";
		ti,hwmods = "tpcc"; 
		reg = <0x49000000 0x10000>;
		interrupts = <12 13 14>;
		#dma-cells = <1>;
	};

	tptc0: tptc@49800000 {
		compatible = "ti,tptc3";
		ti,hwmods = "tptc0";
		reg = <0x49800000 0x10000>;
	};

	tptc1: tptc@49900000 {
		compatible = "ti,tptc3";
		ti,hwmods = "tptc1";
		reg = <0x49900000 0x10000>;
	};

	tptc2: tptc@49a00000 {
		compatible = "ti,tptc3";
		ti,hwmods = "tptc2";
		reg = <0x49a00000 0x10000>;
	};
	...
};

Then eventually we can deprecate the ti,hwmods property and just
leave it out.

Changing thing this way means each tptc instance should register
itself separately with tpcc when probed. Other than that, I think
that's pretty much the only changes needed here to fix up things.

Regards,

Tony
