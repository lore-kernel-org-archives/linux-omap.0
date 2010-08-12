From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/4 v2] omap: hwspinlock: uncomment the hwmod part for
 hwspinlock
Date: Thu, 12 Aug 2010 15:07:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E814705E@dbde02.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55662 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337Ab0HLJhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 05:37:45 -0400
In-Reply-To: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E46@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Que, Simon" <sque@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

> -----Original Message-----
> From: Que, Simon 
> Sent: Thursday, August 12, 2010 6:00 AM
> To: Linux Omap; Tony Lindgren
> Cc: Cousson, Benoit; Shilimkar, Santosh; Premi, Sanjeev; 
> Kanigeri, Hari
> Subject: [PATCH 1/4 v2] omap: hwspinlock: uncomment the hwmod 
> part for hwspinlock
> 
> uncomment the hwmod part for hwspinlock
> 
> Signed-off-by: Simon Que <sque@ti.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
> arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
[sp] I did not see this file in any of the "master",
     "for-next" or "pm" branches.

> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index bb0c870..81e3f3f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5797,7 +5797,7 @@ static __initdata struct omap_hwmod 
> *omap44xx_hwmods[] = {
>  /*     &omap44xx_smartreflex_iva_hwmod, */
>  /*     &omap44xx_smartreflex_mpu_hwmod, */
>         /* spinlock class */
> -/*     &omap44xx_spinlock_hwmod, */
> +       &omap44xx_spinlock_hwmod,
>         /* timer class */
>         &omap44xx_timer1_hwmod,
>         &omap44xx_timer2_hwmod,
> --
> 1.7.0
> 