From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP3: PM: Fix compile error with 'CONFIG_OMAP_PM_SRF=y'
Date: Tue, 31 Mar 2009 17:13:57 -0700
Message-ID: <87k565tem2.fsf@deeprootsystems.com>
References: <4d34a0a70903200107j65ae61fay9a954e71b8910348@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:56500 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbZDAAOC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 20:14:02 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3453951wff.4
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 17:14:01 -0700 (PDT)
In-Reply-To: <4d34a0a70903200107j65ae61fay9a954e71b8910348@mail.gmail.com> (Kim Kyuwon's message of "Fri\, 20 Mar 2009 17\:07\:32 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

Kim Kyuwon <chammoru@gmail.com> writes:

> This patch fixes below compile error. The header file
> 'mach/omap34xx.h' declared all needed symbols.
>
>   CC      arch/arm/mach-omap2/pm.o
>   CC      arch/arm/mach-omap2/resource34xx.o
> arch/arm/mach-omap2/resource34xx.c: In function 'resource_access_opp_lock':
> arch/arm/mach-omap2/resource34xx.c:174: error: 'VDD1_OPP' undeclared
> (first use in this function)
> arch/arm/mach-omap2/resource34xx.c:177: error: 'VDD2_OPP' undeclared
> (first use in this function)
> arch/arm/mach-omap2/resource34xx.c:209: error: 'MAX_VDD1_OPP'
> undeclared (first use in this function)
> <snip>
> make[1]: *** [arch/arm/mach-omap2/resource34xx.o] Error 1
> arch/arm/mach-omap2/pm.c: In function 'vdd_opp_show':
> arch/arm/mach-omap2/pm.c:140: error: 'VDD1_OPP' undeclared (first use
> in this function)
> arch/arm/mach-omap2/pm.c:140: error: (Each undeclared identifier is
> reported only once
> <snip>
> make[1]: *** [arch/arm/mach-omap2/pm.o] Error 1
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm.c           |    1 +
>  arch/arm/mach-omap2/resource34xx.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index e64a80e..c0f1ae8 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -34,6 +34,7 @@
>  #include <mach/powerdomain.h>
>  #include <mach/omapdev.h>
>  #include <mach/resource.h>
> +#include <mach/omap34xx.h>
>
>  #include "prm-regbits-34xx.h"
>  #include "pm.h"
> diff --git a/arch/arm/mach-omap2/resource34xx.c
> b/arch/arm/mach-omap2/resource34xx.c
> index 2328323..4db9289 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -20,6 +20,7 @@
>  #include <linux/cpufreq.h>
>  #include <mach/powerdomain.h>
>  #include <mach/clockdomain.h>
> +#include <mach/omap34xx.h>
>  #include "smartreflex.h"
>  #include "resource34xx.h"
>  #include "pm.h"
> -- 
> 1.5.2.5
>
>
> -- 
> Kim Kyuwon
