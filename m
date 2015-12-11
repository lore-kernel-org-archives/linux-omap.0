From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 4/5] ARM: dts: DRA7: add entry for qspi mmap region
Date: Fri, 11 Dec 2015 09:09:35 -0600
Message-ID: <20151211150935.GA15654@rob-hp-laptop>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-5-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449807000-6457-5-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 11, 2015 at 09:39:59AM +0530, Vignesh R wrote:
> Add qspi memory mapped region entries for DRA7xx based SoCs. Also,
> update the binding documents for the controller to document this change.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> 
> v5: use syscon to access scm register.
> 
>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 17 +++++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi                       |  6 ++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> index 601a360531a5..809c3f334316 100644
> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> @@ -15,6 +15,10 @@ Recommended properties:
>  - spi-max-frequency: Definition as per
>                       Documentation/devicetree/bindings/spi/spi-bus.txt
>  
> +Optional properties:
> +- syscon-chipselects: Handle to system control region contains QSPI
> +		      chipselect register and offset of that register.
> +
>  Example:
>  
>  qspi: qspi@4b300000 {
> @@ -26,3 +30,16 @@ qspi: qspi@4b300000 {
>  	spi-max-frequency = <25000000>;
>  	ti,hwmods = "qspi";
>  };
> +
> +For dra7xx:
> +qspi: qspi@4b300000 {
> +	compatible = "ti,dra7xxx-qspi";
> +	reg = <0x4b300000 0x100>,
> +	      <0x5c000000 0x4000000>,
> +	reg-names = "qspi_base", "qspi_mmap";
> +	syscon-chipselects = <&scm_conf 0x558>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	spi-max-frequency = <48000000>;
> +	ti,hwmods = "qspi";
> +};
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index fe99231cbde5..be91c7781c07 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1153,8 +1153,10 @@
>  
>  		qspi: qspi@4b300000 {
>  			compatible = "ti,dra7xxx-qspi";
> -			reg = <0x4b300000 0x100>;
> -			reg-names = "qspi_base";
> +			reg = <0x4b300000 0x100>,
> +			      <0x5c000000 0x4000000>;
> +			reg-names = "qspi_base", "qspi_mmap";
> +			syscon-chipselects = <&scm_conf 0x558>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			ti,hwmods = "qspi";
> -- 
> 2.6.3
> 
