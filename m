From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/2] OMAP3: PM: Configure CPUidle latencies/thresholds
 from board files
Date: Tue, 30 Jun 2009 17:11:18 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D83B1E1C@dbde02.ent.ti.com>
References: <1246286113-21197-1-git-send-email-rnayak@ti.com>
 <1246286113-21197-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbZF3LlX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jun 2009 07:41:23 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5UBfKde021884
	for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2009 06:41:26 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5UBfJaw003536
	for <linux-omap@vger.kernel.org>; Tue, 30 Jun 2009 17:11:19 +0530 (IST)
In-Reply-To: <1246286113-21197-2-git-send-email-rnayak@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nayak, Rajendra
> Sent: Monday, June 29, 2009 8:05 PM
> To: linux-omap@vger.kernel.org
> Cc: Nayak, Rajendra
> Subject: [PATCH 2/2] OMAP3: PM: Configure CPUidle 
> latencies/thresholds from board files
> 
> The CPUidle C state latencies and thresholds are dependent
> on various board specific details.
> Hence this patch makes it possible to configure these values from the
> respective board files.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c     |   22 ++++++-
>  arch/arm/mach-omap2/board-apollon.c     |    2 +-
>  arch/arm/mach-omap2/board-generic.c     |    2 +-
>  arch/arm/mach-omap2/board-h4.c          |    2 +-
>  arch/arm/mach-omap2/board-ldp.c         |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
>  arch/arm/mach-omap2/board-overo.c       |    3 +-
>  arch/arm/mach-omap2/board-rx51.c        |    2 +-
>  arch/arm/mach-omap2/board-zoom2.c       |    2 +-
>  arch/arm/mach-omap2/cpuidle34xx.c       |  105 
> ++++++++++++++++++++++++------
>  arch/arm/mach-omap2/io.c                |    5 +-
>  arch/arm/mach-omap2/pm.c                |    7 ++-
>  arch/arm/mach-omap2/pm.h                |   12 +++-
>  arch/arm/plat-omap/include/mach/io.h    |    4 +-
>  15 files changed, 136 insertions(+), 38 deletions(-)
> 

[snip]---[snip]

> diff --git a/arch/arm/plat-omap/include/mach/io.h 
> b/arch/arm/plat-omap/include/mach/io.h
> index 3582bef..d143bd9 100644
> --- a/arch/arm/plat-omap/include/mach/io.h
> +++ b/arch/arm/plat-omap/include/mach/io.h
> @@ -225,6 +225,7 @@
>  struct omap_sdrc_params;
>  struct omap_opp;
>  struct prm_setup_vc;
> +struct cpuidle_params;
>  
>  extern void omap1_map_common_io(void);
>  extern void omap1_init_common_hw(void);
> @@ -234,7 +235,8 @@ extern void omap2_init_common_hw(struct 
> omap_sdrc_params *sp,
>  				 struct omap_opp *mpu_opps,
>  				 struct omap_opp *dsp_opps,
>  				 struct omap_opp *l3_opps,
> -				 struct prm_setup_vc *setup_times);
> +				 struct prm_setup_vc *setup_times,
> +				 struct cpuidle_params *idle_params);

Rajendra, all,

Aren't we 'overloading' omap2_init_common_hw() each time we add another
argument to it?

Shouldn't we defined define a function specific for PM initialization?
Some of the initialization actually doesn't even touch the HW.

Best regards,
Sanjeev

>  
>  #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
>  #define __arch_iounmap(v)	omap_iounmap(v)
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 