From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [PATCH] RX51: Add support for SDRAM chip select 1
Date: Mon, 8 Jun 2009 15:05:49 +0200
Message-ID: <200906081505.49935.jpihet@mvista.com>
References: <> <1244462603-12793-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:30169 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZFHNG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 09:06:27 -0400
In-Reply-To: <1244462603-12793-1-git-send-email-tero.kristo@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Tero,

You should also ensure that the CKE signals mux settings are correct cf. an 
example for Overo at http://patchwork.kernel.org/patch/28598/.

Note: the config option CONFIG_OMAP_MUX must be set for the omap_cfg* 
functions to have any effect.

Regards,
Jean

On Monday 08 June 2009 14:03:23 Tero Kristo wrote:
> From: Tero Kristo <tero.kristo@nokia.com>
>
> Applies on top of PM branch.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/board-rx51.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-rx51.c
> b/arch/arm/mach-omap2/board-rx51.c index 3e4b7f8..7ab8a74 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -61,7 +61,11 @@ static struct omap_bluetooth_config rx51_bt_config = {
>
>  static void __init rx51_init_irq(void)
>  {
> -	omap2_init_common_hw(rx51_get_sdram_timings(), NULL,
> +	struct omap_sdrc_params *sdrc_params;
> +
> +	sdrc_params = rx51_get_sdram_timings();
> +
> +	omap2_init_common_hw(sdrc_params, sdrc_params,
>  			     omap3_mpu_rate_table,
>  			     omap3_dsp_rate_table,
>  			     omap3_l3_rate_table);


