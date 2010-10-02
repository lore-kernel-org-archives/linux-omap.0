From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] OMAP2plus: PM: omap_device: API for set/get MIDLE mode
Date: Sat, 2 Oct 2010 09:27:29 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C5B2@dbde02.ent.ti.com>
References: <1285990750-10117-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39962 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab0JBD5j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 23:57:39 -0400
In-Reply-To: <1285990750-10117-1-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>


FYI,
This API is required for multiple DMA errata's which require
putting DMA controller in no mstandby mode before stopping dma.

The applicable errata's:
1. Errata ID: i557(Applicable for omap36xx all ES versions)
The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared 
through config port while in Standby.

2. Errata ID: i541(all omap2plus except omap4)
sDMA FIFO draining does not finish
Peter has posted patch for this errata
https://patchwork.kernel.org/patch/224132/

3. Errata ID: i88(only omap3430 ES1.0)
Special programming model needed to disable DMA before end
of block

-Manjunath

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G, 
> Manjunath Kondaiah
> Sent: Saturday, October 02, 2010 9:09 AM
> To: linux-omap@vger.kernel.org
> Cc: Kevin Hilman; Paul Walmsley
> Subject: [PATCH] OMAP2plus: PM: omap_device: API for set/get 
> MIDLE mode
> 
> Certain errata's in OMAP2plus processors will require 
> disabling master standby mode before completing on going 
> operation. Without this, the results will be unpredictable.
> Ex: OMAP3430 ES1.0(Errata ID:i88) will require DMA to be put 
> in no mstandby mode before disabling the channel after 
> completing the data transfer operation.
> 
> Since current implementation of PM run time framework does 
> not support changing sysconfig settings during middle of the 
> on going operation, these API's will support the same.
> 
> These API's should be used by device drivers only incase of 
> erratum applicable to their modules if there is no other 
> methods to resolve.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   83 
> ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
>  arch/arm/plat-omap/omap_device.c             |   36 +++++++++++
>  3 files changed, 122 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c 
> b/arch/arm/mach-omap2/omap_hwmod.c
> index 955861a..4f638fe 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -250,6 +250,35 @@ static int 
> _set_master_standbymode(struct omap_hwmod *oh, u8 standbymode,  }
>  
>  /**
> + * _get_master_standbymode: get the OCP_SYSCONFIG MIDLEMODE field in 
> +@midlemode
> + * @oh: struct omap_hwmod *
> + * @standbymode: pointer to get mstandby mode bits(shifted to bit 0)
> + *
> + * Get the master standby mode bits in @midlemode for the @oh hwmod.
> + * Does not fetch the data from the hardware instead returns value
> + * from sysc_cache. Returns -EINVAL upon error or 0 upon success.
> + */
> +static int _get_master_standbymode(struct omap_hwmod *oh, u32 
> +*midlemode) {
> +	u32 mstandby_mask;
> +	u8 mstandby_shift;
> +
> +	if (!oh->class->sysc ||
> +	    !(oh->class->sysc->sysc_flags & SYSC_HAS_MIDLEMODE))
> +		return -EINVAL;
> +
> +	if (!oh->class->sysc->sysc_fields) {
> +		WARN(1, "omap_hwmod: %s: offset struct for 
> sysconfig not"
> +					" provided in class\n", 
> oh->name);
> +		return -EINVAL;
> +	}
> +
> +	*midlemode = ((oh->_sysc_cache) & mstandby_mask) >> 
> mstandby_shift;
> +
> +	return 0;
> +}
> +
> +/**
>   * _set_slave_idlemode: set the OCP_SYSCONFIG SIDLEMODE field in @v
>   * @oh: struct omap_hwmod *
>   * @idlemode: SIDLEMODE field bits
> @@ -1421,6 +1450,60 @@ int 
> omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)  }
>  
>  /**
> + * omap_hwmod_set_master_idlemode - set the hwmod's OCP 
> master idlemode
> + * @oh: struct omap_hwmod *
> + * @idlemode: SIDLEMODE field bits (shifted to bit 0)
> + *
> + * Sets the IP block's OCP master idlemode in hardware, and 
> updates our
> + * local copy.  Intended to be used by drivers that have some erratum
> + * that requires direct manipulation of the MIDLEMODE bits.  Returns
> + * -EINVAL if @oh is null, or passes along the return value from
> + * _set_master_standbymode().
> + *
> + * Any users of this function should be scrutinized carefully.
> + */
> +int omap_hwmod_set_master_idlemode(struct omap_hwmod *oh, u8 
> midlemode) 
> +{
> +	u32 v;
> +	int retval = 0;
> +
> +	if (!oh)
> +		return -EINVAL;
> +
> +	v = oh->_sysc_cache;
> +
> +	retval = _set_master_standbymode(oh, midlemode, &v);
> +	if (!retval)
> +		_write_sysconfig(v, oh);
> +
> +	return retval;
> +}
> +
> +/**
> + * omap_hwmod_get_master_idlemode - set the hwmod's OCP 
> master idlemode
> + * @oh: struct omap_hwmod *
> + * @idlemode: pointer to get SIDLEMODE field bits (shifted to bit 0)
> + *
> + * Gets the IP block's OCP master idlemode from our local copy. 
> +Intended
> + * to be used by drivers that have some erratum that requires direct
> + * manipulation of the MIDLEMODE bits. Returns -EINVAL if 
> @oh is null,
> + * or passes along the return value from _get_master_standbymode().
> + *
> + * Any users of this function should be scrutinized carefully.
> + */
> +int omap_hwmod_get_master_idlemode(struct omap_hwmod *oh, u32 
> +*idlemode) {
> +	int retval = 0;
> +
> +	if (!oh)
> +		return -EINVAL;
> +
> +	retval = _get_master_standbymode(oh, idlemode);
> +
> +	return retval;
> +}
> +
> +/**
>   * omap_hwmod_register - register a struct omap_hwmod
>   * @oh: struct omap_hwmod *
>   *
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h 
> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index c1835af..13d5f0a 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -524,6 +524,9 @@ int omap_hwmod_disable_clocks(struct 
> omap_hwmod *oh);
>  
>  int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 
> idlemode);
>  
> +int omap_hwmod_set_master_idlemode(struct omap_hwmod *oh, u8 
> +midlemode); int omap_hwmod_get_master_idlemode(struct 
> omap_hwmod *oh, 
> +u32 *idlemode);
> +
>  int omap_hwmod_reset(struct omap_hwmod *oh);  void 
> omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
>  
> diff --git a/arch/arm/plat-omap/omap_device.c 
> b/arch/arm/plat-omap/omap_device.c
> index abe933c..d782314 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -584,6 +584,42 @@ int omap_device_idle(struct 
> platform_device *pdev)  }
>  
>  /**
> + * omap_device_mstandby - set/get mstandby mode an omap_device
> + * @od: struct omap_device * to idle
> + * @midlemode: MIDLEMODE field bits (shifted to bit 0)
> + * @set_mstandby: flag for mstandby get/set
> + *
> + * Sets/Gets the IP block's OCP master standby in hardware. Intended
> + * to be used by drivers that have some erratum that requires direct
> + * manipulation of the MSTANDBYMODE bits. Returns -EINVAL if the
> + * omap_device is not currently enabled or passes along the return 
> +value
> + * of 
> omap_hwmod_set_master_idlemode()/omap_hwmod_get_master_idlemode().
> + */
> +int omap_device_mstandby(struct platform_device *pdev, u8 *midlemode,
> +						bool set_mstandby)
> +{
> +	int ret, i;
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +
> +	od = _find_by_pdev(pdev);
> +	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
> +		WARN(1, "omap_device: %s.%d: %s() called from 
> invalid state %d\n",
> +		     od->pdev.name, od->pdev.id, __func__, od->_state);
> +		return -EINVAL;
> +	}
> +
> +	oh = *od->hwmods;
> +	for (i = 0; i < od->hwmods_cnt; i++) {
> +		if (set_mstandby)
> +			ret = 
> omap_hwmod_set_master_idlemode(oh, *midlemode);
> +		else
> +			ret = 
> omap_hwmod_get_master_idlemode(oh, midlemode);
> +	}
> +	return ret;
> +}
> +
> +/**
>   * omap_device_shutdown - shut down an omap_device
>   * @od: struct omap_device * to shut down
>   *
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 