From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] Initializing gpmc before accessing flash
Date: Thu, 12 Aug 2010 10:51:31 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E700EF0@dbde02.ent.ti.com>
References: <1281537690.1512.2.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60230 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab0HLFVj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 01:21:39 -0400
In-Reply-To: <1281537690.1512.2.camel@black>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@canonical.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Mathieu Poirier
> Sent: Wednesday, August 11, 2010 8:12 PM
> To: tony@atomide.com
> Cc: linux-omap@vger.kernel.org; Mathieu Poirier
> Subject: [PATCH] Initializing gpmc before accessing flash
> 
> >From b12de3010763a8c047eefd2eb9296eb68157b07e Mon Sep 17 00:00:00 2001
> From: Mathieu J. Poirier <mathieu.poirier@canonical.com>
> Date: Tue, 10 Aug 2010 17:14:25 -0400
> Subject: [PATCH] Initializing gpmc before accessing flash
> 
> Adding initialization of the General Purpose Memory Controller
> (gpmc) in 'omap3beagle_flash_init'.
> 
> The gpmc init was decoupled from nand flash init and
> got its own init function.  This change was not reflected in
> 'omap3beagle_flash_init' resulting in a lookup failure when
> probing for flash.
> 
> BugLink: https://bugs/launchpad.net/bugs/608266
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@canonical.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-
> omap2/board-omap3beagle.c
> index 7a1b351..e1203a4 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -466,6 +466,7 @@ static void __init omap3beagle_flash_init(void)
>  		omap3beagle_nand_data.gpmc_cs_baseaddr = (void *)
>  			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
>  		omap3beagle_nand_data.gpmc_baseaddr = (void *)
> (gpmc_base_add);
> +               gpmc_nand_init(&omap3beagle_nand_data);
[Ghorai] things are queued for 2.6.36; can refer 
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=f450d86790ebf72ac93c7ea5addd6fa278aae64c

> 
>  		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
>  		if (platform_device_register(&omap3beagle_nand_device) < 0)
> --
> 1.7.0.4
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
