From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] mfd: cpcap: Add minimal support
Date: Mon, 21 Nov 2016 10:34:39 -0600
Message-ID: <20161121163439.22ztjxnq535lo6dd@rob-hp-laptop>
References: <20161119012748.17224-1-tony@atomide.com>
 <20161121114558.GJ32509@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121114558.GJ32509@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Mark Rutland <mark.rutland@arm.com>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 21, 2016 at 11:45:58AM +0000, Lee Jones wrote:
> On Fri, 18 Nov 2016, Tony Lindgren wrote:
> 
> > Many Motorola phones like droid 4 are using a custom PMIC called CPCAP
> > or 6556002. We can support it's core features quite easily with regmap_spi
> > and regmap_irq.
> > 
> > The children of cpcap, such as regulators, ADC and USB, can be just regular
> > device drivers and defined in the dts file. They get probed as we call
> > of_platform_populate() at the end of our probe, and then the children
> > can just call dev_get_regmap(dev.parent, NULL) to get the regmap.
> > 
> > Cc: devicetree@vger.kernel.org
> > Cc: Marcel Partap <mpartap@gmx.net>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Scott <michael.scott@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/cpcap.txt |  36 ++++
> >  drivers/mfd/Kconfig                             |   8 +
> >  drivers/mfd/Makefile                            |   1 +
> >  drivers/mfd/cpcap.c                             | 255 ++++++++++++++++++++++++
> >  include/linux/mfd/cpcap.h                       | 238 ++++++++++++++++++++++
> >  5 files changed, 538 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/cpcap.txt
> >  create mode 100644 drivers/mfd/cpcap.c
> >  create mode 100644 include/linux/mfd/cpcap.h
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/cpcap.txt b/Documentation/devicetree/bindings/mfd/cpcap.txt
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/cpcap.txt
> > @@ -0,0 +1,36 @@
> > +CPCAP PMIC device tree binding
> > +
> > +Required properties:
> > +- compatible		: Motorola device "motorola,cpcap", others "st,6556002"
> > +- reg			: Chip select and size
> > +- interrupt-parent	: The parent interrupt controller
> > +- interrupts		: The interrupt line the device is connected to
> > +- interrupt-controller	: Marks the device node as an interrupt controller
> > +- #interrupt-cells	: The number of cells to describe an IRQ, should be 2
> > +- #address-cells	: Child device offset number of cells, typically 1
> > +- #size-cells		: Child device size number of cells, typically 1
> > +- ranges		: Child device register range
> > +- spi-max-frequency	: Typically set to 3000000
> > +- spi-cs_high		: SPI chip select direction
> > +
> > +Example:
> > +
> > +&mcspi1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges;
> > +	cpcap: pmic@0 {
> > +		compatible = "motorola,cpcap", "st,6556002";
> > +		reg = <0 0>;	/* cs0, size 0 */
> 
> Is this really correct?

No, SPI devices are 1 cell and there shouldn't be a ranges prop.

> 
> How can ranges have a size of 0x8000 and this 0?

reg here doesn't affect ranges and address translation.

Perhaps this is trying to make address translation work, but if that 
does, it is by chance. Children of pmic addresses in the range of 
0-0x8000 would get translated to "cpu address" 0-0x8000 as long as the 
DT has empty ranges up to the root. If the parent bus (i.e. SoC bus) has 
any base address, then that is going to get added which would not be 
good.

> 
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <2>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0 0x8000>;
> > +		spi-max-frequency = <3000000>;
> > +		spi-cs-high;
> > +	};
> > +};
> > +
