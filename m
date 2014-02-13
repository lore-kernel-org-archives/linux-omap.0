From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: omap3-tobi: Use the correct vendor prefix
Date: Thu, 13 Feb 2014 08:41:36 -0600
Message-ID: <52FCD9A0.1070600@ti.com>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch> <1392287116-4548-3-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45178 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaBMOmF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 09:42:05 -0500
In-Reply-To: <1392287116-4548-3-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 02/13/2014 04:25 AM, Florian Vaussard wrote:
> Gumstix is the correct vendor for all Overo related products.
> 
> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/omap3-tobi.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
> index 0e3b8bf..c742afa 100644
> --- a/arch/arm/boot/dts/omap3-tobi.dts
> +++ b/arch/arm/boot/dts/omap3-tobi.dts
> @@ -17,7 +17,7 @@
>  
>  / {
>  	model = "TI OMAP3 Gumstix Overo on Tobi";
> -	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap36xx", "ti,omap3";
> +	compatible = "gumstix,omap3-tobi", "gumstix,omap3-overo", "ti,omap36xx", "ti,omap3";
>  
>  	leds {
>  		compatible = "gpio-leds";
> 


-- 
Regards,
Nishanth Menon
