From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v6 02/16] OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
Date: Sat, 01 Oct 2011 20:03:59 +0530
Message-ID: <4E8724D7.6060907@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com> <1317380495-584-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:41593 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab1JAOeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Oct 2011 10:34:09 -0400
In-Reply-To: <1317380495-584-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Friday 30 September 2011 04:31 PM, Govindraj.R wrote:
> Add API to determine IO-PAD wakeup event status for a given
> hwmod dynamic_mux pad.
>
> Wake up event set will be cleared on pad mux_read.

Are these api's even getting used in this series?

>
> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
> ---
>   arch/arm/mach-omap2/mux.c                    |   30 ++++++++++++++++++++++++++
>   arch/arm/mach-omap2/mux.h                    |   13 +++++++++++
>   arch/arm/mach-omap2/omap_hwmod.c             |    7 ++++++
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>   4 files changed, 51 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 655e948..fb75aae 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -351,6 +351,36 @@ err1:
>   	return NULL;
>   }
>
> +/**
> + * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
> + * @hmux:		Pads for a hwmod
> + *
> + * Gets the wakeup status of given pad from omap-hwmod.
> + * Returns true if wakeup capability is set and wakeup event occurred.
> + * Returns false if wakeup event has not occurred or pads are not available.
> + */
> +bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
> +{
> +	int i;
> +	unsigned int val;
> +	u8 ret = false;
> +
> +	for (i = 0; i<  hmux->nr_pads; i++) {
> +		struct omap_device_pad *pad =&hmux->pads[i];
> +
> +		if (pad->flags&  OMAP_DEVICE_PAD_WAKEUP) {
> +			val = omap_mux_read(pad->partition,
> +					pad->mux->reg_offset);
> +			if (val&  OMAP_WAKEUP_EVENT) {
> +				ret = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   /* Assumes the calling function takes care of locking */
>   void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>   {
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index 2132308..8b2150a 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
>    */
>   void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>
> +/**
> + * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
> + * @hmux:		Pads for a hwmod
> + *
> + * Called only from omap_hwmod.c, do not use.
> + */
> +bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux);
>   #else
>
> +static inline bool
> +omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
> +{
> +	return 0;
> +}
> +
>   static inline int omap_mux_init_gpio(int gpio, int val)
>   {
>   	return 0;
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e751dd9..a8b24d7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2724,3 +2724,10 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
>
>   	return 0;
>   }
> +
> +int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh)
> +{
> +	if (oh&&  oh->mux)
> +		return omap_hwmod_mux_get_wake_status(oh->mux);
> +	return -EINVAL;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 0e329ca..9a6195c 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -607,6 +607,7 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>
>   int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>
> +int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh);
>   /*
>    * Chip variant-specific hwmod init routines - XXX should be converted
>    * to use initcalls once the initial boot ordering is straightened out

