From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 08/21] irqchip: crossbar: convert dra7 crossbar to
 stacked domains
Date: Thu, 8 Jan 2015 08:39:38 -0600
Message-ID: <20150108143938.GA30790@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-9-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-9-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
[..]
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 10b725c..048cfeb 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -423,7 +423,7 @@
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart1_pins>;
> -	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
>  			      <&dra7_pmx_core 0x3e0>;
^^ interrrupt-extended for uart1 here
[..]

> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
[...]
> @@ -344,7 +344,7 @@
>  		uart1: serial@4806a000 {
>  			compatible = "ti,omap4-uart";
>  			reg = <0x4806a000 0x100>;
> -			interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
^^ implies we will have both interrupts and interrupts-extended
properties for uart1 in dra7-evm.dtb

Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
does not make it clear as to what the priority will be when both
properties are present.

[...]
Also, for 3.19-rc3, Missing the following causing x15 to fail boot.

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 49edbda68cd5..c2241c2e5d9d 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -335,7 +335,6 @@
 	mcp_rtc: rtc@6f {
 		compatible = "microchip,mcp7941x";
 		reg = <0x6f>;
-		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_LOW>;  /* IRQ_SYS_1N */
 
 		pinctrl-names = "default";
@@ -358,7 +357,7 @@
 
 &uart3 {
 	status = "okay";
-	interrupts-extended = <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+	interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
 			      <&dra7_pmx_core 0x248>;
 
 	pinctrl-names = "default";
-- 
Regards,
Nishanth Menon
