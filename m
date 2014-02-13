From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: omap3-tobi: Fix boot with OMAP36xx-based
 Overo
Date: Thu, 13 Feb 2014 08:41:22 -0600
Message-ID: <52FCD992.3080100@ti.com>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch> <1392287116-4548-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbaBMOlv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 09:41:51 -0500
In-Reply-To: <1392287116-4548-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 02/13/2014 04:25 AM, Florian Vaussard wrote:
> Tobi expansion board can be used with both OMAP35xx-based Overo,
> and OMAP36xx-based Overo. Currently the boot is broken with newer
> OMAP36xx-based Overo (Storm and alike). Fix include file and
> compatible string to be able to boot newer models.
> 
> This will break older models. This will be addressed later.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> Tested-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/omap3-overo.dtsi | 3 ---
>  arch/arm/boot/dts/omap3-tobi.dts   | 5 ++++-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
> index a461d2f..5970999 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -9,9 +9,6 @@
>  /*
>   * The Gumstix Overo must be combined with an expansion board.
>   */
> -/dts-v1/;
> -
> -#include "omap34xx.dtsi"
>  
>  / {
>  	pwmleds {
> diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
> index 7e4ad2a..0e3b8bf 100644
> --- a/arch/arm/boot/dts/omap3-tobi.dts
> +++ b/arch/arm/boot/dts/omap3-tobi.dts
> @@ -10,11 +10,14 @@
>   * Tobi expansion board is manufactured by Gumstix Inc.
>   */
>  
> +/dts-v1/;
> +
> +#include "omap36xx.dtsi"
>  #include "omap3-overo.dtsi"
>  
>  / {
>  	model = "TI OMAP3 Gumstix Overo on Tobi";
> -	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap3";
> +	compatible = "ti,omap3-tobi", "ti,omap3-overo", "ti,omap36xx", "ti,omap3";
>  
>  	leds {
>  		compatible = "gpio-leds";
> 


-- 
Regards,
Nishanth Menon
