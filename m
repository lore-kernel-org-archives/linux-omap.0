From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] dt-bindings: Nokia N9 audio support
Date: Wed, 10 Jan 2018 11:39:30 +0200
Message-ID: <20180110093930.wq5darjgtuugc6ad@paasikivi.fi.intel.com>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180110085315.GA17841@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Wed, Jan 10, 2018 at 09:53:15AM +0100, Pavel Machek wrote:
> From: Filip Matijević <filip.matijevic.pz@gmail.com>
> 
> Add bindings for Nokia N9 audio components.
> 
> Signed-off-by: Filip Matijević <filip.matijevic.pz@gmail.com>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/Documentation/devicetree/bindings/media/ti-wl1273.txt b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> new file mode 100644
> index 0000000..21db389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti-wl1273.txt
> @@ -0,0 +1,36 @@
> +Texas Instruments - wl1273 radio/bluetooth module
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

I'd document this under a separate section, as the compatible property for
the other child node.

You use "property - description" here but "property: description" in the
file below. It'd be nice to be consistent, albeit it's separate files.

> +
> +Optional properties:
> +
> +- wl1273codec child - compatible = "ti,wl1273codec";

"ti,wl1273-codec"

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

A small description saying what this really is would be nice.

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
> +- nokia,headphone-amplifier: phandle for the TPA6130A2 node
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

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
