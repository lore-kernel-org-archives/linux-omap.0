From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-beagle: Fix USB host on beagle boards
 (for 3.13)
Date: Mon, 25 Nov 2013 09:50:55 -0600
Message-ID: <CAGo_u6ryFJvBwd=S9A-nJw+eoGguPj0jMOtgMiZ7mXXAbh4i+w@mail.gmail.com>
References: <1385387745-7162-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385387745-7162-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 25, 2013 at 7:55 AM, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> Beagle (rev. C4) and Beagle-XM (all revs) need VAUX2 1.8V supply
> for the USB PHY.
>
> As the generic PHY driver can't handle more than one supply
> at the moment, we configure this supply to be always on.
> This will cause a very small power impact if the USB host subsystem
> is not in use, about 76.86 micro-W + LDO power.

>
> Older Beagle boards (prior to C4) don't have VAUX2 connected anywhere,
> so there won't be any functional impact on those boards other than
> some additional LDO power consumption.
>
> Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

I might suggest though that the better alternative might be to get phy
driver to handle multiple regulators considering that DT is supposed
to represent the h/w topology.

> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 8 ++++++++
>  arch/arm/boot/dts/omap3-beagle.dts    | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> index 31a632f..b39918e 100644
> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> @@ -215,3 +215,11 @@
>  &usbhsehci {
>         phys = <0 &hsusb2_phy>;
>  };
> +
> +&vaux2 {
> +       regulator-name = "usb_1v8";
> +       regulator-min-microvolt = <1800000>;
> +       regulator-max-microvolt = <1800000>;
> +       regulator-always-on;
> +};
> +
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index fa532aa..9764556 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -178,3 +178,11 @@
>         mode = <3>;
>         power = <50>;
>  };
> +
> +&vaux2 {
> +       regulator-name = "vdd_ehci";
> +       regulator-min-microvolt = <1800000>;
> +       regulator-max-microvolt = <1800000>;
> +       regulator-always-on;
> +};
> +
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
