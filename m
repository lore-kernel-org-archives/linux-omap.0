From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH v3 2/4] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Mon, 5 Nov 2012 10:57:00 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9DA7EC@DBDE01.ent.ti.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
 <1351869956-2787-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35562 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab2KEK6Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 05:58:16 -0500
In-Reply-To: <1351869956-2787-3-git-send-email-zonque@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nori, Sekhar" <nsekhar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 02, 2012 at 20:55:54, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 8607735..c3616c6 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -92,7 +92,7 @@ static int omap2_nand_gpmc_retime(
>  static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>  {
>  	/* support only OMAP3 class */
> -	if (!cpu_is_omap34xx()) {
> +	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
>  		pr_err("BCH ecc is not supported on this CPU\n");
>  		return 0;
>  	}

Please add '!soc_is_am33xx()' check for BCH4 failure case also.
BCH4 support tested in AM335x.
https://lkml.org/lkml/2012/10/31/82

Thanks
Avinash

> -- 
> 1.7.11.7
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

