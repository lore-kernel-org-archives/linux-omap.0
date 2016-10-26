From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH resent v3 2/3] dts: omap5: board-common: enable twl6040
 headset jack detection
Date: Wed, 26 Oct 2016 11:02:14 +0300
Message-ID: <06084abe-015a-ed84-2ce3-779be5744773@ti.com>
References: <cover.1477417090.git.hns@goldelico.com>
 <b918b86fd1d1f7e6fb2c15bb507b84d5cf1f0d3e.1477417090.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b918b86fd1d1f7e6fb2c15bb507b84d5cf1f0d3e.1477417090.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, kernel@pyra-handheld.com, marek@goldelico.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/25/16 20:38, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I'm not sure if this is valid for igep0500 as I have not seen the schematics.
It might be safer to enable the jack detection only for omap5-uevm?

In any case:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> index b04adee..ab60a8e 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -124,6 +124,7 @@
>  		compatible = "ti,abe-twl6040";
>  		ti,model = "omap5-uevm";
>  
> +		ti,jack-detection;
>  		ti,mclk-freq = <19200000>;
>  
>  		ti,mcpdm = <&mcpdm>;
> 


-- 
Péter
