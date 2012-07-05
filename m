From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 1/1] Watchdog: OMAP3: fix wrong boot status from wdt
 reboot
Date: Thu, 5 Jul 2012 13:05:59 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EAF8359@DBDE01.ent.ti.com>
References: <1341417241-11563-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38262 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130Ab2GENGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 09:06:14 -0400
In-Reply-To: <1341417241-11563-1-git-send-email-zumeng.chen@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>, "hubhrajyoti@ti.com" <hubhrajyoti@ti.com>, "wim@iguana.be" <wim@iguana.be>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hello,

On Wed, Jul 04, 2012 at 21:24:01, Zumeng Chen wrote:
> Does the following fix make sense?
> 
> WDIOC_GETBOOTSTATUS always return 0 even if the machine
> comes from omap-wdt reboot. Because WKUP_MOD is not right
> for OMAP3, so give the right addr 0xA00 of PRM_RSTST for
> get_reset_sources, which inputs the signal from omap-wdt
> reboot, and return 1 when coming from omap-wdt reboot for
> WDIOC_GETBOOTSTATUS.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> ---
>  arch/arm/mach-omap2/prcm.c  |    4 +++-
>  drivers/watchdog/omap_wdt.c |    3 +++
>  drivers/watchdog/omap_wdt.h |    3 +++
>  3 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 480f40a..43f3feb 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -49,8 +49,10 @@ void __iomem *prcm_mpu_base;
>  u32 omap_prcm_get_reset_sources(void)
>  {
>  	/* XXX This presumably needs modification for 34XX */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx())
>  		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
> +	if (cpu_is_omap34xx())
> +		return omap2_prm_read_mod_reg(0xA00, OMAP2_RM_RSTST) & 0x7f;
>  	if (cpu_is_omap44xx())
>  		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;

Instead of adding more cpu_is_* checks maybe you could switch to a
function pointers based approach here?

>  
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 8285d65..ea57078 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -234,6 +234,9 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
>  		if (cpu_is_omap24xx())
>  			return put_user(omap_prcm_get_reset_sources(),
>  					(int __user *)arg);
> +		if (cpu_is_omap34xx())
> +			return put_user(omap_prcm_get_reset_sources() & 0x10 >>
> +				OMAP3_PRM_RSTST_BIT, (int __user *)arg);
>  		return put_user(0, (int __user *)arg);

Usage of PRCM bit masks in the driver looks wrong. Why not
introduce an API like omap_prcm_check_reset_reason() which
returns true or false based on the reset reason being checked?

In case of WDT, the driver can then pass the right flag to
userspace.

Regards,
Vaibhav B.

>  	case WDIOC_KEEPALIVE:
>  		pm_runtime_get_sync(wdev->dev);
> diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.h
> index 09b774c..d8d5daa 100644
> --- a/drivers/watchdog/omap_wdt.h
> +++ b/drivers/watchdog/omap_wdt.h
> @@ -40,6 +40,9 @@
>  #define OMAP_WATCHDOG_WPS		(0x34)
>  #define OMAP_WATCHDOG_SPR		(0x48)
>  
> +/* PRM_RSTST MPU_WD_RST bit */
> +#define OMAP3_PRM_RSTST_BIT		4
> +
>  /* Using the prescaler, the OMAP watchdog could go for many
>   * months before firing.  These limits work without scaling,
>   * with the 60 second default assumed by most tools and docs.
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

