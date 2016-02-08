From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: RX51: Set system_rev from ATAGS
Date: Mon, 8 Feb 2016 12:48:06 -0800
Message-ID: <20160208204806.GE19432@atomide.com>
References: <3663322.UyrB2OmX6o@wuerfel>
 <1454696102-2214-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454696102-2214-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160205 10:17]:

Can you please add the "why?" part here? Other than that looks
OK to me.

And unless people have objections, I'd like to get this merged
in as it fixes yet another legacy boot vs DT boot regression.

Regards,

Tony

> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  arch/arm/mach-omap2/board-generic.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 8098272..b91fabe 100644
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
> +static void __init rx51_system_rev(const struct tag *tags)
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
> +	rx51_system_rev(tags);
>  	omap_reserve();
>  }
>  
> -- 
> 1.9.1
> 
