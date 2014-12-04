From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/4] ARM: OMAP2+: Make sure pandora_wl1251_init_card()
 applies to SDIO only
Date: Thu, 4 Dec 2014 13:06:44 -0800
Message-ID: <20141204210644.GJ2817@atomide.com>
References: <1417563767-32181-1-git-send-email-dianders@chromium.org>
 <1417563767-32181-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55656 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736AbaLDVJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 16:09:06 -0500
Content-Disposition: inline
In-Reply-To: <1417563767-32181-2-git-send-email-dianders@chromium.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Doug Anderson <dianders@chromium.org> [141202 15:45]:
> In preparation for having init_card() called for all card types (not
> just SDIO), change pandora_wl1251_init_card() so it checks whether the
> card type is SDIO.

Seems OK to me and should not conflict with linux-omap patches:

Acked-by: Tony Lindgren <tony@atomide.com>

> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v5:
> - Split fixup to pandora_wl1251_init_card() into its own patch.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/mach-omap2/board-omap3pandora.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index 7f17087..969e100 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -254,12 +254,14 @@ static void pandora_wl1251_init_card(struct mmc_card *card)
>  	 * We have TI wl1251 attached to MMC3. Pass this information to
>  	 * SDIO core because it can't be probed by normal methods.
>  	 */
> -	card->quirks |= MMC_QUIRK_NONSTD_SDIO;
> -	card->cccr.wide_bus = 1;
> -	card->cis.vendor = 0x104c;
> -	card->cis.device = 0x9066;
> -	card->cis.blksize = 512;
> -	card->cis.max_dtr = 20000000;
> +	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
> +		card->quirks |= MMC_QUIRK_NONSTD_SDIO;
> +		card->cccr.wide_bus = 1;
> +		card->cis.vendor = 0x104c;
> +		card->cis.device = 0x9066;
> +		card->cis.blksize = 512;
> +		card->cis.max_dtr = 20000000;
> +	}
>  }
>  
>  static struct omap2_hsmmc_info omap3pandora_mmc[] = {
> -- 
> 2.2.0.rc0.207.ga3a616c
> 
