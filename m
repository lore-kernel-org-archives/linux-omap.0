From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 3/3] omap: zoom3: add zoom3 board support
Date: Fri, 23 Oct 2009 14:39:22 -0500
Message-ID: <A24693684029E5489D1D202277BE89444B781BAA@dlee02.ent.ti.com>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-3-git-send-email-vikram.pandita@ti.com>,<1256325806-14400-4-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbZJWTjS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 15:39:18 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9NJdNDk002663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 14:39:23 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9NJdM08001728
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 14:39:22 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9NJdMRi024150
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 14:39:22 -0500 (CDT)
In-Reply-To: <1256325806-14400-4-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram,

Just some comments I came across below.

From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Pandita, Vikram
Sent: Friday, October 23, 2009 2:23 PM
> Add machine type support for zoom3 board
> Add board type in Kconfig and Makefile
> Reused the zoom board file for zoom2 and zoom3
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig             |    4 ++++
>  arch/arm/mach-omap2/Makefile            |    3 +++
>  arch/arm/mach-omap2/board-zoom2-zoom3.c |    4 ++++
>  3 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 8685df5..fa20996 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -97,6 +97,10 @@ config MACH_OMAP_ZOOM2
>         bool "OMAP3 Zoom2 board"

How about also clarifying here ^^ the chip version:

         bool "OMAP3430 Zoom2 board"

I mean, just to stick to the convention you're putting below.

>         depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> +config MACH_OMAP_ZOOM3
> +       bool "OMAP3630 Zoom3 board"
> +       depends on ARCH_OMAP3 && ARCH_OMAP34XX

Shouldn't this be:

       depends on ARCH_OMAP3 && ARCH_OMAP36XX

?

> +
>  config MACH_CM_T35
>         bool "CompuLab CM-T35 module"
>         depends on ARCH_OMAP3 && ARCH_OMAP34XX
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 68f7419..fac13ba 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -74,6 +74,9 @@ obj-$(CONFIG_MACH_NOKIA_RX51)         += board-rx51.o \
>  obj-$(CONFIG_MACH_OMAP_ZOOM2)          += board-zoom2-zoom3.o \
>                                            mmc-twl4030.o \
>                                            board-zoom-debugboard.o
> +obj-$(CONFIG_MACH_OMAP_ZOOM3)          += board-zoom2-zoom3.o \
> +                                          mmc-twl4030.o \
> +                                          board-zoom-debugboard.o
>  obj-$(CONFIG_MACH_CM_T35)              += board-cm-t35.o \
>                                            mmc-twl4030.o
> 
> diff --git a/arch/arm/mach-omap2/board-zoom2-zoom3.c b/arch/arm/mach-omap2/board-zoom2-zoom3.c
> index 4ad9b94..d806dbf 100644
> --- a/arch/arm/mach-omap2/board-zoom2-zoom3.c
> +++ b/arch/arm/mach-omap2/board-zoom2-zoom3.c
> @@ -281,7 +281,11 @@ static void __init omap_zoom2_map_io(void)
>         omap2_map_common_io();
>  }
> 
> +#ifdef CONFIG_MACH_OMAP_ZOOM3
> +MACHINE_START(OMAP_ZOOM3, "OMAP ZOOM3 board")

Case consistency?

MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")

Regards,
Sergio

> +#else
>  MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
> +#endif
>         .phys_io        = 0x48000000,
>         .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
>         .boot_params    = 0x80000100,
> --
> 1.6.5.rc1.19.g8426
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
