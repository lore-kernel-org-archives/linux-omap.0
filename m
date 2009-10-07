From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]PM: Initialization of SDRC params for DVFS on Zoom2
Date: Wed, 07 Oct 2009 06:13:03 -0700
Message-ID: <878wfnny8w.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3327C7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:61738 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933353AbZJGNNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 09:13:44 -0400
Received: by pxi9 with SMTP id 9so4771384pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 06:13:08 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3327C7@dbde02.ent.ti.com> (Teerth Reddy's message of "Wed\, 7 Oct 2009 14\:27\:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From ba898041224fc496f6694b0ebca9afa77190abf0 Mon Sep 17 00:00:00 2001
> From: Teerth Reddy <teerth@ti.com>
> Date: Wed, 9 Sep 2009 10:38:30 +0530
> Subject: [PATCH] ARM: OMAP3: PM: Initialize SDRC params for DVFS for Zoom2
>
> This patch initializes the SDRC params for DVFS.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>

Teerth,

Please resubmit this patch against linux-omap master.  This
fix could go into 2.6.32 fixes.

Kevin

> ---
>  arch/arm/mach-omap2/board-zoom2.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/board-zoom2.c
> +++ linux-omap-pm/arch/arm/mach-omap2/board-zoom2.c
> @@ -26,6 +26,7 @@
>  
>  #include "mmc-twl4030.h"
>  #include "omap3-opp.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
>  
>  /* Zoom2 has Qwerty keyboard*/
>  static int board_keymap[] = {
> @@ -214,8 +215,9 @@ static void __init omap_zoom2_init_irq(v
>  {
>  	omap_board_config = zoom2_config;
>  	omap_board_config_size = ARRAY_SIZE(zoom2_config);
> -	omap2_init_common_hw(NULL, NULL, omap3_mpu_rate_table,
> -	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +				mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
> +				omap3_dsp_rate_table, omap3_l3_rate_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
