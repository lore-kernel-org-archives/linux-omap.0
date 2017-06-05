From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: bonegreen-wireless: add WL1835 Bluetooth device node
Date: Mon, 5 Jun 2017 10:38:03 -0500
Message-ID: <CAOCHtYh0gNH2xgU7zM9PVXitwVdv+qX5DtXkNoNhSz+SXQPANg@mail.gmail.com>
References: <20170605153621.9121-1-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170605153621.9121-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ricardo Salveti <ricardo.salveti-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Sorry, Tony, i had forgotten to include the subject in the first ARM:
dts: bonegreen-wireless: add WL1835 Bluetooth device node patch

Regards,

On Mon, Jun 5, 2017 at 10:36 AM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This adds the serial slave device for the WL1835 Bluetooth interface.
>
> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Ricardo Salveti <ricardo.salveti-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
> ---
>  arch/arm/boot/dts/am335x-bonegreen-wireless.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
> index 9d1a0fd555f3..57731f0daf10 100644
> --- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
> +++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
> @@ -97,6 +97,11 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart3_pins &bt_pins>;
>         status = "okay";
> +
> +       bluetooth {
> +               compatible = "ti,wl1835-st";
> +               enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +       };
>  };
>
>  &gpio1 {
> --
> 2.11.0
>



-- 
Robert Nelson
https://rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
