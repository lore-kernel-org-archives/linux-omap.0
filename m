From: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-igep0020: Use MMC pwrseq to init SDIO WiFi
Date: Fri, 4 Dec 2015 15:36:52 +0100
Message-ID: <CAFqH_50v7gkxWqwVMLtwn9g5WTRF7k16_r1Xaztt3GC4wO9wiA@mail.gmail.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
	<1449165729-993-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449165729-993-2-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2015-12-03 19:02 GMT+01:00 Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>:
> When the WiFi support was added to the IGEP0020 board, the MMC subsystem
> did not provide a mechanism to define power sequence providers. So a DT
> hack was used to toggle the WiFi chip reset and power down pins by using
> fake fixed regulators whose enable GPIO was the GPIOs connected to these
> pins.
>
> But now the simple MMC power sequence provider can be used for this and
> the workaround removed.
>
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
> ---
>
>  arch/arm/boot/dts/omap3-igep0020.dts | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
> index 3835e1569c29..33d6b4ead092 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -15,25 +15,17 @@
>         model = "IGEPv2 Rev. C (TI OMAP AM/DM37x)";
>         compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
>
> -       /* Regulator to trigger the WIFI_PDN signal of the Wifi module */
> -       lbee1usjyc_pdn: lbee1usjyc_pdn {
> +       vmmcsdio_fixed: fixedregulator-mmcsdio {
>                 compatible = "regulator-fixed";
> -               regulator-name = "regulator-lbee1usjyc-pdn";
> +               regulator-name = "vmmcsdio_fixed";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
> -               gpio = <&gpio5 10 GPIO_ACTIVE_HIGH>;    /* gpio_138 - WIFI_PDN */
> -               startup-delay-us = <10000>;
> -               enable-active-high;
>         };
>
> -       /* Regulator to trigger the RESET_N_W signal of the Wifi module */
> -       lbee1usjyc_reset_n_w: lbee1usjyc_reset_n_w {
> -               compatible = "regulator-fixed";
> -               regulator-name = "regulator-lbee1usjyc-reset-n-w";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -               gpio = <&gpio5 11 GPIO_ACTIVE_HIGH>;    /* gpio_139 - RESET_N_W */
> -               enable-active-high;
> +       mmc2_pwrseq: mmc2_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>,      /* gpio_139 - RESET_N_W */
> +                             <&gpio5 10 GPIO_ACTIVE_LOW>;      /* gpio_138 - WIFI_PDN */
>         };
>  };
>
> @@ -51,8 +43,8 @@
>  &mmc2 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc2_pins &lbee1usjyc_pins>;
> -       vmmc-supply = <&lbee1usjyc_pdn>;
> -       vmmc_aux-supply = <&lbee1usjyc_reset_n_w>;
> +       vmmc-supply = <&vmmcsdio_fixed>;
> +       mmc-pwrseq = <&mmc2_pwrseq>;
>         bus-width = <4>;
>         non-removable;
>  };
> --
> 2.4.3
>

I also tested these patches

Acked-by: Enric Balletbo Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
