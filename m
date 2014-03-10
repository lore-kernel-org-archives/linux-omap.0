From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/8] ARM: dts: dra7: Initialize USB_DPLL
Date: Mon, 10 Mar 2014 15:28:35 +0200
Message-ID: <531DBE03.2070603@ti.com>
References: <1394197751-28984-2-git-send-email-rogerq@ti.com> <1394455761-19226-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394455761-19226-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 03/10/2014 02:49 PM, Roger Quadros wrote:
> USB_DPLL must be initialized and locked at boot so that
> USB modules can work.
>
> Program USB_DLL_M2 output to half rate as well.
>
> Patch depends on
> https://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg101300.html
>
> CC: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/dra7.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 597979b..f376923 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -815,3 +815,11 @@
>   };
>
>   /include/ "dra7xx-clocks.dtsi"
> +
> +&dpll_usb_ck {
> +        default-rate = <960000000>;
> +};
> +
> +&dpll_usb_m2_ck {
> +	default-rate = <480000000>;
> +};
>

You can add these directly under the dra7xx-clocks.dtsi file as well, as 
I don't think anybody needs to modify these. And the properties can be 
added directly under the nodes themselves.

However, this patch can't be acked yet as we have no feedback from Mike 
for the default-rate proposal.

-Tero

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
