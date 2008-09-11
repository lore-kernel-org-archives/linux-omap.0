From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fixed CPU type check for OMAP3
Date: Wed, 10 Sep 2008 17:29:13 -0700
Message-ID: <20080911002912.GG21163@atomide.com>
References: <1220892685-3422-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63616 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYIKA3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 20:29:14 -0400
Content-Disposition: inline
In-Reply-To: <1220892685-3422-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tero Kristo <tero.kristo@nokia.com> [080908 08:01]:
> ES version definitions were incorrect, also GP/EMU/SEC etc. types were not
> detected at all.

I've redone the id.c, the old one was getting messy for omap2. Maybe
try my patch I posted on Tuesday and see how it works for you?

Also one comment below.

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/id.c              |    11 +++++++++--
>  arch/arm/plat-omap/include/mach/cpu.h |    2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index a526c0f..290b88c 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -53,6 +53,13 @@ static struct omap_id omap_ids[] __initdata = {
>  	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300000 },
>  };
>  
> +static const char omap3_revs[][4] = {
> +	"1.0",
> +	"2.0",
> +	"2.1",
> +	"3.0"
> +};
> +
>  static struct omap_chip_id omap_chip;
>  
>  /**
> @@ -224,7 +231,7 @@ void __init omap2_check_revision(void)
>  	 * Note that rev cannot be used directly as ES1.0 uses value 0.
>  	 */
>  	if (hawkeye == 0xb7ae) {
> -		system_rev = 0x34300000 | ((1 + rev) << 12);
> -		pr_info("OMAP%04x ES2.%i\n", system_rev >> 16, rev);
> +		_set_system_rev(0x34300000 | (rev << 12), rev);
> +		pr_info("OMAP%04x ES%s\n", system_rev >> 16, omap3_revs[rev]);
>  		_set_omap_chip();
>  		return;
> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
> index e046418..e170d29 100644
> --- a/arch/arm/plat-omap/include/mach/cpu.h
> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> @@ -357,7 +357,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define OMAP3430_REV_ES1_0	0x34300000
>  #define OMAP3430_REV_ES2_0	0x34301000
>  #define OMAP3430_REV_ES2_1	0x34302000
> -#define OMAP3430_REV_ES2_2	0x34303000
> +#define OMAP3430_REV_ES3_0	0x34303000
>  
>  /*
>   * omap_chip bits

Are you sure ES3.0 gives a three for revision? I believe 2.2 had 3, or
is the revision register broken again?

Tony
