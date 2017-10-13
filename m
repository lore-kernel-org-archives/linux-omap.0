From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 1/6] ARM: dts: DRA72: Add CAL dtsi node
Date: Fri, 13 Oct 2017 09:54:09 -0700
Message-ID: <20171013165408.GJ4394@atomide.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-2-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171012192719.15193-2-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [171012 12:29]:
> This patch adds the required dtsi node to support the Camera
> Adaptation Layer (CAL) for the DRA72 family of devices.
> 
> - Added CAL entry in dra72x.dtsi.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  arch/arm/boot/dts/dra72x.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
> index 67107605fb4c..d0ba4f238084 100644
> --- a/arch/arm/boot/dts/dra72x.dtsi
> +++ b/arch/arm/boot/dts/dra72x.dtsi
> @@ -17,6 +17,37 @@
>  		interrupt-parent = <&wakeupgen>;
>  		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +	ocp {
> +		cal: cal@4845b000 {
> +			compatible = "ti,dra72-cal";
> +			ti,hwmods = "cal";
> +			reg = <0x4845B000 0x400>,
> +			      <0x4845B800 0x40>,
> +			      <0x4845B900 0x40>,
> +			      <0x4A002e94 0x4>;

Care to fix the cAmelcasing here? All lower case hex is pretty much the
standard with linux, so might as well lower case them all while at it.

Regards,

Tony
