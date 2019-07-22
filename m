From: Teresa Remmet <t.remmet@phytec.de>
Subject: Re: [PATCH] ARM: dts: am335x-wega.dtsi: fix wrong card detect pin
 level
Date: Mon, 22 Jul 2019 10:06:05 +0200
Message-ID: <812cb14400ee43176c2118247c8c47230b9206c2.camel@phytec.de>
References: <20190709183209.y64keopah5rkismc@arbad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183209.y64keopah5rkismc@arbad>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Klinger <ak@it-klinger.de>, linux-omap@vger.kernel.org
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Andreas,

Am Dienstag, den 09.07.2019, 20:32 +0200 schrieb Andreas Klinger:
> mmc cards on mmc1 are not detected because of wrong card detect (cd)
> level.
> 
> Change cd from GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW.
> 
> This is necessary because of commit e63201f19438 ("mmc: omap_hsmmc:
> Delete platform data GPIO CD and WP")

Thanks for noticing. But the fix is already in master.

Teresa

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  arch/arm/boot/dts/am335x-wega.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-wega.dtsi
> b/arch/arm/boot/dts/am335x-wega.dtsi
> index b7d28a20341f..84581fed3d06 100644
> --- a/arch/arm/boot/dts/am335x-wega.dtsi
> +++ b/arch/arm/boot/dts/am335x-wega.dtsi
> @@ -157,7 +157,7 @@
>  	bus-width = <4>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
> -	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
>  
> -- 
> 2.11.0
> 
> 
