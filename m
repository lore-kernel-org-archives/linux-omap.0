From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND] [PATCH 3/3] omap4: Platform changes for CMA3000
 Accelerometer driver
Date: Fri, 17 Dec 2010 17:33:13 -0800
Message-ID: <20101218013313.GI5941@atomide.com>
References: <62022.10.24.255.17.1291275880.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677Ab0LRBdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:33:17 -0500
Content-Disposition: inline
In-Reply-To: <62022.10.24.255.17.1291275880.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

* Hemanth V <hemanthv@ti.com> [101201 23:34]:
> Pl ignore the earlier patch, which seems to have rebasing issues.
> 
> Thanks
> Hemanth
> 
> From 42cb400c1bd3878977bc8fd416c9c39f81bed674 Mon Sep 17 00:00:00 2001
> From: Hemanth V <hemanthv@ti.com>
> Date: Thu, 2 Dec 2010 12:44:19 +0530
> Subject: [PATCH] omap4: Platform changes for CMA3000 Accelerometer driver
> 
> Update 4430 SDP board file with platform data for accelerometer driver
> 
> Signed-off-by: Hemanth V <hemanthv@ti.com>
> ---
> CMA3000 Driver is queued up for 2.6.38 merge window
> 
>  arch/arm/mach-omap2/board-4430sdp.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index ea56c30..6bda335 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -24,6 +24,8 @@
>  #include <linux/regulator/machine.h>
>  #include <linux/leds.h>
>  #include <linux/leds_pwm.h>
> +#include <linux/input/cma3000.h>
> +#include <linux/interrupt.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/omap4-common.h>

This you should send via the input list along with the cma3000
driver:

Acked-by: Tony Lindgren <tony@atomide.com>
