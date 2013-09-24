From: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] ARM: DTS: omap3-devkit8000.dts: fix a typo
Date: Tue, 24 Sep 2013 11:35:17 +0200
Message-ID: <52415CD5.8050209@baylibre.com>
References: <1379720414-14960-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379720414-14960-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On 21/09/2013 01:40, Aaro Koskinen wrote:
> "gpmc,sync-clki-ps" is not defined/documented, it should be
> "gpmc,sync-clk-ps" instead.

Thanks for the fix. I've just applied it with a slight change in the 
subject for consistency:

ARM: dts: omap3-devkit8000: fix a typo in GMPC node

Regards,
Benoit

>
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> ---
>   arch/arm/boot/dts/omap3-devkit8000.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index 7ef2827..4665421 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -125,7 +125,7 @@
>   		nand-bus-width = <16>;
>
>   		gpmc,device-nand;
> -		gpmc,sync-clki-ps = <0>;
> +		gpmc,sync-clk-ps = <0>;
>   		gpmc,cs-on-ns = <0>;
>   		gpmc,cs-rd-off-ns = <44>;
>   		gpmc,cs-wr-off-ns = <44>;
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
