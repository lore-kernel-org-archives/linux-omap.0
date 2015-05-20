From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Fix WLAN interrupt line for AM335x EVM-SK
Date: Wed, 20 May 2015 09:52:23 -0700
Message-ID: <20150520165223.GW10274@atomide.com>
References: <1431502655-23255-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52446 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736AbbETQwZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 12:52:25 -0400
Content-Disposition: inline
In-Reply-To: <1431502655-23255-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Romain Izard <romain.izard.pro@gmail.com> [150513 00:39]:
> While Sitara AM335x SoCs are very close to OMAP SoCs, the 32-line GPIO
> controllers are numbered from 0 on AM335x and from 1 on OMAP. But when
> the configuration for the TI WLAN controllers was converted from
> platform data to device tree, this detail was overlooked, as 10 boards
> were using OMAP with the WL12xx and WL18xx controllers, and only one
> was based on AM335x.
> 
> This invalid configuration prevents the WL1271 module on the AM335x
> EVM-SK from notifying interrupts to the SoC, and breaks the wlan driver.
> 
> The DTS must be corrected to use the correct GPIO controller.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-evmsk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index 87fc7a35e802..156d05efcb70 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -654,7 +654,7 @@
>  	wlcore: wlcore@2 {
>  		compatible = "ti,wl1271";
>  		reg = <2>;
> -		interrupt-parent = <&gpio1>;
> +		interrupt-parent = <&gpio0>;
>  		interrupts = <31 IRQ_TYPE_LEVEL_HIGH>; /* gpio 31 */
>  		ref-clock-frequency = <38400000>;
>  	};

Applying into omap-for-v4.1/fixes thanks.

Tony
