From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] ARM: dts: Add support for more than 2GB of memory for
 omap5
Date: Sat, 10 Sep 2016 11:40:45 +0530
Message-ID: <67d158dd-4c08-42cc-0fe0-fc198d792e5e@ti.com>
References: <20160909210530.19839-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160909210530.19839-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Saturday 10 September 2016 02:35 AM, Tony Lindgren wrote:
> Some omap5 variants have more than 2GB of memory available as
> optional models. Let's update the dts files to use two address
> cells similar to what dra7 is using with commit dae320ec3173
> ("ARM: dts: DRA7: change address-cells and size-cells").

Acked-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap5-cm-t54.dts   |  2 +-
>  arch/arm/boot/dts/omap5-igep0050.dts |  2 +-
>  arch/arm/boot/dts/omap5-uevm.dts     |  2 +-
>  arch/arm/boot/dts/omap5.dtsi         | 22 +++++++++++-----------
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
> index c9390fa..b153f60 100644
> --- a/arch/arm/boot/dts/omap5-cm-t54.dts
> +++ b/arch/arm/boot/dts/omap5-cm-t54.dts
> @@ -13,7 +13,7 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> -		reg = <0x80000000 0x7F000000>; /* 2048 MB */
> +		reg = <0 0x80000000 0 0x7f000000>; /* 2048 MB */
>  	};
>  
>  	aliases {
> diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
> index f24b449..078dd53 100644
> --- a/arch/arm/boot/dts/omap5-igep0050.dts
> +++ b/arch/arm/boot/dts/omap5-igep0050.dts
> @@ -16,7 +16,7 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> -		reg = <0x80000000 0x7f000000>; /* 2032 MB */
> +		reg = <0x0 0x80000000 0 0x7f000000>;	/* 2032 MB */
>  	};
>  
>  	gpio_keys {
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 1770447..c3c23e4 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -15,7 +15,7 @@
>  
>  	memory@80000000 {
>  		device_type = "memory";
> -		reg = <0x80000000 0x7F000000>; /* 2032 MB */
> +		reg = <0 0x80000000 0 0x7f000000>; /* 2032 MB */
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -12,8 +12,8 @@
>  #include <dt-bindings/pinctrl/omap.h>
>  
>  / {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
>  
>  	compatible = "ti,omap5";
>  	interrupt-parent = <&wakeupgen>;
> @@ -90,10 +90,10 @@
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> -		reg = <0x48211000 0x1000>,
> -		      <0x48212000 0x1000>,
> -		      <0x48214000 0x2000>,
> -		      <0x48216000 0x2000>;
> +		reg = <0 0x48211000 0 0x1000>,
> +		      <0 0x48212000 0 0x1000>,
> +		      <0 0x48214000 0 0x2000>,
> +		      <0 0x48216000 0 0x2000>;
>  		interrupt-parent = <&gic>;
>  	};
>  
> @@ -101,7 +101,7 @@
>  		compatible = "ti,omap5-wugen-mpu", "ti,omap4-wugen-mpu";
>  		interrupt-controller;
>  		#interrupt-cells = <3>;
> -		reg = <0x48281000 0x1000>;
> +		reg = <0 0x48281000 0 0x1000>;
>  		interrupt-parent = <&gic>;
>  	};
>  
> @@ -129,11 +129,11 @@
>  		compatible = "ti,omap5-l3-noc", "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		ranges;
> +		ranges = <0 0 0 0xc0000000>;
>  		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> -		reg = <0x44000000 0x2000>,
> -		      <0x44800000 0x3000>,
> -		      <0x45000000 0x4000>;
> +		reg = <0 0x44000000 0 0x2000>,
> +		      <0 0x44800000 0 0x3000>,
> +		      <0 0x45000000 0 0x4000>;
>  		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>  
> 
