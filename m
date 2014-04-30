From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: DTS: omap54xx-clocks: Correct abe_iclk clock
 node
Date: Wed, 30 Apr 2014 15:31:38 +0300
Message-ID: <5360ED2A.5070605@ti.com>
References: <1398858096-32144-1-git-send-email-peter.ujfalusi@ti.com> <1398858096-32144-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398858096-32144-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/30/2014 02:41 PM, Peter Ujfalusi wrote:
> abe_iclk's parent is aess_fclk and not abe_clk.
> Also correct the parameters for clock rate calculation as used for OMAP4
> since in PRCM level there's no difference between the two platform
> regarding to AESS/ABE clocking.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Acked-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>

> ---
>   arch/arm/boot/dts/omap54xx-clocks.dtsi | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
> index d784ff5d3904..86fc507a0567 100644
> --- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
> @@ -143,10 +143,11 @@
>
>   	abe_iclk: abe_iclk {
>   		#clock-cells = <0>;
> -		compatible = "fixed-factor-clock";
> -		clocks = <&abe_clk>;
> -		clock-mult = <1>;
> -		clock-div = <2>;
> +		compatible = "ti,divider-clock";
> +		clocks = <&aess_fclk>;
> +		ti,bit-shift = <24>;
> +		reg = <0x0528>;
> +		ti,dividers = <2>, <1>;
>   	};
>
>   	abe_lp_clk_div: abe_lp_clk_div {
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
