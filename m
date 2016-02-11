From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1] ARM: RX51: Set system_rev from ATAGS
Date: Wed, 10 Feb 2016 16:19:43 -0800
Message-ID: <20160211001942.GN19432@atomide.com>
References: <20160209161659.GJ19432@atomide.com>
 <1455128582-25669-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455128582-25669-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160210 10:24]:
> This fixed a regression with DT boot compared to legacy boot.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Thanks, applying into omap-for-v4.5/fixes with Pali's ack.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/board-generic.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 8098272..bab814d 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -18,6 +18,7 @@
>  
>  #include <asm/setup.h>
>  #include <asm/mach/arch.h>
> +#include <asm/system_info.h>
>  
>  #include "common.h"
>  
> @@ -77,12 +78,31 @@ static const char *const n900_boards_compat[] __initconst = {
>  	NULL,
>  };
>  
> +/* Set system_rev from atags */
> +static void __init rx51_set_system_rev(const struct tag *tags)
> +{
> +	const struct tag *tag;
> +
> +	if (tags->hdr.tag != ATAG_CORE)
> +		return;
> +
> +	for_each_tag(tag, tags) {
> +		if (tag->hdr.tag == ATAG_REVISION) {
> +			system_rev = tag->u.revision.rev;
> +			break;
> +		}
> +	}
> +}
> +
>  /* Legacy userspace on Nokia N900 needs ATAGS exported in /proc/atags,
>   * save them while the data is still not overwritten
>   */
>  static void __init rx51_reserve(void)
>  {
> -	save_atags((const struct tag *)(PAGE_OFFSET + 0x100));
> +	const struct tag *tags = (const struct tag *)(PAGE_OFFSET + 0x100);
> +
> +	save_atags(tags);
> +	rx51_set_system_rev(tags);
>  	omap_reserve();
>  }
>  
> -- 
> 1.9.1
> 
