From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH] dmtimer: hwmod: add omap2420 database
Date: Fri, 3 Sep 2010 14:33:39 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402781CE640@dbde02.ent.ti.com>
References: <1281798868-14599-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab0ICJDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 05:03:48 -0400
In-Reply-To: <1281798868-14599-1-git-send-email-tarun.kanti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Gopinath, Thara" <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>


Tarun,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> DebBarma, Tarun Kanti
> Sent: Saturday, August 14, 2010 8:44 PM
> To: linux-omap@vger.kernel.org
> Cc: DebBarma, Tarun Kanti; Basak, Partha; Gopinath, Thara; 
> Paul Walmsley; Kevin Hilman; Tony Lindgren
> Subject: [PATCH] dmtimer: hwmod: add omap2420 database
> 
> This patch adds hwmod database for omap2420.
> 
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |  597 
> ++++++++++++++++++++++++++++
>  1 files changed, 597 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 
> arch/arm/mach-omap2/omap_hwmod_2420_data.c
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c 
> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> old mode 100644
> new mode 100755
> index 3cc768e..7f87924
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -15,6 +15,7 @@
>  #include <mach/irqs.h>
>  #include <plat/cpu.h>
>  #include <plat/dma.h>
> +#include <plat/dmtimer.h>
>  
>  #include "omap_hwmod_common_data.h"
>  
> @@ -121,6 +122,590 @@ static struct omap_hwmod 
> omap2420_l4_wkup_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>  	.flags		= HWMOD_NO_IDLEST,
>  };
> +/* Timer Common */
> +static struct omap_hwmod_class_sysconfig omap2420_timer_sysc = {
> +	.rev_offs	= 0x0000,
> +	.sysc_offs	= 0x0010,
> +	.syss_offs	= 0x0014,
> +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> +			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
> +			   SYSC_HAS_AUTOIDLE),
> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
> +	.sysc_fields    = &omap_hwmod_sysc_type1,
> +};
> +
> +static struct omap_hwmod_class omap2420_timer_hwmod_class = {
> +	.name = "timer",
> +	.sysc = &omap2420_timer_sysc,
> +	.rev = OMAP_TIMER_IP_LEGACY,

Applying only this patch breaks build. Take care to address dependenices
for each patch in the series so that, git bisect works with any patch in the
series.

-Manjunath