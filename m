From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: Nokia N9 audio support
Date: Fri, 19 Jan 2018 14:15:46 -0600
Message-ID: <20180119201546.v4ua72kejql3w2ro@rob-hp-laptop>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
 <20180108222054.GA17452@amd>
 <20180110085315.GA17841@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180110085315.GA17841@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 10, 2018 at 09:53:15AM +0100, Pavel Machek wrote:
> From: Filip Matijević <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add bindings for Nokia N9 audio components.
> 
> Signed-off-by: Filip Matijević <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> 
> diff --git a/Documentation/devicetree/bindings/media/ti-wl1273.txt b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> new file mode 100644
> index 0000000..21db389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> @@ -0,0 +1,36 @@
> +Texas Instruments - wl1273 radio/bluetooth module

bluetooth chips have a binding location: bindings/net/bluetooth.

And we already have a WL1273 binding. Plus there's the one for the Nokia 
BT which I think can be TI chips with a different firmware and protocol. 
Is this related?

> +
> +Required properties:
> +
> +- compatible - "ti,wl1273-core"
> +- reg - I2C slave address
> +- interrupts       - The interrupt output from the device.
> +- interrupt-parent - The parent interrupt controller.
> +- power-gpio       - gpio pin to power the device.
> +
> +- wl1273radio child - compatible = "ti,wl1273-fm-radio";

AIUI, the FM radio is accessed thru the HCI interface aka shared 
transport via the UART. So it is already covered by the serial device 
binding for TI chips.

> +
> +Optional properties:
> +
> +- wl1273codec child - compatible = "ti,wl1273codec";

This is a codec or just BT audio I2S/PCM interface?

> +
> +Example:
> +
> +wl1273core: wl1273core@22 {
> +		compatible = "ti,wl1273-core";
> +		reg = <0x22>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wl1273_gpio>;
> +
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <11 2>; /* gpio_43, IRQF_TRIGGER_FALLING */
> +
> +		wl1273radio: wl1273radio {
> +			compatible = "ti,wl1273-fm-radio";
> +		};
> +
> +		wl1273codec: wl1273codec {
> +			compatible = "ti,wl1273-codec";
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/sound/nokia,n9.txt b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> new file mode 100644
> index 0000000..230b1eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nokia,n9.txt
> @@ -0,0 +1,32 @@
> +* Nokia N9/N950 audio setup
> +
> +Required properties:
> +- compatible: "nokia,n9-audio"
> +
> +- nokia,twl4030-cpu-dai: phandle for the McBSP node connected to TWL4030
> +- nokia,tlv320dac33-cpu-dai: phandle for the McBSP node connected to TLV320DAC33
> +- nokia,wl1273-cpu-dai: phandle for the McBSP node connected to WL1273
> +
> +- nokia,twl4030-codec: phandle for the TWL4030 codec
> +- nokia,tlv320dac33-codec: phandle for the TLV320DAC33 codec
> +- nokia,wl1273-codec: phandle for the WL1273 codec

Both dais and codecs should just be lists with a defined order.

> +- nokia,headphone-amplifier: phandle for the TPA6130A2 node

The simple card or graph card binding don't work? At least follow them 
to the extent that they do work. 
> +
> +- nokia,speaker-amplifier-gpios: GPIO for speaker amplifier
> +
> +Example:
> +
> +sound: n9-audio {
> +	compatible = "nokia,n9-audio";
> +
> +	nokia,twl4030-cpu-dai = <&mcbsp3>;
> +	nokia,tlv320dac33-cpu-dai = <&mcbsp2>;
> +	nokia,wl1273-cpu-dai = <&mcbsp4>;
> +
> +	nokia,twl4030-codec = <&twl4030_audio>;
> +	nokia,tlv320dac33-codec = <&tlv320dac33>;
> +	nokia,wl1273-codec = <&wl1273codec>;
> +	nokia,headphone-amplifier = <&tpa6140a2>;
> +
> +	nokia,speaker-amplifier-gpios = <&twl_gpio 7 GPIO_ACTIVE_HIGH>;
> +};
> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> new file mode 100644
> index 0000000..8e981f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
> @@ -0,0 +1,39 @@
> +Texas Instruments - tlv320dac33 Codec module
> +
> +The tlv320dac33 serial control bus communicates through I2C protocols.
> +
> +Required properties:
> +
> +- compatible - "ti,tlv320dac33"
> +- reg - I2C slave address
> +
> +Optional properties:
> +
> +- power-gpio - gpio pin to power the device

power-gpios.

Active high or low?

> +
> +- avdd-supply, dvdd-supply, iovdd-supply: power supplies for the device as covered
> +  in Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +- interrupts       - The interrupt output from the device.
> +- interrupt-parent - The parent interrupt controller.
> +
> +- ti,keep-bclk 	- Keep the BCLK running in FIFO modes
> +- ti,burst-bclkdiv - BCLK divider value in burst mode
> +
> +Example:
> +
> +tlv320dac33: tlv320dac33@19 {

audio-codec@19

> +	compatible = "ti,tlv320dac33";
> +	reg = <0x19>;
> +
> +	avdd-supply = <&vaux4>;
> +	dvdd-supply = <&vio>;
> +	iovdd-supply = <&vio>;
> +
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <21 1>; /* gpio_53, IRQF_TRIGGER_RISING */
> +	power-gpio = <&gpio2 28 0>; /* gpio_60 */
> +
> +	ti,keep-bclk;
> +	ti,burst-bclkdiv = /bits/ 8 <3>;
> +};
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
