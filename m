From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iio: enable selection and build of pulse drivers
Date: Sat, 15 Feb 2014 11:41:40 +0000
Message-ID: <52FF5274.5060408@kernel.org>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org> <1391626901-31684-4-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391626901-31684-4-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux IIO List <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 05/02/14 19:01, Matt Porter wrote:
> Add the pulse driver subdirectory when configuring and building
> IIO.
>
> Signed-off-by: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Hi Matt,

This wants rolling into the driver patch before it.  No point it giving it
it's own patch.  This will just lead to confusion on git bisections etc.


Jonathan
> ---
>   drivers/iio/Kconfig  | 1 +
>   drivers/iio/Makefile | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 5dd0e12..286acc3 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -74,6 +74,7 @@ if IIO_TRIGGER
>      source "drivers/iio/trigger/Kconfig"
>   endif #IIO_TRIGGER
>   source "drivers/iio/pressure/Kconfig"
> +source "drivers/iio/pulse/Kconfig"
>   source "drivers/iio/temperature/Kconfig"
>
>   endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 887d390..9a953c9 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -24,5 +24,6 @@ obj-y += light/
>   obj-y += magnetometer/
>   obj-y += orientation/
>   obj-y += pressure/
> +obj-y += pulse/
>   obj-y += temperature/
>   obj-y += trigger/
>
