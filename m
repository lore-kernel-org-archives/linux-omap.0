From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/3] ARM: OMAP3: Enable IO-CHAIN wakeup
Date: Tue, 31 Mar 2009 17:27:17 -0700
Message-ID: <87prfxrzfe.fsf@deeprootsystems.com>
References: <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
	<1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
	<1238075941-24931-3-git-send-email-kalle.jokiniemi@digia.com>
	<1238075941-24931-4-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:6559 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762687AbZDAA1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 20:27:22 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3459200wff.4
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 17:27:20 -0700 (PDT)
In-Reply-To: <1238075941-24931-4-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Thu\, 26 Mar 2009 15\:59\:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> OMAP 3430 ES3.1 chips have a separate bit for IO daisy-chain
> wake up enabling. It needs to be enabled when entering
> retention or off state, otherwise waking up might not work
> in all situations.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Thanks, pushed after...

> ---
>  arch/arm/mach-omap2/pm34xx.c           |   37 +++++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    2 +
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7bbbcce..4345df1 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -101,6 +101,34 @@ static inline void omap3_per_restore_context(void)
>  	omap3_gpio_restore_context();
>  }
>  
> +static void omap3_enable_io_chain(void)
> +{
> +	int timeout = 0;
> +
> +	if (omap_rev() >= OMAP3430_REV_ES3_1) {
> +		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
> +		/* Do a readback to assure write has been done */
> +		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
> +
> +		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
> +						OMAP3430_ST_IO_CHAIN)) {
> +			timeout++;
> +			if (timeout > 1000) {
> +				printk(KERN_ERR "Wake up daisy chain "
> +						"activation failed.\n");
> +				return;
> +			}
> +		prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN, WKUP_MOD, PM_WKST);

fixing this screwy indent.

Kevin
