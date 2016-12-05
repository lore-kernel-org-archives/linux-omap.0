From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] mfd: cpcap: Add minimal support
Date: Mon, 5 Dec 2016 16:25:21 -0600
Message-ID: <20161205222521.lm7pyyjnmdi6asei@rob-hp-laptop>
References: <20161129164702.5334-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161129164702.5334-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 29, 2016 at 08:47:02AM -0800, Tony Lindgren wrote:
> Many Motorola phones like droid 4 are using a custom PMIC called CPCAP
> or 6556002. We can support it's core features quite easily with regmap_spi
> and regmap_irq.
> 
> The children of cpcap, such as regulators, ADC and USB, can be just regular
> device drivers and defined in the dts file. They get probed as we call
> of_platform_populate() at the end of our probe, and then the children
> can just call dev_get_regmap(dev.parent, NULL) to get the regmap.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Changes from v1:
> 
> - Addressed comments from Lee Jones except did not start
>   generalizing bulk adding of IRQ chips. That can be done
>   later as needed.
> 
> - Dropped the ranges translation based on comments from
>   Lee Jones and Rob Herring. We are using regmap anyways.
> 
> - Changed naming to use motorola-cpcap as this is Motorola
>   custom PMIC manufactured by STE and TI.
> 
> - Moved the revision and vendor check to motorola-cpcap.h.
>   This keeps the undocumented register bits limited to
>   these functions and the child device drivers can use
>   them for the related workarounds.
> 
> - Checked that motorola-cpcap.h is really aligned despite
>   how the patch looks for some of the lines.
> 
> ---
>  .../devicetree/bindings/mfd/motorola-cpcap.txt     |  31 +++
>  drivers/mfd/Kconfig                                |  11 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/motorola-cpcap.c                       | 244 +++++++++++++++++
>  include/linux/mfd/motorola-cpcap.h                 | 289 +++++++++++++++++++++
>  5 files changed, 576 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
>  create mode 100644 drivers/mfd/motorola-cpcap.c
>  create mode 100644 include/linux/mfd/motorola-cpcap.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
> new file mode 100644
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

Should be spi-cs-high.

With that:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
