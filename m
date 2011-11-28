From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Mon, 28 Nov 2011 07:40:49 -0600
Message-ID: <4ED38F61.50604@gmail.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com> <1321969456-24266-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1321969456-24266-5-git-send-email-rnayak@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

On 11/22/2011 07:44 AM, Rajendra Nayak wrote:
> Pass minimal data needed for console boot, from dt, for
> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> static initialization from generic board file.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob
> ---
>  arch/arm/boot/dts/omap3.dtsi        |   31 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi        |   28 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-generic.c |    1 -
>  3 files changed, 59 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..216c331 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -13,6 +13,13 @@
>  / {
>  	compatible = "ti,omap3430", "ti,omap3";
>  
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +	};
> +
>  	cpus {
>  		cpu@0 {
>  			compatible = "arm,cortex-a8";
> @@ -59,5 +66,29 @@
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
>  		};
> +
> +		uart1: serial@0x4806a000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart1";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart2: serial@0x4806c000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart2";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart3: serial@0x49020000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart3";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart4: serial@0x49042000 {
> +			compatible = "ti,omap3-uart";
> +			ti,hwmods = "uart4";
> +			clock-frequency = <48000000>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 4c61c82..e8fe75f 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -21,6 +21,10 @@
>  	interrupt-parent = <&gic>;
>  
>  	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
>  	};
>  
>  	cpus {
> @@ -99,5 +103,29 @@
>  			reg = <0x48241000 0x1000>,
>  			      <0x48240100 0x0100>;
>  		};
> +
> +		uart1: serial@0x4806a000 {
> +			compatible = "ti,omap4-uart";
> +			ti,hwmods = "uart1";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart2: serial@0x4806c000 {
> +			compatible = "ti,omap4-uart";
> +			ti,hwmods = "uart2";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart3: serial@0x48020000 {
> +			compatible = "ti,omap4-uart";
> +			ti,hwmods = "uart3";
> +			clock-frequency = <48000000>;
> +		};
> +
> +		uart4: serial@0x4806e000 {
> +			compatible = "ti,omap4-uart";
> +			ti,hwmods = "uart4";
> +			clock-frequency = <48000000>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index fb55fa3..bb72809 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -70,7 +70,6 @@ static void __init omap_generic_init(void)
>  	if (node)
>  		irq_domain_add_simple(node, 0);
>  
> -	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);

