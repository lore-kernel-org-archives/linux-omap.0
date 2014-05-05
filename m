From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv5 RFC 08/15] hwspinlock/core: add support for base id in DT
Date: Mon, 5 May 2014 15:37:20 -0500
Message-ID: <CAL_JsqJW1pqUjQ3DQrppO5n=MmpFOhCyU2zkSzA9s9TpYbq3CA@mail.gmail.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
	<1398904476-26200-9-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398904476-26200-9-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 30, 2014 at 7:34 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
> The HwSpinlock core requires a base id for registering a bank
> of hwspinlocks. This base id needs to be unique across multiple
> IP instances of a hwspinlock device, so that each hwlock can be
> represented uniquely in a system.
>
> Support has been added to represent this in DT through a common
> property 'hwlock-base-id', and retrieve the value through a core
> OF helper function, of_hwspin_lock_get_base_id(). The representation
> in DT provides a uniform way of assigning a fixed base value for a
> hwspinlock device across different SoCs.
>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/hwlock/hwlock.txt |  6 ++++++
>  drivers/hwspinlock/hwspinlock_core.c                | 21 +++++++++++++++++++++
>  include/linux/hwspinlock.h                          |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/hwlock/hwlock.txt b/Documentation/devicetree/bindings/hwlock/hwlock.txt
> index 32381cc..d538a9b 100644
> --- a/Documentation/devicetree/bindings/hwlock/hwlock.txt
> +++ b/Documentation/devicetree/bindings/hwlock/hwlock.txt
> @@ -18,6 +18,12 @@ Common properties:
>                         property is needed on hwlock devices, where the number
>                         of supported locks within a hwlock device cannot be
>                         read from a register.
> +- hwlock-base-id:      An unique base Id for the locks for a particular hwlock
> +                       device. This property is mandatory ONLY if a SoC has
> +                       several hwlock devices.
> +
> +                       See documentation on struct hwspinlock_pdata in
> +                       include/linux/hwspinlock.h for more details.

The documentation cannot refer to kernel files. Generally, creating a
global number space like this would not be accepted, but I don't
really have any better idea here.

Please put all binding docs in 1 patch and copy all the DT binding maintainers.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
