From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: am437x-idk-evm: Mark MAC as having only one
 PHY
Date: Fri, 3 Jun 2016 19:47:23 +0300
Message-ID: <5751B49B.1000508@ti.com>
References: <20160527181743.8401-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160527181743.8401-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/27/2016 09:17 PM, Andrew F. Davis wrote:
> Currently am4372.dtsi declares the MAC controller to have two
> slave ports, on this board we only use one, so set the slave
> count to one. This eliminates a console error message when
> the non-existent PHY is not detected.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>   arch/arm/boot/dts/am437x-idk-evm.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
> index 76dcfc6..12a6951 100644
> --- a/arch/arm/boot/dts/am437x-idk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-idk-evm.dts
> @@ -382,6 +382,7 @@
>   };
>
>   &mac {
> +	slaves = <1>;
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&cpsw_default>;
>   	pinctrl-1 = <&cpsw_sleep>;
>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
