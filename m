From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for Overo
Date: Mon, 10 Sep 2012 15:25:34 +0200
Message-ID: <504DEA4E.7080109@ti.com>
References: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch>
 <1347282996-31190-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1347282996-31190-2-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Steve Sakoman <steve-4Uf0gMDude1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/10/2012 03:16 PM, Florian Vaussard wrote:
> Support the blue LED connected to the LEDB pin of the TWL4030
> on the Gumstix Overo.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-overo.dtsi |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
> index d6cc5e2..89808ce 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -13,6 +13,17 @@
>  
>  /include/ "omap3.dtsi"
>  
> +/ {

BTW, I'm just wondering. Cannot we use overo without tobi?

In that case, the model and compatible should probably be used as well:

	model = "TI OMAP3 Gumstix Overo";
	compatible = "ti,omap3-overo", "ti,omap3";


> +	leds {
> +		compatible = "gpio-leds";
> +		overo {
> +			label = "overo:blue:COM";
> +			gpios = <&twl_gpio 19 0>;
> +			linux,default-trigger = "mmc0";
> +		};
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <2600000>;
>  
> @@ -40,3 +51,7 @@
>  &mmc2 {
>  	bus-width = <4>;
>  };
> +
> +&twl_gpio {
> +	ti,use-leds;
> +};
> 

Otherwise, it is fine.

Thanks,
Benoit
