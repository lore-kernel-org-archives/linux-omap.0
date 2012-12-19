From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Fix build breakage due to missing
 include in i2c.c
Date: Wed, 19 Dec 2012 08:38:14 -0800
Message-ID: <20121219163814.GM4989@atomide.com>
References: <1355899610-11548-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18550 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751721Ab2LSQiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 11:38:20 -0500
Content-Disposition: inline
In-Reply-To: <1355899610-11548-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Vaibhav Bedia <vaibhav.bedia@ti.com> [121218 22:49]:
> Merge commit 752451f (Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux)
> resulted in a build breakage for OMAP
> 
> ...
> arch/arm/mach-omap2/i2c.c: In function 'omap_pm_set_max_mpu_wakeup_lat_compat':
> arch/arm/mach-omap2/i2c.c:130:2: error: implicit declaration of function 'omap_pm_set_max_mpu_wakeup_lat'
> make[1]: *** [arch/arm/mach-omap2/i2c.o] Error 1
> ...
> 
> Fix this by including the appropriate header file with the function prototype

Thanks applying.

Tony
 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> ---
>  arch/arm/mach-omap2/i2c.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
> index df6d6ac..b9074dd 100644
> --- a/arch/arm/mach-omap2/i2c.c
> +++ b/arch/arm/mach-omap2/i2c.c
> @@ -22,6 +22,7 @@
>  #include "soc.h"
>  #include "omap_hwmod.h"
>  #include "omap_device.h"
> +#include "omap-pm.h"
>  
>  #include "prm.h"
>  #include "common.h"
> -- 
> 1.7.0.4
> 
