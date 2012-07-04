From: "zumeng.chen" <zchen@windriver.com>
Subject: Re: [PATCH 1/1] Watchdog: OMAP3: fix wrong boot status from wdt reboot
Date: Wed, 4 Jul 2012 23:57:44 +0800
Message-ID: <4FF467F8.9070804@windriver.com>
References: <1341417241-11563-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63847 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab2GDP6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 11:58:06 -0400
In-Reply-To: <1341417241-11563-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com
Cc: Zumeng Chen <zumeng.chen@windriver.com>, wim@iguana.be, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

To: Shubhrajyoti
On 2012=E5=B9=B407=E6=9C=8804=E6=97=A5 23:54, Zumeng Chen wrote:
> Does the following fix make sense?
>
> WDIOC_GETBOOTSTATUS always return 0 even if the machine
> comes from omap-wdt reboot. Because WKUP_MOD is not right
> for OMAP3, so give the right addr 0xA00 of PRM_RSTST for
> get_reset_sources, which inputs the signal from omap-wdt
> reboot, and return 1 when coming from omap-wdt reboot for
> WDIOC_GETBOOTSTATUS.
>
> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
> ---
>   arch/arm/mach-omap2/prcm.c  |    4 +++-
>   drivers/watchdog/omap_wdt.c |    3 +++
>   drivers/watchdog/omap_wdt.h |    3 +++
>   3 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 480f40a..43f3feb 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -49,8 +49,10 @@ void __iomem *prcm_mpu_base;
>   u32 omap_prcm_get_reset_sources(void)
>   {
>   	/* XXX This presumably needs modification for 34XX */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx())
>   		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST)&  0x7f;
> +	if (cpu_is_omap34xx())
> +		return omap2_prm_read_mod_reg(0xA00, OMAP2_RM_RSTST)&  0x7f;
>   	if (cpu_is_omap44xx())
>   		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST)&  0x7f;
>
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.=
c
> index 8285d65..ea57078 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -234,6 +234,9 @@ static long omap_wdt_ioctl(struct file *file, uns=
igned int cmd,
>   		if (cpu_is_omap24xx())
>   			return put_user(omap_prcm_get_reset_sources(),
>   					(int __user *)arg);
> +		if (cpu_is_omap34xx())
> +			return put_user(omap_prcm_get_reset_sources()&  0x10>>
> +				OMAP3_PRM_RSTST_BIT, (int __user *)arg);
>   		return put_user(0, (int __user *)arg);
>   	case WDIOC_KEEPALIVE:
>   		pm_runtime_get_sync(wdev->dev);
> diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.=
h
> index 09b774c..d8d5daa 100644
> --- a/drivers/watchdog/omap_wdt.h
> +++ b/drivers/watchdog/omap_wdt.h
> @@ -40,6 +40,9 @@
>   #define OMAP_WATCHDOG_WPS		(0x34)
>   #define OMAP_WATCHDOG_SPR		(0x48)
>
> +/* PRM_RSTST MPU_WD_RST bit */
> +#define OMAP3_PRM_RSTST_BIT		4
> +
>   /* Using the prescaler, the OMAP watchdog could go for many
>    * months before firing.  These limits work without scaling,
>    * with the 60 second default assumed by most tools and docs.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
