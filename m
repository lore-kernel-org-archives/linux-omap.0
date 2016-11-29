From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] mfd: cpcap: Add minimal support
Date: Tue, 29 Nov 2016 11:12:56 -0800
Message-ID: <20161129191255.GB3430@atomide.com>
References: <20161129164702.5334-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161129164702.5334-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161129 08:48]:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> @@ -0,0 +1,31 @@
> +Motorola CPCAP PMIC device tree binding
> +
> +Required properties:
> +- compatible		: One or both of "motorola,cpcap" or "ste,6556002"
> +- reg			: SPI chip select
> +- interrupt-parent	: The parent interrupt controller
> +- interrupts		: The interrupt line the device is connected to
> +- interrupt-controller	: Marks the device node as an interrupt controller
> +- #interrupt-cells	: The number of cells to describe an IRQ, should be 2
> +- #address-cells	: Child device offset number of cells, typically 1
> +- #size-cells		: Child device size number of cells, typically 1
> +- spi-max-frequency	: Typically set to 3000000
> +- spi-cs_high		: SPI chip select direction
> +
> +Example:
> +
> +&mcspi1 {
> +	cpcap: pmic@0 {
> +		compatible = "motorola,cpcap", "ste,6556002";
> +		reg = <0>;	/* cs0 */
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <3000000>;
> +		spi-cs-high;
> +	};
> +};

The #address-cells should be 0 instead of 1 above.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
