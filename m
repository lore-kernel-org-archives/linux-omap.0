From: "Cooper Jr., Franklin" <fcooper@ti.com>
Subject: RE: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
Date: Tue, 24 Jun 2014 18:39:40 +0000
Message-ID: <8F29D6B095ED194EA1980491A5E029710C6D71A1@DFLE08.ent.ti.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403547659-24558-2-git-send-email-balbi@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "galak@codeaurora.org" <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Nayak, Rajendra" <rnayak@ti.com>, "Menon, Nishanth" <nm@ti.com>, "R, Sricharan" <r.sricharan@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Tested-by: Franklin Cooper Jr. <fcooper@ti.com>

> -----Original Message-----
> From: Balbi, Felipe
> Sent: Monday, June 23, 2014 1:21 PM
> To: Benoit Cousson
> Cc: robh+dt@kernel.org; galak@codeaurora.org; Tony Lindgren;
> linux@arm.linux.org.uk; Nayak, Rajendra; Menon, Nishanth; R, Sricharan;
> devicetree@vger.kernel.org; Linux Kernel Mailing List; Linux OMAP Mailing
> List; Linux ARM Kernel Mailing List; Balbi, Felipe
> Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes through
> phandles
> 
> by providing phandles to rtc, wdt, cpu and dispc nodes, boards can access
> them to add board-specific data.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	- added phandles to cpu and dispc
> 
>  arch/arm/boot/dts/am4372.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 49fa596..8d3c163 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -30,7 +30,7 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -		cpu@0 {
> +		cpu: cpu@0 {
>  			compatible = "arm,cortex-a9";
>  			device_type = "cpu";
>  			reg = <0>;
> @@ -270,7 +270,7 @@
>  			ti,hwmods = "counter_32k";
>  		};
> 
> -		rtc@44e3e000 {
> +		rtc: rtc@44e3e000 {
>  			compatible = "ti,am4372-rtc","ti,da830-rtc";
>  			reg = <0x44e3e000 0x1000>;
>  			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH @@ -
> 279,7 +279,7 @@
>  			status = "disabled";
>  		};
> 
> -		wdt@44e35000 {
> +		wdt: wdt@44e35000 {
>  			compatible = "ti,am4372-wdt","ti,omap3-wdt";
>  			reg = <0x44e35000 0x1000>;
>  			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>; @@
> -871,7 +871,7 @@
>  			#size-cells = <1>;
>  			ranges;
> 
> -			dispc@4832a400 {
> +			dispc: dispc@4832a400 {
>  				compatible = "ti,omap3-dispc";
>  				reg = <0x4832a400 0x400>;
>  				interrupts = <GIC_SPI 127
> IRQ_TYPE_LEVEL_HIGH>;
> --
> 2.0.0.390.gcb682f8
