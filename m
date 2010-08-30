From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC: PATCH] New API to modify the autoidle bits of sysconfig register
Date: Mon, 30 Aug 2010 08:26:00 -0700
Message-ID: <878w3o9l6f.fsf@deeprootsystems.com>
References: <1282823155-18328-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:45089 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0H3P0C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 11:26:02 -0400
Received: by pxi10 with SMTP id 10so2113772pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 08:26:02 -0700 (PDT)
In-Reply-To: <1282823155-18328-1-git-send-email-kishon@ti.com> (Kishon Vijay
	Abraham, I's message of "Thu, 26 Aug 2010 17:15:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Partha Basak <p-basak2@ti.com>

Kishon Vijay Abraham I <kishon@ti.com> writes:

> Though the sysconfig register values shouldn't be modified directly by
> the driver, MCBSP should be considered a special case where sysconfig
> registers need to be modified dynamically by the driver.
>
> For e.g MCBSP 2 and 3 in OMAP3 has sidetone feature which requires
> autoidle to be disabled before starting the sidetone.
>
> This patch creates a new API that forms a wrapper to
> _set_module_autoidle() to modify the AUTOIDLE bit.

Since driver should not be using hwmod directly, how is this API going
to be used?  Will this only be called from arch/arm/mach-omap2/mcbsp.c?

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Partha Basak <p-basak2@ti.com>

Subject should contain prefix like 'OMAP: hwmod: ...'

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   29 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>  2 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 9bd99ad..0d38404 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -969,6 +969,35 @@ int _omap_hwmod_idle(struct omap_hwmod *oh)
>  }
>  
>  /**
> + * omap_hwmod_set_module_autoidle - set the hwmod's OCP slave autoidle
> + * @oh: struct omap_hwmod *
> + * @autoidle: desired AUTOIDLE bitfield value (0 or 1)
> + *
> + * Sets the IP block's OCP slave autoidle in hardware, and updates our
> + * local copy. Intended to be used by drivers that have some erratum
> + * that requires direct manipulation of the AUTOIDLE bits.  Returns
> + * -EINVAL if @oh is null, or passes along the return value from
> + * _set_module_autoidle().
> + */
> +int omap_hwmod_set_module_autoidle(struct omap_hwmod *oh, u8 autoidle)
> +{
> +	u32 v;
> +	int retval = 0;
> +
> +	if (!oh)
> +		return -EINVAL;
> +
> +	v = oh->_sysc_cache;
> +
> +	retval = _set_module_autoidle(oh, autoidle, &v);
> +
> +	if (!retval)
> +		_write_sysconfig(v, oh);
> +
> +	return retval;
> +}
> +
> +/**
>   * _shutdown - shutdown an omap_hwmod
>   * @oh: struct omap_hwmod *
>   *
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 6adbb63..7042b86 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -526,6 +526,7 @@ int omap_hwmod_hardreset_deassert(struct omap_hwmod *oh, const char *name);
>  int omap_hwmod_hardreset_state(struct omap_hwmod *oh, const char *name);
>  
>  int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
> +int omap_hwmod_set_module_autoidle(struct omap_hwmod *oh, u8 autoidle)
>  
>  int omap_hwmod_reset(struct omap_hwmod *oh);
>  void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
