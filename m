From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Keep all VDD rails always-on
Date: Mon, 3 Nov 2014 16:43:02 +0200
Message-ID: <54579476.10702@ti.com>
References: <1413902290-304-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413902290-304-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Nishant,

On 10/21/2014 05:38 PM, Nishanth Menon wrote:
> DRA7 Data Manual (SPRS857L - August 2014) section 4.1.1 states: "All
> unused power supply balls must be supplied with the voltages specified
> in the Section 5.2, Recommended Operating Conditions".
> 
> This implies that all unused voltage rails for Vayu can never be
> switched off even if the hardware blocks inside that voltage domain is
> unused. Switching off these unused rails may result in stability issues
> on other domains and increased leakage and power-on-hour impacts.
> 
> J6eco-evm dts file already considers this, however j6evm-dts file needs
> to be fixed to consider this constraint of the SoC.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

I'm assuming that vddshv8 (MMC1 power group) can be switched off.

cheers,
-roger

> ---
> 
> Patch is based on v3.18-rc1 tag.
> 
>  arch/arm/boot/dts/dra7-evm.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index c6ce625..4f4c469 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -201,6 +201,7 @@
>  					regulator-name = "smps45";
>  					regulator-min-microvolt = < 850000>;
>  					regulator-max-microvolt = <1150000>;
> +					regulator-always-on;
>  					regulator-boot-on;
>  				};
>  
> @@ -209,6 +210,7 @@
>  					regulator-name = "smps6";
>  					regulator-min-microvolt = <850000>;
>  					regulator-max-microvolt = <12500000>;
> +					regulator-always-on;
>  					regulator-boot-on;
>  				};
>  
> @@ -226,6 +228,7 @@
>  					regulator-name = "smps8";
>  					regulator-min-microvolt = < 850000>;
>  					regulator-max-microvolt = <1250000>;
> +					regulator-always-on;
>  					regulator-boot-on;
>  				};
>  
> @@ -252,6 +255,7 @@
>  					regulator-name = "ldo2";
>  					regulator-min-microvolt = <3300000>;
>  					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
>  					regulator-boot-on;
>  				};
>  
> @@ -269,6 +273,7 @@
>  					regulator-name = "ldo9";
>  					regulator-min-microvolt = <1050000>;
>  					regulator-max-microvolt = <1050000>;
> +					regulator-always-on;
>  					regulator-boot-on;
>  				};
>  
> 
