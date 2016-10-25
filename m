From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/2] dts: omap5: baord-common: enable twl6040 headset
 jack detection
Date: Tue, 25 Oct 2016 19:51:11 +0300
Message-ID: <105a8b87-69d0-19c7-8337-7d32fd6e997a@ti.com>
References: <cover.1477414105.git.hns@goldelico.com>
 <7771a9fb3b9133fc361c87970444c1a3918891d0.1477414105.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7771a9fb3b9133fc361c87970444c1a3918891d0.1477414105.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, kernel@pyra-handheld.com, marek@goldelico.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/25/2016 07:48 PM, H. Nikolaus Schaller wrote:
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap5-board-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> index b04adee..91456b4 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -124,6 +124,7 @@
>  		compatible = "ti,abe-twl6040";
>  		ti,model = "omap5-uevm";
>  
> +		ti,jack_detection;

ti,jack-detection

>  		ti,mclk-freq = <19200000>;
>  
>  		ti,mcpdm = <&mcpdm>;
> 


-- 
Péter
