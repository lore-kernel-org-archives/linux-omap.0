From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: cpu: Add am33xx device under
 cpu_class_is_omap2
Date: Sun, 10 Jun 2012 23:38:17 -0700
Message-ID: <20120611063816.GU12766@atomide.com>
References: <1339253773-24088-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41993 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab2FKGiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 02:38:20 -0400
Content-Disposition: inline
In-Reply-To: <1339253773-24088-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120609 08:00]:
> Newly added AM33XX device falls under omap2 class, so
> make cpu_class_is_omap2() true for AM33XX
> (Add soc_is_am33xx() check).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/cpu.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 14f050f..5e36564 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -375,7 +375,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>  #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
>  				cpu_is_omap16xx())
>  #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
> -				cpu_is_omap44xx())
> +				cpu_is_omap44xx() || soc_is_am33xx())
>  
>  /* Various silicon revisions for omap2 */
>  #define OMAP242X_CLASS		0x24200024

I think this can be now simply !cpu_class_is_omap1() as there is
a very slim chance that we'll ever be compiling omap1 and omap2+ together
because of the different compiler flags needed.

Regards,

Tony
