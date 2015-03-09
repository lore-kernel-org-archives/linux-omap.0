From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Mon, 09 Mar 2015 20:50:09 +0100
Message-ID: <9217056.Z3urqp19oZ@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com> <1425915402-10012-3-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425915402-10012-3-git-send-email-eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 09 March 2015 17:36:42 Eliad Peller wrote:
> --- a/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030-rev-g.dts
> @@ -64,4 +64,13 @@
>         vmmc-supply = <&lbep5clwmc_wlen>;
>         bus-width = <4>;
>         non-removable;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore@2 {
> +               compatible = "ti,wl1835";
> +               reg = <2>;
> +               interrupt-parent = <&gpio5>;
> +               interrupts = <8 IRQ_TYPE_NONE>;
> +       };
> 

Why IRQ_TYPE_NONE?

I was expecting you to remove all calls to legacy_init_wl12xx from this file,
including the ones for wl12xx aside from the wl18xx ones you removed, but
if that's enough to clean out the platform_data handling from the wlcore
driver, it's good enough as a start.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
