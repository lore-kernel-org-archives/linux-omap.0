From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3 4/8] MFD: ti_am335x_tscadc: add device tree binding
 information
Date: Sat, 19 Jan 2013 23:28:14 +0100
Message-ID: <50FB1DFE.6090805@metafoo.de>
References: <cover.1358502134.git.rachna@ti.com> <daf18b4779ac3c6b69b1e7e2d1a4abd18b13fee5.1358502134.git.rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <daf18b4779ac3c6b69b1e7e2d1a4abd18b13fee5.1358502134.git.rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On 01/18/2013 11:48 AM, Patil, Rachna wrote:
> From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
> 
> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   35 ++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt b/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> new file mode 100644
> index 0000000..c13c492
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> @@ -0,0 +1,35 @@
> +Texas Instruments - TSC / ADC multi-functional device
> +
> +ti_tscadc is a multi-function device with touchscreen and ADC on chip.
> +This document describes the binding for mfd device.
> +
> +Required properties:
> +- compatible: "ti,ti-tscadc"
> +- reg: Specifies the address of MFD block
> +- interrupts: IRQ line connected to the main SoC
> +- interrupt-parent: The parent interrupt controller

The subnodes and their properties also need documentation.

> +
> +Optional properties:
> +- ti,hwmods: Hardware information related to TSC/ADC MFD device
> +
> +Example:
> +
> +	tscadc: tscadc@44e0d000 {
> +		compatible = "ti,ti-tscadc";
> +		reg = <0x44e0d000 0x1000>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <16>;
> +		ti,hwmods = "adc_tsc";
> +
> +		tsc {
> +			wires = <4>;
> +			x-plate-resistance = <200>;
> +			steps-to-configure = <5>;
> +			wire-config = <0x00 0x11 0x22 0x33>;

Non-standard properties should have a vendor prefix.

> +		};
> +
> +		adc {
> +			adc-channels = <4>;
> +		};
> +	};
