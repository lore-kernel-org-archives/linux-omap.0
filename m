From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 1/8] OMAP: powerdomain: Move powerdomain.c from mach-omap2
 to plat-omap
Date: Tue, 12 Oct 2010 01:28:48 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010120127250.16871@utopia.booyaka.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com> <1285245291-26442-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32802 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab0JLH2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 03:28:49 -0400
In-Reply-To: <1285245291-26442-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com

Hi Rajendra,

some brief comments -

On Thu, 23 Sep 2010, Rajendra Nayak wrote:

> This is in preparation of splitting the powerdomain framework into
> platform-independent part (for all omaps) and platform-specific
> parts.
> The platform-independent code would reside in plat-omap/powerdomain.c
> and the platform-specific code will resides in
> mach-omap2/powerdomain-xxxx.c files.

Unless you are planning to add powerdomain support for OMAP1, it seems 
best to keep the powerdomain code in mach-omap2/.  That will also avoid 
sideways includes like these:

> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/plat-omap/powerdomain.c
> @@ -26,19 +26,19 @@
>  
>  #include <asm/atomic.h>
>  
> -#include "cm.h"
> -#include "cm-regbits-34xx.h"
> -#include "cm-regbits-44xx.h"
> -#include "prm.h"
> -#include "prm-regbits-34xx.h"
> -#include "prm-regbits-44xx.h"
> +#include "../mach-omap2/cm.h"
> +#include "../mach-omap2/cm-regbits-34xx.h"
> +#include "../mach-omap2/cm-regbits-44xx.h"
> +#include "../mach-omap2/prm.h"
> +#include "../mach-omap2/prm-regbits-34xx.h"
> +#include "../mach-omap2/prm-regbits-44xx.h"
>  
>  #include <plat/cpu.h>
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
>  #include <plat/prcm.h>
>  
> -#include "pm.h"
> +#include "../mach-omap2/pm.h"
>  
>  enum {
>  	PWRDM_STATE_NOW = 0,
> -- 
> 1.7.0.4
> 


- Paul
