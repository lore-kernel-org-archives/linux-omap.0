From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP3: PM: include 'mach/irqs.h'
Date: Tue, 17 Mar 2009 07:53:23 -0700
Message-ID: <874oxsgpzw.fsf@deeprootsystems.com>
References: <4d34a0a70903170023l5b94db2an204f1aaae46b14cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:57865 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbZCQOx2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 10:53:28 -0400
Received: by mail-qy0-f122.google.com with SMTP id 28so84410qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 07:53:26 -0700 (PDT)
In-Reply-To: <4d34a0a70903170023l5b94db2an204f1aaae46b14cf@mail.gmail.com> (Kim Kyuwon's message of "Tue\, 17 Mar 2009 16\:23\:02 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, q1.kim@samsung.com, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com

Kim Kyuwon <chammoru@gmail.com> writes:

> This patch fixes this compile error
>   CC      arch/arm/mach-omap2/cpuidle34xx.o
> arch/arm/mach-omap2/cpuidle34xx.c:100: error: implicit declaration of
> function 'omap_irq_pending'
> make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
>
> The omap_irq_pending() function is declared in
> 'arch/arm/plat-omap/include/mach/irqs.h'
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>

Thanks, pushing to PM branch.

Kevin

>  arch/arm/mach-omap2/cpuidle34xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index 62fbb2e..5e50c46 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -28,6 +28,7 @@
>  #include <mach/powerdomain.h>
>  #include <mach/control.h>
>  #include <mach/serial.h>
> +#include <mach/irqs.h>
>
>  #include "pm.h"
>
> -- 
> 1.5.2.5
>
> -- 
> Kyuwon
