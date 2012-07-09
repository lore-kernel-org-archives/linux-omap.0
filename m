From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] Watchdog: Omap: get the bootstatus for OMAP2Plus
Date: Mon, 09 Jul 2012 09:40:28 -0700
Message-ID: <87ipdwx4zn.fsf@ti.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com>
	<1341808779-25532-4-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:56342 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752400Ab2GIQkd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 12:40:33 -0400
Received: by pbbrp2 with SMTP id rp2so22101912pbb.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Jul 2012 09:40:31 -0700 (PDT)
In-Reply-To: <1341808779-25532-4-git-send-email-zumeng.chen@windriver.com>
	(Zumeng Chen's message of "Mon, 9 Jul 2012 12:39:39 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: shubhrajyoti@ti.com, wim@iguana.be, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul.gortmaker@windriver.com

Zumeng Chen <zumeng.chen@windriver.com> writes:

> The offset of WKUP_MOD is not right for the PRM_RSTST of OMAP3. So here
> put the right one to match to the actual physical addr 0x48307258, which
> defined in PRCM Registers section.
>
> And there is a MPU_WD_RST bit in PRM_RSTST(0x48307258) holding the signal
> from omap-wdt reboot, so that we can return WDIOF_CARDRESET if the board
> wakes up from omap-wdt reboot for WDIOC_GETBOOTSTATUS ioctl.
>
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> ---
>  arch/arm/mach-omap2/prcm.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 480f40a..4dcc706 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -49,8 +49,11 @@ void __iomem *prcm_mpu_base;
>  u32 omap_prcm_get_reset_sources(void)
>  {
>  	/* XXX This presumably needs modification for 34XX */

While you're fixing this for OMAP3, you can remove this comment as well.

> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx())
>  		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
> +	if (cpu_is_omap34xx())
> +		return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP2_RM_RSTST) &
> +		       0x7f;
>  	if (cpu_is_omap44xx())
>  		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;

Kevin
