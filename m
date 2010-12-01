From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH v6] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Wed, 01 Dec 2010 22:16:44 +0200
Message-ID: <4CF6AD2C.4020907@nokia.com>
References: <1291229228-4438-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:21666 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab0LAURC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 15:17:02 -0500
In-Reply-To: <1291229228-4438-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 01/12/10 20:47, ext G, Manjunath Kondaiah wrote:
> Certain errata in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
>
> Since current implementation of PM run time framework does not support
> changing sysconfig settings during middle of the on going operation,
> these API's will support the same. One API will force the device's
> sysconfig mstandby mode settings to "no standby" and other API will
> release "no standby" mode and sets it to "smart standby" or "no
> standby? depending on HWMOD_SWSUP_MSTANDBY value.
>
> These API's should be used by device drivers only incase of
> erratum applicable to their modules if there is no other methods
> to resolve.
>
> These API's are required for multiple DMA errata which require
> putting DMA controller in no mstandby mode before stopping dma.
>
> The applicable errata:
> 1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
>
> 2. Erratum ID: i541
> sDMA FIFO draining does not finish. Applicable to all omap2+ except
> omap4.
>
> 3. Erratum ID:i88
> The sDMA to be put in no mstandby mode before disabling the channel
> after completing the data transfer operation.
> Applicable only for OMAP3430 ES1.0
>
> Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> omap_hwmod.h
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> Cc: Kevin Hilman<khilman@deeprootsystems.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: linux-arm-kernel@lists.infradead.org
>
> ---
> Change summary:
> v3: Review comments incorporated for:
> https://patchwork.kernel.org/patch/282212/
> v4: added mutex changes
> v5: typo fixes for errata and erratum
> v6: fixed oh increment bug and also mutex(missing in v5)
>
>   arch/arm/mach-omap2/omap_hwmod.c              |   47 +++++++++++++++++++-
>   arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>   arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>   arch/arm/plat-omap/omap_device.c              |   60 +++++++++++++++++++++++++
>   4 files changed, 111 insertions(+), 2 deletions(-)
>

Does not seem to handle overlapping requests to set/clear
midle mode.

Also, there is a mutex but don't these functions get called
sometimes in interrupt context?


> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5a30658..023bca9 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1427,6 +1427,52 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
>   }
>
>   /**
> + * omap_hwmod_set_master_standbymode - set the hwmod's OCP mstandby mode
> + * @oh: struct omap_hwmod *
> + * @midlemode: flag to set mstandby to either "no standby" or "smart standby"
> + *
> + * Sets the IP block's OCP mstandby mode in hardware, and updates our
> + * local copy.  Intended to be used by drivers that have some erratum
> + * that requires direct manipulation of the MIDLEMODE bits.  Returns
> + * -EINVAL if @oh is null, or passes along the return value from
> + * _set_master_standbymode().
> + *
> + * Any users of this function should be scrutinized carefully.
> + */
> +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode)
> +{
> +	u32 v;
> +	u8 sf;
> +	int retval = 0;
> +
> +	if (!oh)
> +		return -EINVAL;
> +
> +	if (!oh->class->sysc)
> +		return -EINVAL;
> +
> +	mutex_lock(&omap_hwmod_mutex);
> +
> +	v = oh->_sysc_cache;
> +	sf = oh->class->sysc->sysc_flags;
> +
> +	if (sf&  SYSC_HAS_MIDLEMODE) {
> +		if (idlemode)
> +			idlemode = HWMOD_IDLEMODE_NO;
> +		else
> +			idlemode = (oh->flags&  HWMOD_SWSUP_MSTANDBY) ?
> +				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> +	}
> +	retval = _set_master_standbymode(oh, idlemode,&v);
> +	if (!retval)
> +		_write_sysconfig(v, oh);
> +
> +	mutex_unlock(&omap_hwmod_mutex);
> +
> +	return retval;
> +}
> +
> +/**
>    * omap_hwmod_register - register a struct omap_hwmod
>    * @oh: struct omap_hwmod *
>    *
> @@ -2116,4 +2162,3 @@ int omap_hwmod_for_each_by_class(const char *classname,
>
>   	return ret;
>   }
> -
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 28e2d1a..4fbf7c1 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -116,6 +116,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
>   int omap_device_disable_clocks(struct omap_device *od);
>   int omap_device_enable_clocks(struct omap_device *od);
>
> +int omap_device_require_no_mstandby(struct platform_device *pdev);
> +int omap_device_release_no_mstandby(struct platform_device *pdev);
>
>   /*
>    * Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 7eaa8ed..c7ff65a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -354,7 +354,7 @@ struct omap_hwmod_omap4_prcm {
>    *
>    * HWMOD_SWSUP_SIDLE: omap_hwmod code should manually bring module in and out
>    *     of idle, rather than relying on module smart-idle
> - * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module in and out
> + * HWMOD_SWSUP_MSTANDBY: omap_hwmod code should manually bring module in and out
>    *     of standby, rather than relying on module smart-standby
>    * HWMOD_INIT_NO_RESET: don't reset this module at boot - important for
>    *     SDRAM controller, etc.
> @@ -526,6 +526,8 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
>
>   int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
>
> +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode);
> +
>   int omap_hwmod_reset(struct omap_hwmod *oh);
>   void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
>
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index abe933c..2d42ab2 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -584,6 +584,66 @@ int omap_device_idle(struct platform_device *pdev)
>   }
>
>   /**
> + * omap_device_require_no_mstandby - set no mstandby mode of an omap_device
> + * @od: struct omap_device * to idle
> + *
> + * Sets the IP block's OCP master standby to no mstandby mode in hardware.
> + *
> + * Intended to be used by drivers that have some erratum that requires direct
> + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> + * omap_device is not currently enabled or passes along the return value
> + * of omap_hwmod_set_master_standbymode().
> + */
> +int omap_device_require_no_mstandby(struct platform_device *pdev)
> +{
> +	int ret  = 0, i;
> +	struct omap_device *od;
> +
> +	od = _find_by_pdev(pdev);
> +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> +		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
> +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		ret = omap_hwmod_set_master_standbymode(od->hwmods[i], true);
> +
> +	return ret;
> +}
> +
> +/**
> + * omap_device_release_no_mstandby - releases no mstandby mode of an omap_device
> + * @od: struct omap_device * to idle
> + *
> + * Release no mstandby mode and sets the master standby to either no standby or
> + * smart standby in IP block's OCP in hardware depending on status of the flag
> + * HWMOD_SWSUP_MSTANDBY.
> + *
> + * Intended to be used by drivers that have some erratum that requires direct
> + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> + * omap_device is not currently enabled or passes along the return value
> + * of omap_hwmod_set_master_standbymode().
> + */
> +int omap_device_release_no_mstandby(struct platform_device *pdev)
> +{
> +	int ret  = 0, i;
> +	struct omap_device *od;
> +
> +	od = _find_by_pdev(pdev);
> +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> +		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
> +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i<  od->hwmods_cnt; i++)
> +		ret = omap_hwmod_set_master_standbymode(od->hwmods[i], false);
> +
> +	return ret;
> +}
> +
> +/**
>    * omap_device_shutdown - shut down an omap_device
>    * @od: struct omap_device * to shut down
>    *

