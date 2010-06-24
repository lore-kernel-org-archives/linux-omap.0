From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 12/13] OMAP: hwmod data: add class for DSP hwmods
Date: Thu, 24 Jun 2010 12:44:49 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006241243130.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-13-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59714 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab0FXSou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 14:44:50 -0400
In-Reply-To: <1277336563-24988-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> Add a new hwmod class for DSP devices.  To be used when hwmods
> are created for DSP on OMAP3 (a.k.a. IVA2.)

I guess this patch is not needed any more?  But if it is, it might be best 
to name the class "iva2" or something like that, since the IVA2 subsystem 
contains more than just the DSP; it also contains the dedicated hardware 
video accelerator blocks, which are separate from the DSP.

- Paul

> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +++
>  arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.c b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> index 1e80b91..09f1e98 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_common_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.c
> @@ -66,3 +66,6 @@ struct omap_hwmod_class mpu_hwmod_class = {
>  	.name = "mpu"
>  };
>  
> +struct omap_hwmod_class dsp_hwmod_class = {
> +	.name = "dsp"
> +};
> diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
> index 3645a28..d03ebfa 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
> +++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
> @@ -20,5 +20,6 @@
>  extern struct omap_hwmod_class l3_hwmod_class;
>  extern struct omap_hwmod_class l4_hwmod_class;
>  extern struct omap_hwmod_class mpu_hwmod_class;
> +extern struct omap_hwmod_class dsp_hwmod_class;
>  
>  #endif
> -- 
> 1.7.0.2
> 


- Paul
