From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Tue, 5 Jan 2016 17:40:01 -0600
Message-ID: <568C5451.8070709@ti.com>
References: <cover.1451995297.git.hns@goldelico.com>
 <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com
List-Id: linux-omap@vger.kernel.org

On 01/05/2016 06:01 AM, H. Nikolaus Schaller wrote:
> tested on OMP5432 EVM
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap5-board-common.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
> index 5cf76a1..30c0d3b 100644
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -358,6 +358,14 @@
>  			#clock-cells = <0>;
>  		};
>  
> +		rtc {
> +			compatible = "ti,palmas-rtc";
> +			interrupt-parent = <&palmas>;
> +			interrupts = <8 IRQ_TYPE_NONE>;

IRQ_TYPE_NONE is not correct here -> it should have some polarity - if
it had none, there'd be no interrupt, right?

> +			ti,backup-battery-chargeable;
> +			ti,backup-battery-charge-high-current;
> +		};
> +
>  		palmas_pmic {
>  			compatible = "ti,palmas-pmic";
>  			interrupt-parent = <&palmas>;
> 


-- 
Regards,
Nishanth Menon
