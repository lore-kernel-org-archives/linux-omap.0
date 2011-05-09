From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2 v2] OMAP2+: hwmod: Add API to enable IO ring
 wakeup.
Date: Mon, 9 May 2011 08:48:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105090845480.19521@utopia.booyaka.com>
References: <1304944530-12998-1-git-send-email-govindraj.raja@ti.com> <1304944530-12998-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49350 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab1EIOsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 10:48:03 -0400
In-Reply-To: <1304944530-12998-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Todd Poynor <toddpoynor@google.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hello Govindraj

On Mon, 9 May 2011, Govindraj.R wrote:

> Add API to enable IO pad wakeup capability based on mux dynamic pad and
> wake_up enable flag available from hwmod_mux initialization.
> 
> Use the wakeup_enable flag and enable wakeup capability
> for the given pads. Wakeup capability will be enabled/disabled
> during hmwod idle transition based on whether wakeup_flag is
> set or cleared.
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   51 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 +
>  arch/arm/plat-omap/omap_device.c              |   50 ++++++++++++++++++++++++
>  4 files changed, 106 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..bbbe1ed 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2369,3 +2369,54 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +static int omap_hwmod_configure_ioring_wakeup(struct omap_hwmod *oh, u16 val)

What about Todd's comments?

If this function is still valid after considering those comments -- 
perhaps by adding a 'mask' argument -- then lease change this function's 
name to simply _set_ioring_wakeup() and move it up towards the top of the 
file with the rest of the static functions.

> +{
> +	struct omap_device_pad *pad;
> +	int ret = -EINVAL, j;
> +
> +	if (oh->mux->enabled) {
> +		for (j = 0; j < oh->mux->nr_pads_dynamic; j++) {
> +			pad = oh->mux->pads_dynamic[j];
> +			if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
> +				pad->idle = pad->enable | val;
> +				ret = 0;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * omap_hwmod_enable_ioring_wakeup - Set wakeup flag for iopad.
> + * @oh: struct omap_hwmod *
> + *
> + * Traverse through dynamic pads, if pad is enabled then
> + * set wakeup enable bit flag for the mux pin. Wakeup pad bit
> + * will be set during hwmod idle transistion.
> + * Return error if pads are not enabled or not available.
> + */
> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh)
> +{
> +	/* Enable pad wake-up capability */
> +	return omap_hwmod_configure_ioring_wakeup(oh, OMAP_WAKEUP_EN);
> +}
> +
> +/**
> + * omap_hwmod_disable_ioring_wakeup - Clear wakeup flag for iopad.
> + * @oh: struct omap_hwmod *
> + *
> + * Traverse through dynamic pads, if pad is enabled then
> + * clear wakeup enable bit flag for the mux pin. Wakeup pad bit
> + * will be set during hwmod idle transistion.
> + * Return error if pads are not enabled or not available.
> + */
> +int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh)
> +{
> +	u16 val = 0;
> +
> +	/* Disable pad wakeup capability */
> +	val &= ~OMAP_WAKEUP_EN;
> +	return omap_hwmod_configure_ioring_wakeup(oh, val);
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index e4c349f..a377dd0 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -117,6 +117,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
>  int omap_device_disable_clocks(struct omap_device *od);
>  int omap_device_enable_clocks(struct omap_device *od);
>  
> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev);
> +int omap_device_disable_ioring_wakeup(struct platform_device *pdev);
>  
>  /*
>   * Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1adea9c..7ef11a6 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -602,6 +602,9 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
>  int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>  
> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh);
> +int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh);
> +
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
>   * to use initcalls once the initial boot ordering is straightened out
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..04a4f15 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -742,6 +742,56 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
>  	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>  }
>  
> +/**
> + * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @pdev: platform_device for which wakeup needs to be set.
> + *
> + * Caller should ensure this is called if device_may_wakeup(dev) is true
> + * traverse through each hwmod and check each available pads
> + * if pad is enabled then set wakeup enable flag for the mux pin.
> + * Return error if pads are not enabled or not available.
> + * Wakeup enable flag will be we used during hwmod idle transistion.
> + */
> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev)
> +{
> +	int ret = -EINVAL, i;
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +
> +	od = _find_by_pdev(pdev);
> +	for (i = 0; i < od->hwmods_cnt; i++) {
> +		oh = od->hwmods[i];
> +		ret = omap_hwmod_enable_ioring_wakeup(oh);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * omap_device_disable_ioring_wakeup - Clear wakeup bit for iopad ring.
> + * @pdev: platform_device for which wakeup needs to be cleared.
> + *
> + * Caller should ensure this is called if device_may_wakeup(dev) is false
> + * traverse through each hwmod and check each available pads
> + * if pad is enabled then clear wakeup enable flag for the mux pin.
> + * Return error if pads are not enabled or not available.
> + * Wakeup enable flag will be we used during hwmod idle transistion.
> + */
> +int omap_device_disable_ioring_wakeup(struct platform_device *pdev)
> +{
> +	int ret = -EINVAL, i;
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +
> +	od = _find_by_pdev(pdev);
> +	for (i = 0; i < od->hwmods_cnt; i++) {
> +		oh = od->hwmods[i];
> +		ret = omap_hwmod_disable_ioring_wakeup(oh);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * Public functions intended for use in omap_device_pm_latency
>   * .activate_func and .deactivate_func function pointers
> -- 
> 1.7.1
> 


- Paul
