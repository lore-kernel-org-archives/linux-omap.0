From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH V2 1/2] ARM: dts: DRA7: Add bandgap and related thermal
 nodes
Date: Fri, 27 Mar 2015 11:32:36 +0530
Message-ID: <5514F27C.7070904@ti.com>
References: <1427139579-4215-1-git-send-email-nm@ti.com> <1427139579-4215-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427139579-4215-2-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, tony@atomide.com, bcousson@baylibre.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Tuesday 24 March 2015 01:09 AM, Nishanth Menon wrote:
> From: Keerthy <j-keerthy@ti.com>
>
> Add bandgap and related thermal nodes. The patch adds 5 thermal
> sensors. Only one cooling device for mpu as of now. The sensors are
> the exact same on both dra72 and dra7. Introduce CPU, GPU, core nodes
> for the moment as they are direct reuse of OMAP5 entities.
>
> NOTE: OMAP4 has a finer counter granularity, which allows for a delay
> of 1000ms in the thermal zone polling intervals. DRA7 have different
> counter mechanism, which allows at maximum a 500ms timer. Adjust the
> cpu thermal zone accordingly for DRA7.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [t-kristo@ti.com: few reuse from OMAP5 entities]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> 	- omap5-cpu-thermal.dtsi dropped
> 	- approach similar to omap5
> 	- added core and gpu thermal dtsi(they can be reused)
> 	- Squashed patch #1 from v1 to patch #2 - this patch.
> 	- Not carrying forward ack due to change

Thanks for updating Nishanth. Looks good to me.

- Keerthy

>
> V1: http://marc.info/?t=142688102700006&r=1&w=2
>
>   arch/arm/boot/dts/dra7.dtsi   |   23 +++++++++++++++++++++++
>   arch/arm/boot/dts/dra72x.dtsi |    5 +++++
>   arch/arm/boot/dts/dra74x.dtsi |    5 +++++
>   3 files changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index eea4a54d6cb3..2d6a7e3e001f 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -177,6 +177,18 @@
>   			};
>   		};
>
> +		bandgap: bandgap@4a0021e0 {
> +			reg = <0x4a0021e0 0xc
> +				0x4a00232c 0xc
> +				0x4a002380 0x2c
> +				0x4a0023C0 0x3c
> +				0x4a002564 0x8
> +				0x4a002574 0x50>;
> +				compatible = "ti,dra752-bandgap";
> +				interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +				#thermal-sensor-cells = <1>;
> +		};
> +
>   		cm_core_aon: cm_core_aon@4a005000 {
>   			compatible = "ti,dra7-cm-core-aon";
>   			reg = <0x4a005000 0x2000>;
> @@ -1419,6 +1431,17 @@
>   			status = "disabled";
>   		};
>   	};
> +
> +	thermal_zones: thermal-zones {
> +		#include "omap4-cpu-thermal.dtsi"
> +		#include "omap5-gpu-thermal.dtsi"
> +		#include "omap5-core-thermal.dtsi"
> +	};
> +
> +};
> +
> +&cpu_thermal {
> +	polling-delay = <500>; /* milliseconds */
>   };
>
>   /include/ "dra7xx-clocks.dtsi"
> diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
> index e5a3d23a3df1..6ac8e3601499 100644
> --- a/arch/arm/boot/dts/dra72x.dtsi
> +++ b/arch/arm/boot/dts/dra72x.dtsi
> @@ -20,6 +20,11 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a15";
>   			reg = <0>;
> +
> +			/* cooling options */
> +			cooling-min-level = <0>;
> +			cooling-max-level = <2>;
> +			#cooling-cells = <2>; /* min followed by max */
>   		};
>   	};
>
> diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
> index 10173fab1a15..eef981f4bcd5 100644
> --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -31,6 +31,11 @@
>   			clock-names = "cpu";
>
>   			clock-latency = <300000>; /* From omap-cpufreq driver */
> +
> +			/* cooling options */
> +			cooling-min-level = <0>;
> +			cooling-max-level = <2>;
> +			#cooling-cells = <2>; /* min followed by max */
>   		};
>   		cpu@1 {
>   			device_type = "cpu";
>
