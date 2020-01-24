From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [Patch v4 09/10] arm64: dts: k3-am65-main Add CAL node
Date: Fri, 24 Jan 2020 13:32:19 +0200
Message-ID: <dd203eea-f467-07a0-c578-cc6eeb512032@ti.com>
References: <20191211140558.10407-1-bparrot@ti.com>
 <20191211140558.10407-10-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211140558.10407-10-bparrot@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/12/2019 16:05, Benoit Parrot wrote:
> Add CAL dtsi node for AM654 device. Including proper power-domains and
> clock properties.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>

Queued this and patch #10 up for 5.6, thanks.

-Tero

> ---
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index efb24579922c..551adcefcc83 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -624,4 +624,26 @@
>   		dma-coherent;
>   		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
>   	};
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
>   };
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
