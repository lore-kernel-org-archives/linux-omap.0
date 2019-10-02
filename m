From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-sancloud-bbe: Fix PHY mode for ethernet
Date: Wed, 2 Oct 2019 17:48:35 +0300
Message-ID: <d027ef07-807d-6a7b-2939-b67be4542469@ti.com>
References: <20191002095416.19603-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002095416.19603-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Koen Kooi <koen@dominion.thruhere.net>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 02/10/2019 12:54, Jeroen Hofstee wrote:
> cd28d1d6e52e: ("net: phy: at803x: Disable phy delay for RGMII mode") broke
> the ethernet networking on the beaglebone enhanced.

Above commit is incorrect (by itself) and there are few more commits on top of
it, so pls. update reference to commit(s)

bb0ce4c1517d net: phy: at803x: stop switching phy delay config needlessly
6d4cd041f0af net: phy: at803x: disable delay only for RGMII mode


> 
> The board relied on the bug in the at803x driver to always enable the rx
> delay. So change the phy-mode to rgmii-id so it is enabled again.
> 
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> cc: Koen Kooi <koen@dominion.thruhere.net>
> ---
>   arch/arm/boot/dts/am335x-sancloud-bbe.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
> index 8678e6e35493..e5fdb7abb0d5 100644
> --- a/arch/arm/boot/dts/am335x-sancloud-bbe.dts
> +++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
> @@ -108,7 +108,7 @@
>   
>   &cpsw_emac0 {
>   	phy-handle = <&ethphy0>;
> -	phy-mode = "rgmii-txid";
> +	phy-mode = "rgmii-id";
>   };
>   
>   &i2c0 {
> 

-- 
Best regards,
grygorii
