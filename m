From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Move pcie RC node to common file
Date: Wed, 11 Oct 2017 08:44:48 -0700
Message-ID: <20171011154447.GY4394@atomide.com>
References: <20171011080430.13160-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011080430.13160-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Ravikumar Kattekola <rk@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [171011 01:06]:
> From: Ravikumar Kattekola <rk@ti.com>
> 
> Move the pcie_rc node to common file so that it can be
> used by dra76-evm as well.
> 
> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Can you please resend this with your Signed-off-by also
since you're the one sending it out?

Regards,

Tony

>  arch/arm/boot/dts/dra7-evm-common.dtsi | 4 ++++
>  arch/arm/boot/dts/dra7-evm.dts         | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
> index 343e95f9a001..e088bb93636a 100644
> --- a/arch/arm/boot/dts/dra7-evm-common.dtsi
> +++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
> @@ -256,3 +256,7 @@
>  		status = "okay";
>  	};
>  };
> +
> +&pcie1_rc {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index aa426dabb6c3..ef9c90daa74b 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -497,7 +497,3 @@
>  	pinctrl-1 = <&dcan1_pins_sleep>;
>  	pinctrl-2 = <&dcan1_pins_default>;
>  };
> -
> -&pcie1_rc {
> -	status = "okay";
> -};
> -- 
> 2.11.0
> 
