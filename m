From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/13] OMAP: hwmod: add non-locking versions of enable
 and idle functions
Date: Wed, 23 Jun 2010 23:08:59 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006232307170.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-7-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39130 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0FXFJA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 01:09:00 -0400
In-Reply-To: <1277336563-24988-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> Some hwmods may need to be idled/enabled in atomic context, so
> non-locking versions of these functions are required.
> 
> Most users should not need these and usage of theses should be
> controlled to understand why access is being done in atomic context.
> For this reason, the non-locking functions are only exposed at the
> hwmod level and not at the omap-device level.
> 
> The use-case that led to the need for the non-locking versions is
> hwmods that are enabled/idled from within the core idle/suspend path.
> Since interrupts are already disabled here, the mutex-based locking in
> hwmod can sleep and will cause potential deadlocks.

I accept the use-case.  But maybe it would be preferable to rename 
_enable(), _idle(), _shutdown() to _omap_hwmod_{enable,idle,shutdown}() ?
That would avoid the need to add new functions that just call the existing 
ones.


- Paul

> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   32 ++++++++++++++++++++++---
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 3d11523..8b2b44a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1287,6 +1287,18 @@ int omap_hwmod_unregister(struct omap_hwmod *oh)
>  }
>  
>  /**
> + * __omap_hwmod_enable - enable an omap_hwmod (non-locking version)
> + * @oh: struct omap_hwmod *
> + *
> + * Enable an omap_hwomd @oh.  Intended to be called in rare cases
> + * where usage is required in atomic context.
> + */
> +int __omap_hwmod_enable(struct omap_hwmod *oh)
> +{
> +	return _enable(oh);
> +}
> +
> +/**
>   * omap_hwmod_enable - enable an omap_hwmod
>   * @oh: struct omap_hwmod *
>   *
> @@ -1301,12 +1313,26 @@ int omap_hwmod_enable(struct omap_hwmod *oh)
>  		return -EINVAL;
>  
>  	mutex_lock(&omap_hwmod_mutex);
> -	r = _enable(oh);
> +	r = __omap_hwmod_enable(oh);
>  	mutex_unlock(&omap_hwmod_mutex);
>  
>  	return r;
>  }
>  
> +
> +/**
> + * __omap_hwmod_idle - idle an omap_hwmod (non-locking)
> + * @oh: struct omap_hwmod *
> + *
> + * Idle an omap_hwomd @oh.  Intended to be called in rare instances where
> + * used in atomic context.
> + */
> +int __omap_hwmod_idle(struct omap_hwmod *oh)
> +{
> +	_idle(oh);
> +	return 0;
> +}
> +
>  /**
>   * omap_hwmod_idle - idle an omap_hwmod
>   * @oh: struct omap_hwmod *
> @@ -1319,9 +1345,7 @@ int omap_hwmod_idle(struct omap_hwmod *oh)
>  	if (!oh)
>  		return -EINVAL;
>  
> -	mutex_lock(&omap_hwmod_mutex);
> -	_idle(oh);
> -	mutex_unlock(&omap_hwmod_mutex);
> +	__omap_hwmod_idle(oh);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 0eccc09..9a3f4dc 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -486,7 +486,9 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh));
>  int omap_hwmod_late_init(void);
>  
>  int omap_hwmod_enable(struct omap_hwmod *oh);
> +int __omap_hwmod_enable(struct omap_hwmod *oh);
>  int omap_hwmod_idle(struct omap_hwmod *oh);
> +int __omap_hwmod_idle(struct omap_hwmod *oh);
>  int omap_hwmod_shutdown(struct omap_hwmod *oh);
>  
>  int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
> -- 
> 1.7.0.2
> 


- Paul
