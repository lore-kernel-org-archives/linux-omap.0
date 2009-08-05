From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: PM: warn if CONFIG_CPU_IDLE is not enabled
Date: Wed, 05 Aug 2009 08:33:37 -0700
Message-ID: <87fxc68ecu.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0908030138020.19529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f179.google.com ([209.85.222.179]:34213 "EHLO
	mail-pz0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753AbZHEPdi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 11:33:38 -0400
Received: by pzk9 with SMTP id 9so117882pzk.21
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2009 08:33:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0908030138020.19529@utopia.booyaka.com> (Paul Walmsley's message of "Mon\, 3 Aug 2009 01\:39\:02 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> For MPU latency constraints to work, CONFIG_CPU_IDLE must be enabled,
> since CPUIdle is where the constraints are evaluated.  Warn during
> compilation if CONFIG_CPU_IDLE is not defined.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/resource34xx.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index 25535a3..1693e9b 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -28,6 +28,10 @@
>  #include "cm.h"
>  #include "cm-regbits-34xx.h"
>  
> +#ifndef CONFIG_CPU_IDLE
> +#warning MPU latency constraints require CONFIG_CPU_IDLE to function!
> +#endif
> +
>  /**
>   * init_latency - Initializes the mpu/core latency resource.
>   * @resp: Latency resource to be initalized
> -- 
> 1.6.3.GIT
