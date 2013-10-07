From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: omap3-igep: Add USB OTG support
Date: Mon, 7 Oct 2013 20:10:23 +0300
Message-ID: <5252EAFF.1090505@ti.com>
References: <1381158745-9557-1-git-send-email-javier.martinez@collabora.co.uk> <1381158745-9557-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495Ab3JGRKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 13:10:32 -0400
In-Reply-To: <1381158745-9557-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On 10/07/2013 06:12 PM, Javier Martinez Canillas wrote:
> Commit ad871c10b ("ARM: dts: OMAP: Add usb_otg and glue data to O
> added USB OTG support for most OMAP boards but some OMAP3 boards
> such as IGEP boards were not updated. This patch adds an USB OTG
> device node to these board.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

> ---
> 
> Changes since v2:
>  - Add phys and phy-names properties as required by the new
>    generic PHY framework; suggested by Roger Quadros
> 
> Changes since v1:
>  - Add USB OTG support for both IGEPv2 and IGEP COM and not only to IGEPv2 
> 
>  arch/arm/boot/dts/omap3-igep.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index 0f92224..ba1e58b 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -143,3 +143,12 @@
>  &twl_gpio {
>  	ti,use-leds;
>  };
> +
> +&usb_otg_hs {
> +	interface-type = <0>;
> +	usb-phy = <&usb2_phy>;
> +	phys = <&usb2_phy>;
> +	phy-names = "usb2-phy";
> +	mode = <3>;
> +	power = <50>;
> +};
> 

