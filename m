From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Fri, 6 May 2011 14:37:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105061433190.30136@utopia.booyaka.com>
References: <1304676557-15613-1-git-send-email-govindraj.raja@ti.com> <1304676557-15613-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab1EFUh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 16:37:29 -0400
In-Reply-To: <1304676557-15613-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Hi

some comments

On Fri, 6 May 2011, Govindraj.R wrote:

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
>  arch/arm/mach-omap2/omap_hwmod.c              |   35 +++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
>  arch/arm/plat-omap/omap_device.c              |   27 +++++++++++++++++++
>  4 files changed, 64 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..97d3302 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2369,3 +2369,38 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +/**
> + * omap_hwmod_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @oh: struct omap_hwmod *
> + * @enable: based on 0 or 1 set or unset wakeup bit.
> + *
> + * Traverse through dynamic pads, if pad is enabled then
> + * set wakeup enable bit flag for the mux pin. Wakeup pad bit
> + * will be set during hwmod idle transistion.
> + * Return error if pads are not enabled or not available.
> + */
> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
> +{
> +	struct omap_device_pad *pad;
> +	int ret = -EINVAL, j;
> +	int val = 0;
> +
> +	/* Enable pin mux to make pad wake-up capable */
> +	if (enable)
> +		val = OMAP_WAKEUP_EN;
> +	else
> +		val = ~OMAP_WAKEUP_EN;

Instead of combining enable and disable into the same function, please 
create two functions, one enable function and one disable function, to 
make the code that uses this easier to understand.

Please move the code beneath into a separate, static function, shared 
between both functions.

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
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index e4c349f..ce8e3e8 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -117,6 +117,7 @@ int omap_device_enable_hwmods(struct omap_device *od);
>  int omap_device_disable_clocks(struct omap_device *od);
>  int omap_device_enable_clocks(struct omap_device *od);
>  
> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev, bool enable);
>  
>  /*
>   * Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1adea9c..b7f8d1b 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -601,6 +601,7 @@ int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
>  u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
>  int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
> +int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable);
>  
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..82fb4a6 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -742,6 +742,33 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
>  	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>  }
>  
> +/**
> + * omap_device_enable_ioring_wakeup - Set wakeup bit for iopad ring.
> + * @pdev: platform_device for which wakeup needs to be set.
> + * @enable: based on true or false set or unset ioring wakeup enable flag.
> + *
> + * Caller should ensure this is called if device_may_wakeup(dev) is true
> + * traverse through each hwmod and check each available pads
> + * if pad is enabled then set wakeup enable flag for the mux pin.
> + * Return error if pads are not enabled or not available.
> + * Wakeup enable flag will be we used during hwmod idle transistion
> + * to enable or disable wakeup capability for the pad.
> + */
> +int omap_device_enable_ioring_wakeup(struct platform_device *pdev, bool enable)

Instead of combining enable and disable into the same function, please 
create two functions, one enable function and one disable function, to 
make the code that uses this easier to understand.

> +{
> +	int ret = -EINVAL, i;
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +
> +	od = _find_by_pdev(pdev);
> +	for (i = 0; i < od->hwmods_cnt; i++) {
> +		oh = od->hwmods[i];
> +		ret = omap_hwmod_enable_ioring_wakeup(oh, enable);
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
