From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: add bindings for TI PRU as remoteproc
Date: Tue, 3 Jul 2018 14:59:32 -0600
Message-ID: <20180703205932.GA28054@rob-hp-laptop>
References: <20180623210810.21232-1-david@lechnology.com>
 <20180623210810.21232-5-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180623210810.21232-5-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 23, 2018 at 04:08:06PM -0500, David Lechner wrote:
> This adds a new binding for the TI Programmable Runtime Unit (PRU)
> as a remoteproc device.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/remoteproc/ti_pru_rproc.txt      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> new file mode 100644
> index 000000000000..0e80a8db46d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> @@ -0,0 +1,51 @@
> +TI Programmable Realtime Unit (PRU)
> +===================================
> +
> +Some TI Sitara SoCs contain a Programmable Realtime Unit subsystem with two
> +processor cores that can be used for hard-realtime tasks.
> +
> +
> +Required properties:
> +--------------------
> +The following are the mandatory properties:
> +
> +- compatible:		Should be one of the following,
> +			    "ti,da850-pru-rproc" for AM18xx/OMAPL138 SoCs
> +			    "ti,am3352-pru-rproc" for AM355x SoCs
> +
> +- reg:			Should contain the memory region for the PRUSS
> +
> +- interrupts: 		Should contain the interrupt number used to receive the
> +			virtualqueue kick interrupts from the PRU (i.e.
> +			PRU_EVTOUT0 and PRU_EVTOUT1)
> +
> +- interrupt-names	Should contain "pru0-vq", "pru1-vq"
> +
> +Optional properties:
> +--------------------
> +
> +- power-domains:	A phandle to the power domain that powers the PRUSS

Only for da850?

> +
> +- ti,hwmods:		Name of the hwmod associated to the PRUSS, which is
> +			typically "pruss"

Only for am3352?

typically? You should enumerate possible values.

> +
> +Example:
> +--------
> +
> +	// AM18xx
> +	pru_rproc: cpu@30000 {

cpu is reserved for cpu nodes.

> +		compatible = "ti,da850-pru-rproc";
> +		reg = <0x30000 0x10000>;
> +		interrupts = <3>, <4>;
> +		interrupt-names = "pru0-vq", "pru1-vq";
> +		power-domains = <&psc0 13>;
> +	};
> +
> +	// AM335x
> +	pru_rproc: cpu@4a300000 {
> +		compatible = "ti,am3352-pru-rproc";
> +		reg = <0x4a300000 0x80000>;
> +		interrupts = <20>, <21>;
> +		interrupt-names = "pru0-vq", "pru1-vq";
> +		ti,hwmods = "pruss";
> +	};

Really need 2 examples?

> -- 
> 2.17.1
> 
