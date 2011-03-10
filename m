From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Thu, 10 Mar 2011 03:12:31 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100257480.15132@utopia.booyaka.com>
References: <1298542475-1460-1-git-send-email-manjugk@ti.com> <1298542475-1460-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41117 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab1CJKMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 05:12:32 -0500
In-Reply-To: <1298542475-1460-2-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Thu, 24 Feb 2011, G, Manjunath Kondaiah wrote:

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
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>  arch/arm/plat-omap/omap_device.c              |   64 +++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e282e35..27eb845 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1537,6 +1537,48 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
>  }
>  
>  /**
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

Please create two functions here, omap_hwmod_require_no_mstandby() and 
omap_hwmod_release_no_mstandby(), to match the two omap_device* functions.

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

This API call is presumably only valid when the hwmod is in ENABLED state, 
so please check that here.

> +
> +	v = oh->_sysc_cache;
> +	sf = oh->class->sysc->sysc_flags;
> +
> +	if (sf & SYSC_HAS_MIDLEMODE) {
> +		if (idlemode)
> +			idlemode = HWMOD_IDLEMODE_NO;
> +		else
> +			idlemode = (oh->flags & HWMOD_SWSUP_MSTANDBY) ?
> +				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;

Please don't reuse the idlemode variable.  This is confusing and can lead 
to errors...

> +	}
> +	retval = _set_master_standbymode(oh, idlemode, &v);

.. like this one, where, if !(sf & SYSC_HAS_MIDLEMODE), this code will try 
to convince the lower-level API to write either a 1 or a 0 to idlemode.

> +	if (!retval)
> +		_write_sysconfig(v, oh);
> +
> +	return retval;
> +}
> +
> +/**
>   * omap_hwmod_lookup - look up a registered omap_hwmod by name
>   * @name: name of the omap_hwmod to look up
>   *
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index e4c349f..42e0186 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -117,6 +117,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
>  int omap_device_disable_clocks(struct omap_device *od);
>  int omap_device_enable_clocks(struct omap_device *od);
>  
> +int omap_device_require_no_mstandby(struct platform_device *pdev);
> +int omap_device_release_no_mstandby(struct platform_device *pdev);
>  
>  /*
>   * Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1eee85a..8a37c6e 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -366,7 +366,7 @@ struct omap_hwmod_omap4_prcm {
>   *
>   * HWMOD_SWSUP_SIDLE: omap_hwmod code should manually bring module in and out
>   *     of idle, rather than relying on module smart-idle
> - * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module in and out
> + * HWMOD_SWSUP_MSTANDBY: omap_hwmod code should manually bring module in and out
>   *     of standby, rather than relying on module smart-standby
>   * HWMOD_INIT_NO_RESET: don't reset this module at boot - important for
>   *     SDRAM controller, etc. XXX probably belongs outside the main hwmod file
> @@ -556,6 +556,8 @@ int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
>  
>  int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
>  
> +int omap_hwmod_set_master_standbymode(struct omap_hwmod *oh, u8 idlemode);

This will also need to be updated.

> +
>  int omap_hwmod_reset(struct omap_hwmod *oh);
>  void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
>  
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 57adb27..125cbef 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -612,6 +612,70 @@ int omap_device_idle(struct platform_device *pdev)
>  }
>  
>  /**
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
> +	struct omap_hwmod *oh;
> +
> +	od = _find_by_pdev(pdev);
> +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> +		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
> +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> +		return -EINVAL;
> +	}
> +
> +	oh = *od->hwmods;
> +	for (i = 0; i < od->hwmods_cnt; i++)
> +		ret = omap_hwmod_set_master_standbymode(oh, true);

What increments oh?

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
> +	struct omap_hwmod *oh;
> +
> +	od = _find_by_pdev(pdev);
> +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> +		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
> +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> +		return -EINVAL;
> +	}
> +
> +	oh = *od->hwmods;
> +	for (i = 0; i < od->hwmods_cnt; i++)
> +		ret = omap_hwmod_set_master_standbymode(oh, false);

What increments oh?

> +
> +	return ret;
> +}
> +
> +/**
>   * omap_device_shutdown - shut down an omap_device
>   * @od: struct omap_device * to shut down
>   *
> -- 
> 1.7.1
> 


- Paul
