From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v6 01/16] OMAP2+: hwmod: Add API to enable IO ring wakeup.
Date: Sat, 01 Oct 2011 19:11:23 +0530
Message-ID: <4E871883.4010207@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48116 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226Ab1JANlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Oct 2011 09:41:35 -0400
In-Reply-To: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
> Add API to enable IO pad wakeup capability based on mux dynamic pad and
> wake_up enable flag available from hwmod_mux initialization.
>
> Use the wakeup_enable flag and enable wakeup capability
> for the given pads. Wakeup capability will be enabled/disabled
> during hwmod idle transition based on whether wakeup_flag is
> set or cleared.
>
> Call the omap_hwmod_set_ioring_wakeup from hwmod_wakeup_enable/disable.
>
> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   59 ++++++++++++++++++++++++++++++++++++++
>   1 files changed, 59 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 84cc0bd..e751dd9 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2062,6 +2062,34 @@ static int __init omap_hwmod_setup_all(void)
>   core_initcall(omap_hwmod_setup_all);
>
>   /**
> + * omap_hwmod_set_ioring_wakeup - enable io pad wakeup flag.
> + * @oh: struct omap_hwmod *
> + * @set: bool value indicating to set or clear wakeup status.
> + *
> + * Set or Clear wakeup flag for the io_pad.
> + */
> +static int omap_hwmod_set_ioring_wakeup(struct omap_hwmod *oh, bool set_wake)
> +{
> +	struct omap_device_pad *pad;
> +	int ret = -EINVAL, j;
> +
> +	if (oh->mux&&  oh->mux->enabled) {
> +		for (j = 0; j<  oh->mux->nr_pads_dynamic; j++) {
> +			pad = oh->mux->pads_dynamic[j];
> +			if (pad->flags&  OMAP_DEVICE_PAD_WAKEUP) {
> +				if (set_wake)
> +					pad->idle |= OMAP_WAKEUP_EN;
> +				else
> +					pad->idle&= ~OMAP_WAKEUP_EN;

I think apart from enabling/disabling the IO wakeup's at the pad
level, there is also a need to trigger the IO daisy chain control
(Wu clock) by programming the PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN
bit and waiting on the PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN) bit,
which is done by the omap3_enable/disable_io_chain function.
This is still done in the cpuidle path, but it makes sense to
move that over here, since it should be done every time a pad
level wakeup is enabled or disabled.

See section 3.5.7.2.2 I/O Wake-Up Mechanism of 36xx TRM revA.

"The I/O wake-up scheme is enabled by triggering the I/O daisy chain 
control (Wu clock) by
programming a dedicated register (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN) in 
the PRCM module.Software must wait for the I/O daisy chain to complete 
before it transitions the PER domain to a
nonfunctional state. This is done by polling a dedicated status bit in 
the PRCM module
(PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared by 
software when the bit is
read to 1."

> +				ret = 0;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/**
>    * omap_hwmod_enable - enable an omap_hwmod
>    * @oh: struct omap_hwmod *
>    *
> @@ -2393,6 +2421,35 @@ int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
>   {
>   	return _del_initiator_dep(oh, init_oh);
>   }
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
> +	return omap_hwmod_set_ioring_wakeup(oh, true);
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
> +	/* Disable pad wakeup capability */
> +	return omap_hwmod_set_ioring_wakeup(oh, false);
> +}
>
>   /**
>    * omap_hwmod_enable_wakeup - allow device to wake up the system
> @@ -2419,6 +2476,7 @@ int omap_hwmod_enable_wakeup(struct omap_hwmod *oh)
>   	v = oh->_sysc_cache;
>   	_enable_wakeup(oh,&v);
>   	_write_sysconfig(v, oh);
> +	omap_hwmod_enable_ioring_wakeup(oh);
>   	spin_unlock_irqrestore(&oh->_lock, flags);
>
>   	return 0;
> @@ -2449,6 +2507,7 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
>   	v = oh->_sysc_cache;
>   	_disable_wakeup(oh,&v);
>   	_write_sysconfig(v, oh);
> +	omap_hwmod_disable_ioring_wakeup(oh);
>   	spin_unlock_irqrestore(&oh->_lock, flags);
>
>   	return 0;

