From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v3 09/10] arm64: dts: k3-am65-main Add CAL node
Date: Tue, 12 Nov 2019 07:38:31 -0800
Message-ID: <20191112153831.GI5610@atomide.com>
References: <20191112142753.22976-1-bparrot@ti.com>
 <20191112142753.22976-10-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112142753.22976-10-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191112 14:25]:
> Add CAL dtsi node for AM654 device. Including proper power-domains and
> clock properties.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 799c75fa7981..4c65ed445e8b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -516,4 +516,27 @@
>  		dma-coherent;
>  		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
>  	};
> +
> +	cal: cal@6f03000 {
> +		compatible = "ti,am654-cal";
> +		reg = <0x0 0x06f03000 0x0 0x400>,
> +		      <0x0 0x06f03800 0x0 0x40>;
> +		reg-names = "cal_top",
> +			    "cal_rx_core0";
> +		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> +		ti,camerrx-control = <&scm_conf 0x40c0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 2 0>;
> +		power-domains = <&k3_pds 2 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			csi2_0: port@0 {
> +				reg = <0>;
> +			};
> +		};
> +	};
>  };

Here too just drop the status = "disabled" line. For reference, see commit
12afc0cf8121 ("ARM: dts: Drop pointless status changing for am3 musb")
in Linux next where we remove about 450 lines of pointless back and forth
noise from status = "disabled" to various board specific files setting
musb components back to status = "okay".

Regards,

Tony
