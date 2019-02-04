From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Mon, 4 Feb 2019 08:33:12 -0800
Message-ID: <20190204163312.GI5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549290167-876-2-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [190204 14:23]:
> From: Suman Anna <s-anna@ti.com>
...
> +Example:
> +========
> +1.	/* AM33xx PRU-ICSS */
> +
> +	pruss: pruss@0 {
> +		compatible = "ti,am3356-pruss";
> +		reg = <0x0 0x2000>,
> +		      <0x2000 0x2000>,
> +		      <0x10000 0x3000>;
> +		reg-names = "dram0", "dram1",
> +			    "shrdram2";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

Thanks for fixing up the reg ranges for the top level node.

Ideally there would not even be a top level node here as
AFAIK the whole PRUSS is a collection of devices on a PRU
internal interconnect. So following that path a bit further..
How about just get rid of the top level node and just do:

pruss: pruss@0 {
	dram0: memory@0 {
	       device_type = "memory";
	       reg = <0x0 0x2000>;
	};

	dram1: memory@2000 {
	       device_type = "memory";
	       reg = <0x2000 0x2000>;
	};

	shrdram2: memory@10000 {
		device_type = "memory";
		reg = <0x10000 0x3000>;
	};

	pruss_cfg: cfg@26000 {
		...
	};
	...
};

If the device_type = "memory" cannot be used here for
being specific to the top level properties, then
there's probably some other generic property usable
here :)

> +		pruss_mii_rt: mii_rt@32000 {
> +			reg = <0x32000 0x58>;
> +		};

The node name should not have underscores so
pruss_mii_rt: mii-rt@32000. Please check the others
too, like app_node.

> +	app_node: app_node {
> +		prus = <&pru0>, <&pru1>;
> +		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
> +		ti,pruss-gp-mux-sel = <2>, <1>;
> +		/* setup interrupts for prus:
> +		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
> +		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
> +		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
> +	}

If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
firmware configuration options, maybe leave them out of
the dts completely and make the app-node optional.

And have a proper compatible for this node such as
"ti,pruss-app-xyz". And this should be only set if the the
hardware is wired up in such way that things need to be
configured in the dts rather than by the firmware.

And then you can just hide mux-sel and interrupt-map
behind the compatible property for that hardware. And
leave them out from the dts and have the handling driver
would set mux-sel and interrupt-map based on the
match->data during probe.

Regards,

Tony
