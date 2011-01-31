From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 19/23] arm: Fix possible null pointer read access
Date: Mon, 31 Jan 2011 08:26:26 -0800
Message-ID: <87tygp82fh.fsf@ti.com>
References: <1296415778-4638-1-git-send-email-weil@mail.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296415778-4638-1-git-send-email-weil@mail.berlios.de> (Stefan
	Weil's message of "Sun, 30 Jan 2011 20:29:38 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Weil <weil@mail.berlios.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Stefan Weil <weil@mail.berlios.de> writes:

> These errors were found by cppcheck:
> arch/arm/mach-omap2/smartreflex.c:784: error: Possible null pointer dereference: sr_info
> arch/arm/mach-omap2/smartreflex.c:799: error: Possible null pointer dereference: sr_info
>
> Both conditional statements are executed when sr_info == NULL,
> so accessing sr_info->voltdm would fail.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Weil <weil@mail.berlios.de>

Thanks, queuing for 2.6.38-rc in my pm-fixes branch.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 77ecebf..af39d17 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -780,8 +780,7 @@ static int omap_sr_autocomp_show(void *data, u64 *val)
>  	struct omap_sr *sr_info = (struct omap_sr *) data;
>
>  	if (!sr_info) {
> -		pr_warning("%s: omap_sr struct for sr_%s not found\n",
> -			__func__, sr_info->voltdm->name);
> +		pr_warning("%s: omap_sr struct not found\n", __func__);
>  		return -EINVAL;
>  	}
>
> @@ -795,8 +794,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
>  	struct omap_sr *sr_info = (struct omap_sr *) data;
>
>  	if (!sr_info) {
> -		pr_warning("%s: omap_sr struct for sr_%s not found\n",
> -			__func__, sr_info->voltdm->name);
> +		pr_warning("%s: omap_sr struct not found\n", __func__);
>  		return -EINVAL;
>  	}
>
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
