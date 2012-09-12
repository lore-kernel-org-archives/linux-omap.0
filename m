From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/2] arm/dts: AM33XX: Add device tree OPP table
Date: Wed, 12 Sep 2012 19:21:55 +0200
Message-ID: <5050C4B3.9040107@ti.com>
References: <1346405840-31058-1-git-send-email-anilkumar@ti.com> <1346405840-31058-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1346405840-31058-3-git-send-email-anilkumar@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>, paul Walmsley <paul@pwsan.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+ Paul

Hi Anil,

On 08/31/2012 11:37 AM, AnilKumar Ch wrote:
> Add DT OPP table for AM33XX family of devices. This data is
> decoded by OF with of_init_opp_table() helper function.
> 
> Also adds cpu0 supply name to the corresponding dts files.
> cpu0-supply name is used by cpufreq-cpu0 driver to get the
> regulator pointer for voltage modifications.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

I've just applied your patch in my for_3.7/dts_part2 branch.

I changed the subject to use "ARM: dts: " prefix seems it seems to be
the convention nowadays.

I can apply as the well the clock patch if Paul acks it, but it can go
through Paul as well since there is no strong dependency between them AFAIK.

Thanks,
Benoit


> ---
>  arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
>  arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
>  arch/arm/boot/dts/am33xx.dtsi     |   15 +++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index ce486fc..2767b5f 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -13,6 +13,12 @@
>  	model = "TI AM335x BeagleBone";
>  	compatible = "ti,am335x-bone", "ti,am33xx";
>  
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply = <&dcdc2_reg>;
> +		};
> +	};
> +
>  	memory {
>  		device_type = "memory";
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index baa3276..54d972c 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -13,6 +13,12 @@
>  	model = "TI AM335x EVM";
>  	compatible = "ti,am335x-evm", "ti,am33xx";
>  
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply = <&vdd1_reg>;
> +		};
> +	};
> +
>  	memory {
>  		device_type = "memory";
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index ab744d6..2043b53 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -25,6 +25,21 @@
>  	cpus {
>  		cpu@0 {
>  			compatible = "arm,cortex-a8";
> +
> +			/*
> +			 * To consider voltage drop between PMIC and SoC,
> +			 * tolerance value is reduced to 2% from 4% and
> +			 * voltage value is increased as a precaution.
> +			 */
> +			operating-points = <
> +				/* kHz    uV */
> +				720000  1285000
> +				600000  1225000
> +				500000  1125000
> +				275000  1125000
> +			>;
> +			voltage-tolerance = <2>; /* 2 percentage */
> +			clock-latency = <300000>; /* From omap-cpufreq driver */
>  		};
>  	};
>  
> 

