From: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH 04/18] ARM: am57xx: cl-som-am57x: dts: add EEPROM support
Date: Mon, 30 Nov 2015 16:23:46 +0200
Message-ID: <565C5BF2.5000601@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448433590-1399-5-git-send-email-lifshitz@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-5-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Dima,

On 11/25/15 08:39, Dmitry Lifshitz wrote:
> On-board EEPROM chip is used for storing a board production
> info.
> 
> Add module EEPROM support (over I2C4 bus).
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
>  arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> index eb9b81b..b6919a7 100644
> --- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> +++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> @@ -289,6 +289,12 @@
>  		compatible = "emmicro,em3027";
>  		reg = <0x56>;
>  	};
> +
> +	eeprom_module: atmel@50 {
> +		compatible = "atmel,24c02";

If I'm not mistaken, the eeprom should be 24c08, no?

> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
>  };
>  
>  
> 

-- 
Regards,
Igor.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
