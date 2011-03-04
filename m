From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable requested pads
Date: Fri, 04 Mar 2011 15:54:44 -0800
Message-ID: <87lj0u8mrf.fsf@ti.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 2 Mar 2011 16:42:23 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

"Govindraj.R" <govindraj.raja@ti.com> writes:

> For device pads which have OMAP_DEVICE_PAD_WAKEUP set (which means they
> are wakeup capable) enable the IO-daisy wakeup capability.
> During re-muxing avoid direct write with val as this can disturb if any
> mux done at bootloader level so read the pad then write back.
>
> Also add an API to fetch the wake-up status bit is set for given omap-hwmod
> device using available mux info which is added during omap_hwmod_mux_init.
> Wakeup status bit is needed for uart_resume_idle call from sram_idle path
> based on wake-up event has occurred for given uart we can enable clocks back.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/mux.c                    |   28 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/mux.h                    |   13 ++++++++++++
>  arch/arm/mach-omap2/omap_hwmod.c             |   13 ++++++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>  4 files changed, 55 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 98148b6..50edcea 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -317,6 +317,29 @@ err1:
>  	return NULL;
>  }
>  
> +/* Gets the wakeup status of given pad from omap-hwmod */
> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)

should return a bool

Also, documentation should be clear that it returns true if *any* pad
associated with this device has a wakeup event.

Also a name reflecting the get/check/status nature of this function
would help readability, maybe:

bool omap_hwmod_mux_wakeup_event(struct omap_hwmod_mux_info *hmux)

> +{
> +	int i;
> +	unsigned int val;
> +	u8 ret = 0;
> +
> +	for (i = 0; i < hmux->nr_pads; i++) {
> +		struct omap_device_pad *pad = &hmux->pads[i];
> +
> +		if (pad->flags & OMAP_DEVICE_PAD_WAKEUP) {
> +			val = omap_mux_read(pad->partition,
> +						pad->mux->reg_offset);
> +			if (val & OMAP_WAKEUP_EVENT) {
> +				ret = 1;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  /* Assumes the calling function takes care of locking */
>  void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  {
> @@ -342,6 +365,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  				break;
>  			flags &= ~OMAP_DEVICE_PAD_ENABLED;
>  			val = pad->idle;
> +			if (flags & OMAP_DEVICE_PAD_WAKEUP)
> +				val |= OMAP_WAKEUP_EN;
> +

Is this needed on every idle transition?  

You're currently setting it on every idle transition, but never clearing
it.  If it is to be a one-time thing, then move it to the early init of
the mux.

>  			pr_debug("%s: Idling %s %x\n", __func__,
>  					pad->name, val);
>  			break;
> @@ -358,6 +384,8 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>  		};
>  
>  		if (val >= 0) {
> +			val |= omap_mux_read(pad->partition,
> +						pad->mux->reg_offset);

I don't think this is doing what you expect, and will lead to very
difficult to find bugs.  Since your OR'ing in bits from the current
value, you will never be able to clear any bits in this register.

As just a dumb example, consider the enable case where
pad->enable=MUX_MODE0 (0x0).  If the bootloader has initialized this pad
to MUX_MODE7 (0x7), this code will never set it to MUX_MODE0, since this
read and OR of the existing value will always set it back to MUX_MODE7.

At a minimum, this change should be a separate patch with a more
detailed description.


>  			omap_mux_write(pad->partition, val,
>  					pad->mux->reg_offset);
>  			pad->flags = flags;
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index a4ab17a..84a8fc2 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -220,8 +220,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
>   */
>  void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>  
> +
> +/**
> + * omap_hwmod_mux_wakeup - omap hwmod check given pad had wakeup event
> + * @hmux:		Pads for a hwmod
> + *
> + * Called only from omap_hwmod.c, do not use.
> + */
> +int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux);
>  #else
>  
> +static inline int omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
> +{
> +	return 0;
> +}
> +
>  static inline int omap_mux_init_gpio(int gpio, int val)
>  {
>  	return 0;
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 9e89a58..893dae1 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2239,3 +2239,16 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
>  
>  	return ret;
>  }
> +
> +/**
> + * omap_hwmod_pad_wakeup_status - get pad wakeup status if mux is available.
> + * @oh: struct omap_hwmod *
> + *
> + * Returns the wake_up status bit of available pad mux pin.
> + */
> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh)

Again, naming here could improve readability.  Maybe:

bool omap_hmwod_get_io_wakeup_status(struct omap_hwmod *oh)

>From the name and the bool return, it should be clear that this is just
checking for the wakeup event.  I also think it should be clear that
this is checking for IO-ring wakeups, not module wakeups.

Also, in PATCH 5/7, you're calling this hwmod API directly from a
driver.  Drivers should not know anything about hwmods.  Any
OMAP-specific hooks must be called through pdata function pointers.
Also, they should go through omap_device, which would then call
omap_hwmod.

Thinking more about this (and how you use it in PATCH 5/7), what is
needed is an omap_device level API to check if a wakeup occured for that
device.  That function would check for either module-level wakeup or IO
pad wakeup.  The driver should not need to care about how the wakeup
occurred.

> +{
> +	if (oh->mux)
> +		return omap_hwmod_mux_wakeup(oh->mux);
> +	return -EINVAL;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index fedd829..4100be0 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -588,6 +588,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
>  int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
>  u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh);
>  /*
>   * Chip variant-specific hwmod init routines - XXX should be converted
>   * to use initcalls once the initial boot ordering is straightened out

Kevin
