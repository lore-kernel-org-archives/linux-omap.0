From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] dts: dra7: Add device tree node for i2c6
Date: Wed, 25 May 2016 11:11:05 -0500
Message-ID: <5745CE99.50704@ti.com>
References: <20160525125341.10044-1-rk@ti.com>
 <20160525125341.10044-3-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525125341.10044-3-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>, paul@pwsan.com, tony@atomide.com, linux@armlinux.org.uk, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/25/2016 07:53 AM, Ravikumar Kattekola wrote:
> DRA72x devices have an extra i2c controller instance - i2c6
> Adding device description for the same.
> 
> Reference : DRA72x_SR1.0 TRM [ SPRUHP2Q ]
> 
> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 3a8f397..84729a1 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -27,6 +27,7 @@
>  		i2c2 = &i2c3;
>  		i2c3 = &i2c4;
>  		i2c4 = &i2c5;
> +		i2c5 = &i2c6;
>  		serial0 = &uart1;
>  		serial1 = &uart2;
>  		serial2 = &uart3;
> @@ -929,6 +930,16 @@
>  			status = "disabled";
>  		};
>  
> +		i2c6: i2c@48458000 {
> +			compatible = "ti,omap4-i2c";
> +			reg = <0x48458000 0x100>;
> +			interrupts = <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			ti,hwmods = "i2c6";
> +			status = "disabled";
> +		};
> +
>  		mmc1: mmc@4809c000 {
>  			compatible = "ti,omap4-hsmmc";
>  			reg = <0x4809c000 0x400>;
> 
NAK again for the same reasoning.

-- 
Regards,
Nishanth Menon
