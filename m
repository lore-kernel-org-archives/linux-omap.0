From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 5/5] omap:hwspinlocks-ensure the order of registration
Date: Wed, 28 Jul 2010 22:30:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7E3A021@dbde02.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-6-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42883 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537Ab0G1RAL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 13:00:11 -0400
In-Reply-To: <1279558221-14954-6-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
> Sent: Monday, July 19, 2010 10:20 PM
> To: Linux Omap; Tony Lindgren
> Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon; Kanigeri, Hari
> Subject: [PATCH 5/5] omap:hwspinlocks-ensure the order of registration
> 
> Ensure that the hwspinlock driver is registered prior to
> I2C driver registration since I2C is dependent on hwspinlock.

[sp] Is there another patch where this dependency is introduced?

> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/hwspinlocks.c |    2 +-
>  arch/arm/plat-omap/hwspinlock.c   |    3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hwspinlocks.c 
> b/arch/arm/mach-omap2/hwspinlocks.c
> index f0f05e1..a9f85b9 100644
> --- a/arch/arm/mach-omap2/hwspinlocks.c
> +++ b/arch/arm/mach-omap2/hwspinlocks.c
> @@ -67,4 +67,4 @@ int __init hwspinlocks_init(void)
>  
>  	return retval;
>  }
> -module_init(hwspinlocks_init);
> +postcore_initcall(hwspinlocks_init);
> diff --git a/arch/arm/plat-omap/hwspinlock.c 
> b/arch/arm/plat-omap/hwspinlock.c
> index 1883add..3742b04 100644
> --- a/arch/arm/plat-omap/hwspinlock.c
> +++ b/arch/arm/plat-omap/hwspinlock.c
> @@ -309,6 +309,7 @@ static int __init hwspinlock_init(void)
>  
>  	return retval;
>  }
> +postcore_initcall(hwspinlock_init);
>  
>  /* Cleanup function */
>  static void __exit hwspinlock_exit(void)
> @@ -325,8 +326,6 @@ static void __exit hwspinlock_exit(void)
>  	if (hwspinlock_module->is_init)
>  		kfree(hwspinlocks);
>  }
> -
> -module_init(hwspinlock_init);
>  module_exit(hwspinlock_exit);
>  
>  MODULE_LICENSE("GPL v2");
> -- 
> 1.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 