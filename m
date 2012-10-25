From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM: add missing newline to VC warning
 message
Date: Thu, 25 Oct 2012 12:56:07 -0500
Message-ID: <20121025175607.GA21937@kahuna>
References: <1351186501-32223-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36619 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992485Ab2JYR4R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 13:56:17 -0400
Content-Disposition: inline
In-Reply-To: <1351186501-32223-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10:35-20121025, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
> 
> Add missing newline to warning message to avoid annoying
> wrapping problems during kernel boot like this one:
> 
>    omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
>    omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/vc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 880249b..75878c3 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -264,7 +264,7 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
>  
>  	if (initialized) {
>  		if (voltdm->pmic->i2c_high_speed != i2c_high_speed)
> -			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).",
> +			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).\n",
>  				__func__, voltdm->name, i2c_high_speed);
>  		return;
>  	}
Acked-by: Nishanth Menon <nm@ti.com>
while we are at it, could we clean up the pr_warning usage back to
pr_warn as well?
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 880249b..2d66f8c 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -186,7 +186,7 @@ int omap_vc_bypass_scale(struct voltagedomain *voltdm,
 		loop_cnt++;
 
 		if (retries_cnt > 10) {
-			pr_warning("%s: Retry count exceeded\n", __func__);
+			pr_warn("%s: Retry count exceeded\n", __func__);
 			return -ETIMEDOUT;
 		}
 
-- 
Regards,
Nishanth Menon
