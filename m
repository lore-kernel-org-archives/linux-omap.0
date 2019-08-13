From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-wega.dtsi: fix wrong card detect pin
 level
Date: Tue, 13 Aug 2019 03:17:19 -0700
Message-ID: <20190813101719.GG52127@atomide.com>
References: <20190709183209.y64keopah5rkismc@arbad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190709183209.y64keopah5rkismc@arbad>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Klinger <ak@it-klinger.de>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andreas Klinger <ak@it-klinger.de> [190709 11:32]:
> mmc cards on mmc1 are not detected because of wrong card detect (cd) level.
> 
> Change cd from GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW.
> 
> This is necessary because of commit e63201f19438 ("mmc: omap_hsmmc:
> Delete platform data GPIO CD and WP")
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  arch/arm/boot/dts/am335x-wega.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
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

Looks like this already got fixed with an earlier commit 8a0098c05a27
("ARM: dts: am335x phytec boards: Fix cd-gpios active level").

Regards,

Tony
