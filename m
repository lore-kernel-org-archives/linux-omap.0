From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: enable BCH_HW ecc-scheme for AM43xx
 platforms
Date: Tue, 27 May 2014 14:22:58 -0700
Message-ID: <20140527212257.GH32336@atomide.com>
References: <1400498556-24005-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32241 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaE0VXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 17:23:05 -0400
Content-Disposition: inline
In-Reply-To: <1400498556-24005-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>

* Pekon Gupta <pekon@ti.com> [140519 04:23]:
> Fixes: commit 0611c41934ab35ce84dea34ab291897ad3cbc7be
> ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms and ECC schemes
> 
> Though the commit log of above commit mentions AM43xx platforms, but code change
> missed AM43xx. This patch adds AM43xx to list of those SoC which have built-in
> ELM hardware engine, so that BCH ecc-schemes with hardware error-correction can
> be enabled on AM43xx devices.
> 
> Reported-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Applying into omap-for-v3.16/dt-v2 thanks.

Tony

> ---
>  arch/arm/mach-omap2/gpmc-nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 4349e82..17cd393 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -46,7 +46,7 @@ static struct platform_device gpmc_nand_device = {
>  static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
>  {
>  	/* platforms which support all ECC schemes */
> -	if (soc_is_am33xx() || cpu_is_omap44xx() ||
> +	if (soc_is_am33xx() || soc_is_am43xx() || cpu_is_omap44xx() ||
>  		 soc_is_omap54xx() || soc_is_dra7xx())
>  		return 1;
>  
> -- 
> 1.8.5.1.163.gd7aced9
> 
