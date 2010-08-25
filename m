From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 7/8 v2] OMAP: Hwmod api changes
Date: Wed, 25 Aug 2010 16:42:05 -0700
Message-ID: <877hje8dki.fsf@deeprootsystems.com>
References: <1282140652-29837-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33824 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab0HYXmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 19:42:08 -0400
In-Reply-To: <1282140652-29837-1-git-send-email-hemahk@ti.com> (Hema HK's
	message of "Wed, 18 Aug 2010 19:40:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, "Basak, Partha" <p-basak2@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hema HK <hemahk@ti.com> writes:

> OMAP USBOTG modules has a requirement to set the auto idle bit only after
> setting smart idle bit. Modified the _sys_enable api to set the smart idle
> first and then the autoidle bit. Setting this will not have any impact on the
> other modules.
>
> Added 2 wrapper APIs in the omap device layer for wakeup enable/disable
> and sidle/mstandby settings.

This should be a separate patch, with an description of who the users of
this API would be and why.

> Signed-off-by: Hema HK <hemahk@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>
>
> Cc: Felipe Balbi <felipe.balbi@nokia.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   18 +++++++---
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/omap_device.c              |   43 +++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 9bd99ad..55507a6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -654,12 +654,6 @@ static void _sysc_enable(struct omap_hwmod *oh)
>  		_set_master_standbymode(oh, idlemode, &v);
>  	}
>  
> -	if (sf & SYSC_HAS_AUTOIDLE) {
> -		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
> -			0 : 1;
> -		_set_module_autoidle(oh, idlemode, &v);
> -	}
> -
>  	/* XXX OCP ENAWAKEUP bit? */
>  
>  	/*
> @@ -672,6 +666,18 @@ static void _sysc_enable(struct omap_hwmod *oh)
>  		_set_clockactivity(oh, oh->class->sysc->clockact, &v);
>  
>  	_write_sysconfig(v, oh);
> +
> +	/* Set the auto idle bit only after setting the smartidle bit
> +	 * as this is requirement for some modules like USBOTG
> +	 * setting this will not have any impact on the other modues.
> +	 */

Please fix multi-line comment style.  (search for multi-line in
Documentation/CodingStyle)

Kevin

> +	if (sf & SYSC_HAS_AUTOIDLE) {
> +		idlemode = (oh->flags & HWMOD_NO_OCP_AUTOIDLE) ?
> +			0 : 1;
> +		_set_module_autoidle(oh, idlemode, &v);
> +	}
> +	_write_sysconfig(v, oh);
>  }
>  
>  /**
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index 25cd9ac..c3eb07e 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -116,6 +116,8 @@ int omap_device_enable_hwmods(struct omap_device *od);
>  int omap_device_disable_clocks(struct omap_device *od);
>  int omap_device_enable_clocks(struct omap_device *od);
>  
> +int omap_device_enable_wakeup(struct platform_device *pdev);
> +int omap_device_disable_wakeup(struct platform_device *pdev);
>  
>  /*
>   * Entries should be kept in latency order ascending
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index d2b1609..10182b1 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -757,3 +757,46 @@ int omap_device_enable_clocks(struct omap_device *od)
>  	/* XXX pass along return value here? */
>  	return 0;
>  }
> +
> +/**
> + * omap_device_enable_wakeup - Enable the wakeup bit
> + * @od: struct omap_device *od
> + *
> + * Enable the wakup bit for omap_hwmods associated
> + * with the omap_device.  Returns 0.
> + */
> +int omap_device_enable_wakeup(struct platform_device *pdev)
> +{
> +	struct omap_hwmod *oh;
> +	struct omap_device *od = _find_by_pdev(pdev);
> +	int i;
> +
> +	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
> +		omap_hwmod_enable_wakeup(oh);
> +
> +	/* XXX pass along return value here? */
> +	return 0;
> +}
> +
> +/**
> + * omap_device_disable_wakeup -Disable the wakeup bit
> + * @od: struct omap_device *od
> + *
> + * Disable the wakup bit for omap_hwmods associated
> + * with the omap_device.  Returns 0.
> + */
> +
> +
> +int omap_device_disable_wakeup(struct platform_device *pdev)
> +{
> +	struct omap_hwmod *oh;
> +	struct omap_device *od = _find_by_pdev(pdev);
> +	int i;
> +
> +	for (i = 0, oh = *od->hwmods; i < od->hwmods_cnt; i++, oh++)
> +		omap_hwmod_disable_wakeup(oh);
> +
> +	/* XXX pass along return value here? */
> +	return 0;
> +}
> +
