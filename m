From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/9] regulator: lp873x: Add support for populating
 input supply
Date: Sun, 30 Oct 2016 15:41:18 -0500
Message-ID: <20161030204118.ojeetnxl5qsi6lp7@rob-hp-laptop>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <20161021103841.8044-5-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161021103841.8044-5-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 21, 2016 at 04:08:36PM +0530, Lokesh Vutla wrote:
> In order to have a proper topology of regulators for a platform, each
> registering regulator needs to populate supply_name field for identifying
> its supply's name. Add supply_name field for lp873x regulators.
> 
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
>  drivers/regulator/lp873x-regulator.c             | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
> index 52766c2..998837a 100644
> --- a/Documentation/devicetree/bindings/mfd/lp873x.txt
> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
> @@ -7,6 +7,9 @@ Required properties:
>    - #gpio-cells:	Should be two.  The first cell is the pin number and
>  			the second cell is used to specify flags.
>  			See ../gpio/gpio.txt for more information.
> +  - xxx-in-supply:	Phandle to parent supply node of each regulator
> +			populated under regulators node. xxx should match
> +			the supply_name populated in driver.

The driver is irrelevant. This should reference a list in this document.

>    - regulators:	List of child nodes that specify the regulator
>  			initialization data.
>  Example:
> @@ -17,6 +20,11 @@ pmic: lp8733@60 {
>  	gpio-controller;
>  	#gpio-cells = <2>;
>  
> +	buck0-in-supply = <&vsys_3v3>;
> +	buck1-in-supply = <&vsys_3v3>;
> +	ldo0-in-supply = <&vsys_3v3>;
> +	ldo1-in-supply = <&vsys_3v3>;
> +
>  	regulators {
>  		lp8733_buck0: buck0 {
>  			regulator-name = "lp8733-buck0";
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
