From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 01:28:17 +0100
Message-ID: <CABxcv=kL3Hw43VVxAsZ=DnY4Z+5431PO2YehcK2zTkFGBG0cNA@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
	<1425915402-10012-3-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425915402-10012-3-git-send-email-eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Eliad,

On Mon, Mar 9, 2015 at 4:36 PM, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:
> Add wl18xx (wilink8) bindings to omap3-igep0030-rev-g and
> omap3-igep0020-rev-f dts files, instead of defining the
> platform data through the pdata-quirks.
>
> The patch was compile-tested only.
>

You should look at MAINTAINERS or use ./scripts/get_maintainer.pl to
know who should be cc'ed. Specially for this kind of patches where you
are not able to test on the actual platform. Added Enric to cc as well
since he also maintains the IGEP boards an has access to the hw too.

> Signed-off-by: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 9 +++++++++
>  arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 9 +++++++++
>  arch/arm/mach-omap2/pdata-quirks.c         | 2 --
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> index cc8bd0c..8e5b44e 100644
> --- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
> @@ -42,4 +42,13 @@
>         vmmc-supply = <&lbep5clwmc_wlen>;
>         bus-width = <4>;
>         non-removable;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore@2 {
> +               compatible = "ti,wl1835";
> +               reg = <2>;
> +               interrupt-parent = <&gpio6>;
> +               interrupts = <17 IRQ_TYPE_NONE>;

As Arnd said, it seems this should be IRQ_TYPE_LEVEL_HIGH to match
what the platform code is currently doing.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
