From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 1/8] DSPBRIDGE: Cleanup SSI handling - remove IO_ADDRESS
Date: Fri, 8 Jan 2010 16:20:31 +0200
Message-ID: <20100108142031.GE11897@annwn.felipec.org>
References: <1262912426-29974-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52456 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0AHOVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 09:21:32 -0500
Content-Disposition: inline
In-Reply-To: <1262912426-29974-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

On Fri, Jan 08, 2010 at 02:00:26AM +0100, Omar Ramirez Luna wrote:
> This patch cleans SSI clock preparation and also removes
> the dependency on IO_ADDRESS variants for easier maintenance.

So this patch is:
 * reorganizing SSI configuration
 * doing some code-style cleanups
 * using ioremap()

That doesn't look very atomic to me.

> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/drv.h |    7 ++++++
>  drivers/dsp/bridge/services/clk.c          |   30 ++++++++++++++-------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
> index d14613f..59c26fc 100644
> --- a/arch/arm/plat-omap/include/dspbridge/drv.h
> +++ b/arch/arm/plat-omap/include/dspbridge/drv.h
> @@ -115,6 +115,13 @@
>  #define OMAP_DMMU_BASE 0x5D000000
>  #define OMAP_DMMU_SIZE 0x1000
>  
> +#define OMAP_SSI_BASE		0x48058000
> +#define OMAP_SSI_SIZE		0x1000
> +
> +#define SSI_AUTOIDLE			(1 << 0)
> +#define SSI_SIDLE_SMARTIDLE	(2 << 3)
> +#define SSI_MIDLE_NOIDLE		(1 << 12)
> +
>  #define OMAP_PRCM_VDD1_DOMAIN 1
>  #define OMAP_PRCM_VDD2_DOMAIN 2

Isn't this some abuse of arch/arm? In general things in header files are
meant to be used in more than one source file, and it doesn't seem
anybody would use these other than clk.c.

-- 
Felipe Contreras
