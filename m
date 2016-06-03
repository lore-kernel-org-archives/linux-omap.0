From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: am335x-bone-common: Mark MAC as having only
 one PHY
Date: Fri, 3 Jun 2016 19:47:36 +0300
Message-ID: <5751B4A8.4060706@ti.com>
References: <20160527181743.8401-1-afd@ti.com>
 <20160527181743.8401-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160527181743.8401-2-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 05/27/2016 09:17 PM, Andrew F. Davis wrote:
> Currently am33xx.dtsi declares the MAC controller to have two
> slave ports, on these boards we only use one, so set the slave
> count to one. This eliminates a console error message when
> the non-existent PHY is not detected.
>
> Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/am335x-bone-common.dtsi | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 0cc150b..8767bbe 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -359,12 +359,8 @@
>   	phy-mode = "mii";
>   };
>
> -&cpsw_emac1 {
> -	phy_id = <&davinci_mdio>, <1>;
> -	phy-mode = "mii";
> -};
> -
>   &mac {
> +	slaves = <1>;
>   	pinctrl-names = "default", "sleep";
>   	pinctrl-0 = <&cpsw_default>;
>   	pinctrl-1 = <&cpsw_sleep>;
>

Reviewed-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
